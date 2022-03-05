from flask import Flask, jsonify, request
import uuid
import torch
import torch.nn as nn
from torchvision import transforms
from PIL import Image

app = Flask(__name__)

@app.route('/diagnosis/kidney', methods = ['GET', 'POST'])
def kidney_diagnosis():
    if request.method == 'POST':
        f = request.files['file']
        file_path = 'uploads/' + str(uuid.uuid4()) + '.jpg'
        f.save(file_path)

        model = torch.hub.load('pytorch/vision:v0.6.0', 'alexnet', pretrained = True)
        model.classifier[4] = nn.Linear(4096, 1024)
        model.classifier[6] = nn.Linear(1024, 5)
        model.load_state_dict(torch.load('./kidney-diagnosis.pt', map_location = torch.device('cpu')))

        image = Image.open(file_path)
        test_transforms = transforms.Compose(
          [
            transforms.CenterCrop(224),
            transforms.ToTensor()
          ]
        )

        input = test_transforms(image)
        input = input.view(1, 3, 224, 224)
        output = model(input)
        prediction = int(torch.max(output.data, 1)[1].numpy())

        return jsonify(
          result = 'No cancer tumor present' if prediction == 0 else 'A cancer tumor has been detected',
        )

    return None 

if __name__ == '__main__':
  app.run(debug=False)
