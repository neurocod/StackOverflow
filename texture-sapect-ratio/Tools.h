#pragma once
#include <QObject>
#include <QGenericMatrix>

class Tools: public QObject {
	Q_OBJECT
	public:
		Q_INVOKABLE QMatrix3x3 scalingMatrix(float x, float y, float z)const {
			float values[3*3] = {x, 0, 0,
							  0, 2, 0,
							  0, 0, 1};
			return QMatrix3x3(values);
		}
};
