From: Juergen Beisert <jbe@pengutronix.de>
Date: Thu, 10 Feb 2011 11:12:17 +0000
Subject: Re: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <201102101212.17370.jbe@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102101052.10958.jbe@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D69167988@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <09EC74FE2C9E8444BF2FF67BD36E1D69167988@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Li Frank-B20596 wrote:
> > This kind of macro encryption _may_ help when you are coding the driver
> > the
> > first time. But after reading and reading it again (while testing and
> > debugging) all these prefixes and suffixes do not add any valuable
> > information. They only fill up your lines, enlarges your source code and
> > make
> > you blind for the real bug...
> >
> > Everyone who wants to see how source code looks that uses these longs
> > macros I
> > can recommend reading the so called 'bootlets' source code. :-))
>
> The complex of bootlets is not long macro, but the work around to make sure
> Chip PMU work safely. If there are not such macro, power_prep will become
> more difficult to understand.

Its your opinion...

> > > Developer needn't look up register header file when coding, just
> >
> > That's why I add these macros into the source file instead into a header
> > file.
> >
> > > write down Register name or bit name according to mx23/mx28 spec.
> >
> > And sometimes the spec is incomplete or just wrong and so on. Independent
> > of any macro naming policy.
>
> Not at all. Mx23/mx28 can keep spec, header file and RTL consistent just
> because using one source and multiple output. During Freescale mx28 BSP
> develop, never happen bit and register definition error.
>
> > > If you still think it is too long, I suggest keep HW_ and BM_ prefix to
> > > distinguish Which one is register name, which one is bit mask.
> >
> > The used macro in the address part of the writel() must be an offset,
> > while
> > the macro used in the value part must be a bit definition. Anything else
> > is
> > redundant.
>
> If name is too short, there are possible to cause name pollution.
> BM_, BP_, BF_ have their implication.

If you collect everything in header files: Yes. If you keep the macros where 
they are used, IMHO: No.
 
> VDCTRL4_SET_DOTCLK_DLY(x), according to our macro policy, it should be
> BF_VDCTRL4_SET_DOTCLK_DLY(x).
>
> Generally, you need
> Reg = readl(offset+VDCTRL4);
> Reg &=~ ((0x7)<<29);

What about?
> Reg &= ~VDCTRL4_SET_DOTCLK_DLY(0x7);
Or?
> Reg &= ~VDCTRL4_SET_DOTCLK_DLY_MASK;
Okay, the even get longer and longer.
> Reg |= VDCTRL4_SET_DOTCLK_DLY(value)
> Writel(reg, offset+VDCTRL4)
>
> Compared with our macro policy.
>
> Reg = readl(offset+HW_VDCTRL4);
> Reg &=~ BM_VDCTRL4_SET_DOTCLK_DLY;
> Reg |= BF_VDCTRL4_SET_DOTCLK_DLY(value)
> Writel(reg, offset+HW_VDCTRL4)

Anywhere else such naming policy in the kernel? I have to deal with all kind 
of CPUs, not only i.MX23/28.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
