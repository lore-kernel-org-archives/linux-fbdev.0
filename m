From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>
Date: Sat, 07 Feb 2015 15:19:37 +0000
Subject: Re: [PATCH 2/8] fbdev: ssd1307fb: Unify init code and make controller configurable from device tree
Message-Id: <54D62D09.8080404@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>	<1423261694-5939-3-git-send-email-niederp@physik.uni-kl.de>	<20150207104225.GM2079@lukather> <20150207155933.4f1d0998@maestro.intranet>
In-Reply-To: <20150207155933.4f1d0998@maestro.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?VGhvbWFzIE5pZWRlcnByw7xt?= <niederp@physik.uni-kl.de>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

Hi,

Den 07.02.2015 15:59, skrev Thomas Niederprüm:
> Am Sat, 7 Feb 2015 11:42:25 +0100
> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>
>> Hi,
>>
>> On Fri, Feb 06, 2015 at 11:28:08PM +0100, niederp@physik.uni-kl.de
>> wrote:
>>> From: Thomas Niederprüm <niederp@physik.uni-kl.de>
>>>
>>> This patches unifies the init code for the ssd130X chips and
>>> adds device tree bindings to describe the hardware configuration
>>> of the used controller. This gets rid of the magic bit values
>>> used in the init code so far.
>>>
>>> Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
>>> ---
>>>   .../devicetree/bindings/video/ssd1307fb.txt        |  11 +
>>>   drivers/video/fbdev/ssd1307fb.c                    | 243
>>> ++++++++++++++------- 2 files changed, 174 insertions(+), 80
>>> deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt
>>> b/Documentation/devicetree/bindings/video/ssd1307fb.txt index
>>> 7a12542..1230f68 100644 ---
>>> a/Documentation/devicetree/bindings/video/ssd1307fb.txt +++
>>> b/Documentation/devicetree/bindings/video/ssd1307fb.txt @@ -15,6
>>> +15,17 @@ Required properties:
>>>   Optional properties:
>>>     - reset-active-low: Is the reset gpio is active on physical low?
>>> +  - solomon,segment-remap: Invert the order of data column to
>>> segment mapping
>>> +  - solomon,offset: Map the display start line to one of COM0 -
>>> COM63
>>> +  - solomon,contrast: Set initial contrast of the display
>>> +  - solomon,prechargep1: Set the duration of the precharge period
>>> phase1
>>> +  - solomon,prechargep2: Set the duration of the precharge period
>>> phase2
>>> +  - solomon,com-alt: Enable/disable alternate COM pin configuration
>>> +  - solomon,com-lrremap: Enable/disable left-right remap of COM
>>> pins
>>> +  - solomon,com-invdir: Invert COM scan direction
>>> +  - solomon,vcomh: Set VCOMH regulator voltage
>>> +  - solomon,dclk-div: Set display clock divider
>>> +  - solomon,dclk-frq: Set display clock frequency
>> I'm sorry, but this is the wrong approach, for at least two reasons:
>> you broke all existing users of that driver, which is a clear no-go,
> Unfortunately this is true. The problem is that the SSD130X controllers
> allow for a very versatile wiring of the display to the controller.
> It's over to the manufacturer of the OLED module (disp+controller) to
> decide how it's actually wired and during device initialization the
> driver has to take care to configure the SSD130X controller according
> to that wiring. If the driver fails to do so you will end up having
> your display showing garbage. Unfortunately the current sate of the
> initialization code of the ssd1307fb driver is not very flexible in that
> respect. Taking a look at the initialization code for the ssd1306 shows
> that it was written with one very special display module in mind. Most
> of the magic bit values set there are non-default values according to
> the datasheet. The result is that the driver works with that one
> particular display module but many other (differently wired) display
> modules using a ssd1306 controller won't work without changing the
> hardcoded magic bit values.
>
> My idea here was to set all configuration to the default values (as
> given in the datasheet) unless it is overwritten by DT. Of course,
> without a change in DT, this breaks the driver for all existing users.
> The only alternative would be to set the current values as default.
> Somehow this feels wrong to me as these values look arbitrary when you
> don't know what exact display module they were set for. But if you
> insist, I will change the default values.
>
>> and the DT itself should not contain any direct mapping of the
>> registers.
>>
> I think I don't get what you mean here. Is it because I do no sanity
> checks of the numbers set in DT? I was just looking for a way to hand
> over the information about the wiring of display to the driver. How
> would you propose to solve this?

I have the exact same challenge with the staging/fbtft drivers.
I have asked about this on the DT list a couple of days ago, but no 
answer yet:

Can I do register initialization from Device Tree?
http://www.spinics.net/lists/devicetree/msg68174.html


Regards,
Noralf Trønnes

