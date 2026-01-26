import os
from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/multiply', methods=['POST'])
def multiply_matrices():
    data = request.get_json()
    matrix_a_str = data.get('A')
    matrix_b_str = data.get('B')

    try:
        matrix_a = [[int(num) for num in row.strip()[1:-1].split(",")] for row in matrix_a_str.strip()[1:-1].replace('],', '];').split(";")]
        matrix_b = [[int(num) for num in row.strip()[1:-1].split(",")] for row in matrix_b_str.strip()[1:-1].replace('],', '];').split(";")]

        if len(matrix_a[0]) != len(matrix_b):
            return jsonify({"error": "Incompatible matrix dimensions for multiplication."}), 400

        result = [[0 for _ in range(len(matrix_b[0]))] for _ in range(len(matrix_a))]

        for i in range(len(matrix_a)):
            for j in range(len(matrix_b[0])):
                for k in range(len(matrix_b)):
                    result[i][j] += matrix_a[i][k] * matrix_b[k][j]

        return jsonify({"result": result})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5050)