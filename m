From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 09 Apr 2013 08:08:12 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <CAMuHMdXm94FtmS-qMN6FGjtRs08xkZhmSmCU8Nfr1UgyTK5QEw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <20130408171637.98b5ad1f867bcbda883af68b@linux-foundation.org>
In-Reply-To: <20130408171637.98b5ad1f867bcbda883af68b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Apr 9, 2013 at 2:16 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed,  3 Apr 2013 20:39:43 -0600 Stephen Warren <swarren@wwwdotorg.org> wrote:
>> A simple frame-buffer describes a raw memory region that may be rendered
>> to, with the assumption that the display hardware has already been set
>> up to scan out from that buffer.
>>
>> This is useful in cases where a bootloader exists and has set up the
>> display hardware, but a Linux driver doesn't yet exist for the display
>> hardware.
>>
>> ...
>>
>> +config FB_SIMPLE
>> +     bool "Simple framebuffer support"
>> +     depends on (FB = y) && OF
>
> It's sad that this simple little thing requires Open Firmware.  Could
> it be generalised in some way so that the small amount of setup info
> could be provided by other means (eg, module_param) or does the
> dependency go deeper than that?

Indeed. Instead of consolidating, we seem to get more of them: offb, vesafb,
efifb, ...

cfr. near the tail of drivers/video/Makefile (don't know about all of them):
 # Platform or fallback drivers go here
obj-$(CONFIG_FB_UVESA)            += uvesafb.o
obj-$(CONFIG_FB_VESA)             += vesafb.o
obj-$(CONFIG_FB_EFI)              += efifb.o
obj-$(CONFIG_FB_VGA16)            += vga16fb.o
obj-$(CONFIG_FB_OF)               += offb.o
obj-$(CONFIG_FB_BF537_LQ035)      += bf537-lq035.o
obj-$(CONFIG_FB_BF54X_LQ043)      += bf54x-lq043fb.o
obj-$(CONFIG_FB_BFIN_LQ035Q1)     += bfin-lq035q1-fb.o
obj-$(CONFIG_FB_BFIN_T350MCQB)    += bfin-t350mcqb-fb.o
obj-$(CONFIG_FB_BFIN_7393)        += bfin_adv7393fb.o
obj-$(CONFIG_FB_MX3)              += mx3fb.o
obj-$(CONFIG_FB_DA8XX)            += da8xx-fb.o
obj-$(CONFIG_FB_MXS)              += mxsfb.o
obj-$(CONFIG_FB_SSD1307)          += ssd1307fb.o

# the test framebuffer is last
obj-$(CONFIG_FB_VIRTUAL)          += vfb.o

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
