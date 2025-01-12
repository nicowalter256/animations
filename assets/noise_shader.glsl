#version 450
layout(location = 0) in vec2 fragCoord; // Fragment coordinate

out vec4 fragColor; // Output color

// Simple noise function for effect
float random(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec2 uv = fragCoord / vec2(800, 600); // Normalize
    float noise = random(uv * 10.0); // Generate noise effect
    fragColor = vec4(vec3(noise), 1.0); // Apply noise to color
}
