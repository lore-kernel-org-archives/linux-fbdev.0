From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 01 Mar 2014 18:58:30 +0000
Subject: Re: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI Connector
Message-Id: <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>
	<20140228160612.GR21483@n2100.arm.linux.org.uk>
	<5310B609.1010105@ti.com>
	<20140228163431.GV21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228163431.GV21483@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Andrzej Hajda <a.hajda@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Fri, Feb 28, 2014 at 5:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> There's actually three HDMI connectors:
>
>   All three connectors carry all required HDMI signals, including a TMDS
>   link. The Type B connector is slightly larger and carries a second TMDS
>   link, which is necessary to support very high resolution displays using
>   dual link. The Type C connector carries the same signals as the Type A
>   but is more compact and intended for mobile applications.
>
> So, Type C and Type A are electrically the same.

There's also D (e.g. on BeagleBone Black) and E:

http://en.wikipedia.org/wiki/HDMI#Connectors

Electrically they seem to be the same as A/C.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
