require("@nomicfoundation/hardhat-foundry");
require("@nomicfoundation/hardhat-toolbox");

function getRemappings() {
  return fs
    .readFileSync('remappings.txt', 'utf8')
    .split('\n')
    .filter(Boolean)
    .map((line) => line.trim().split('='));
}

const config = {
  solidity: {
    version: '0.8.23',
    settings: {
      optimizer: {
        enabled: true,
        runs: 9999,
      },
    },
  },
  paths: {
    sources: './src',
    tests: './test',
    artifacts: './out/hardhat',
    cache: './cache/hardhat',
  },
  typechain: {
    outDir: 'types',
    target: 'ethers-v5',
  },
  preprocess: {
    eachLine: () => ({
      transform: (line) => {
        getRemappings().forEach(([find, replace]) => {
          if (line.match(find)) {
            if (replace.includes('node_modules')) {
              line = line.replace(find, replace.replace('node_modules/', ''));
            } else {
              line = line.replace(find, replace);
            }
          }
        });

        return line;
      },
    }),
  },
};

module.exports = config;