// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TodoList {
    struct TodoItem {
        string task;
        bool isCompleted;
    }

    mapping(uint256 => TodoItem) public list;
    uint256 internal count = 0;
    address public owner;

    event TaskCompleted(uint256 indexed id);

    constructor() {
        owner = msg.sender;
    }

    function addTask(string calldata task) public onlyOwner {
        TodoItem memory item = TodoItem({task: task, isCompleted: false});
        list[count] = item;
        count++;
    }

    function completeTask(uint256 id) public onlyOwner {
        require(id < count, "Invalid task ID");
        require(!list[id].isCompleted, "Task already completed");

        list[id].isCompleted = true;
        emit TaskCompleted(id);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner can call this");
        _;
    }
}
