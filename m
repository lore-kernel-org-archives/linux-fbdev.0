From: Juergen Beisert <jbe@pengutronix.de>
Date: Thu, 10 Feb 2011 09:52:10 +0000
Subject: Re: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <201102101052.10958.jbe@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102100951.10977.jbe@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D691678C9@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <09EC74FE2C9E8444BF2FF67BD36E1D691678C9@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Li Frank-B20596 wrote:
> > > > +#define VDCTRL1				0x80
> > > > +#define VDCTRL2				0x90
> > > > +#define VDCTRL3				0xa0
> > > > +#define VDCTRL4				0xb0
> > >
> > > Why you give up mx23/mx28 register define role, which generate from SOC
> > > xml.
> >
> > Your macros prevent me from writing short and compact code. If you need
> > more than one of these macros you always have to split each line to follow
> > the 80 columns rule. Unreadable.
> >
> > > There is a set header files for each mx23/mx28 module, which generate
> > > from xml. I know original header files affect run time one Image.
> > > But I think we can copy common part of such register definition because
> > > That keep consistent with mx23/mx28 data sheet. Data sheet and header
> > > file
> >
> > > generate from one source xml.
> > >
> > > HW_<Module name>_<Register name>.
> > > BM_<Module name>_<Register name>_Bit name.
> >
> > IMHO when I define the macros where they belong to, there is not need for
> > this redundant HW_<Module name> or BW__<Module name> prefixes. They are
> > just needless.
>
> At first, someone complain name is longer. But during mx23/mx28 developing,
> Everyone start enjoy such definition because there are not error happen
> about register and bit position definition and identical map to silicon
> spec.

This kind of macro encryption _may_ help when you are coding the driver the 
first time. But after reading and reading it again (while testing and 
debugging) all these prefixes and suffixes do not add any valuable 
information. They only fill up your lines, enlarges your source code and make 
you blind for the real bug...

Everyone who wants to see how source code looks that uses these longs macros I 
can recommend reading the so called 'bootlets' source code. :-))

> Developer needn't look up register header file when coding, just 

That's why I add these macros into the source file instead into a header file.

> write down Register name or bit name according to mx23/mx28 spec.

And sometimes the spec is incomplete or just wrong and so on. Independent of 
any macro naming policy.

> If you still think it is too long, I suggest keep HW_ and BM_ prefix to
> distinguish Which one is register name, which one is bit mask.

The used macro in the address part of the writel() must be an offset, while 
the macro used in the value part must be a bit definition. Anything else is 
redundant.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
