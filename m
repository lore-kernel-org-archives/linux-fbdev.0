From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Mar 2014 08:00:12 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <CAMuHMdWqt4M5OEXp8y_DR8UEA8GPxJg99cz-HcmMPQB+h+Rh0A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
	<20140228155937.GQ21483@n2100.arm.linux.org.uk>
	<1393604717.3802.61.camel@paszta.hi.pengutronix.de>
	<CAL_JsqJ00Zr1tMoyR1+qHUhsNoc6Kj6s+nTZTkNTwki9HFHq8g@mail.gmail.com>
	<531EAF8F.2040400@ti.com>
In-Reply-To: <531EAF8F.2040400@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, DRI Development <dri-devel@lists.freedesktop.org>, Andrzej Hajda <a.hajda@samsung.com>, Rob Herring <robherring2@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Tue, Mar 11, 2014 at 7:39 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 10/03/14 23:45, Rob Herring wrote:
>> I like this proposal over the others. Although, would dual link be a
>
> I don't like inferring the information. With the above, you can't find
> out that the DVI connector has digital and analog support before all the
> drivers are loaded.
>
>> single endpoint or 2 endpoints? How would you differentiate that?
>
> Hmm, well endpoints for a single port are exclusive. So it's either a
> single port and a single endpoint, or two ports and two endpoints. I
> think dual link has to be single port & endpoint, as the TMDS links need
> to be driven together as a single bus.
>
> And dual-link is not really "two links". DVI dual-link means 1 clock
> lane and 6 data lanes, compared to 1 clock lane and 3 data lanes for
> single-link.

What about having a property for the number of data lanes?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
