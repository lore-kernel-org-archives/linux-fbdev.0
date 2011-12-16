From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Dec 2011 11:53:06 +0000
Subject: Re: Should I use FBINFO_VIRTFB?
Message-Id: <CAMuHMdX0io+0VoA-a=9N9RQpnv1RuovFMnAgAnqhRsQcMhXxtg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4EEA5DA7.3010406@freescale.com>
In-Reply-To: <4EEA5DA7.3010406@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Thu, Dec 15, 2011 at 23:10, Timur Tabi <timur@freescale.com> wrote:
> Konrad Rzeszutek Wilk wrote:
>>> > #define FBINFO_PARTIAL_PAN_OK      0x0040 /* otw use pan only for double-buffering */
>>> > #define FBINFO_READS_FAST  0x0080 /* soft-copy faster than rendering */
>
>> Not really. They have a different function, but you are better of looking in the code
>> to see how they are used.

> I can't parse this, and I can't figure out if my driver is better off with or without FBINFO_PARTIAL_PAN_OK.

This depends on which of these two is fastest for scrolling the console:
  - panning the virtual screen and redrawing the missing part: set
FBINFO_PARTIAL_PAN_OK
  - copying or redrawing the screen: don't set FBINFO_PARTIAL_PAN_OK

> I have the same problem with FBINFO_READS_FAST.

You should set this flag if reading from frame buffer memory is a fast
operation.
On many graphics devices, reading from frame buffer memory is much slower
than writing. As you use system RAM, you probably want to set it.

If this flag is set, scrolling is implemented by copying memory around.
If not set, scrolling is implemented by redrawing the whole screen.

A simple way to find the optimal settings of both flags (all 4 combinations) is
running "clear; time cat big_text_file" and comparing the timing results

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
