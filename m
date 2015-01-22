From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <notro@tronnes.org>
Date: Thu, 22 Jan 2015 20:58:38 +0000
Subject: Re: fbcon gives mirrored fonts on monochrome display
Message-Id: <54C1647E.7030201@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54C145B8.6080204@tronnes.org>
In-Reply-To: <54C145B8.6080204@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Den 22.01.2015 21:42, skrev Geert Uytterhoeven:
> Hi Noralf,
>
> On Thu, Jan 22, 2015 at 9:38 PM, Noralf Trønnes <notro@tronnes.org> wrote:
>> Den 22.01.2015 20:59, skrev Geert Uytterhoeven:
>>> On Thu, Jan 22, 2015 at 8:55 PM, Noralf Trønnes <notro@tronnes.org> wrote:
>>>> Den 22.01.2015 20:44, skrev Geert Uytterhoeven:
>>>>> On Thu, Jan 22, 2015 at 7:47 PM, Noralf Trønnes <notro@tronnes.org>
>>>>> wrote:
>>>>>> I'm playing with a SSD1306 128x64 monochrome display and fbcon gives me
>>>>>> mirrored fonts and some extra lines.
>>>> $ zgrep CONFIG_FB_CFB_REV_PIXELS_IN_BYTE /proc/config.gz
>>>> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
>>>>
>>>>> Does your driver set FB_NONSTD_REV_PIX_IN_B?
>>>> No it doesn't. I also tried setting it now, with no effect:
>>>> info->var.nonstd = FB_NONSTD_REV_PIX_IN_B;
>>> The latter only seems to matter if CONFIG_FB_CFB_REV_PIXELS_IN_BYTE
>>> is set, so please try the config option first.
>>
>> $ zgrep CONFIG_FB_CFB_REV_PIXELS_IN_BYTE /proc/config.gz
>> CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
>>
>> $ dmesg
>> [  365.595787]   nonstd = 2
>>
>> It didn't change anything.
>>
>> I looked up the code that is affected by this change, and only the cbf*.c
>> files use the rev/swap/shift functions from fb_draw.h
>> I use the sys_* modules not cbf*
> One more thing that's no longer in sync...
> Ideally, the cfb* and sys* versions are identical, except that the former
> operates on MMIO, and the latter on RAM.

Ok, so I'm out of luck, unless I patch this up myself :-) (which didn't 
look very complicated btw, as you say they look very similar)

Thanks for your help.


Noralf.

