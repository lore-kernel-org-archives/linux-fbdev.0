From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Mar 2014 08:40:52 +0000
Subject: Re: [PATCHv2 2/8] Doc/DT: Add DT binding documentation for Analog TV Connector
Message-Id: <CAMuHMdVhh_qqXvUP9zUo0iCJ=O6bLqp-qTdaMQNLNcVgAgROBg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
 <1395130547-18633-3-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1395130547-18633-3-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, DRI Development <dri-devel@lists.freedesktop.org>, Andrzej Hajda <a.hajda@samsung.com>, Rob Herring <robherring2@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Tomi,

On Tue, Mar 18, 2014 at 9:15 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
> @@ -0,0 +1,25 @@
> +Analog TV Connector
> +=========> +
> +Required properties:
> +- compatible: "composite-connector" or "svideo-connector"
> +
> +Optional properties:
> +- label: a symbolic name for the connector
> +
> +Required nodes:
> +- Video port for TV input

Only input, not output?

Have you considered adding bindings for other analog connector types?
  - composite (YCbCr),
  - component with and without sync-on-green (RGB and RGBHV),
  - D-terminal (D1/D2/D3/D4/D5).

Am I missing some?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
