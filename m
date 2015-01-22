From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <notro@tronnes.org>
Date: Thu, 22 Jan 2015 20:38:50 +0000
Subject: Re: fbcon gives mirrored fonts on monochrome display
Message-Id: <54C15FDA.5050409@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54C145B8.6080204@tronnes.org>
In-Reply-To: <54C145B8.6080204@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Den 22.01.2015 20:59, skrev Geert Uytterhoeven:
> Hi Noralf,
>
> On Thu, Jan 22, 2015 at 8:55 PM, Noralf Trønnes <notro@tronnes.org> wrote:
>> Den 22.01.2015 20:44, skrev Geert Uytterhoeven:
>>> On Thu, Jan 22, 2015 at 7:47 PM, Noralf Trønnes <notro@tronnes.org> wrote:
>>>> I'm playing with a SSD1306 128x64 monochrome display and fbcon gives me
>>>> mirrored fonts and some extra lines.
>>>> fbdev config:
>>>>     info->var.bits_per_pixel = 1;
>>>>     info->fix.visual = FB_VISUAL_MONO10;
>>>>     info->var.red.length = 1;
>>>>     info->var.red.offset = 0;
>>>>     info->var.green.length = 1;
>>>>     info->var.green.offset = 0;
>>>>     info->var.blue.length = 1;
>>>>     info->var.blue.offset = 0;
>>>> Uses: sys_fillrect, sys_copyarea, sys_imageblit (and deferred_io)
>>>>
>>>> System: Raspberry Pi, ARM, Linux 3.18.3
>>>>
>>>> Does anyone see what this might be?
>>> What's the value on CONFIG_FB_CFB_REV_PIXELS_IN_BYTE in your .config?
>> $ zgrep CONFIG_FB_CFB_REV_PIXELS_IN_BYTE /proc/config.gz
>> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
>>
>>> Does your driver set FB_NONSTD_REV_PIX_IN_B?
>> No it doesn't. I also tried setting it now, with no effect:
>> info->var.nonstd = FB_NONSTD_REV_PIX_IN_B;
> The latter only seems to matter if CONFIG_FB_CFB_REV_PIXELS_IN_BYTE
> is set, so please try the config option first.

$ zgrep CONFIG_FB_CFB_REV_PIXELS_IN_BYTE /proc/config.gz
CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y

$ dmesg
[  365.595787]   nonstd = 2

It didn't change anything.

I looked up the code that is affected by this change, and only the 
cbf*.c files use the rev/swap/shift functions from fb_draw.h
I use the sys_* modules not cbf*
In principle the driver is like fb_ssd1307. It copies the framebuffer to 
RAM in the LCD controller at deferred_io intervals.

