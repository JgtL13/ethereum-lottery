applicants: HashMap[uint256, address]
numApplicants: public(uint256)
winnerAddress: public(address)
winnerInd: public(uint256)
owner: public(address)
time: public(uint256)

@external
def __init__():
    self.numApplicants = 0
    self.owner = msg.sender

@external
@payable
def enter():
    assert self.numApplicants < 3
    for i in range(3):
        assert self.applicants[i] != msg.sender
    self.applicants[self.numApplicants + 1] = msg.sender

@external
@payable
def hold():
    assert self.owner == msg.sender
    assert self.numApplicants == 3
    self.time = block.timestamp
    self.winnerInd = self.time % 3
    self.winnerAddress = self.applicants[self.winnerInd]

@external
@payable
def clearApplicants():
    assert self.owner == msg.sender
    for i in range(3):
        self.applicants[i] = empty(address)
    self.numApplicants = 0
    self.winnerAddress = empty(address)
    self.winnerInd = empty(uint256)
    self.time =empty(uint256)