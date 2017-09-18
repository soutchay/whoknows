# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
Clarifai = require('clarifai');
base64js = require('base64-js')
btoa = require ('btoa')
fs = require('fs');
FileReader = require('filereader')
app = new Clarifai.App({
  apiKey: 'findyourown'
});

global.urlParameter = null
global.base64Encoded = null
global.dataUrl = null


module.exports = (robot) ->

#  robot.hear /badger/i, (res) ->
#     res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  robot.listen(
# Matcher
    (message) ->
      return unless message['message']['subtype'] == "file_share"
      isImage = message['message']['subtype'] == "file_share"
      console.log message['message']['file'].url_private
      global.urlParameter = message['message']['file'].url_private
      isImage
# Callback
    (response) ->
      robot.http("https://files.slack.com/files-pri/T729UUV5X-F73CWLT99/hotdog.jpg")
        .header('Authorization', 'Bearer xoxb-240852848146-lvQNG9KOx9XPnkbH9CAl1eeH')
        .get() (err, response2, body) ->

#           someString = btoa String.fromCharCode.apply(null, body.replace(/\r|\n/g, '').replace(/([\da-fA-F]{2}) ?/g, '0x$1 ').replace(RegExp(' +$'), '').split(' '))
#           console.log someString
#          global.base64Encoded = '"' + body + '"'
#          base64data = new Buffer(body).toString('base64');
#          console.log base64data
#          global.base64Encoded = '"' + base64data + '"'
#          app.models.predict("hotdogs", {base64: base64data}).then (response) ->
##            console.log response.outputs[0].data.concepts[0].value
#            if response.outputs[0].data.concepts[0].value > 0.8
#              response.reply "Yes, it is a hotdog"
#            else
#              response.reply "Not a hotdog"
#          .catch (err) ->
##            console.log err
#            response.reply("This is not a hotdog!")
  )

  robot.hear /^(http|https):\/\/.*/i, (res) ->
    res.send("Checking if hotdog...")
    app.models.predict("hotdogs", "#{res.message.text}").then (response) ->
      console.log response.outputs[0].data.concepts[0].value
      if response.outputs[0].data.concepts[0].value > 0.8
        res.send "Yes, it is a hotdog"
      else
        res.send "No, not a hotdog"
    .catch (err) ->
      res.send("This is not a hotdog!")

