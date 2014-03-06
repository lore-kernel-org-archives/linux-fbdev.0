From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Mar 2014 08:39:40 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <CAMuHMdWVSfKrudBhE7FW-ZWBvMOLWjrQZvn1qZUfRt_H+P7A2w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
	<20140228155937.GQ21483@n2100.arm.linux.org.uk>
	<5310B567.7040605@ti.com>
	<20140228162327.GT21483@n2100.arm.linux.org.uk>
	<5316E31F.9050308@ti.com>
In-Reply-To: <5316E31F.9050308@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, DRI Development <dri-devel@lists.freedesktop.org>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Wed, Mar 5, 2014 at 9:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 28/02/14 18:23, Russell King - ARM Linux wrote:
>
>> That's rather a lot of compatible strings.  Another possibility is:
>>
>>       compatible = "dvi-connector";
>>       analog;
>>       digital;
>>       single-link;
>>       dual-link;
>
> I made the following changes compared to the posted version. I decided
> to leave the "single-link" out, as it's implied if "digital" is set.
>
>  Tomi
>
> @@ -6,11 +6,16 @@ Required properties:
>
>  Optional properties:
>  - label: a symbolic name for the connector
> -- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
> +- ddc-i2c-bus: phandle to the i2c bus that is connected to DVI DDC
> +- analog: the connector has DVI analog pins
> +- digital: the connector has DVI digital pins
> +- dual-link: the connector has pins for DVI dual-link
>
>  Required nodes:
>  - Video port for DVI input
>
> +Note: One (or both) of 'analog' or 'digital' must be set.

So dual-link needs both "digital" and "dual-link"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
