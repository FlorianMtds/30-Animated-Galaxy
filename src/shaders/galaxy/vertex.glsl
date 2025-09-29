uniform float uSize;
attribute float aScale;
uniform float uTime;

varying vec3 vColor;

void main ()
{
    // Positions
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // Rotate
    float angle = atan(modelPosition.x, modelPosition.z);
    float distanceToCenter = length(modelPosition.xz);
    float angleOffsett = (1.0 / distanceToCenter) * uTime * 0.2;
    angle += angleOffsett;
    modelPosition.x = cos(angle) * distanceToCenter;
    modelPosition.z = sin(angle) * distanceToCenter;

    // Project to clip space
    vec4 viewPosition = viewMatrix * modelPosition;
    gl_Position = projectionMatrix * viewPosition;

    // Size
    gl_PointSize = uSize * aScale;
    gl_PointSize *= (1.0 / - viewPosition.z);

    // Color
    vColor = color;
}