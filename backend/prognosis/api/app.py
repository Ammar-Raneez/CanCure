from flask import Flask
from flask_cors import CORS
from flask_restful import Api, Resource, reqparse
import joblib
import numpy as np

app = Flask(__name__)
app.config['CORS_HEADERS'] = 'Content-Type'
CORS(app)
API = Api(app)

kidney_prognosis_model = joblib.load('kidney-prognosis.pickle')

class KidneyPrognosis(Resource):
    @staticmethod
    def post():
        parser = reqparse.RequestParser()
        parser.add_argument('age')
        parser.add_argument('bp')
        parser.add_argument('al')
        parser.add_argument('su')
        parser.add_argument('rbc')
        parser.add_argument('bgr')
        parser.add_argument('bu')
        parser.add_argument('sc')
        parser.add_argument('sod')
        parser.add_argument('hemo')
        parser.add_argument('pcv')
        parser.add_argument('rc')
        parser.add_argument('htn')
        parser.add_argument('dm')
        parser.add_argument('cad')
        parser.add_argument('appet')
        parser.add_argument('ane')
        args = parser.parse_args()
        prognosis_input = np.fromiter(args.values(), dtype=float)
        out = {'Prediction': kidney_prognosis_model.predict([prognosis_input])[0]}
        print("Output: ", out)
        return { "Prediction": "There is a possibility of cancer within the next 5 years" if int(out['Prediction']) else "Cancer within next 5 years is unlikely" }, 200

API.add_resource(KidneyPrognosis, '/prognosis/kidney')

if __name__ == "__main__":
    app.run(debug=False)

