pragma solidity ^0.5.1;

contract Waybill{

    // 一、客户信息
    struct User{
        string userName;//客户姓名 
        uint userPhone;//客户电话 
        string realAddr;//客户地址
        string userPost;//邮编 
    }

    // 二、货物信息
    // HS编码、品名、产地、重量、品类、集装箱箱号、集装箱箱型、集装箱箱类、施封号码等
    // 以太坊虚拟机输入+输出参数总数上限是16个，因此必须拆分成两部分输入
    struct Cargo1{
        string HSCode;//海关HS编码（商品名称及编码协调制度的国际公约）
        string cargoName;//品名 
        string origin;//产地
        string weight;//重量
        string category;//品类 
    }
    struct Cargo2{
        string containerNumber;//集装箱箱号 
        string containerType;//集装箱箱型
        string containerClass;//集装箱箱类 
        string sealNumber;//施封号码 
    }

    // 三、运输信息
    // 1、多式联运经营人信息
    struct TransportMul{
        string companyName;//公司名称 "中铁国际多式联运有限公司"
        string dealerMul;//业务员 "高军宁"
    }

    // 2、分段承运人信息
    // 始发机场、目的机场、航班号等航空运输信息；发站、到站、车牌号等公路运输信息；发站、到站、车次等铁路运输信息；装运港、目的港、船公司等水路运输信息
    struct TransportSec{
        string departure;//始发机场or发站or发站or装运港 "大连"
        string desination;//目的机场or到站or到站or目的港 "烟台"
        string transNumber;//航班号or车牌号or车次or航线 "CR041101"
        string dealerSec;//分段承运业务员 "王一"
    }

    // 四、监管信息
    // 1、报关信息
    // 海关注册编码、注册日期、工商注册全称、工商注册地址、法人代表、纳税人识别号、营业执照编号、组织机构代码、进出口企业代码等；
    struct GovernCus1{//customs
        string CRCode;// 海关注册编码
        uint CRdate;// 注册日期 
        string orgCode;// 组织机构代码 777296277
        string IECode;// 进出口企业代码 无
    }
    struct GovernCus2{
        string ICName;// 工商注册全称 "大连海事大学投资管理有限责任公司"
        string ICAddr;// 工商注册地址 "辽宁省大连市甘井子区凌海路1号301室"
        string legalPerson;// 法人代表 "潘新祥"
        string taxNumber;// 纳税人识别号 912102317772962774
        string BLNumber;// 营业执照编号 210231000004951
    }

    // 2、检验检疫信息
    // 品质证书、重量证书、数量证书、兽医卫生证书、健康证书、卫生证书、动物卫生证书、植物检疫证书、熏蒸证书、消毒证书等。
    struct GovernIQ1{//inspection and quarantine
        bool qc;// 品质证书certificate of quality
        bool wc;// 重量证书weight
        bool ac;// 数量证书amount
        bool vsc;// 兽医卫生证书veterinary sanitary 
        bool hc;// 健康证书health
    }
    struct GovernIQ2{
        bool sc;// 卫生证书sanitary
        bool ahc;// 动物卫生证书animal health
        bool qpc;// 植物检疫证书plant quarantine
        bool fc;// 熏蒸证书fumigation
        bool pc;// 消毒证书phytosanitary
    }







    // -----------------------------------------------结构体与功能函数分割线-----------------------------------------------------------






    // 一、信息录入
    //发货人信息录入
    function initUserA(string memory _userNameA, uint _userPhoneA, string memory _realAddrA, string memory _userPostA) pure public 
    returns(string memory, uint, string memory, string memory){
        User memory userA = User(_userNameA, _userPhoneA, _realAddrA, _userPostA);
        return(userA.userName, userA.userPhone, userA.realAddr, userA.userPost);
    }

    //收货人信息录入
    function initUserB(string memory _userNameB, uint _userPhoneB, string memory _realAddrB, string memory _userPostB) pure public 
    returns(string memory, uint, string memory, string memory){
        User memory userB = User(_userNameB, _userPhoneB, _realAddrB, _userPostB);
        return(userB.userName, userB.userPhone, userB.realAddr, userB.userPost);
    }

    // 货物信息录入(1/2)
    function initCargo1(string memory _HSCode, string memory _cargoName, string memory _origin, 
    string memory _weight, string memory _category) pure public 
    returns(string memory, string memory, string memory, string memory, string memory){
        Cargo1 memory cargoTest = Cargo1(_HSCode, _cargoName, _origin, _weight, _category);
        return(cargoTest.HSCode, cargoTest.cargoName, cargoTest.origin, cargoTest.weight, cargoTest.category);
    }
    // 货物信息录入(2/2) containerNUmber containerType containerClass sealNumber
    function initCargo2(string memory _containerNUmber, string memory _containerType, string memory _containerClass, string memory _sealNumber)
     pure public returns(string memory, string memory, string memory, string memory){
        Cargo2 memory cargoTest = Cargo2(_containerNUmber, _containerType, _containerClass, _sealNumber);
        return(cargoTest.containerNUmber, cargoTest.containerType, cargoTest.containerClass, cargoTest.sealNumber);
    }

    // 多式联运经营人信息录入
    function initTransportMul(string memory _companyName, string memory _dealerMul)pure public returns(string memory, string memory){
        TransportMul memory transportMulTest = TransportMul(_companyName, _dealerMul);
        return(transportMulTest.companyName, transportMulTest.dealerMul);
    }

    // 分段承运人信息录入
    function initTransportSec(string memory _departure, string memory _desination, string memory _transNumber, string memory _dealerSec) 
    pure public returns(string memory, string memory, string memory, string memory){
        TransportSec memory TransportSecTest = TransportSec(_departure, _desination, _transNumber, _dealerSec);
        return(TransportSecTest.departure, TransportSecTest.desination, TransportSecTest.transNumber, TransportSecTest.dealerSec);
    }

    // 报关信息录入(1/2)
    function initCus1(string memory _CRCode, uint _CRdate, string memory _orgCode, string memory _IECode) pure public
     returns(string memory, uint, string memory, string memory){
        GovernCus1 memory cusTest = GovernCus1(_CRCode, _CRdate, _orgCode, _IECode);
        return(cusTest.CRCode, cusTest.CRdate, cusTest.orgCode, cusTest.IECode);
    }
    // 报关信息录入(2/2)
    function initCus2(string memory _ICName, string memory _ICAddr, string memory _legalPerson, string memory _taxNumber, 
    string memory _BLNumber) pure public returns(string memory, string memory, string memory, string memory, string memory){
        GovernCus2 memory cusTest = GovernCus2(_ICName, _ICAddr, _legalPerson, _taxNumber, _BLNumber);
        return(cusTest.ICName, cusTest.ICAddr, cusTest.legalPerson, cusTest.taxNumber, cusTest.BLNumber);
    }

    // 检验检疫信息录入(1/2)
    function initIQ1(bool _qc, bool _wc, bool _ac, bool _vsc, bool _hc) pure public returns(bool, bool, bool, bool, bool){
        GovernIQ1 memory IQtest = GovernIQ1(_qc, _wc, _ac, _vsc, _hc);
        return(IQtest.qc, IQtest.wc, IQtest.ac, IQtest.vsc, IQtest.hc);
    }
    // 检验检疫信息录入(2/2)
    function initIQ2(bool _sc, bool _ahc, bool _qpc, bool _fc, bool _pc) pure public returns(bool, bool, bool, bool, bool){
        GovernIQ2 memory IQtest = GovernIQ2(_sc, _ahc, _qpc, _fc, _pc);
        return(IQtest.sc, IQtest.ahc, IQtest.qpc, IQtest.fc, IQtest.pc);
    }

    // 二、功能实现：查询、授权、签注、签收、转让
    int endorse = -10;

    // 查询功能
    function transDisplay()public view returns(int){
        return (endorse);
    }

    // function transDisplayTest()public view returns(string memory){
    //     if(endorse==-10)return "";
    // }

    // 授权功能
    // 监管授权，状态码0
    function govern()public{
        delete endorse;
    }

    // 签注功能
    // 多式联运经营人签注，状态码-1
    function transBegin()public{
        endorse = -1;
    }
    //分段承运人签注，第一分段承运状态码1，第二分段承运状态码2，后面依次排列...
    function transSection()public{
        if(endorse>=0)endorse++;
    }

    // 签收功能
    // 用户签收，状态码-20
    function receive()public{
        endorse = -20;
    }

    // 转让功能
    function transfer(address _userB) payable{
        address account = _userB;
        account.transfer(msg.value);
    }


    // 2、功能完善：转让功能实现；分段运输信息输入；监管授权流程。
    // 3、部署
}
