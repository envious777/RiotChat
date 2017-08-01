var path = require('path')

module.exports = {
    entry: './src/scripts/index.js',
    output: {
        path: __dirname,
        filename: 'bundle.js'
    },
    module: {
        loaders: [
            {
                test: /\.js$/,
                loader: 'babel-loader',
                exclude: /node_modules/,
                query: {
                    presets: ['es2015']
                }
            },
            {
                test: /\.tag$/,
                loader: 'tag-loader',
                exclude: /node_modules/
            },
            {   
                test: /\.css$/, 
                loader: 'style-loader!css-loader',
                exclude: /node_modules/
            }
        ]
    }
}