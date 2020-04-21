From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Apr 2020 05:52:02 +0000
Subject: Re: [PATCH 5/5] backlight: led_bl: rewrite led_bl_parse_levels()
Message-Id: <2233a194-bc8e-99ba-d302-edd087a3adfa@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417113312.24340-1-tomi.valkeinen@ti.com>
 <20200417113312.24340-5-tomi.valkeinen@ti.com>
 <20200420160154.4xxv37fofx37ow7q@holly.lan>
In-Reply-To: <20200420160154.4xxv37fofx37ow7q@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 20/04/2020 19:01, Daniel Thompson wrote:
> On Fri, Apr 17, 2020 at 02:33:12PM +0300, Tomi Valkeinen wrote:
>> led_bl_parse_levels() is rather difficult to follow. Rewrite it with a
>> more obvious code flow.
> 
> ... that introduces new behaviour.
> 
> There's a couple of new behaviours here but the one that particular
> attracted my attention is the disregarding the "default-brightness-level" if
> there is no table. That looks like a bug to me.

I think the previous behavior was a (minor) bug: how can there be default brightness level if there 
are no brightness levels? The led-backlight.txt is a bit lacking (another thing to improve...) but 
led-backlight mimics pwm-backlight, and pwm-backlight.txt says

default-brightness-level: The default brightness level (index into the array defined by the 
"brightness-levels" property)

But I agree, it's a change, so good to mention.

> Please can you add any intended changes of behaviour in the patch
> header?

Ok.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
