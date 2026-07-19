# Plugin Signing

Plugin Signing is a mechanism introduced in the 2021.2 release cycle to increase security on the [JetBrains Marketplace](https://plugins.jetbrains.com)
and all IntelliJ-based IDEs.

The JetBrains Marketplace signing process is designed to ensure that plugins are not modified over the course of the publishing and delivery pipeline.
If the author does not sign the plugin or has a revoked certificate, a warning dialog will appear in the IDE during installation.

On our side, we will check if the public part of a key is present, and we will verify the signature.
This is similar to the [Google upload key](https://developer.android.com/studio/publish/app-signing#generate-key) mechanism.

## How Signing Works

To be sure a file has not been modified, the file will be signed twice – first by the plugin author, then by JetBrains Marketplace.

Procedure: Signing and Verification Process

The intermediate certificate issues a certificate that will be used to sign plugins.
This way, it will be possible to re-generate this certificate without access to JetBrains CA's supersecret private key.
The private key of the intermediate certificate is issued and kept in the AWS Certificate Manager, and no application has access to it; people's access is also limited.
So now we have an AWS-based Intermediate CA.
The public part of the intermediate certificate will be added to the plugin distribution file together with the signing certificate.

The certificate used to sign plugins is stored securely, too.
JetBrains Marketplace uses AWS KMS as a signature provider to sign plugin distribution files.

## Signing Methods

For signing, the [Marketplace ZIP Signer](https://github.com/JetBrains/marketplace-zip-signer) library is used.
For Gradle-based projects, it can be used conveniently using the provided tasks via [Gradle Integration](#gradle-integration).
Alternatively, a standalone [CLI Tool](#cli-tool) can be used.

Both methods require a private certificate key to be present.

### Generate Private Key

Warning: Storing Secrets

Never commit your credentials to the Version Control System!
Instead, use environment variables, like:

```
token.set(providers.environmentVariable("PUBLISH_TOKEN"))
password.set(providers.environmentVariable("PRIVATE_KEY_PASSWORD"))
```

To generate an RSA `private.pem` private key, run the `openssl genpkey` command in the terminal, as below:

```BASH
openssl genpkey\
  -aes-256-cbc\
  -algorithm RSA\
  -out private_encrypted.pem\
  -pkeyopt rsa_keygen_bits:4096
```

After that, it's required to convert it into the RSA form with:

```BASH
openssl rsa\
  -in private_encrypted.pem\
  -out private.pem
```

At this point, the generated `private.pem` content should be provided to the
`signPlugin.privateKey` property
([2.x](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-privateKey), [1.x](tools-gradle-intellij-plugin.html#tasks-signplugin-privatekey)).
The provided password should be specified as the `signPlugin.password` property
([2.x](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-password), [1.x](tools-gradle-intellij-plugin.html#tasks-signplugin-password)).

As a next step, we will generate a `chain.crt` certificate chain with:

```BASH
openssl req\
  -key private.pem\
  -new\
  -x509\
  -days 365\
  -out chain.crt
```

The content of the `chain.crt` file will be used for the `signPlugin.certificateChain` property
([2.x](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-certificateChain), [1.x](tools-gradle-intellij-plugin.html#tasks-signplugin-certificatechain)).

Tip:

Information about generating a public key based on the private key will be added later when uploading public keys to JetBrains Marketplace becomes available.

### Gradle Integration

#### IntelliJ Platform Gradle Plugin (2.x)

The [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html) provides the [signPlugin](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin) task,
which will be executed automatically right before the [publishPlugin](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin) task
when [signPlugin.certificateChain](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-certificateChain) and [signPlugin.privateKey](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-privateKey) properties are specified.
Otherwise, it'll be skipped.

See [intellijPlatform.signing](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing) for configuration reference.

##### Configuration using Files

Instead of using the `signPlugin.certificateChain` and `signPlugin.privateKey` properties which expect the certificate chain and key to be provided directly,
it's also possible to specify the paths to the files containing the certificate chain and key content.
Use [signPlugin.certificateChainFile](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-certificateChainFile) and [signPlugin.privateKeyFile](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-privateKeyFile) properties instead.

#### Gradle IntelliJ Plugin (1.x)

The [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) provides the [signPlugin](tools-gradle-intellij-plugin.html#tasks-signplugin) task, which will be executed automatically right before the [publishPlugin](tools-gradle-intellij-plugin.html#tasks-publishplugin) task
when [signPlugin.certificateChain](tools-gradle-intellij-plugin.html#tasks-signplugin-certificatechain) and [signPlugin.privateKey](tools-gradle-intellij-plugin.html#tasks-signplugin-privatekey) properties are specified.
Otherwise, it'll be skipped.

An example [signPlugin](tools-gradle-intellij-plugin.html#tasks-signplugin) task configuration may look like this:

Kotlin:

```KOTLIN
signPlugin {
  certificateChain.set("""
    -----BEGIN CERTIFICATE-----
    MIIElgCCAn4CCQDo83LWYj2QSTANBgkqhkiG9w0BAQsFADANMQswCQYDVQQGEwJQ
    ...
    gdZzxCN8t1EmH8kD2Yve6YKGFCRAIIzveEg=
    -----END CERTIFICATE-----
  """.trimIndent())

  privateKey.set("""
    -----BEGIN RSA PRIVATE KEY-----
    MIIJKgIBAAKCAgEAwU8awS22Rw902BmwVDDBMlTREX440BAAVM40NW3E0lJ7YTJG
    ...
    EnNBfIVFhh6khisKqTBWSEo5iS2RYJcuZs961riCn1LARztiaXL4l17oW8t+Qw==
    -----END RSA PRIVATE KEY-----
  """.trimIndent())

  password.set("8awS22%#3(4wVDDBMlTREX")
}

publishPlugin {
  token.set("perm:a961riC....l17oW8t+Qw==")
}
```

Groovy:

```GROOVY
signPlugin {
  certificateChain = """
    -----BEGIN CERTIFICATE-----
    MIIElgCCAn4CCQDo83LWYj2QSTANBgkqhkiG9w0BAQsFADANMQswCQYDVQQGEwJQ
    ...
    gdZzxCN8t1EmH8kD2Yve6YKGFCRAIIzveEg=
    -----END CERTIFICATE-----
  """.stripIndent()

  privateKey = """
    -----BEGIN RSA PRIVATE KEY-----
    MIIJKgIBAAKCAgEAwU8awS22Rw902BmwVDDBMlTREX440BAAVM40NW3E0lJ7YTJG
    ...
    EnNBfIVFhh6khisKqTBWSEo5iS2RYJcuZs961riCn1LARztiaXL4l17oW8t+Qw==
    -----END RSA PRIVATE KEY-----
  """.stripIndent()

  password = "8awS22%#3(4wVDDBMlTREX"
}

publishPlugin {
  token = "perm:a961riC....l17oW8t+Qw=="
}
```

##### Using Files

Instead of using the [signPlugin.privateKey](tools-gradle-intellij-plugin.html#tasks-signplugin-privatekey) and [signPlugin.certificateChain](tools-gradle-intellij-plugin.html#tasks-signplugin-certificatechain) properties which expect the key and certificate chain
content to be provided directly, it's also possible to specify the paths to the files containing the key and certificate chain content.
To do that, use the [signPlugin.privateKeyFile](tools-gradle-intellij-plugin.html#tasks-signplugin-privatekeyfile) and [signPlugin.certificateChainFile](tools-gradle-intellij-plugin.html#tasks-signplugin-certificatechainfile) properties instead.

Kotlin:

```KOTLIN
signPlugin {
  certificateChainFile.set(file("certificate/chain.crt"))
  privateKeyFile.set(file("certificate/private.pem"))
  password.set("8awS22%#3(4wVDDBMlTREX")
}

publishPlugin {
  token.set("perm:a961riC....l17oW8t+Qw==")
}
```

Groovy:

```GROOVY
signPlugin {
  certificateChainFile = file("certificate/chain.crt")
  privateKeyFile = file("certificate/private.pem")
  password = "8awS22%#3(4wVDDBMlTREX"
}

publishPlugin {
  token = "perm:a961riC....l17oW8t+Qw=="
}
```

### Provide Secrets to IDE

To avoid storing hard-coded values in the project configuration, the most suitable method for local development would be using environment variables provided within the Run/Debug Configuration.

To specify secrets like `PUBLISH_TOKEN` and values required for the
`signPlugin` Gradle task ([2.x](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin), [1.x](tools-gradle-intellij-plugin.html#tasks-signplugin)),
modify your Gradle configuration as follows:

Kotlin:

```KOTLIN
signPlugin {
  certificateChain.set(providers.environmentVariable("CERTIFICATE_CHAIN"))
  privateKey.set(providers.environmentVariable("PRIVATE_KEY"))
  password.set(providers.environmentVariable("PRIVATE_KEY_PASSWORD"))
}

publishPlugin {
  token.set(providers.environmentVariable("PUBLISH_TOKEN"))
}
```

Groovy:

```GROOVY
signPlugin {
  certificateChain = providers.environmentVariable("CERTIFICATE_CHAIN")
  privateKey = providers.environmentVariable("PRIVATE_KEY")
  password = providers.environmentVariable("PRIVATE_KEY_PASSWORD")
}

publishPlugin {
  token = providers.environmentVariable("PUBLISH_TOKEN")
}
```

In the Run/Debug Configuration for `publishPlugin` Gradle task
([2.x](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin), [1.x](tools-gradle-intellij-plugin.html#tasks-publishplugin)),
provide Environment Variables using relevant environment variable names:

![Run/Debug Configuration Environment Variables](images/plugin_singing_env_variables.png)
Warning: Encoding Values

Note that both the private key and certificate chain are multi-line values.
It is necessary to transform them first using Base64 encoding before providing the single-line field in the Environment Variables panel.

The corresponding Gradle task properties will automatically detect and decode the Base64-encoded values.

### CLI Tool

<tldr>
Current Release: 0.1.43

GitHub: [Releases &amp; Changelog](https://github.com/JetBrains/marketplace-zip-signer/releases), [Issue Tracker](https://github.com/JetBrains/marketplace-zip-signer/issues)

JetBrains Platform Forum: [Marketplace](https://platform.jetbrains.com/c/marketplace/8) category
</tldr>

CLI tool is required if you don't rely on either Gradle plugin – i.e., when working with [Themes](developing-themes.html).

Get the latest Marketplace ZIP Signer CLI Tool version from the GitHub Releases page.
After downloading the `marketplace-zip-signer-cli.jar`, execute it as below:

```BASH
java -jar marketplace-zip-signer-cli.jar sign\
  -in "unsigned.zip"\
  -out "signed.zip"\
  -cert-file "/path/to/chain.crt"\
  -key-file "/path/to/private.pem"\
  -key-pass "PRIVATE_KEY_PASSWORD"
```

## Signing for Custom Repositories

Signing plugins hosted on a [Custom Plugin Repository](custom-plugin-repository.html) can be achieved for added trust between the repository and installation.
However, unlike JetBrains Marketplace, the custom repository will not re-sign the plugin with the JetBrains key.
Instead, a trusted private CA or self-signed certificate can be used to sign and validate plugins.

### Verification

Before looking at how we can sign a plugin, let's first review how verification works when a non-JetBrains certificate is used.
As of 2021.2, during verification, IntelliJ-based IDEs check if the plugin was signed with the JetBrains CA certificate or any public key provided by the user via `Settings | Plugins | Manage Plugin Certificates`.
In 2021.2.1, a system property has been added: `intellij.plugins.truststore`, pointing to a trusted JKS TrustStore.
During verification, the plugin's public key is extracted from the signature.
The last certificate entry in the chain matched against the certificates stored in one of the storages from above.

### Using a Trusted Internal CA

If an internal CA is available, it can be used to generate certificates for signing.
When choosing this route, the certificate chain includes the root CA public key at the end of the chain.

With this approach, existing internal TrustStores may exist and could be used.
Be sure when choosing a TrustStore that the CAs are limited to the internal CAs you trust.
Using a TrustStore with public CAs can expose users to an attack vector.

If adding a TrustStore to a user's environment is not possible, the user may also add the root CAs public key to `Settings | Plugins | Manage Plugin Certificates`.

### Using Self-Signed Certificates

Using a self-signed certificate is an option if no internal CAs exist.
To generate the key and public key, see [Generate Private Key](#generate-private-key).

If providing users with a TrustStore, you can generate one with the public key using `keytool`:

```BASH
keytool -import -alias IdeaPlugin -file chain.crt -keystore pluginKeystore.jks -storepass changeit
```

(note: the TrustStore password must remain `changeit`)

Otherwise, users may add the public key manually to `Settings | Plugins | Manage Plugin Certificates`.

## Plugin Signature Verification

The signature of a plugin can be verified using the `verifyPluginSignature` Gradle task
([2.x](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginSignature), [1.x](tools-gradle-intellij-plugin.html#tasks-verifypluginsignature)).

By default, it will use the same certificate chain as provided to the `signPlugin` Gradle task (see [Gradle Integration](#gradle-integration)).

To verify the signature using the [CLI tool](#cli-tool), execute the `verify` command as below:

```BASH
java -jar marketplace-zip-signer-cli.jar verify\
  -in "signed.zip"\
  -cert "/path/to/chain.crt"
```

