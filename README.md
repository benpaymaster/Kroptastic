
# Kroptastic MVP

![Kroptastic Logo](https://raw.githubusercontent.com/benpaymaster/Kroptastic/main/public/logo.png)

<p align="center">
	<b>Decentralized Crop Harvest Optimization for Farmers & Supply Chain</b><br>
	<i>AI-powered, blockchain-secured, and built for transparency</i>
</p>


## Overview
Kroptastic is a decentralized platform for optimizing crop harvest times, starting with barley for malting. The MVP enables:

1. **Farmers submit crop metrics** before and during crop growth (e.g., soil moisture, nitrogen content, coloration, etc.) via a user-friendly form.
2. **AI model calculates harvest readiness** using these metrics, providing a percentage indicator of how close the crop is to optimal harvest (e.g., "Soil moisture is 60%, Nitrogen content is 40% — 40% to optimal harvest").
3. **Notifications are sent to farmers** about harvest readiness. These notifications are also available to supply chain partners (malsters, etc.), who can send prompts to farmers (e.g., "Deliver produce by X date").
4. **Malsters receive notifications and can prompt farmers**, ensuring produce meets malster requirements and reducing losses for farmers.

All crop data and notifications are stored on the blockchain for privacy, traceability, and transparency, allowing supply chain participants (malsters, pubs, importers, exporters, farmers) to access and act on real-time information.


## Features
- 🌾 Farmer data entry form (React frontend)
- 🤖 AI harvest readiness prediction (backend)
- 🔗 Smart contract (Solidity, Foundry) for transparent crop data storage
- 🔒 Access control for farmers and owner
- ⚡ Gas-optimized and secure contract design
- 🧪 Foundry-based testing
- 🔄 Ready for upgradeability and further security enhancements


## Tech Stack
- React (frontend)
- Node.js/Express (backend)
- Solidity + Foundry (smart contracts)
- Web3/Ethers.js (integration)


## Getting Started
1. Clone the repo
2. Install dependencies in `frontend` and `backend`
3. Run Foundry tests in `smart-contracts`
4. Start frontend and backend servers


## Smart Contract Highlights
[//]: # (---)

## MVP Architecture Mapping & Development Plan

### Architecture Mapping

## New MVP Features (2026)
- 🛰️ Mock Oracle: Simulated on-chain oracle for soil moisture data (see smart-contracts/src/MockSoilMoistureOracle.sol)
- 🏷️ Batch NFT: Each harvest cycle is minted as an NFT with GPS, Protein %, and Nitrogen metadata (see smart-contracts/src/BatchNFT.sol)
- ⏳ Forecast Backend: Node.js endpoint provides "Days to Harvest" countdown for frontend (see backend/forecast.js)
**Frontend**
- Metric Input: `frontend/src/components/CropForm.js`
- Dashboard Display: `frontend/src/components/CropDashboard.js`
- API Services: `frontend/src/services/api.js`

**Smart Contracts**
- Blockchain Storage: `smart-contracts/KroptasticLogs.sol`, `smart-contracts/deploy.js`

**Other Relevant Folders**

**New MVP Features**
- Mock Oracle: `smart-contracts/src/MockSoilMoistureOracle.sol`
- Batch NFT: `smart-contracts/src/BatchNFT.sol`
### MVP Development Plan
1. **Design MVP architecture**
3. **Integrate AI harvest prediction model**
	- Develop or stub model, connect to backend
	- Backend logic to send/store notifications, frontend dashboard integration
5. **Integrate blockchain storage**

Refer to this section for development, collaboration, and grant application alignment.
- Gas optimization: packed struct, smaller uint types, calldata usage
- Security: access control, input validation
- Role management: owner and authorized farmers
- Event-driven notifications


## Example Usage
```js
// Farmer logs a crop
{
	cropName: "Barley",
	coloration: "Golden",
7. **Add mock oracle and Batch NFT**
	- Simulate soil moisture data on-chain and mint tradable harvest NFTs
8. **Add forecast backend**
	- Provide "Days to Harvest" countdown via API for frontend
	soilMoisture: 18,
	nitrogenContent: 1400,
	carbonContent: 480,
	notes: "Preferred for malting",
	harvestReadiness: 85
}
```

## Usage
- Farmers log crop data via the frontend
- AI model predicts harvest readiness
- Data is stored on-chain and accessible to supply chain
- Notifications sent for optimal harvest times


## Contributing
Open to collaboration with agricultural universities, farmers, and supply chain partners. PRs and issues welcome!


## License
MIT


## Contact
For pilot projects, funding, or partnership inquiries, contact: [Your Name/Email]


