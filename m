From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Apr 2020 11:53:02 +0000
Subject: Re: [PATCH 5/5] backlight: led_bl: rewrite led_bl_parse_levels()
Message-Id: <476ec68b-da2b-2f29-bc0a-3d61b4fc3eb6@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417113312.24340-1-tomi.valkeinen@ti.com>
 <20200417113312.24340-5-tomi.valkeinen@ti.com>
 <20200420160154.4xxv37fofx37ow7q@holly.lan>
 <2233a194-bc8e-99ba-d302-edd087a3adfa@ti.com>
 <20200421104812.kgsdgv2r7bu7iqhe@holly.lan>
 <0c7d02aa-db51-1c6f-e126-88472db4345b@ti.com>
In-Reply-To: <0c7d02aa-db51-1c6f-e126-88472db4345b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 21/04/2020 14:26, Tomi Valkeinen wrote:

>>> The led-backlight.txt is
>>> a bit lacking (another thing to improve...) but led-backlight mimics
>>> pwm-backlight, and pwm-backlight.txt says
>>>
>>> default-brightness-level: The default brightness level (index into the array
>>> defined by the "brightness-levels" property)
>>
>> I think this implies we should improve the binding documentation!
>>
>> The parenthetic text's main purpose is to make clear which scale should
>> be used when interpreting the default brightness. Just because the scale
>> is 1:1 doesn't render it meaningless.
> 
> If I read pwm_bl.c right, that's not how the code works. If pwm_bl has no 'brightness-levels', then 
> 'default-brightness-level' is ignored. Which matches the binding documentation.
> 
> What you suggest makes sense, though, so I can adjust this patch to make led_bl behave like that.

On the other hand... If we want to use LED's (or PWM's) brightness levels directly, should the 
default brightness be defined in the LED's (or PWM's) DT node?

And only if we create a backlight brightness-levels mapping, we need to add a new property to define 
a default for those levels. Which, I think, the name implies with the "-level".

Well, in any case, there should be no harm in using 'default-brightness-level' also for the 1:1 
mapping without the 'brightness-levels'. So maybe that's the best route.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
