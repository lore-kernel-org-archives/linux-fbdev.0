From: Dan Murphy <dmurphy@ti.com>
Date: Tue, 23 Apr 2019 15:31:41 +0000
Subject: Re: [PATCH v5 3/3] backlight: lm3630a: add firmware node support
Message-Id: <dfd59e3f-b60b-da09-bf23-a05de5f4575a@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190418151143.26068-1-masneyb@onstation.org>
 <20190418151143.26068-4-masneyb@onstation.org>
 <dc20ab5d-8c44-78a8-3ebc-7fefe8aaf2d5@ti.com>
 <20190423140150.GA10071@basecamp>
In-Reply-To: <20190423140150.GA10071@basecamp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca

Brian

On 4/23/19 9:01 AM, Brian Masney wrote:
> On Tue, Apr 23, 2019 at 08:49:20AM -0500, Dan Murphy wrote:
>>> +static int lm3630a_parse_led_sources(struct fwnode_handle *node,
>>> +				     int default_led_sources)
>>> +{
>>> +	u32 sources[LM3630A_NUM_SINKS];
>>> +	int ret, num_sources, i;
>>> +
>>> +	num_sources = fwnode_property_read_u32_array(node, "led-sources", NULL,
>>> +						     0);
>>> +	if (num_sources < 0)
>>> +		return default_led_sources;
>>> +	else if (num_sources > ARRAY_SIZE(sources))
>>> +		return -EINVAL;
>>> +
>>> +	ret = fwnode_property_read_u32_array(node, "led-sources", sources,
>>> +					     num_sources);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	for (i = 0; i < num_sources; i++) {
>>> +		if (sources[i] < LM3630A_SINK_0 || sources[i] > LM3630A_SINK_1)
>>> +			return -EINVAL;
>>> +
>>> +		ret |= BIT(sources[i]);
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int lm3630a_parse_bank(struct lm3630a_platform_data *pdata,
>>> +			      struct fwnode_handle *node, int *seen_led_sources)
>>
>> Why is seen_led_sources passed in here?
>> It is initialized on the stack in lm3630a_parse_node but the variable is never referenced in that API.
> 
> It's to see all of the led-sources that are configured across all of the
> banks. If it is just in lm3630a_parse_bank(), then it won't catch the
> following invalid configuration:
> 

Ok I see what it is for now.

Not sure why it is declared as a pointer though.

Dan

> led@0 {
> 	reg = <0>;
> 	led-sources = <0 1>;
> 	label = "lcd-backlight";
> 	default-brightness = <200>;
> };
> 
> led@1 {
> 	reg = <1>;
> 	default-brightness = <150>;
> };
> 
> Brian
> 
