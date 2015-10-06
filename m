From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 06 Oct 2015 19:32:29 +0000
Subject: Re: [PATCH v2] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <87y4ffaj3m.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443954683-13126-1-git-send-email-robert.jarzmik@free.fr>
	<CAL_JsqLy-pK4VpBkj1-wVg85XvPemssM-=Ckx=yDjiXKXbtwtA@mail.gmail.com>
In-Reply-To: <CAL_JsqLy-pK4VpBkj1-wVg85XvPemssM-=Ckx=yDjiXKXbtwtA@mail.gmail.com>
	(Rob Herring's message of "Tue, 6 Oct 2015 08:30:30 -0500")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Rob Herring <robh@kernel.org> writes:

> On Sun, Oct 4, 2015 at 5:31 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Add documentation for the PXA frambuffer devicetree binding.
>
> Strictly speaking this is a binding for PXA display controller, not a
> Linux FB driver. There are lots of "framebuffer" and "DRM" bindings
> which I'm trying to curb.
Yes, that's very true. That deserves a new commit message and a new file name
(marvell,pxa2xx-lcd).
>>  .../devicetree/bindings/video/marvell,pxafb.txt    | 80 ++++++++++++++++++++++
>
> Please put in bindings/display/ as I'm consolidating all the display
> related bindings there[1].
Of course, for v3.

>> +++ b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
>> @@ -0,0 +1,80 @@
>> +PXA LCDC Framebuffer
>> +--------------------
>> +
>> +Required properties:
>> + - compatible :
>> +       "marvell,pxa2xx-lcdc",
>
> No differences in h/w for any of the chips?
All pxa25x, pxa27x and pxa3xx are compatible.
AFAIK, pxa3xx has an IP with additional registers. But :
 - these (this) register(s) is not necessary for the display controller to work
   (it's more a control to shift red/green/blue values, and energy management)
 - all the registers in pxa2{5,7}x are the same in pxa3xx

The pxafb driver acts today on the subset of registers which are the same across
all pxaXXX variants. This is what made me think only one compatible property was
required.

If I'm wrong, I could add "marvell,pxa3xx-lcdc", is that what you think I should
do ?
>
>> + - reg : Should contain 1 register ranges(address and length).
>> +        Can contain an additional register range(address and length)
>> +        for fixed framebuffer memory. Useful for dedicated memories.
>
> This is memory that can't be used for anything else? We already have
> reserved-memory for this if it is just RAM. There's also a binding for
> on-chip SRAM which should probably be used if the memory is usable for
> other things.
That is a wrong copy paste I made. I was more thinking of having only 1 register
range, and no video memory reservation ...

>> +PXA LCDC Display
>
> This should not be specific to PXA, but for this panel. This should be
> in bindings/display/panel/.
Sure, for v3.

>> +----------------
>> +Required properties (as per of_videomode_helper):
>> + - lcd-type: either "mono-stn", "mono-dstn", "color-stn", "color-dstn",
>> +                   "color-tft", "smart-panel"
>> +
>> +Optional properties (as per of_videomode_helper):
>> + - power-supply: power supply regulator to the LCD to power it on or off
>> +                (see regulator.txt)
>> + - backlight: backlight control (see backlight.txt)
>> +
>> +Required nodes:
>> + - port: connection to the LCD controller
>> + - display-timings: panel timings (see display-timing.txt)
>
> If lcd-type is smart-panel, then this node would not make sense.
Ah I see, so this could be optional maybe ?

Actually when I'll move the panel definition to bindings/display/panel, is this
what I should do :
 - create a file marvell,pxa2xx-panel
 - input all these properties into this file

And then, when a board maintainer will create a devicetree description, he will
write something like :
      compatible = "toshiba,ltm0305a776";
      compatible = "marvell,pxa2xx-panel";
      lcd-type = "color-tft";
      ...

If that's the case, I wonder how to "enforce" that a panel used with
marvell,pxa2xx-lcdc (through the of_graph 'port' node) be compatible with
marvell,pxa2xx-panel ?

Cheers.

-- 
Robert
