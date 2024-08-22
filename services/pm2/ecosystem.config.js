const isProd = process.env.NODE_ENV === 'production'

module.exports = {
  apps: [{
    name: 'app-name',
    script: './src/index.js',
    ignore_watch: ['node_modules', 'data', '.git', '*.log'],
    instances: isProd ? 'max' : 1,
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }]
}
