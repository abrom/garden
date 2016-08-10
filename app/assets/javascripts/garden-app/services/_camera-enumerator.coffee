App.CameraEnumeratorService = Em.Object.extend
  enumerateCameras: (store)->
    return new Promise (resolve, reject)->
      if navigator.mediaDevices && navigator.mediaDevices.enumerateDevices
        try
          navigator.mediaDevices.enumerateDevices().then (devices)->
            devices.forEach (device)->
              if device.kind == 'videoinput'
                store.createRecord 'camera',
                  deviceId: device.deviceId
                  label: device.label
            resolve store.peekAll 'camera' if resolve
        catch
          reject() if reject
      else
        reject() if reject
