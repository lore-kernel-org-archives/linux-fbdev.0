From: Stefan Agner <stefan@agner.ch>
Date: Tue, 06 Sep 2016 18:23:31 +0000
Subject: Re: [PATCH] video: mxsfb: get supply regulator optionally
Message-Id: <4b3a7bda2202a536efaf4a693234c273@agner.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160904042627.30182-1-stefan@agner.ch>
 <f8368040-bb5a-91e0-7511-df462719b949@ti.com>
In-Reply-To: <f8368040-bb5a-91e0-7511-df462719b949-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

On 2016-09-06 01:21, Tomi Valkeinen wrote:
> Hi,
> 
> On 04/09/16 07:26, Stefan Agner wrote:
>> The lcd-supply is meant to be optional, there are several device-
>> trees not specifying it and the code handles error values silently.
>> Therefor, avoid creating a dummy regulator (and the associated
>> warning) by using devm_regulator_get_optional.
>>
>> While at it, document that fact also in the device-tree bindings.
> 
> The binding change looks correct, but using
> devm_regulator_get_optional() does not sound correct.
> 
> devm_regulator_get_optional() is to be used when the device in question
> truly can function without the power supply. But if the supply is there,
> it's just not controlled by the SW, devm_regulator_get() is to be used.

The framebuffer device can even function without a display, no problem
there.. Probably not really useful...

devm_regulator_get creates a dummy regulator and a warning. Afaik, the
dummy regulator was meant to be as an aid during development, but not as
a permanent solution. This is what the initial commit of the dummy
regulator says:

> In order to ease transitions with drivers are boards start using regulators
> provide an option to cause all regulator_get() calls to succeed, with a
> dummy always on regulator being supplied where one has not been configured.
> A warning is printed whenever the dummy regulator is used to aid system
> development.

I think we should either make the property mandatory and fix the device
trees or we should fix the driver to support an optional regulator. The
code already supports the reg_lcd being NULL, which is probably mostly
pointless right now as devm_regulator_get always returns a dummy
regulator.

--
Stefan
