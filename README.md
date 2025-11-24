
# Kroptastic MVP

![Kroptastic Logo](https://raw.githubusercontent.com/benpaymaster/Kroptastic/main/public/logo.png)

<p align="center">
	<b>Decentralized Crop Harvest Optimization for Farmers & Supply Chain</b><br>
	<i>AI-powered, blockchain-secured, and built for transparency</i>
</p>


## Overview
Kroptastic is a decentralized platform for optimizing crop harvest times, starting with barley for malting. Farmers record key parameters (coloration, soil moisture, nitrogen, carbon, etc.), which are analyzed by an AI model to predict harvest readiness. Crop data is stored on the blockchain for transparency, allowing supply chain participants (maltsters, pubs, importers, exporters, farmers) to access and receive notifications.


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


