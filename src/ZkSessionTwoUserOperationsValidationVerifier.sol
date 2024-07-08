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

contract ZkSessionTwoUserOperationsValidationVerifier {
    // Scalar field size
    uint256 constant r    = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // Base field size
    uint256 constant q   = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Verification Key data
    uint256 constant alphax  = 13697314212317519091960046854296891503354482212615258734544198460223460967323;
    uint256 constant alphay  = 6885221367273117508917118842210793569332788157038059842530610182957589350844;
    uint256 constant betax1  = 6675903445562159561654724822410387991201293393118258405977231839940478235679;
    uint256 constant betax2  = 6936822159933629698193632818069460928805835133717607390966640280248765592786;
    uint256 constant betay1  = 6851295661260966202492912268664633287439454210032881033424615912340669622109;
    uint256 constant betay2  = 20398768436072683751955821389294002432863399591136985165339146710959740101655;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 18114087035216786852463038928456399596485421847442709128850944674327913833886;
    uint256 constant deltax2 = 19526137185152688805379845520920056850812219381742858180359367003175103451284;
    uint256 constant deltay1 = 1397972738967209987732085920561611367116998640185331777800392796609239446611;
    uint256 constant deltay2 = 18011466076127869571601633549029012224417388789694708544120184330540420924919;

    
    uint256 constant IC0x = 11135812212049155184150646815275021726093207356152467754487164162630226712545;
    uint256 constant IC0y = 6625550720372927509050723095506841552728859692453133635661726108910847449375;
    
    uint256 constant IC1x = 182794649048930743362807168327957385418129773977868188817659084606520488070;
    uint256 constant IC1y = 9205617171792258536037218382255420944909726179351208284983341749483021659706;
    
    uint256 constant IC2x = 17214459277679738530632925786148325114333825109002068637592139460281470339282;
    uint256 constant IC2y = 4256037615584065644172495512901795431627594750644390082048369181099815715423;
    
    uint256 constant IC3x = 15254963750686922234580207476930795490037695944297494337452698562743077417221;
    uint256 constant IC3y = 17652111807753937593532432913489043678900244107025435001398463285061573035188;
    
    uint256 constant IC4x = 8043895599965134489627316568967851968121726870422965718967746204233883128272;
    uint256 constant IC4y = 15629001290858679319974940887848930669702127054520686804347786412555990743357;
    
    uint256 constant IC5x = 18797207192598648862861646457408221482703014016095936326005017420014635841482;
    uint256 constant IC5y = 7764159564975465692983753434928476308566419615507674676153855346289911034215;
    
    uint256 constant IC6x = 6182736780252257177046210345861322298960511064981443559264943524212513781654;
    uint256 constant IC6y = 7101154897398974534875333600674000958355217057938856532991671306309036363821;
    
    uint256 constant IC7x = 4333517356819611203156500711499465148885439506806137546591889051150954002191;
    uint256 constant IC7y = 11965103280282323106050583054126400253761964252307726971056768720883354892126;
    
    uint256 constant IC8x = 10882721701886364613883123397625705991439474151708384783138194379464848300426;
    uint256 constant IC8y = 19521910781754225139483470976114260491170992204466545378422378462610796444588;
    
    uint256 constant IC9x = 9445434773581192205596535566646476614658771614221001005031795073003177771732;
    uint256 constant IC9y = 14395164524654334955716779425224979505907393513248684917565022230153620992632;
    
    uint256 constant IC10x = 16342599816092823714062035615404111025920558258903572312884587212505281365582;
    uint256 constant IC10y = 12325130940812354992891288320884891205307707206392085585143532370067791880775;
    
    uint256 constant IC11x = 18917872175155440276484317337489582228929638879235305322421625467340819637063;
    uint256 constant IC11y = 21659097394295920789201918041183052931092890947052529912441058232331697300270;
    
    uint256 constant IC12x = 16609152652262223245270193760254526914392713207228273291784143562352793223970;
    uint256 constant IC12y = 13235447530602238589813523318933833367267764834782541775008639842578649578748;
    
    uint256 constant IC13x = 1261391181229454727902813701524552001566496575345081391976162104445621861063;
    uint256 constant IC13y = 5134298520751968368233670886060529592760681849529852764109584307191161219235;
    
 
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[13] calldata _pubSignals) public view returns (bool) {
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
                
                g1_mulAccC(_pVk, IC10x, IC10y, calldataload(add(pubSignals, 288)))
                
                g1_mulAccC(_pVk, IC11x, IC11y, calldataload(add(pubSignals, 320)))
                
                g1_mulAccC(_pVk, IC12x, IC12y, calldataload(add(pubSignals, 352)))
                
                g1_mulAccC(_pVk, IC13x, IC13y, calldataload(add(pubSignals, 384)))
                

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
            
            checkField(calldataload(add(_pubSignals, 320)))
            
            checkField(calldataload(add(_pubSignals, 352)))
            
            checkField(calldataload(add(_pubSignals, 384)))
            
            checkField(calldataload(add(_pubSignals, 416)))
            

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
             return(0, 0x20)
         }
     }
 }
