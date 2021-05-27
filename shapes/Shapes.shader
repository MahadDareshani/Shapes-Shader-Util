shader_type canvas_item;

uniform int shape = 0;
uniform int poly_count : hint_range(3, 10, 1) = 3;
uniform vec4 chosen_color : hint_color;
uniform float outline_width : hint_range(0, 1, 0.01) = 0.5;

uniform float shape_feather : hint_range(0, 0.5, 0.01) = 0.05;
uniform float outline_feather : hint_range(0, 0.5, 0.01) = 0.05;

const float PI =  3.14159265359;
const float TWO_PI =  6.28318530718;

float Circle(vec2 st, float size, float feather)
{
	vec2 center = vec2(0.5) - st;
	return smoothstep(size - feather, size, length(center));
}

float Square(vec2 st, float width, float feather)
{
	st = st * 2.0 - 1.0;
	
	float angle = atan(st.x, st.y) + radians(180.0);
	float radius = TWO_PI / 4.0;
	
	float dist = cos(floor(0.5 + angle / radius) * radius - angle) * length(st);
	float poly = smoothstep(dist, dist + feather, width);
	return poly;
}

float Triangle(vec2 st, float width, float feather)
{
	st = st * 2.0 - 1.0;
	
	if (poly_count > 2)
	{
		if (poly_count < 4)
		{
			st.y += 0.25;
		}
	}
	
	float angle = atan(st.x, st.y) + radians(180.0);
	float radius = TWO_PI / float(poly_count);
	
	float dist = cos(floor(0.5 + angle / radius) * radius - angle) * length(st);
	float poly = smoothstep(dist, dist + feather, width);
	return poly;
}

void fragment()
{
	vec2 st = UV;
	st.y = 1.0 - st.y;
	
	float sh;
	float outline;
	
	if (shape == 0)
	{
		sh = 1.0 - Circle(st, 0.5, shape_feather);
		sh -= 1.0 - Circle(st, (1.0 - outline_width) / 2.0, outline_feather);
		
	}
	else if (shape == 1)
	{
		sh = Square(st, 1.0, shape_feather);
		sh -= Square(st, (1.0 - outline_width), outline_feather);
	}
	else if (shape == 2)
	{
		sh = Triangle(st, 0.5, shape_feather);
		sh -= Triangle(st, (1.0 - outline_width) / 2.0, outline_feather);
	}
	
	vec3 color = vec3(sh);
	
	color = 1.0 - color;
	float alpha = 1.0 - color.r;
	color = 1.0 - color;
	
	color = mix(vec3(0.0), chosen_color.rgb, color.r);
	alpha *= chosen_color.a;
	
	COLOR = vec4(color, alpha);
}