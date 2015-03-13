From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Mar 2015 10:12:51 +0000
Subject: Re: related to frame buffer rotation to 180 degree
Message-Id: <CAMuHMdX99CNGOufLmJTEbENRGq=tj0+5rBo823V=oyVvMKNHgA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5502A2A9.4080204@deltaembedded.in>
In-Reply-To: <5502A2A9.4080204@deltaembedded.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Mar 13, 2015 at 9:41 AM, Jaymin Dabhi
<jaymin.dabhi@deltaembedded.in> wrote:
> I using i/MX6Q processor with Linux Kernel 3.0.35 version with 3.5 inch RGB
> type ORTUSTECH LCD display.
>
> I want to rotate my LCD screen to 180 degree from current position.
> I tried out to pass digits by use of echo to fb0 and fbcon in
> /sys/class/graphics/fb0 and fbcon but still nothing happen, I can do mirror
> my display but not rotate.

You do have FRAMEBUFFER_CONSOLE_ROTATION=y in your .config?

Note that rotation is only done for text console output.
Graphical applications have to take care of rotation theirselves.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
