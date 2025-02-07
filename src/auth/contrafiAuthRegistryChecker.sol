///SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

interface IContrafiAuthRegistry {
    function isAuthorized(address _contractToCall, bytes4 _functionSelector, address _caller)
        external
        view
        returns (bool);
}

abstract contract ContrafiAuthRegistryChecker {
    ///@notice interface to the ContrafiAuthRegistry
    IContrafiAuthRegistry internal immutable _registry;

    ///@notice thrown when a function is called by an unauthorized caller
    error UnauthorizedCaller();

    constructor(address _registryAddress) {
        _registry = IContrafiAuthRegistry(_registryAddress);
    }

    ///@notice enforces that the caller is authorized to call the contract+function combination
    modifier onlyAuthorized() {
        if (!_registry.isAuthorized(address(this), msg.sig, msg.sender)) {
            revert UnauthorizedCaller();
        }
        _;
    }
}