#  robot.hear /hotdog/i, (res) ->
#    console.log "hellloooo"
#    app.models.predict("hotdogs", {base64: "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wgARCAEoAe0DASIAAhEBAxEB/8QAGwABAAIDAQEAAAAAAAAAAAAAAAIDAQQFBgf/xAAZAQEAAwEBAAAAAAAAAAAAAAAAAQIDBAX/2gAMAwEAAhADEAAAAfqgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACvjUv3Xkrq6+ncvp6YZEwAAAAAAAAAAAAAAAAAAAAAAAAAA0d7wePRpUXdfg9ngVegxZ52/q1mz6PidPHguzzacY6l3PlV37PMdf1uToNTY6Mpi8AAAAAAAAAAAAAAAAAAAAAU/Nff/OuH1dmzWjzehvbHHXr3HFxNPV6fnNfnx2Y7G7126HV4XW83Gzznp5Ked7O1jSuLtaFY2Ja0qT097zex6PP3Ghtd2Fo0qAAAAAAAAAAAAAAAABV8r+s+G5u3gZ7vf5O7wkfoXItHkcdTlt8ZwJyqzE2dLl68Ze2l42fPj62ny05np6mxv9M6/f43R46bXG7cMc+Dv61/Vfp36+c8NxoSl0LeTi0eicfqery2DagAAAAAAAAAAAAphV5WvW8v1d+/myy161/DnfP0FnCv1wnxu9fefB0fSNZr4OPrORG3HjM0xdXKs7F2rKJ3r+TWz9rd57qedhvx5+pMdDS4lnTpZPaxu62zwu752enVu+K3n3lnz3o9Ee2u4uw5u3b52V6egcHa6M+o0NnelwvUAAAAAAB471/zXk7bVTz/AErpUZL80SRsWamUb9vNsmu/PnTmvVt5MrZ9zV0LtM9Piey2tJ+cWe70mvks9vk13042xI0bFk1t2tSNdepvedstTs9fyu9zZek1VvHjq71OrM7tPH0tb+g2vLdqG3nS4cvd0eJ6nbl3rtDq2wr2FFqdKfE3Nab46cgAAANP5z9M+Y8XoWZpcnfcqyi5VKJtQQunTlF2aZwus1pI2c68kbVunKadW/jWaZd2/g364XcvrW3eI5/0ult88s9Vyq9HMjZXToVWxRub3E165d3U518x0+r56zR6DT1r7Z043rzj196Fb+ep9FqV01unx66x7i3536O3H6nocTp9HFsDqyAAAfPfoXBy38Jmt5/r2qpItlUibp05qulTKFua8wtzXkszVItlTlF9mtlG3LVK79vPTXp28qc17Gxw79Me3pa9umejzfTWTp8/h9F1I28JH03Ir0aOYzrrmyvMTddpxmOtfxcWz9Db5q29O9ytfViWrtaMX971PFeov5PpB3coAADGR805n0z5rw+rCdbLe3NWYWzpzE3ypzC2VUqzZmuUJyqkWZqyWyqxC5VInKrJdKjERt51iNq3Rkjoz5ya9S7kytTt2cOy+fU5srZjicz2Vk7eIj7HRa+cx0+fG0MSwmuONbSlmjdVty9r2HmPVZ8vpx3cYAAADgd9W3yKPvvCcXqVpKa4zEm3NM6rc1oXqpQzZVJNma0LUcwlKtE2ICSAtlVktzXKFkqSL41ZhbZrYNuWplG5LTzNelbyU1793m7dMupzL928eI5f1D5rtOhKvtTXuel8x6jCvoR6XAAAAABHldeET8u0vqvkebu81FjDrZiTOVWYi2VeYmyVaFyvMJ5rlE2YhlM80yJ5ryW4rQvxVlNmacxF2asJujDJOdWIi2VIuxTktVxLp6iY7HOlbfl8vu63Vm237Hxn0Hfm2R28gAAAAAEKtiJyvMe4ppp8u1/qPFx6vEx7nHy6IZgre3NM4XT17Im6NUoTzASlVmJszWLEMFma5Qlmsm1XguxWhZmrJbiGCxWLIxiWxrjMbOzo7EZ6+6Wy3/c+b7vbxbWa7N8gAAAAAAMRmKKtuJoUdSs8zxPeVU1+YUfUeXlv4SXc4mXTKNal7c0zTbmrMLM15ibIxiXKpFimRbiGE2ZqnETVkzzVgnKqRPFeCWI4lPY1roz6N1He34t/d0d/s5dq2u0AAAAAAAAARkIQuGtXt4NCjqVnlOF9Epz1+WY+lcLLp8jnocvPe5TKtrVeU2ZrzE24jIxkhjOMEsxJliOCTGECMs4RJbmh6zTn3duO71+dPdhsylLGQAAAAAAAAAAABjIhC7BrVbsTnavYrh5Ple9qrr801fqGtnr84e15tNvPOnpU1hmqVbSzXlMsRwTYIZiTnDdmulZ3exrz83sy2ujixu42pjNjIAAAAAAAAAAAAAAABjEhXC/BrQ28GjDfic6vpwORqd+ET5un08Yt5Z6eMT5p6TB52/t5mOfbuztTTt3LDX2LrCNmcgAAAAAAAAAAAAAAAAAAADGRjEhXi0UYvGtjZGtjaGrnZGvK7JXKYjIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/xAAtEAACAgEDAwMEAgEFAAAAAAAAAQIDEQQQEgUTISAwMRRAQVAVIjIjJDRgcP/aAAgBAQABBQL/ANCnKMI29Spify5HrFJVr9Nb+51V8dPVbdZe8DTPkcclVl1JT1a6JHVOUZWzZztO7YR1LISUl+w6jd3dRVFSaih5ifJKvJKmJpqFWNpKV2DvZE87c5Vz70oNaitkWpfrbZdur8qTRG+aO8pHNZ5YFI5FlmFO6y9w0pocqhEoprt6vSOGv1BCSnFWWHesZ3LDvTK71L9R1D/h5x6Pwvjl4hq51KUp3yh4cJcq9PZiSZE4mD+qHNI7xyzsynUyI6hMU4v9LZHnB/1eTOd87NCPIpYJPktHquT5HMcyVhdqVEVl7NNdLuoaNbO7Txr6pIjrtLM7icY6iaPqWfUsWpRC6Mn9/wBX0rWpo0cEQ4xJRhNX9PqmT6fqYE065C9E1lQ1V9a/kLD622RF2WlVUYEZJqfxXNSjHySj4+ghmGhqQocV/U5xOSe9N+HGUZfe6i5UwlY5y5Cs8dwVgpkuM1d07TWlvS74K2E6xbPbBgQpCuaFYjS2YmmcjkkOwlaStJ6pIq1qzXLki58VXrtJcoZaVtsRalkdRAhOM19tZONcL7nbYZMnIUhWCsFYKw7mVLS6W0s6TBlvTtVAknB7Ji3lk02rVhyHMstUVLUym40SsI0VpSrZo49qyJOI6uElHi6dVrIlF1sx5ZxbOU0R1NiPqhamBGyEvsuo387smTJkzshSOeBT8cxWtHfeO889yFinoNJYW9JebtNdSJ5PJkyTSkRnbWPUak4ubg+K7viq1HLKlPi4s/yLKI2EdJWKKiOUUSuFf5WG2zS8eboR9P4VM4mb0LUTQtTWyLUl7beFJuUjJnfJkzvkTEzkcvEbGd14jaWafT3E+l0tWdLvRZVbUfJjZPbG3PB3PGjvyKR3B2ErC29RXO20ddsTuHcNdJTVV2oqK+qXRK+p6eRXbCxfJKA63F1XZftat8dKZ2yZ9GTO2fCZnbImRkQkKZzwRmKZdo9PcW9JWL9HfQvRjaSKtdxPrKSWspQ9RK11VRUsoeMTqljt3M7KQ6xxHE44KtXqaivqjNPqKtSWVtlNvn2bYdyp+PX8+tMRkzkyJikKYrBTOYpl1VOoU+k0tWdN1NZKE4C3ccjqFVgic2jmxXiujmN0G00YQ61jsJk9M0SrktmvPT+oyc70Uz7kPZ6rV2tXnbPu5Mn4z4ycjIpCkKQpkZimcslml01hLpdTLOm3xLFKuW+dvjbIrGQuwQtRGwjPJyTWoaQ2Wo6dd9To9G8T9nq9Pd0x+TO6ELb8Z9WTPkyZEzJyyKWRSFYK0Vh3BTOSmrNJprS3pciel1Fe2X6MiZk5HdY7pjllylhSlg6DZ/el/wC/9rqGnem1Hoz7uRGdsmTJk+DIpHPApncOYrBXCsJqEyzQUyLdDbAl/V7vdsySkxnSVw1GnlnWe1rtMtTROLhPbJn2smdnt+ds753yZGKRyOQpisFYKZyUlPTaexS6dFlmivgPwxkhskyUsLpalCGiSes9vqWh+oi1h7/n0pmds7fD9P5yZ9GTJkyZMiZnByOZzFYd0jac4zU9FprCzpk0tRF1jkORRW756f8Ay6f51HudR0K1BOLhPx6ci2XnbPpzst3vkyJ753zsts7cjkKwjc0R1BZKNseqaV6W2uhsp8Ffg6T591ms0sNRHU6ezTTT9KZkz5Efk+fbztn052zsn5yZMmTkKZGeTqtfOlEER8Q6XHGk91lkFOOr6YSjKEvRkztkzsts+WZM7Z3zv8Ce2fRkztnbO2doSwS/vGKw64+GjTx4Ue+0X0QtV/TGi2qyt+nJkTM+jx6Pxtnz+dsmTO62yZM+cmTJkT88jj/qRRp4c78/YtDiShku6fTMt6dZEnXOt75M7N7Z2/HqXr+PQjOzMmREGVYe3T4cIpi+yaHEcSUMlugpmW9Mmi2mysQmcsnjbPs5frz7DMmRMXxTDuTiyIvs8GBxHEcRwLdFTYX9MmiyudT2QvRn0ZM7Z95ESuPccFxUCAvtsGDiOI4kq01d06qZd0+6A04v8Z9nG349L9WTJRDuWQioqKIIihfc4MDiOI4llMZq7pkGW6C+sknF7Z2yZMmfeZ8vR0dqEUQiRQvvcGBxHEcSyiEyzptLJ9MmizS3Q9Pn3oQlY9LpVURRGJFCX6HBgcRxHAcCdMZlnT6ZE+lktBfElVZD1fHpWSGmtkVaFIhWopRIxIxEv0uDBxOJxOBwOBKqLJaSlj0NI+n1H8dWfx9Z/H1n8fWfQVkdHUiNaicRRFEURREv1ODBg4nE4nE4HA4HA4HA4HA4HAURREjH6/BgwcTicTicTicTiYMGP22NsGP+nf/EACwRAAIBAgQFAwQDAQAAAAAAAAECAAMRBBIxQRATICEwMkBRIkJSYQUUUGD/2gAIAQMBAT8B/wANKbP6RDhao2hUrr7zDUea9toXFPsJzv1C6t2Mq06RP0iCj+oaSnaPRKntCpGvt/48fSTMoOsNMQ0pltCpjCXG8OXYTl32mQbiVKG6wqRr7PBVcrZY+Jy6CLjFPqFoHV9DxdZaC0LW0h7y+xhSltMimclfiHDrGQrr5h3lChyx31hS8NEQ0YHqpvBi/wAhFxFNt5YQSwjJ8QrBTgsJmBjRUz7x8MYaI+J/X+DDRcQqRqPDgkuxb46LQoIUE5QnJK+g2gq1V17wYtN+0Wqj6GFIFgQRqN9IyWliNJZm1mQDWFQdIaeYWhoVl07xs49SyyHaNTt3HVgT2I67cCsNKNQgaquhgxRHqETEod4DeGGnApnJvOWyzMw1grwVVMahTfaVaDU/qWVF+4dOHfI/itLTJDTjUpkZdIK1VYMZ+Qi1kfQ8SAYaQMNCJTymM0cajqw9XOv78lpaZZkENOGjAHTSCuy6iLiVOsVg2h4MYzRx2PUrFTcSlWFQewtLTKIaYhoS9anoYcRm1EHeV/SesEg3Ep4kHs0HszKi7wTEHt4UqsmkXFj7otRW0PC/XfjfqeAys128i1nXeLivyEWoracL+Vo9S3YewWu6xcSDrFcNpwv4q75R7QVnG8GKO4gxCGB1Oh434lgNY+JA9MZixufcAkTmP8zmv8zmv8zmMd/+G//EACwRAAICAQIFAwMFAQEAAAAAAAABAhEDEjEEECAhQRMwUSIyQAUUQlJhUGD/2gAIAQIBAT8B/wCHKcY7izQfku/zM2T04iTn3ZoPqWxLjZ7RPWyvvqZHicsHuYuKjONsjOMtn+PxXdoTaNRd9iPC9+5Gl2RnjpmzFklj+0lmlLwetk/sevkW0mcNxt9shHJGWz/D4iNqxRQ8ZVcqJRU1TP2k/AuEfkjgijisWhpohLQ1NDz434P3OSP29j95m/sR/UMi3MWaORWvebozZnkf+FiyCymqLNKezNDLGbEvrjpZKEoOmLUyHCvyPh40ZceiWk4fS00xWtpUPi5Q/lZH9Qj/ACRHi8UvJHJGWz9nipdlHp1GpmtizfJqgzRew00X8lpbI1MWQ4mGv60J+S7/ANIYJTMuF46MCqZowy8Cgo/bI1ZY7OzHxCbqXZ9XFLuiiuuxTFlLiyk9h43yR6WOQseOJ6hqjJdxRj4HiNEkamilMwZH9kunNHVEoooorrsUhZDWmfSzRezNLXNCmz1CU9SIo2yJ9WWGl8qKK517Gpmo9Q13yrmkRReqa6mtSpk4OHOiiuqvY1MWU1RkY62J5KXYwd5rravcnh+Odcq50Vyoooroooog6ZI4ZfV7MoKW48HwOLXKiiiiiiiiiiiiiiihjRghpj7jxxY8PwODW5RXOiiiuVFcqKGY8Wru/wAB40x4X4HForrrohDU/wARwix4R4maWupJvYjifkSrb8ijQjRH4NEfg0L/AMN//8QAOBAAAQIDBAgDCAICAwEAAAAAAQACAxEhIjFhcRASICMwMkFRQFCBEzNCUmJykaEEsZLRJENwgP/aAAgBAQAGPwL/ANCm4gDFWZvXuZ+qtsiNVmK2fY0851neg7rWin06BUGxuojm4KUWGH5UQPsy3BypTJcy5laCmPMTLlbQK1dpqwK5Ump/Hpv0tLTfRSez1CvlmqGflrndhooV0KrRCqqQpmUtGClAoPmXvH/lBpOtI3nQQagr/jxXmH0F8lKJ/HET7RqlaxhPhu7ErmV8sguYq9SND5RFyVNjBX6NVzddvTBbzl6NCpd2WK1e92xU6KLpsFpE9VVaQqOHkrmnqFqm8cT2cU2+jvm0X6ZdewVIdMU1kRmrPT7X+OQDc6YnRb6AM2FVcWfe1ThxadNR01WRC5f2uT9qrSpXHHyAPZ/2dMVbtn9KyGjJW2grdEw3fkLkD/tKk9pYeztuVHj6r17kflUYwZlW4kh2apBoz0TF4qECLipKRFCqOcB2XKXZroBouV2nUdPNWT42ZRc412pPDXDFWAYR+lThuZEwuK3jHMzHA66Sw9ajboZ5K0HNzVNGvfq1XvNTB4kpwnzH0ldDmqsHoVam1WTPw5c80U3cG9d1agtnhRbqKW4OE1RoiD6SpPBacacDViENi/3pm4yGKlBbPErfP9FQLlYc0WfCajRIpzD8JU2ktOBkpQ3mLg5s1v8A+OGfa5UGjncrRBGSqz8FV1h6Kjh4LUFzePJ4a7Ne71PtMluIol2et5CdLuKhUOxVbuK6Xa9c/wClOIS7NDRfVBNcemm02q5Z5roBpvVVRGG668aL1YcQuYfhW2j0VZj0UwZ8QlE9+PdsbyC3MUW7fEZ+1u4jImdFvYL2jvLbpor1XsybQuxGzUyVhkh3cp6x9NIh4zyW7juyNVvYbXju2hVS6H9wU2ODlRGim0yK1X0PDin6TwabddNbtmsPVd3bRbmKZ/Wpvhzb3bVY6b9IIpJSj/5Be9aveA5LdiQ+YrWdaPc6d2RkVadLJUGxSYyVmKSOzqoCPB9WFbqJmOq7LUff34TmfMJLHwFeFvYYdj1W6ivYcaqzKI36SrbHtzbwb1L9rsuaumgE+iNKKiqNExMO7hCB/KN9GxP96J8J3yvteLv02oLfSisRXszqrGrEGFCpPaWHHiVRul0VCpSqqqqa99YjTqOT2evC1hzMr4Pvou4F+xJwBHYqsMA920U4EUHB6tQXeleHeqqRCl0UeH3k5NkaV4er8Bq3wVVXgU4NuGx3orBcz9qxvG4KTqZ0VOFGdK5oChev9cMt+L4Si1wk4eBr4CmzaAcMVWGGnu2isRjP6guTX+1SdNpx2anRO5zrSmb5E8TXh+9H7UjOfGEvXxQUnhrhiuXUPdq3UQPwNFJ7S046KqZ5Bf8A6WSfg3i67KRf7Ra8SOPgKeAx4eq9oc00kUPZzdCddPpgpv8AwEPxoiu9ONa5uhVsWehHlYd2OwD3JPHIcJhF0D/ErVeCDj5JTZw2IbTeB4GT2gqcF3oVvGkeTgJ2ehgxrl4SqoNU/SrBDv0rbSM/G4cB3fRrG8+HqFy6pwVhwdmrbCPI8B4yrJHuFOCZ4FbxpbsV41eKAPUoAeOkRMKzNhwVmTxgpOBB8WAFIeRSe0HNbslqu1hgpHw9FXmN/k1toOaszbkrDwc1WG70r4OTRNazqv8A68rtNBzXLq5KxE/KoAclaY4cOi5ZZreGeAUmiQ8xq0Fe7auX9r4le9XvV71e9XuXJPNWQB/8Df/EACwQAAICAQMDAgYDAQEBAAAAAAABESExQVFhEHGRgaEgMLHB0fBAUPHhYHD/2gAIAQEAAT8h/wDoTQu9WEmZxSGybunBYccpEkQvXF7icqsf3D1c8bgubei+wSazcoVmU/A02xXInQM5WcpXgbJG3uEtcepZDy9L8n7EvwPe+F+BSLluiXsr+xjjfrNiTOH1IEKE/twLZnuOPrIjKC4IGB8littXocsN+TpJEZNWiBR4JpzjgaBoHEeJHuJJUnD/AK2c9Zje6eglC+CsEGLp3IEOLeIF4hZYnNNOth1maFMbcJbbLhaut9h6zJmnlitmzEEGoYpKFDRNb/H6TTHWu7T8Ags3SP3QvSf6jQj1AeQUvf3RDW/j+pfvJFicNjxsQW4aNClvQOLLHY9agQ+AhTiWw9dx6eYJY3vokWe/8CcZOjgxV+gPckwozyMfRKFlN9XGgwqN8oew49p/pV41ESYiGQzRFikhW9jGRtpj1EqRGSlCaWaNwRaba2a0Gp9tuHcWl0+kmc9Fvae4Y1lWqxLg2DmUzQaiITQ0mAxqn2XszPLt9xCSzdaB4HXklDOCOB+uxoB2sy5oLV/QQitZbNwvl2jTH/Q9KHZIIMh5Ui2fOAdOEVr9oZNsSCJWRtIkbfYam2YXGxKJ4JZa2PyGhYcbuoUSncHuXAahqeEqgzWuC55EoaEsC20pENPVD8LyYHUvu9eBcCS2iUEorsZI1QYrGiOSyiVlHAklLXH83PlvCLohirM0UJwhcznFN7Mfh9rJYbhevVDQmgofSpeR5tOSy+o0nnpSoStxq1SNiAqew1K9l9hblT276o1xTFzimqHPLM8DyJO1iiU7pQtTaU9h2p1IKDlmlqtRYhnf+1g9XHKikb7Ig3AaVHcqfoSBacfx40iGnjRbImuR7PcUUhW2R6LwOHLWTnvpMRtJsyRau78IwnbvqBI8s+0ziPayETGGboyeLO/uRsa8tNWmLlgK8c0OLtGyOKKNRKnPjXoi8Y1rgvAkrswQogtROYzRLsPgtRInqUMU7gvbQfyJEcQP91iC13ln0GZKEY174JOJ8v7DV8gCj7Vkj6p3ZfQzN9f4U83T7vqWFbpmxrIGKCrbJYT50FoXcxjFDbxMCVFukKCzsklpY9fpC+a2tr1Q7cT9QxGE+zExyz0JoQRQhuOHuOK19FIVk5CEGtSPoGoVRHnG4bb4LKHCThl4pphrIo5cvMTROwVGIUkGsdLVidGZYD0xMpG8PYicjZwadhz4l/YevPQP7S9J9YYhCTdfM4kUjw5aWTBh0TPYkwZVUKGRO39yfoc2SkAmm3QoAnCTlCXJjah0TUlvQl5RH2veAlngrRNO5El5RSKGmnt0e4rGCooVHDkUpp5CZrstBqyI3fb9JNpiZE/CKrZNomnIrDZY/wCQ8m5KHSjCu40SMzW0dBekit2PuPkteMCvffvaIY7dMdaToIawMQWkaopxaD3+Wlg4/EN+ODcSUUukKd6E0SJ+ScwF6xOc4PUKc2LVoJpSWQ8hBaUovtQgalxs9xdJ5RtKO5xmSexKfqiSDc4E3GE0YnuJ1mBcBs6zBhEzYbNKayhyQOdv6oTFUXLgWfcCGNx7PoZ2r3SJKfLJlW4jhu6aYXjHuJByTrcyMWI9D/F9CLTN3FBspCdgv3QxpE25Seg0b9A1p2O75UxUmBLp4OGthu/wJrehxM+zJsmyY4kdIZj1E+JJqJJE5UkvOhoMbb3FWRZnIrQ2NrWKHKpodJZGBq1k95roaF4InqKfgmxk49oPwxdj6bZQ03Mmn46LXkk0kiYgRp5jsQIkUaUiGGblatRyTc2iPpO7UbUOJHld8jNA7szCZNMyW0muRrcuUQKjELTIa9Rbhz0Evb8iO5hpyJTi8Nc/KlCqh9/c4k0jcfgkTE7JzqJ8ifSRMmM9yazDLbwhWhZE0uRFI5uPBRtTfB20LKfchWaKYkfvg3VZsw6U0huU8pjRORv+IcTxUDOt+c9hnCNVgTVx7DIOwUxdmUsTQo4FsyyXxtJhOEpqGIcPucUPdqLlOSHcyeB0kSTmUZcOSmMHsS5lOVrXxBtlgv30+V/m61J8C8CbHTJNyTeZGGG8E0J4N3uYE0pMKXqJ1BNYomqmCGUrOSXJMa2PN4Z7dP8A3F+0XVJuL4FrWnRFG/cU3Dh0V4C8jebZsnvPuhSk9l+UTzhrLq9iU9bEitCZUtDUGkyZQZaQ4WnAmmc69hKy5WzGvtRDvNi0Q1wQHKdPBC48F/Ri2nE9VfKaTTTUocEU2nA3kmTuSYUSJ5nImTEazYmaUT5Jmz/RZhWyYVUsMT2PIRuQ4RvzsTFLJyqRQcbDeE/poLRqS+Dx3KKaHkE1loUqygtcmvMo0RsSmN23D1ZazxuBJvuc/ArVI+yhqbsQ0yxINBqGaJniS9WRm8Yktw2hjdvBUq1fLOzCW9hj9TMOdOk6GhFiaEzXMid4JsnwJiwTGO4rVbN+Y9ibzO4zVNpS2G/Ubbll9J1Rqm0xOnsTsLUS3ehLmfVFHyJsZGcw1yWp7bmTbyOnLJDT0J4epLPnsYRw3GEkI7oAkr/owYZE3efYVvXsVjphsYpjNCmZuEKS3T+iEF1IwzGhouKfT7/MVAQjsl2ZNqRHDT0ZGRidxAmONBfTpMQJ+SyygqcmjI+43YWaJYnQpck/g7RsLmtybDsLbQ3CmaE6Foll+/Rj7mRbUqhV4RyULQJRMwjbJWDQdNFH3sUk05O3cLIormMew6PgCQrgt2hcxKct6Dn9ycDAlTYg3+jf/PmMTOFS9O8cFXTQWxnOnSaE+hxTPYWz0iRMtkTeSad2Kib2Kpy4J0GU28E1yTAwnUktmHBwHJp7CbJ2L0T+7j8slAT5gZzySthwSoT2wx82xMuCNRN79EmS0HFLpJpi91nybcIVhiZPqNNKhUSHbqciYdNpH+9/moQ5YTDlEcmbhMbOSod49+k8DpYK9qgTbjZ6uTKrE6jeDMFmBXaiCe40jK4E7Q61Eyck7kxwaE8E4emhRwnKw41E9Uarkm0iYVE+Ca3ih1/aEzYTZDLDQ6FNZL49hQFG5HK2ViK3Nz7CuU4nsb9PVGoqNyiLceY+3zkExG5TIWzX7QyMFZQoncdIms2SsTJUTqaEsC0xJPDkaFfsTvgfAuwyqLMZFNzhPQbKCd5JTiTL2E9WOdidBbuN3BlOhNdFq2o7EEnXPV5G5W6MTreDBx6CcXqQlvkxXkoJlO4cCHJrORqSlVsNxAp9/ntdOEp50HjkL97IVyr6J6skk+goKDOY4JHVCSYRiYdGugsjaL0JUJp0a8ick2nQnWVBsOHIltEpoTbnQ7UjkrJbFOCW8sbhbswaePqTyQSv2Iv0HPgW0ISoqBqk6vIrLnorpBCvWUFNFcyrfUEE/ntdWWjSSuSYfLfgTzU+REO1jkyTYoehe9yIh57GwidsHBkld+SZd5E1tL2E9yYUwp5JuzDnUayUuk1CJrknwacMnUJ7WT4x2Hah0dwhhDslrY4Np7TJaHESN7CFZkFKOhvRV3JVWmp26bC+fA18CKUaQ1yXncVLlZtRjeq3ivI0Ozho3aihtIh2TGopUYgmoGoOETPcT0E8XKZMkkdJRPoyp4JQnGo5CZrkw7HuYqRZG/AzanJRQLQqgmgdJZIemrG+k/Sv4MDD+CLxE40dhKEr2GRBlyqYnLJGsbZNlPPoT6kuJiBQwTM9PsLRp0N8Crkl6WJ+omE7JjGSdybjQTJeg2TN/QkmM66jw5HvkdS2l2BeFKhBBRfxIGGX1K5JbDRONfCeCVfvDwPWpEqGh6024JUTD5G6zJNCfoTtlE7lVsJV9xCOfUjKZ4K1knG5MUSTd5GUErEE9kh4yKfUY93uZDsByxZXCXwaJ/IgYfwRY8HgSba7ZRiOd+Iwpaa3FImZZE9eiGldScE2LvBJgm+BtepI2TosGB0ZcakssuJLeiIGP0nHwJp/MgYfwRVMJ+BOtH8h/Kvag6l5b/gJinT2Y2mJ6yLoWLJWBfTonI3KrcVKskk2ToaCwTIuvMf8wuz4W5L+dBAw/hiCrx6TDM3M1PQQxg8jTk4JeCYJnsT0mmxkmcUduiM4SXwP5o3oW3hiIudhfDNJf0UEDDLDLLDDHutIyvpKBvDrsw4olVwz/XX4Nf3l+D/SX4P9JfgW++q/Bb2cpEUJOEL4q8Jf00EdDLLDLLLD+MAgvgKoJf1cEEfMZkiihH9lBBHRHUggj/xf/9oADAMBAAIAAwAAABDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz/7/wA88888888888888888888888888/5APLt2e38888888888888888888888XVE0Kl4QZph5+888888888888888888buQ0VVH0vPm/aL5y+8888888888888/PAsBiv+I6xhS1kvupHo6/w88888888kWq8FCUm+MZwKT0tEwl92givM0888883sdIG9qwUJKP2muwt4lW3XnnTL+88885qpAnTzZI1tNBK9OwN1YK0D29Wr8888sCjjWN2apsuAErnvG1kHUKK5sBY88888quBc6TLglBOwyoilPye5WJvFJS888888AFM8zy0BqYIQTQHkoH9Ni0RL4888888skOmfT3sbBuGFrm1X/bmDHTURY888888888083MX4Lm2DNM7MmqiGi+Q4888888888cYIEnGJxcegi/wC7zmseIc888888888888MMMvQ32gB8EnCHdJ4U8888888888888888sUssc/5nMN80QU88888888888888888888cMos8Qg8Es88888888888888888888888888888888888//EACsRAAMAAgACCQQDAQAAAAAAAAABESExEEEgQFFhcYGRofAwsdHhUMHxYP/aAAgBAwEBPxD+DbxjE1sdRWn39czzTLFaXheguf7hPGp+fBOmYX0oqj/oQmV0aFOrqXNN/b/R6SjeEISq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"}).then (response) ->
#      console.log "in there now!"
#      console.log response.outputs[0].data.concepts[0].value
#      if response.outputs[0].data.concepts[0].value > 0.8
#        res.send "Yes, it is a hotdog"
#      else
#        res.send "No, not a hotdog"
#    .catch (err) ->
#      res.send.reply("This is not a hotdog!")

  robot.react (res) ->
    robot.logger.debug res.message.type, res.message.reaction
    if res.message.reaction == "hotdog"
      res.send "@#{res.message.user.name} reacted with a hotdog!"

#  robot.respond /open the (.*) doors/i, (res) ->
#     doorType = res.match[1]
#     if doorType is "pod bay"
#       res.reply "I'm afraid I can't let you do that."
#     else
#       res.reply "Opening #{doorType} doors"
#
   robot.hear /testing/i, (res) ->
     xhr = new XMLHttpRequest()
     xhr.onload = ->
       reader = new FileReader
       reader.onloadend = ->
         callback reader.result
         console.log reader.result
         return
       reader.readAsDataURL xhr.response
       return
     xhr.setRequestHeader('Authorization', 'Bearer xoxb-240852848146-lvQNG9KOx9XPnkbH9CAl1eeH')
     xhr.open 'GET', 'https://files.slack.com/files-pri/T729UUV5X-F73CWLT99/hotdog.jpg'
     xhr.responseType = 'blob'
     xhr.send()
     console.log "done running through this..."

#   lulz = ['lol', 'rofl', 'lmao']
#
#   robot.respond /lulz/i, (res) ->
#     res.send res.random lulz

  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (res) ->
  #   res.send res.random enterReplies
  # robot.leave (res) ->
  #   res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (res) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     res.reply "I'm too fizzy.."
  #
  #   else
  #     res.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'
