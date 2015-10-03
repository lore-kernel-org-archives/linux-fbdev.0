From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 03 Oct 2015 17:23:44 +0000
Subject: Re: [PATCH] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <87fv1rdfxb.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443888694-12311-1-git-send-email-robert.jarzmik@free.fr>
	<CA+gwMceq-+8UX4J7zgMG_DcGYE1RhmiHhKig8i7MVwga53LQRw@mail.gmail.com>
In-Reply-To: <CA+gwMceq-+8UX4J7zgMG_DcGYE1RhmiHhKig8i7MVwga53LQRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Philipp Zabel's message of "Sat, 3 Oct 2015 19:14:36 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Philipp Zabel <philipp.zabel@gmail.com> writes:

> On Sat, Oct 3, 2015 at 6:11 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Add documentation for the PXA frambuffer devicetree binding.
>>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: linux-fbdev@vger.kernel.org
>>
>> ---
>>  .../devicetree/bindings/video/marvell,pxafb.txt    | 75 ++++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/marvell,pxafb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/marvell,pxafb.txt b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
>> new file mode 100644
>> index 000000000000..489055bf3c57
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
>> @@ -0,0 +1,75 @@
>> +PXA LCDC Framebuffer
>> +-----------------------------------------------------
>> +
>> +Required properties:
>> +- compatible :
>> +       "marvell,pxa2xx-fb",
>
> Should be "marvell,pxa2xx-lcd-controller", "marvell,pxa2xx-lcdc" or
> something like this.
Whichever you see fit.

>
>> +- reg : Should contain 1 register ranges(address and length).
>> +       Can contain an additional register range(address and length)
>> +       for fixed framebuffer memory. Useful for dedicated memories.
>> +- interrupts : framebuffer controller interrupt
>> +- display: a phandle pointing to the display node
>> +
>> +Required nodes:
>> +- display: a display node is required to initialize the lcd panel
>> +          This should be in the board dts.
>
> I'd prefer to use an of-graph link to a panel node with a proper
> compatible value for the panel, instead of this custom display
> property.
> That way, if somebody ever decides convert the fbdev driver to a drm
> driver, we don't have to change the device tree and can directly use
> drm_panel.
Ok, if you give me an example it would be easier for me.

>> +- default-mode: a videomode within the display with timing parameters
>> +               as specified below.
>> +- bits-per-pixel: pixel data bus width of the LCD panel
>
> Would bus-width be better here?
bus-width yes, but I think I should remove this property, and only keep the one
in the panel/display.

>> +Optional properties:
>> +- lcd-supply: Regulator for LCD supply voltage.
>
> How does this differ from the regulator below?
Ah yes, good point. In the end I couldn't decide which one was the correct one
... My feeling is that it's the display's one, as hardware wise the power is
necessary for the display, not the framebuffer.
>
>> +- enable-transparency-bit: if framebuffer colorspace reserves a bit for
>> +                          transparency
>
> That doesn't belong in the device tree.
>
>> +- enable-greyscale-cmap: true if palette is a grayscale based instead of color
>
> I suspect this doesn't belong in the device tree either. Does this
> specify the pixel format of the memory framebuffer?
Yes, both these values specify the pixel format. I was thinking this was a
hardware capability of the IP, I was wrong, just cross-checked. I'll remove
these 2 properties.

>> +               enable-transparency-bit = <0>;
>> +               enable-greyscale-cmap = <0>;
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>
> What are the #address/size-cells needed for?
Copy-paste from another binding, atmel's I think. Poor leftover obviously.

>> +       };
>> +
>> +PXA LCDC Display
>> +-----------------------------------------------------
>> +Required properties (as per of_videomode_helper):
>> + - lcd-type: either "mono-stn", "mono-dstn", "color-stn", "color-dstn",
>> +                   "color-tft", "smart-panel"
>> + - bits-per-pixel: LCD data bus width
>
> This is already found in the lcd controller node above.
I think the bus-width should be here. It represents the number of data lines
between the SoC and the panel.

Cheers.

-- 
Robert
