// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity >=0.7.0 <0.9.0;

import "../common/SelfAuthorized.sol";

abstract contract Verifier {
    function verifyProof(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[2] memory input
    ) public view virtual returns (bool r);
}

contract TrivialVerifier is Verifier {
    function verifyProof(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[2] memory input
    ) public view override returns (bool r) {
        return true;
    }
}

/// @title ZK Signature Verifier Manager - A contract that manages the ZK signature verifier
contract ZkSignatureVerifierManager is SelfAuthorized {
    event ChangedZkSignatureVerifier(address zkSignatureVerifier);

    // keccak256("zk_signature_verifier_manager.zk_signature_verifier.address")
    bytes32 internal constant ZK_SIGNATURE_VERIFIER_STORAGE_SLOT = 0x3da4e60503f0b21d75a282f0646b4570e6832affc6e16156e2dc005f38c1a46f;

    function internalSetZkSignatureVerifier(address zkSignatureVerifier) internal {
        bytes32 slot = ZK_SIGNATURE_VERIFIER_STORAGE_SLOT;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            sstore(slot, zkSignatureVerifier)
        }
    }

    /// @dev Allows to add a contract to verify signature proofs.
    ///      This can only be done via a Safe transaction.
    /// @param zkSignatureVerifier contract to verify signature proofs.
    function setZkSignatureVerifier(address zkSignatureVerifier) public authorized {
        internalSetZkSignatureVerifier(zkSignatureVerifier);
        emit ChangedZkSignatureVerifier(zkSignatureVerifier);
    }

    function getZkSignatureVerifier() public view returns (Verifier) {
        bytes32 slot = ZK_SIGNATURE_VERIFIER_STORAGE_SLOT;
        address zkSignatureVerifierAddress;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            zkSignatureVerifierAddress := sload(slot)
        }
        return Verifier(zkSignatureVerifierAddress);
    }
}
