From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 07 Mar 2014 10:54:29 +0000
Subject: Re: [PATCH] lib: remove FBCON dependency for fonts
Message-Id: <CAMuHMdUheaE00m289h=x0gxf+PAbPjhhdAKATAHGgOgk9YROVQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394187271-5857-1-git-send-email-dh.herrmann@gmail.com>
	<CAMuHMdVxE2jXQE11swi8sM251GcWcdDYpgE37pCoxpb7oF1-Rg@mail.gmail.com>
	<CANq1E4SbA5jCh+5UqyJ=oxdiYdbfkUcfrbB=jGjKRZJ-LAuaXg@mail.gmail.com>
In-Reply-To: <CANq1E4SbA5jCh+5UqyJ=oxdiYdbfkUcfrbB=jGjKRZJ-LAuaXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Fri, Mar 7, 2014 at 11:47 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> Without the "depends on FRAMEBUFFER_CONSOLE", people who don't
>> have FRAMEBUFFER_CONSOLE set, but have set any of these:
>>
>> config EARLY_PRINTK_EFI
>>     select FONT_SUPPORT
>>
>> config VIDEO_VIVI
>>     select FONT_SUPPORT
>>     select FONT_8x16
>>
>> config SOLO6X10
>>     select FONT_SUPPORT
>>     select FONT_8x16
>>
>> config USB_SISUSBVGA
>>     select FONT_SUPPORT
>>     ...
>>     select FONT_8x16
>>
>> config SGI_NEWPORT_CONSOLE
>>     select FONT_SUPPORT
>>
>> config STI_CONSOLE
>>     select FONT_SUPPORT
>>
>> will now get more (unused) fonts in their kernel image.
>
> Why would they get more unused fonts? All those fonts are "default n"
> (except for some arch-specific stuff and 8x8 and obviously 8x16). I

So they get the 8x8 and the arch-specific ones by default (FONTS=n).

> don't mind if we drop this, but it makes font-selection impossible if
> fbcon is disabled, which is kinda unexpected.

IIRC, drivers that "select FONT_8x16" have the font name hardcoded in
the driver, so allowing to select more fonts doesn't gain anything for them.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
