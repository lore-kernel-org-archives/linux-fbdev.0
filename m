From: Stefan Agner <stefan@agner.ch>
Date: Wed, 09 Nov 2016 00:16:43 +0000
Subject: Re: [PATCH] video: mxsfb: get supply regulator optionally
Message-Id: <6cf2f575f3fdc188a189d806813a961d@agner.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160904042627.30182-1-stefan@agner.ch>
 <f8368040-bb5a-91e0-7511-df462719b949@ti.com>
 <4b3a7bda2202a536efaf4a693234c273@agner.ch>
 <1812b2bf-bd66-3553-4c2d-3d2b08603ca0@ti.com>
In-Reply-To: <1812b2bf-bd66-3553-4c2d-3d2b08603ca0-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Hi Tomi,

I vote to merge this patch, see below:

On 2016-09-07 00:20, Tomi Valkeinen wrote:
> On 06/09/16 21:23, Stefan Agner wrote:
>> On 2016-09-06 01:21, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 04/09/16 07:26, Stefan Agner wrote:
>>>> The lcd-supply is meant to be optional, there are several device-
>>>> trees not specifying it and the code handles error values silently.
>>>> Therefor, avoid creating a dummy regulator (and the associated
>>>> warning) by using devm_regulator_get_optional.
>>>>
>>>> While at it, document that fact also in the device-tree bindings.
>>>
>>> The binding change looks correct, but using
>>> devm_regulator_get_optional() does not sound correct.
>>>
>>> devm_regulator_get_optional() is to be used when the device in question
>>> truly can function without the power supply. But if the supply is there,
>>> it's just not controlled by the SW, devm_regulator_get() is to be used.
>>
>> The framebuffer device can even function without a display, no problem
>> there.. Probably not really useful...
> 
> Yes. Of course, the question then becomes, why is the fb driver even
> dealing with the LCD's regulator. But yes, I know the answer: because
> that's how it has been done =).

Agreed, this property really shouldn't be part of the display controller
node.

The device tree should describe the hardware, and that is clearly not
how the hardware is wired up...

The DRM solution to this is having a separate panel node with a
(mandatory) power-supply property.

> 
>> devm_regulator_get creates a dummy regulator and a warning. Afaik, the
>> dummy regulator was meant to be as an aid during development, but not as
>> a permanent solution. This is what the initial commit of the dummy
>> regulator says:
> 
> Yep, the fixed regulator is afaik the correct solution to represent
> non-controllable regulators.
> 
>>> In order to ease transitions with drivers are boards start using regulators
>>> provide an option to cause all regulator_get() calls to succeed, with a
>>> dummy always on regulator being supplied where one has not been configured.
>>> A warning is printed whenever the dummy regulator is used to aid system
>>> development.
>>
>> I think we should either make the property mandatory and fix the device
>> trees or we should fix the driver to support an optional regulator. The
>> code already supports the reg_lcd being NULL, which is probably mostly
>> pointless right now as devm_regulator_get always returns a dummy
>> regulator.
> 
> To really clean this up, the LCD driver should be separated from the fb
> driver. But that's pointless work on a framework that should be
> deprecated (is there a DRM driver for this in the works? =).

Not that I am aware of, but I am considering it actually...

> 
> I'm fine with the _optional version, that's the easiest cleanup here.
> And, I guess, it could be even argued that it's correct in some cases,
> as the fb output could go outside the board, to some externally powered
> display.
> 
> I'm fine with doing more cleanups too, if it eases the maintenance
> burden in the future. But I don't see what the cleanups for the device
> trees would really give us here.
> 
> Mark, what do you say?

So this is what mark said:

On 2016-09-12 16:47, Mark Brown wrote:
> On Wed, Sep 07, 2016 at 10:20:25AM +0300, Tomi Valkeinen wrote:
> 
>> I'm fine with the _optional version, that's the easiest cleanup here.
>> And, I guess, it could be even argued that it's correct in some cases,
>> as the fb output could go outside the board, to some externally powered
>> display.
> 
> I'd *prefer* to see the supplies being specified, if only for the
> encouragement of the others.  But if you want to do the optional thing
> anyway...

In this case we really don't want people encourage using this
property... Making it optional is not the solution, but a band aid until
we have a proper solution (and deprecate the property...)

--
Stefan
