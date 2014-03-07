From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 07 Mar 2014 10:47:04 +0000
Subject: Re: [PATCH] lib: remove FBCON dependency for fonts
Message-Id: <CANq1E4SbA5jCh+5UqyJ=oxdiYdbfkUcfrbB=jGjKRZJ-LAuaXg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394187271-5857-1-git-send-email-dh.herrmann@gmail.com>
	<CAMuHMdVxE2jXQE11swi8sM251GcWcdDYpgE37pCoxpb7oF1-Rg@mail.gmail.com>
In-Reply-To: <CAMuHMdVxE2jXQE11swi8sM251GcWcdDYpgE37pCoxpb7oF1-Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi

On Fri, Mar 7, 2014 at 11:39 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Mar 7, 2014 at 11:14 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> Fonts don't depend on CONFIG_FRAMEBUFFER_CONSOLE at all. Remove that.
>> Besides, CONFIG_FONT_SUPPORT is 'select'ed anyway, so the dependencies
>> aren't checked by most higher-level options.
>
> CONFIG_FONT_SUPPORT is indeed selected, but the other options are about
> which fonts to include by default. No dependencies are bypassed by the select.

Indeed, I missed that, sorry.

> Without the "depends on FRAMEBUFFER_CONSOLE", people who don't
> have FRAMEBUFFER_CONSOLE set, but have set any of these:
>
> config EARLY_PRINTK_EFI
>     select FONT_SUPPORT
>
> config VIDEO_VIVI
>     select FONT_SUPPORT
>     select FONT_8x16
>
> config SOLO6X10
>     select FONT_SUPPORT
>     select FONT_8x16
>
> config USB_SISUSBVGA
>     select FONT_SUPPORT
>     ...
>     select FONT_8x16
>
> config SGI_NEWPORT_CONSOLE
>     select FONT_SUPPORT
>
> config STI_CONSOLE
>     select FONT_SUPPORT
>
> will now get more (unused) fonts in their kernel image.

Why would they get more unused fonts? All those fonts are "default n"
(except for some arch-specific stuff and 8x8 and obviously 8x16). I
don't mind if we drop this, but it makes font-selection impossible if
fbcon is disabled, which is kinda unexpected.

Thanks
David
