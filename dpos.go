package main

import (
	"crypto/sha256"
	"encoding/hex"
	"log"
	"math/rand"
	"sort"
	"time"
)

//定义区块结构体
type Block struct {
	Index     int
	Timestamp string
	BPM       int
	Hash      string
	PrevHash  string
	Delegate  string
}

// 创建区块函数
func generateBlock(oldBlock Block, _BMP int, address string) (Block, error) {
	var newBlock Block
	t := time.Now()

	newBlock.Index = oldBlock.Index + 1
	newBlock.Timestamp = t.String()
	newBlock.BPM = _BMP
	newBlock.PrevHash = oldBlock.Hash
	newBlock.Hash = createBlockHash(newBlock)
	newBlock.Delegate = address

	return newBlock, nil
}

//生成区块hash
func createBlockHash(block Block) string {
	record := string(block.Index) + block.Timestamp + string(block.BPM) + block.PrevHash
	sha3 := sha256.New()
	sha3.Write([]byte(record))
	hash := sha3.Sum(nil)
	return hex.EncodeToString(hash)
}

// 简单的检验区块函数
func isBlockValid(newBlock, oldBlock Block) bool {
	if oldBlock.Index+1 != newBlock.Index {
		return false
	}

	if newBlock.PrevHash != oldBlock.Hash {
		return false
	}
	return true
}

// 区块集合
var blockChain []Block

// dpos里的超级节点结构体（受托人）
type Trustee struct {
	name  string
	votes int
}

type trusteeList []Trustee

// 下面的三个函数是为了排序使用，大家可以查下go的排序还是很强大的
func (_trusteeList trusteeList) Len() int {
	return len(_trusteeList)
}
func (_trusteeList trusteeList) Swap(i, j int) {
	_trusteeList[i], _trusteeList[j] = _trusteeList[j], _trusteeList[i]
}
func (_trusteeList trusteeList) Less(i, j int) bool {
	return _trusteeList[j].votes < _trusteeList[i].votes
}

// 选举获得投票数最高的前10节点作为超级节点，并打乱其顺序
func selectTrustee() []Trustee {
	_trusteeList := []Trustee{
		{"node1", rand.Intn(100)},
		{"node2", rand.Intn(100)},
		{"node3", rand.Intn(100)},
		{"node4", rand.Intn(100)},
		{"node5", rand.Intn(100)},
		{"node6", rand.Intn(100)},
		{"node7", rand.Intn(100)},
		{"node8", rand.Intn(100)},
		{"node9", rand.Intn(100)},
		{"node10", rand.Intn(100)},
		{"node11", rand.Intn(100)},
		{"node12", rand.Intn(100)},
		{"node13", rand.Intn(100)},
		{"node14", rand.Intn(100)},
		{"node15", rand.Intn(100)},
		{"node16", rand.Intn(100)},
		{"node17", rand.Intn(100)},
		{"node18", rand.Intn(100)},
		{"node19", rand.Intn(100)},
		{"node20", rand.Intn(100)},
		{"node21", rand.Intn(100)},
		{"node22", rand.Intn(100)},
		{"node23", rand.Intn(100)},
		{"node24", rand.Intn(100)},
		{"node25", rand.Intn(100)},
		{"node26", rand.Intn(100)},
		{"node27", rand.Intn(100)},
		{"node28", rand.Intn(100)},
		{"node29", rand.Intn(100)},
		{"node30", rand.Intn(100)},
		{"node31", rand.Intn(100)},
		{"node32", rand.Intn(100)},
		{"node33", rand.Intn(100)},
		{"node34", rand.Intn(100)},
		{"node35", rand.Intn(100)},
		{"node36", rand.Intn(100)},
		{"node37", rand.Intn(100)},
		{"node38", rand.Intn(100)},
		{"node39", rand.Intn(100)},
		{"node40", rand.Intn(100)},
		{"node41", rand.Intn(100)},
		{"node42", rand.Intn(100)},
		{"node43", rand.Intn(100)},
		{"node44", rand.Intn(100)},
		{"node45", rand.Intn(100)},
		{"node46", rand.Intn(100)},
		{"node47", rand.Intn(100)},
		{"node48", rand.Intn(100)},
		{"node49", rand.Intn(100)},
		{"node50", rand.Intn(100)},
		{"node51", rand.Intn(100)},
		{"node52", rand.Intn(100)},
		{"node53", rand.Intn(100)},
		{"node54", rand.Intn(100)},
		{"node55", rand.Intn(100)},
		{"node56", rand.Intn(100)},
		{"node57", rand.Intn(100)},
		{"node58", rand.Intn(100)},
		{"node59", rand.Intn(100)},
		{"node60", rand.Intn(100)},
	}
	sort.Sort(trusteeList(_trusteeList))
	result := _trusteeList[:10]
	_trusteeList = result[1:]
	_trusteeList = append(_trusteeList, result[0])
	log.Println("超级节点列表是", _trusteeList)
	return _trusteeList
}

func main() {
	t := time.Now()

	// init gensis block（创建创世区块）
	genesisBlock := Block{0, t.String(), 0, createBlockHash(Block{}), "", ""}
	blockChain = append(blockChain, genesisBlock)
	// 完成了一次dpos的写区块操作
	var trustee Trustee
	for _, trustee = range selectTrustee() {
		_BPM := rand.Intn(100)
		blockHeight := len(blockChain)
		oldBlock := blockChain[blockHeight-1]
		newBlock, err := generateBlock(oldBlock, _BPM, trustee.name)
		if err != nil {
			log.Println(err)
			continue
		}

		if isBlockValid(newBlock, oldBlock) {
			blockChain = append(blockChain, newBlock)
			log.Println("当前操作区块的节点是: ", trustee.name)
			log.Println("当前区块数量是: ", len(blockChain)-1)
			log.Println("当前区块信息: ", blockChain[len(blockChain)-1])

		}

	}
}
