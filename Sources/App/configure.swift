import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "his_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "his_password",
        database: Environment.get("DATABASE_NAME") ?? "his_database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

  
    // 1
    app.migrations.add(CreateUsersTable())
    app.migrations.add(CreateAddressTable())
      
    // 2
    app.logger.logLevel = .debug

    // 3
    try await app.autoMigrate().get()
    
    // register controllers
    try app.register(collection: UserController())
    try app.register(collection: AddressController())
    
// MARK: TODO
    app.jwt.signers.use(.hs256(key: "569j7h4f7n943po1c3"))
    
    
    // register routes
    try routes(app)
}
