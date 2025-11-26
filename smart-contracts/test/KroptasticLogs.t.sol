// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/KroptasticLogs.sol";

contract KroptasticLogsTest is Test {
    KroptasticLogs logs;
    address farmer = address(0xABCD);

    address owner = address(this);

    function setUp() public {
        logs = new KroptasticLogs();
        vm.prank(farmer);
        logs.logCrop(
            "Barley",
            "Golden",
            18,
            1400,
            480,
            "Preferred for malting",
            85
        );
    }

    function testCropLogged() public {
        KroptasticLogs.CropEntry memory crop = logs.getCrop(0);
        assertEq(crop.cropName, "Barley");
        assertEq(crop.coloration, "Golden");
        assertEq(crop.soilMoisture, 18);
        assertEq(crop.nitrogenContent, 1400);
        assertEq(crop.carbonContent, 480);
        assertEq(crop.notes, "Preferred for malting");
        assertEq(crop.harvestReadiness, 85);
        assertEq(crop.farmer, farmer);
    }

    function testNotifyHarvest() public {
        vm.prank(farmer);
        logs.notifyHarvest(0, address(0x1234));
        // Event emission checked via Foundry's log system if needed
    }

    function testPauseUnpause() public {
        // Pause contract
        logs.pause();
        assertTrue(logs.paused());
        // Unpause contract
        logs.unpause();
        assertTrue(!logs.paused());
    }

    function testCannotLogCropWhenPaused() public {
        logs.pause();
        vm.prank(farmer);
        vm.expectRevert("Contract is paused");
        logs.logCrop(
            "Barley",
            "Golden",
            18,
            1400,
            480,
            "Preferred for malting",
            85
        );
    }

    function testCannotNotifyHarvestWhenPaused() public {
        logs.pause();
        vm.prank(farmer);
        vm.expectRevert("Contract is paused");
        logs.notifyHarvest(0, address(0x1234));
    }
}
