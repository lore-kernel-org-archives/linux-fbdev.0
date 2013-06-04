From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 04 Jun 2013 06:50:27 +0000
Subject: Re: linux-next: Tree for Jun 3 (fonts.c & vivi)
Message-Id: <CAMuHMdXp_7aaoxCXqtjVnTivo1Ua+ohfQQ2ZEQNO-OGn-k8iqA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130603163717.a6f78476e57d92fadd6f6a23@canb.auug.org.au>
	<51ACFDF2.4040600@infradead.org>
	<CAMuHMdUALrScFE895xRiBvgUpVa9Tvic5M7YxefrEgyeMaSjhw@mail.gmail.com>
	<51AD053B.1040403@infradead.org>
In-Reply-To: <51AD053B.1040403@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-media <linux-media@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Mon, Jun 3, 2013 at 11:06 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 06/03/13 13:54, Geert Uytterhoeven wrote:
>> On Mon, Jun 3, 2013 at 10:34 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>> On 06/02/13 23:37, Stephen Rothwell wrote:
>>>> Changes since 20130531:
>>> on x86_64:
>>>
>>> warning: (VIDEO_VIVI && USB_SISUSBVGA && SOLO6X10) selects FONT_SUPPORT which has unmet direct dependencies (HAS_IOMEM && VT)
>>> warning: (VIDEO_VIVI && FB_VGA16 && FB_S3 && FB_VT8623 && FB_ARK && USB_SISUSBVGA_CON && SOLO6X10) selects FONT_8x16 which has unmet direct dependencies (HAS_IOMEM && VT && FONT_SUPPORT)
>>
>> I knew about thet warning. But I thought it was harmless, as none of the font
>> code really depends on console support...
>>
>>> drivers/built-in.o: In function `vivi_init':
>>> vivi.c:(.init.text+0x1a3da): undefined reference to `find_font'
>>>
>>> when CONFIG_VT is not enabled.
>>
>> ... but I missed that drivers/video/console is not used if CONFIG_VT=y.
>> Sorry for that.
>>
>>> Just make CONFIG_VIDEO_VIVI depend on VT ?
>>
>> Does this (whitespace-damaged copy-and-paste) help?
>
> Yes, that works.  Thanks.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, I'll fold this into the original commit, which is destined for v3.10.

>> --- a/drivers/video/Makefile
>> +++ b/drivers/video/Makefile
>> @@ -12,7 +12,7 @@ fb-y                              := fbmem.o fbmon.o fbcmap.o
>>                                       modedb.o fbcvt.o
>>  fb-objs                           := $(fb-y)
>>
>> -obj-$(CONFIG_VT)                 += console/
>> +obj-y                            += console/
>>  obj-$(CONFIG_LOGO)               += logo/
>>  obj-y                            += backlight/
>>
>> It shouldn't make a difference if nothing inside drivers/video/console
>> is enabled,
>> as all objects in drivers/video/console/Makefile are conditional.
>>
>> BTW, my plan was to move the font code to lib/font, but I haven't done that yet.

I'l try to do that for v3.11.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
