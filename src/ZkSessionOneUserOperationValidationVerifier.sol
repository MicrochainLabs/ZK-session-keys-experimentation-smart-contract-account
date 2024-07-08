// SPDX-License-Identifier: GPL-3.0
/*
    Copyright 2021 0KIMS association.

    This file is generated with [snarkJS](https://github.com/iden3/snarkjs).

    snarkJS is a free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    snarkJS is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with snarkJS. If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity >=0.7.0 <0.9.0;

contract ZkSessionOneUserOperationValidationVerifier {
    // Scalar field size
    uint256 constant r    = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // Base field size
    uint256 constant q   = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Verification Key data
    uint256 constant alphax  = 6958913215996507894365304544717026606241184699683464443767470276076157706529;
    uint256 constant alphay  = 4404123428976337724564568213571836772308909985888370363613116521116780135923;
    uint256 constant betax1  = 2740592434380698232365256630038042260883810671176468439870516436963190790144;
    uint256 constant betax2  = 7035325723399526442572442889829576766798511826105706984699265900535121604472;
    uint256 constant betay1  = 13151422315429045626542776109596842557942964603138993626769951721136005951002;
    uint256 constant betay2  = 20427714463911454734159434545204975706305481861345118104495757972303424884639;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 732104358051005407891240995794786805412946477372603473761528226327450762144;
    uint256 constant deltax2 = 6263017584917082748341139642843857518555893349423980139687448911204224780673;
    uint256 constant deltay1 = 12343711696750717908433136569838172208122776291124532111511114155778746393437;
    uint256 constant deltay2 = 16282240424770556644899113976164432670423247405743031119242547783178444299794;

    
    uint256 constant IC0x = 19441656417292286702389402946108230979452417658234243028951637731056181730914;
    uint256 constant IC0y = 12521869295075554956696033196838225322335193462915185260554941418351283161932;
    
    uint256 constant IC1x = 4362878096641782964097657624275706075190951881650861082005796731670914072888;
    uint256 constant IC1y = 8000273120493749325110357795809204695040396901240538580514238619802280924748;
    
    uint256 constant IC2x = 18908451533168114568502925031373795130164699371661590483066387751526613172056;
    uint256 constant IC2y = 740434791343216436275806040528282817462574950282487967622637410097363846458;
    
    uint256 constant IC3x = 12785647558692785295122229590269729452787598417941653451760108664388143721153;
    uint256 constant IC3y = 18319911701461182564189147656267426838889098113933571836288077934194098807696;
    
    uint256 constant IC4x = 4728822856182461248324162824736959819830103377309044201259217072938751711465;
    uint256 constant IC4y = 5209366442874511362928814236002300612789658480298635323111644164067754533970;
    
    uint256 constant IC5x = 8647185574427830233520165187122115793234834348960782373955977996893231840064;
    uint256 constant IC5y = 3540067308562484531904688544336699862560691424509767138750718188336665496104;
    
    uint256 constant IC6x = 17345947512131475416820351284509808361050667891160132323276290124364200367193;
    uint256 constant IC6y = 11763321983034171347270399837140152471664284320541595028033954344918087028641;
    
    uint256 constant IC7x = 17844803442869665002388500306761383873360913849616446420430783800888026473059;
    uint256 constant IC7y = 5032607278035705081843184370806948673416574914541923258689412956158155978313;
    
    uint256 constant IC8x = 18253640974749160965447771337775736549131963701122715838679436151647600647316;
    uint256 constant IC8y = 16371051887307135796623765369736414194570782076493440117184520157392613366086;
    
    uint256 constant IC9x = 403115853411503354254071001104245397894454117917001454121158967768747984142;
    uint256 constant IC9y = 15310222352727289646564323945013787114152745072729721065679352277208095893367;
    
 
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[9] calldata _pubSignals) public view returns (bool) {
        assembly {
            function checkField(v) {
                if iszero(lt(v, r)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }
            
            // G1 function to multiply a G1 value(x,y) to value in an address
            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                // Compute the linear combination vk_x
                
                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))
                
                g1_mulAccC(_pVk, IC2x, IC2y, calldataload(add(pubSignals, 32)))
                
                g1_mulAccC(_pVk, IC3x, IC3y, calldataload(add(pubSignals, 64)))
                
                g1_mulAccC(_pVk, IC4x, IC4y, calldataload(add(pubSignals, 96)))
                
                g1_mulAccC(_pVk, IC5x, IC5y, calldataload(add(pubSignals, 128)))
                
                g1_mulAccC(_pVk, IC6x, IC6y, calldataload(add(pubSignals, 160)))
                
                g1_mulAccC(_pVk, IC7x, IC7y, calldataload(add(pubSignals, 192)))
                
                g1_mulAccC(_pVk, IC8x, IC8y, calldataload(add(pubSignals, 224)))
                
                g1_mulAccC(_pVk, IC9x, IC9y, calldataload(add(pubSignals, 256)))
                

                // -A
                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                // B
                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                // alpha1
                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                // beta2
                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                // vk_x
                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))


                // gamma2
                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                // C
                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                // delta2
                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)


                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)

                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            // Validate that all evaluations ∈ F
            
            checkField(calldataload(add(_pubSignals, 0)))
            
            checkField(calldataload(add(_pubSignals, 32)))
            
            checkField(calldataload(add(_pubSignals, 64)))
            
            checkField(calldataload(add(_pubSignals, 96)))
            
            checkField(calldataload(add(_pubSignals, 128)))
            
            checkField(calldataload(add(_pubSignals, 160)))
            
            checkField(calldataload(add(_pubSignals, 192)))
            
            checkField(calldataload(add(_pubSignals, 224)))
            
            checkField(calldataload(add(_pubSignals, 256)))
            
            checkField(calldataload(add(_pubSignals, 288)))
            

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
             return(0, 0x20)
         }
     }
 }
