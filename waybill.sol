pragma solidity ^0.5.1;

contract Waybill{

    // 客户信息
    struct User{
        string userName;//客户姓名
        uint phone;//客户电话
        string realAddr;//客户地址
    }

    // 货物信息
    struct Cargo{
        string cargoName;//货物名称
        uint quantity;//货物数量
        string units;//计量单位
        string containerNumber;//集装箱号
    }

    //信息录入
    function initUser(string memory _userName, uint _phone, string memory _realAddr) pure public returns(string memory, uint, string memory){
        User memory user1 = User(_userName, _phone, _realAddr);
        return(user1.userName, user1.phone, user1.realAddr);
    }
    function initCargo(string memory _cargoName, uint _quantity, string memory _units, string memory _containerNumber) pure public returns(string memory, uint, string memory, string memory){
        Cargo memory cargo1 = Cargo(_cargoName, _quantity, _units, _containerNumber);
        return(cargo1.cargoName, cargo1.quantity, cargo1.units, cargo1.containerNumber);
    }

    int endorse = -10;

    //多式联运经营人签注，状态码-1
    function transBegin()public{
        endorse = -1;
    }

    //监管授权，状态码0
    function govern()public{
        delete endorse;
    }

    //分段承运人签注，第一分段承运状态码1，第二分段承运状态码2，后面依次排列...
    function transport()public{
        if(endorse>=0)endorse++;
    }

    //用户签收，状态码-20
    function receive()public{
        endorse = -20;
    }

    //信息查询
    function transDisplay()public view returns(int){
        return (endorse);
    }
}