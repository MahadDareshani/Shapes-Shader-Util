shader_type canvas_item;

uniform int shape = 0;
uniform int poly_count : hint_range(3, 10, 1) = 3;
uniform vec4 chosen_color = vec4(1.0);

const float PI =  3.14159265359;
const float TWO_PI =  6.28318530718;

float Circle(vec2 st)
{
	vec2 center = vec2(0.5) - st;
	return step(length(center), 0.5);
}

float Square(vec2 st)
{
	return 1.0;
}

float Triangle(vec2 st, float width)
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
	float poly = step(width, dist);
	return 1.0 - poly;
}

void fragment()
{
	vec2 st = UV;
	st.y = 1.0 - st.y;
	
	float sh;
	
	if (shape == 0)
	{
		sh = Circle(st);
	}
	else if (shape == 1)
	{
		sh = Square(st);
	}
	else if (shape == 2)
	{
		sh = Triangle(st, 0.5);
	}
	
	vec3 color = vec3(sh);
	
	color = 1.0 - color;
	float alpha = 1.0 - color.r;
	color = 1.0 - color;
	
	color = mix(vec3(0.0), chosen_color.rgb, color.r);
	alpha *= chosen_color.a;
	
	COLOR = vec4(color, alpha);
}