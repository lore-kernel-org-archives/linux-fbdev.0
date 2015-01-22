From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2015 20:42:23 +0000
Subject: Re: fbcon gives mirrored fonts on monochrome display
Message-Id: <CAMuHMdX9S0=ktRw+wPhjJCMGn5DvmSHLTaavdw8brZ2qvOTv7Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54C145B8.6080204@tronnes.org>
In-Reply-To: <54C145B8.6080204@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hi Noralf,

On Thu, Jan 22, 2015 at 9:38 PM, Noralf Trønnes <notro@tronnes.org> wrote:
> Den 22.01.2015 20:59, skrev Geert Uytterhoeven:
>> On Thu, Jan 22, 2015 at 8:55 PM, Noralf Trønnes <notro@tronnes.org> wrote:
>>> Den 22.01.2015 20:44, skrev Geert Uytterhoeven:
>>>> On Thu, Jan 22, 2015 at 7:47 PM, Noralf Trønnes <notro@tronnes.org>
>>>> wrote:
>>>>> I'm playing with a SSD1306 128x64 monochrome display and fbcon gives me
>>>>> mirrored fonts and some extra lines.

>>> $ zgrep CONFIG_FB_CFB_REV_PIXELS_IN_BYTE /proc/config.gz
>>> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
>>>
>>>> Does your driver set FB_NONSTD_REV_PIX_IN_B?
>>>
>>> No it doesn't. I also tried setting it now, with no effect:
>>> info->var.nonstd = FB_NONSTD_REV_PIX_IN_B;
>>
>> The latter only seems to matter if CONFIG_FB_CFB_REV_PIXELS_IN_BYTE
>> is set, so please try the config option first.
>
>
> $ zgrep CONFIG_FB_CFB_REV_PIXELS_IN_BYTE /proc/config.gz
> CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
>
> $ dmesg
> [  365.595787]   nonstd = 2
>
> It didn't change anything.
>
> I looked up the code that is affected by this change, and only the cbf*.c
> files use the rev/swap/shift functions from fb_draw.h
> I use the sys_* modules not cbf*

One more thing that's no longer in sync...
Ideally, the cfb* and sys* versions are identical, except that the former
operates on MMIO, and the latter on RAM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
