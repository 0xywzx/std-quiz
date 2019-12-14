pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract STD_Zombiee {
    
    struct Zombiee { 
        uint256 id;
        string firstName;
        string middleName;
        string lastName;
        string favoriteFood;
        string placeOfBirth;
        string job;
        string nickName;
        uint256 age;
        uint256 height;
        uint256 weight;
        uint256 BMI;
        uint256 bloodPressure;
        uint256 footSize;
        uint256 motherAge;
        uint256 fatherAge;
        uint256 favoriteNumber;
        bool married;
    }

    uint256 internal id = 0;
    mapping (uint256 => Zombiee) private zombiees;
 
    function zombieeFactoryFirstHalf( 
        bytes memory _dataFirstHalf,
        bytes memory _dataSecondHalf
        ) public {
        id = id + 1;
        (
            string memory _firstName, 
            string memory _middleName, 
            string memory _lastName, 
            string memory _favoriteFood, 
            string memory _placeOfBirth, 
            string memory _job, 
            string memory _nickName
        ) = abi.decode(_dataFirstHalf, (
            string, string, string, string, string, string, string
        ));
        Zombiee memory zombiee = Zombiee({ 
            id: id, 
            firstName: _firstName, 
            middleName: _middleName, 
            lastName: _lastName, 
            favoriteFood: _favoriteFood, 
            placeOfBirth: _placeOfBirth, 
            job: _job, 
            nickName: _nickName, 
            age: 0, 
            height: 0, 
            weight: 0, 
            BMI: 0, 
            bloodPressure: 0, 
            footSize: 0, 
            motherAge: 0, 
            fatherAge: 0, 
            favoriteNumber: 0, 
            married: false 
        });
        zombiees[id] = zombiee;
        zombieeFactorySecondHalf(id, _dataSecondHalf);
    }
    
    function zombieeFactorySecondHalf (
        uint256 _id,
        bytes memory _dataSecondHalf
        ) internal {
        require(_id == zombiees[_id].id);
        (
            uint256 _age,
            uint256 _height,
            uint256 _weight,
            uint256 _BMI,
            uint256 _bloodPressure,
            uint256 _footSize,
            uint256 _motherAge,
            uint256 _fatherAge,
            uint256 _favoriteNumber,
            bool _married
        ) = abi.decode(_dataSecondHalf, (
            uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256, bool
        ));
        Zombiee memory _zombiee = zombiees[_id];
        Zombiee memory zombiee = Zombiee({ 
            id: _zombiee.id, 
            firstName: _zombiee.firstName, 
            middleName: _zombiee.middleName, 
            lastName: _zombiee.lastName, 
            favoriteFood: _zombiee.favoriteFood, 
            placeOfBirth: _zombiee.placeOfBirth, 
            job: _zombiee.job, 
            nickName: _zombiee.nickName, 
            age: _age, 
            height: _height, 
            weight: _weight, 
            BMI: _BMI, 
            bloodPressure: _bloodPressure, 
            footSize: _footSize, 
            motherAge: _motherAge, 
            fatherAge: _fatherAge, 
            favoriteNumber: _favoriteNumber, 
            married: _married
        });
        zombiees[id] = zombiee;
        emit ZombieeCreated(zombiee);    
    }
    
    function getZombiee(uint256 _id) public view returns (Zombiee memory) {
        return zombiees[_id];
    }
    
    event ZombieeCreated(Zombiee zombiee);
}


// サンプル
// 'string', 'string', 'string', 'string', 'string', 'string', 'string', 'uint256', 'uint256', 'uint256', 'uint256', 'uint256', 'uint256', 'uint256', 'uint256', 'uint256','bool' 
// 'Alexsa','Fernando','Moras','Sushi','Arizona','shepherd','Alex','28','6','175','20','100','11','51','53','8','true'

// 前半のstring７つをencodeしたbyteです
// 0x00000000000000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000120000000000000000000000000000000000000000000000000000000000000016000000000000000000000000000000000000000000000000000000000000001a000000000000000000000000000000000000000000000000000000000000001e0000000000000000000000000000000000000000000000000000000000000022000000000000000000000000000000000000000000000000000000000000002600000000000000000000000000000000000000000000000000000000000000006416c65787361000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000084665726e616e646f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000054d6f7261730000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005537573686900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000074172697a6f6e6100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000873686570686572640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004416c657800000000000000000000000000000000000000000000000000000000
// 後半をencodeしたbyteです
// 0x000000000000000000000000000000000000000000000000000000000000001c000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000af00000000000000000000000000000000000000000000000000000000000000140000000000000000000000000000000000000000000000000000000000000064000000000000000000000000000000000000000000000000000000000000000b0000000000000000000000000000000000000000000000000000000000000033000000000000000000000000000000000000000000000000000000000000003500000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000001
// encode, decodeは下記サイトで行いました
// https://adibas03.github.io/online-ethereum-abi-encoder-decoder/#/encode
