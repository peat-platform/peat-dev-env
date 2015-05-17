/**
 * Created by dmccarthy on 17/05/15.
 */

var fs               = require('fs')

var new_private_key = process.argv[2]
var new_public_key  = process.argv[3]
var file_name       = process.argv[4]

var file_content = fs.readFileSync(file_name, "utf8");


file_content = file_content.replace(/'-----BEGIN RSA PRIVATE KEY-----[\s\S]*?-----END RSA PRIVATE KEY-----'/g, JSON.stringify(new_private_key))
file_content = file_content.replace(/'-----BEGIN PUBLIC KEY-----[\s\S]*?-----END PUBLIC KEY-----'/g,           JSON.stringify(new_public_key))
file_content = file_content.replace(/"-----BEGIN RSA PRIVATE KEY-----[\s\S]*?-----END RSA PRIVATE KEY-----"/g, JSON.stringify(new_private_key))
file_content = file_content.replace(/"-----BEGIN PUBLIC KEY-----[\s\S]*?-----END PUBLIC KEY-----"/g,           JSON.stringify(new_public_key))

fs.writeFileSync(file_name, file_content);


console.log("Updated " + file_name)
