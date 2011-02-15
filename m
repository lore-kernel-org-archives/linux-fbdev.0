From: Eric Miao <eric.y.miao@gmail.com>
Date: Tue, 15 Feb 2011 13:36:07 +0000
Subject: Re: [PATCH] ARM: PXA: Make PXA27x/PXA3xx overlay actually work
Message-Id: <AANLkTinu2LT4t=f=Y0ZBmT6=nsoiQ9HVVTYmzgLMpDXR@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
	<201102151041.21560.anarsoul@gmail.com>
	<AANLkTimR_6fYuJHuVC8TD5agjyCoUWiKQmEunhZHSQE5@mail.gmail.com>
	<201102151358.47203.anarsoul@gmail.com>
In-Reply-To: <201102151358.47203.anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 7:58 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> On Tuesday 15 February 2011 13:51:06 Eric Miao wrote:
>> >> >        lcd_writel(fbi, FDADR0, fbi->fdadr[0]);
>> >> > -       lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
>> >> > +       if (fbi->lccr0 & LCCR0_SDS)
>> >> > +               lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
>> >>
>> >> My original intention was to simplify the code a bit by ignoring
>> >> LCCR0_SDS, as FDADR1 would not take effect if not enabled even
>> >> if it's being read/written.
>> >
>> > It leads to potential race condition when you try to reconfigure main
>> > plane and overlay1 simultaneously.
>>
>> You are right on this.
>>
>> >> > +#ifdef CONFIG_FB_PXA_OVERLAY
>> >> > +       if (cpu_is_pxa27x())
>> >> > +               fbi->lccr0 |= LCCR0_OUC;
>> >> > +#endif
>> >> > +
>> >>
>> >> I seem to remember LCCR0_OUC is still valid on pxa3xx, did you
>> >> do some test on pxa3xx as well?
>> >
>> > Sorry, I have no any pxa3xx boards.
>>
>> That's all right, I can give it a test later. The point is, why
>> did you move the code here from pxafb_overlay_init()?
>
> Because otherwise correct plane order (overlays on top) will be selected only
> on next main plane reconfigure.
>

Then maybe in this way? (I'd rather keep this bit in overlay specific
code, and make it valid not only to pxa27x)

@@ -925,6 +925,8 @@ static int __devinit pxafb_overlay_init(struct
pxafb_info *fbi)

        /* place overlay(s) on top of base */
        fbi->lccr0 |= LCCR0_OUC;
+       lcd_writel(fbi, LCCR0, fbi->lccr0 & ~LCCR0_ENB);
+
        pr_info("PXA Overlay driver loaded successfully!\n");
        return 0;


> Regards
> Vasily
>
