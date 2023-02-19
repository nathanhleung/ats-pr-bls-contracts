// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface ZetaInterfaces {
  struct ZetaMessage {
      bytes zetaTxSenderAddress;
      uint256 sourceChainId;
      address destinationAddress;
      /// @dev Remaining ZETA from zetaValueAndGas after subtracting ZetaChain gas fees and destination gas fees
      uint256 zetaValue;
      bytes message;
  }
}

interface ZetaReceiver {
  function onZetaMessage(ZetaInterfaces.ZetaMessage calldata zetaMessage) external;
}