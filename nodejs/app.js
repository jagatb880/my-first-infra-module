const AWS = require('aws-sdk');

// Set your AWS region
AWS.config.update({ region: 'us-east-1' });

// Function to fetch secrets from AWS Secrets Manager
async function getSecrets(secretName) {
    const secretsManager = new AWS.SecretsManager();

    try {
        const data = await secretsManager.getSecretValue({ SecretId: secretName }).promise();
        const secretString = data.SecretString;

        return JSON.parse(secretString);
    } catch (error) {
        console.error(`Error fetching secret "${secretName}":`, error);
        throw error;
    }
}

// Example usage in an asynchronous function
async function main() {
    const secretName = 'my-secret';

    try {
        const secrets = await getSecrets(secretName);
        console.log('Secrets:', secrets);

        // Use the secrets in your application logic
        // For example:
        console.log('Key1:', secrets.db_name);
        console.log('Key2:', secrets.username);
        console.log('Key3:', secrets.password);
    } catch (error) {
        console.error('Error:', error.message);
    }
}

// Run the main function
main();
