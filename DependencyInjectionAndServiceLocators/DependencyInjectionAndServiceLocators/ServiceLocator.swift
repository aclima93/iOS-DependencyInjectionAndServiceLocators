//
//  ServiceLocator.swift
//  DependencyInjectionAndServiceLocators
//
//  Created by Antonio Lima on 23/01/2023.
// Based on: https://raw.githubusercontent.com/Mindera/Alicerce/408a3015dc578f2598c14645b942f04c9042d7ce/Sources/Utils/ServiceLocator.swift
//


import Foundation

protocol Serviceable {
    init()
}

final class ServiceLocator {

    enum Error: Swift.Error {
        case duplicateService(ServiceName)
        case inexistentService(ServiceName)
        case typeMismatch(ServiceName)
    }

    typealias ServiceName = String

    static let shared = ServiceLocator()

    private var services = [ServiceName : Any]()

    // MARK: - Public Methods

    @discardableResult
    func register<Service>(
        service: Service,
        name serviceName: ServiceName? = nil
    ) throws -> ServiceName {

        let name = buildName(for: Service.self, serviceName)

        guard services[name] == nil
        else { throw Error.duplicateService(name) }

        services[name] = service

        return name
    }

    func get<Service>(
        name serviceName: ServiceName? = nil
    ) throws -> Service {

        let name = buildName(for: Service.self, serviceName)

        guard let registeredService = services[name]
        else { throw Error.inexistentService(name) }

        guard let service = registeredService as? Service
        else { throw Error.typeMismatch(name) }

        return service
    }

    func unregister<Service>(
        _ type: Service.Type,
        name serviceName: ServiceName? = nil
    ) throws {

        let name = buildName(for: type, serviceName)

        guard let _ = services[name]
        else { throw Error.inexistentService(name) }

        services[name] = nil
    }

    // MARK: Utils

    func getOrRegister<Service: Serviceable>(_ type: Service.Type) -> Service {

        do {
            return try get()
        } catch Error.inexistentService {
            let instance = Service.init()

            do {
                try register(service: instance)
            } catch {
                fatalError("no thread safety 🔨")
            }

            return instance

        } catch {
            fatalError("not exhaustive 🔨")
        }
    }

    func getRegisteredServiceNames() -> [ServiceName] {
        services.map(\.key)
    }

    func unregisterAll() {
        services.removeAll()
    }

    // MARK: - Private Methods

    private func buildName<Service>(
        for _: Service.Type,
        _ serviceName: ServiceName? = nil
    ) -> ServiceName {
        return serviceName ?? "\(Service.self)"
    }
}
