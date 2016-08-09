App.CameraEnumeratorService = Em.Object.extend
  enumerateCameras: (store)->
    return unless navigator.mediaDevices && navigator.mediaDevices.enumerateDevices
    try
      navigator.mediaDevices.enumerateDevices().then (devices)->
        devices.forEach (device)->
          if device.kind == 'videoinput'
            store.createRecord 'camera',
              deviceId: device.deviceId
              label: device.label
    catch
