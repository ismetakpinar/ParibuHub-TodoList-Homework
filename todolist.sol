// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ToDoList{
    struct TodoItem{
        string task;
        bool isCompleted;
    }
    mapping (uint => TodoItem) public list;
    uint256 public count = 0;
    address owner;
    event TaskCompleted (uint indexed id);

    constructor () {
        owner = msg.sender;
    }
    function addTask(string calldata task ) public{
        require(owner == msg.sender," Only owner can call this");
        TodoItem memory item = TodoItem ({task : task, isCompleted : false });
        list[count] = item ;
        count++;
    }
    function completeTask(uint id ) onlyOwner public {
        if (!list[id].isCompleted){
            list[id].isCompleted = true;
            emit TaskCompleted(id);
        }
    }
    modifier onlyOwner (){
        require(owner == msg.sender, "Only owner can call this");
        _;
    }

}
