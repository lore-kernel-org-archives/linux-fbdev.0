From: Li Frank-B20596 <B20596@freescale.com>
Date: Thu, 10 Feb 2011 09:15:54 +0000
Subject: RE: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <09EC74FE2C9E8444BF2FF67BD36E1D691678C9@039-SN1MPN1-003.039d.mgd.msft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D6916776E@039-SN1MPN1-003.039d.mgd.msft.net>
	<201102100951.10977.jbe@pengutronix.de>
In-Reply-To: <201102100951.10977.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> > > +#define VDCTRL1				0x80
> > > +#define VDCTRL2				0x90
> > > +#define VDCTRL3				0xa0
> > > +#define VDCTRL4				0xb0
> >
> > Why you give up mx23/mx28 register define role, which generate from SOC
> > xml.
> 
> Your macros prevent me from writing short and compact code. If you need
> more
> than one of these macros you always have to split each line to follow the
> 80
> columns rule. Unreadable.
> 
> > There is a set header files for each mx23/mx28 module, which generate
> > from xml. I know original header files affect run time one Image.
> > But I think we can copy common part of such register definition because
> > That keep consistent with mx23/mx28 data sheet. Data sheet and header
> file
> > generate from one source xml.
> >
> > HW_<Module name>_<Register name>.
> > BM_<Module name>_<Register name>_Bit name.
> 
> IMHO when I define the macros where they belong to, there is not need for
> this
> redundant HW_<Module name> or BW__<Module name> prefixes. They are just
> needless.

At first, someone complain name is longer. But during mx23/mx28 developing,
Everyone start enjoy such definition because there are not error happen about
register and bit position definition and identical map to silicon spec. 
Developer needn't look up register header file when coding, just write down
Register name or bit name according to mx23/mx28 spec. 

If you still think it is too long, I suggest keep HW_ and BM_ prefix to distinguish
Which one is register name, which one is bit mask. 

Imx23/imx28 register have consistent convention. 
HW_ is register name
BM_ is bit mask
BP_ is bit position.
BF_(x) is   ((x<<BP)&BM_)

> 
> Regards,
> Juergen
> 

