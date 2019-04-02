From: Dan Murphy <dmurphy@ti.com>
Date: Tue, 02 Apr 2019 13:44:22 +0000
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <c88d954a-ce37-35dc-414b-df28d6095d89@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
 <68229e7f-4749-cde5-f541-793ab614084d@ti.com>
 <20190402132440.GA10359@basecamp>
In-Reply-To: <20190402132440.GA10359@basecamp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca

Brian

On 4/2/19 8:24 AM, Brian Masney wrote:
> On Tue, Apr 02, 2019 at 07:56:55AM -0500, Dan Murphy wrote:
>> This would connect control bank B to control bank A.  Or just use a flag to denote to connect them
>> and not use led-sources.  But led-sources is the property of choice.
>>
>> led@0 {
>> 	reg = <0>;
>> 	led-sources = < 0 1 >;
>> 	label = "main-lcd";
>> 	default-brightness = <200>;
>> 	max-brightness = <255>;
>> };
> 
> OK, I see. I wondered how we could do that in device tree.
> 
>>> +    properties:
>>> +      label:
>>> +        description: |
>>> +          The label for this LED. If omitted, the label is taken from the node
>>> +          name (excluding the unit address). It has to uniquely identify a
>>> +          device, i.e. no other LED class device can be assigned the same label.
>>> +
>>> +      led-sources:
>>> +        description: |
>>> +          List of device current outputs the LED is connected to.
>>> +        allOf:
>>> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +          - minItems: 1
>>> +            maxItems: 2
>>> +            items:
>>> +              minimum: 0
>>> +              maximum: 1
>>> +
>>
>> label and led-sources are already defined in the common.txt no need to redefine them here.
> 
> If I'm going to use the new-style bindings, then I'll need to convert
> common.txt over to use the new format as well so that the automated
> schema validations will work. I'm willing to do that work if there is
> interest from the LED / backlight maintainers. The main issue is that
> there are 62 references to the file common.txt in the directory
> Documentation/devicetree/bindings/leds/. Would the maintainers prefer:
> 
> - Once common.txt is converted to common.yaml, make common.txt only
>   have a line stating that the common bindings were moved into
>   common.yaml. We can remove this file once all of the other bindings
>   are converted to the new-style format.
> 
> - Update all references to common.txt to common.yaml. (1 patch or 62
>   patches?)
> 
> - Or, just go with the older-style binding format for now.
> 
> Thanks Dan for your other comments. They make sense and I'll incorporate
> those changes into my next version.
> 

That is up to the maintainers.

Also one other comment I noticed when reviewing the code that there is no definition to
which child led properties are optional and which are required?

Dan

> Brian
> 


-- 
------------------
Dan Murphy
