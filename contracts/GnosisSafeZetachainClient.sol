// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

import "@zetachain/protocol-contracts/contracts/Zeta.eth.sol";
import "@zetachain/protocol-contracts/contracts/ZetaInteractor.sol";
import "@zetachain/protocol-contracts/contracts/interfaces/ZetaInterfaces.sol";

// Contract to interact with main Gnosis Safe on Zetachain
contract GnosisSafeZetachainClient is
    ZetaInteractor
{
    // Goerli addresses
    address private constant ZETA_CONNECTOR_ADDRESS = 0x00007d0BA516a2bA02D77907d3a1348C1187Ae62;
    address private constant ZETA_TOKEN_ADDRESS = 0xCc7bb2D219A0FC08033E130629C2B854b7bA9195;
    address private constant ZETA_GNOSIS_SAFE_ADDRESS = 0x70441FDBab4D5521FbcF4A62F7c9023eE88CA70D;

    constructor() ZetaInteractor(ZETA_CONNECTOR_ADDRESS) {
    }

    /// @dev Allows to execute a Safe transaction confirmed by required number of owners and then pays the account that submitted the transaction.
    ///      Note: The fees are always transferred, even if the user transaction fails.
    /// @param to Destination address of Safe transaction.
    /// @param value Ether value of Safe transaction.
    /// @param data Data payload of Safe transaction.
    /// @param operation Operation type of Safe transaction.
    /// @param safeTxGas Gas that should be used for the Safe transaction.
    /// @param baseGas Gas costs that are independent of the transaction execution(e.g. base transaction fee, signature check, payment of the refund)
    /// @param gasPrice Gas price that should be used for the payment calculation.
    /// @param gasToken Token address (or 0 if ETH) that is used for the payment.
    /// @param refundReceiver Address of receiver of gas payment (or 0 if tx.origin).
    /// @param signatures Packed signature data ({bytes32 r}{bytes32 s}{uint8 v})
    function execTransaction(
        address to,
        uint256 value,
        bytes calldata data,
        uint operation,
        uint256 safeTxGas,
        uint256 baseGas,
        uint256 gasPrice,
        address gasToken,
        address payable refundReceiver,
        bytes memory signatures
    ) public payable returns (bool success) {
        // Hardcode to 0.05 for now
        uint zetaValueAndGas = 50000000000000000;
        bytes memory message;

        // Avoid stack too deep
        {
            message = abi.encode(to,value,data,operation,safeTxGas,baseGas,gasPrice,gasToken,refundReceiver,signatures);
            ZetaEth(ZETA_TOKEN_ADDRESS).approve(ZETA_CONNECTOR_ADDRESS, zetaValueAndGas);
            ZetaEth(ZETA_TOKEN_ADDRESS).transferFrom(msg.sender, address(this), zetaValueAndGas);
        }

        connector.send(
            ZetaInterfaces.SendInput({
                destinationChainId: 7001,
                destinationAddress: abi.encodePacked(ZETA_GNOSIS_SAFE_ADDRESS),
                destinationGasLimit: 1000000,
                message: message,
                zetaValueAndGas: zetaValueAndGas,
                zetaParams: abi.encode("")
            })
        );
        return true;
    }

    
}
