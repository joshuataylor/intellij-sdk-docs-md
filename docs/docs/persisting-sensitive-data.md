# Persisting Sensitive Data

The Credentials Store API stores sensitive user data securely, including passwords, API keys, private keys, and server URLs.

Use [PasswordSafe](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/credential-store/src/ide/passwordSafe/PasswordSafe.kt) to manage credentials.
The required elements are:

* a human-readable description of the credentials in the form of a service name,

* credential attributes (metadata) that include a service name and an optional username or other identity,

* the actual credential value, such as a password or API key, usually as a `String`.

This is a service-like class, and the [service retrieval rules apply](plugin-services.html#retrieving-a-service).

## Human-Readable Description of Credentials with Service Names

The [generateServiceName()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/credential-store/src/credentialStore/CredentialAttributes.kt) function available in the IntelliJ SDK API helps name credentials in a consistent way so that they can be easily recognized in password managers and when users are asked to allow the IDE to access a secret.
Pass a subsystem name that identifies the plugin or its area of functionality, and a key that identifies the specific secret, such as an account name for a password or server name for an access token.

Kotlin:

```KOTLIN
import com.intellij.credentialStore.generateServiceName

val serviceName =
    generateServiceName("My Service", "john.doe")
```

Java:

```JAVA
import com.intellij.credentialStore.CredentialAttributesKt;

String serviceName = CredentialAttributesKt
    .generateServiceName("My Service", "john.doe");
```

This will generate the following service name:

```TEXT
IntelliJ Platform My Service - john.doe
```

For example, such a service name appears in the macOS Keychain Access application as a keychain entry name.

## Attaching Identity to Credentials with Credentials Attributes

A [CredentialAttributes](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/credential-store/src/credentialStore/CredentialAttributes.kt) instance wraps credential metadata.
To store a username, account name or other identity, set it along with the service name.

Kotlin:

```KOTLIN
import com.intellij.credentialStore.generateServiceName

//...

private fun credentialAttributesOf(username: String): CredentialAttributes {
  val serviceName = generateServiceName("My Service", username)
  return CredentialAttributes(serviceName, username)
}
```

Java:

```JAVA
import com.intellij.credentialStore.CredentialAttributesKt;

// ...

private static CredentialAttributes credentialAttributesOf(String username) {
  String serviceName = CredentialAttributesKt
      .generateServiceName("My Service", username);
  return new CredentialAttributes(serviceName, username);
}
```

## Password Management

### Storing Passwords

To store a `String`-based password, use the `PasswordSafe` instance:

1. Generate [a service name](#human-readable-description-of-credentials-with-service-names).

2. Create [credential attributes](#attaching-identity-to-credentials-with-credentials-attributes).

3. Use the `setPassword()` method with [credential attributes](#attaching-identity-to-credentials-with-credentials-attributes) and the password value.

Kotlin:

```KOTLIN
@Service
class PasswordService {
  suspend fun save(username: String, password: String) {
    withContext(Dispatchers.IO) {
      PasswordSafe.instance
          .setPassword(credentialAttributesOf(username), password)
    }
  }

  private fun credentialAttributesOf(username: String): CredentialAttributes {
    // see above for definition
  }
}
```

Java:

```JAVA
@Service
public final class PasswordService {
  @RequiresBackgroundThread
  public void save(String username, String password) {
    PasswordSafe.getInstance()
        .setPassword(credentialAttributesOf(username), password);
  }

  private CredentialAttributes credentialAttributesOf(String username) {
    // see above for definition
  }
}
```

Warning: Do not use `PasswordSafe` on EDT

The `setPassword()` method of `PasswordSafe` is blocking and must not be invoked on EDT.
In Kotlin, it is recommended to declare a [Light Service](plugin-services.html#light-services) with a suspending function that calls `PasswordSafe` methods on the I/O dispatcher.

The password is persisted in [OS-specific storage](#storage).

### Retrieving Passwords

To retrieve a stored password:

1. Generate [a service name](#human-readable-description-of-credentials-with-service-names).

2. Create [credential attributes](#attaching-identity-to-credentials-with-credentials-attributes).

3. Use the `getPassword()` method with these credential attributes to query for the password.

Kotlin:

```KOTLIN
suspend fun find(username: String): String? = withContext(Dispatchers.IO) {
  PasswordSafe.instance.getPassword(credentialAttributesOf(username))
}
```

Java:

```JAVA
@RequiresBackgroundThread
public String find(String username) {
  return PasswordSafe.getInstance()
      .getPassword(credentialAttributesOf(username));
}
```

Warning: Do not use `PasswordSafe` on EDT

The `getPassword()` method of `PasswordSafe` is blocking and must not be invoked on EDT.

Note:

`PasswordSafe` does not provide an API to retrieve all stored credentials,
nor does it allow retrieving all stored usernames or similar identites.
If the current user identity must be persisted, for example, authenticated user, store it separately using [Persisting State of Components](persisting-state-of-components.html).

## API Key Management

API key management is broadly similar to [password management](#password-management), with two distinct changes.

1. The service name can be a constant string.

2. The `userName` property in `CredentialAttributes` is not set.

Kotlin:

```KOTLIN
@Service
class ApiKeyService {
  private val serviceName =
      generateServiceName("My Credentials Storage", "API Key")

  suspend fun save(apiKey: String) = withContext(Dispatchers.IO) {
    PasswordSafe.instance
        .setPassword(CredentialAttributes(serviceName), apiKey)
  }

  suspend fun load(): String? = withContext(Dispatchers.IO) {
    PasswordSafe.instance
        .getPassword(CredentialAttributes(serviceName))
  }
}
```

Java:

```JAVA
@Service
public final class ApiKeyService {
  private static final String SERVICE_NAME = CredentialAttributesKt
      .generateServiceName("My Credentials Storage", "API Key");

  @RequiresBackgroundThread
  public void save(String apiKey) {
    PasswordSafe.getInstance()
        .setPassword(new CredentialAttributes(SERVICE_NAME), apiKey);
  }

  @RequiresBackgroundThread
  public String load() {
    return PasswordSafe.getInstance()
        .getPassword(new CredentialAttributes(SERVICE_NAME));
  }
}
```

Warning: Do not use `PasswordSafe` on EDT

The same rules for thread-safety apply: both methods must not be invoked on EDT.
Running these suspending functions on the correct dispatcher ensures correctness.

## Private Keys and Other Non-String Credentials

When storing complex credentials that are not easily representable by strings, such as private keys, use map-like behavior of `PasswordSafe`.
Use `CredentialAttributes` as keys, while `Credential` instances represent values.

Use the following `PasswordSafe` methods:

Kotlin:

```KOTLIN
operator fun set(attributes: CredentialAttributes, credentials: Credentials?)
operator fun get(attributes: CredentialAttributes): Credentials?
```

Both functions [allow \[key\] shorthand syntax](https://kotlinlang.org/docs/map-operations.html#retrieve-keys-and-values).

Java:

```JAVA
public void set(CredentialAttributes attributes, @Nullable Credentials credentials);
public @Nullable Credentials get(CredentialAttributes attributes);
```

Construct a `Credential` instance that allows setting both the username and credential value from `String` instances, byte arrays, and char arrays.

When retrieving `Credential` values, their credentials are represented by `OneTimeString`, a wrapper of sensitive data that can be used and cleared.
Such string can be serialized to standard `String` instances, arrays of characters, or arrays of bytes.

Kotlin:

```KOTLIN
@Service
class PrivateKeyService {

  suspend fun save(identity: String, privateKey: PrivateKey) = withContext(Dispatchers.IO) {
    val credentialAttributes = credentialAttributesOf(identity)
    privateKey.encoded?.let { keyBytes: ByteArray ->
      PasswordSafe.instance[credentialAttributes] = Credentials(identity, keyBytes)
    }
  }

  suspend fun find(identity: String): PrivateKey? = withContext(Dispatchers.IO) {
    val credentialAttributes = credentialAttributesOf(identity)
    val credentials: Credentials? = PasswordSafe.instance[credentialAttributes]
    val keyBytes: ByteArray? = credentials?.password?.toByteArray()
    keyBytes?.let {
      loadPrivateKey(keyBytes)
    }
  }

  private fun credentialAttributesOf(identity: String): CredentialAttributes
    // see password management example

  private fun loadPrivateKey(keyBytes: ByteArray): PrivateKey {
    // implement as necessary
  }
}
```

Java:

```JAVA
@Service
public final class PrivateKeyService {

  @RequiresBackgroundThread
  public void save(String identity, PrivateKey key) {
    byte[] keyBytes = key.getEncoded();
    if (keyBytes == null) {
      return;
    }

    CredentialAttributes attributes = createCredentialAttributes(identity);
    PasswordSafe.getInstance().set(attributes, new Credentials(identity, keyBytes));
  }

  @RequiresBackgroundThread
  public PrivateKey find(String identity) {
    CredentialAttributes credentialAttributes = createCredentialAttributes(identity);
    Credentials credentials = PasswordSafe.getInstance().get(credentialAttributes);
    if (credentials == null) {
      return null;
    }

    OneTimeString password = credentials.getPassword();
    if (password == null) {
      return null;
    }

    byte[] keyBytes = password.toByteArray();
    if (keyBytes == null) {
      return null;
    }
    return loadPrivateKey(keyBytes);
  }

  private CredentialAttributes credentialAttributesOf(String identity) {
    // see password management example
  }

  private PrivateKey loadPrivateKey(byte[] keyBytes) {
    // implement as necessary
  }
}
```

## Removing Credentials

To remove stored credentials, pass `null` for the `credentials` parameter.

Kotlin:

```KOTLIN
PasswordSafe.instance[credentialAttributesOf(identity)] = null
```

Java:

```JAVA
PasswordSafe.getInstance().set(credentialAttributesOf(identity), null);
```

## Retrieving Credentials in Remote Development Context

For [Remote Development](https://www.jetbrains.com/help/idea/remote-development-overview.html), `PasswordSafe` provides an alternative way to retrieve credentials in Kotlin code.

```KOTLIN
suspend fun getAsync(attributes: CredentialAttributes): Ephemeral<Credentials>
```

Besides being coroutine-friendly, it returns "ephemeral" credentials that are valid only while the client is connected to the backend in the [Remote Development](https://www.jetbrains.com/help/idea/remote-development-overview.html) context.
When the client disconnects, the credentials are erased, preventing further actions on the user's behalf.

Warning: Experimental

The `getAsync()` and `Ephemeral` APIs are under development and experimental.
Additionally, there are available in Kotlin only.

Some aspects of it may change in future releases.

## Storage

The default storage format depends on the OS.

| OS |Storage |
---------------
| Windows |File in [KeePass](https://keepass.info) format |
| macOS |Keychain using [Security Framework](https://developer.apple.com/documentation/security/keychain_services) |
| Linux |[Secret Service API](https://specifications.freedesktop.org/secret-service-spec/latest/) using [libsecret](https://wiki.gnome.org/Projects/Libsecret) |

Users can override the default behavior `Settings | Appearance & Behavior | System Settings | Passwords`.

### Storage in Remote Development Context

Since 2025.3, credentials are transparently redirected to the frontend and stored according to the local environment and settings, such as KeePass or macOS Keychain.

Before 2025.3, credentials are stored on the backend side in plain text.

