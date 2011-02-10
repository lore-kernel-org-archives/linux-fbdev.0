From: Juergen Beisert <jbe@pengutronix.de>
Date: Thu, 10 Feb 2011 08:51:10 +0000
Subject: Re: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <201102100951.10977.jbe@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D6916776E@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <09EC74FE2C9E8444BF2FF67BD36E1D6916776E@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Li Frank-B20596 wrote:
> > +#define CTRL				0x00
> > +#define CTRL1				0x10
> > +#define MX28_CTRL2			0x20
> > +#define MX23_TRANSFER_COUNT		0x20
> > +#define MX28_TRANSFER_COUNT		0x30
> > +#define MX28_CUR_BUF			0x40
> > +#define MX28_NEXT_BUF			0x50
> > +#define MX23_CUR_BUF			0x30
> > +#define MX23_NEXT_BUF			0x40
> > +#define TIMING				0x60
> > +#define VDCTRL0				0x70
> > +#define VDCTRL1				0x80
> > +#define VDCTRL2				0x90
> > +#define VDCTRL3				0xa0
> > +#define VDCTRL4				0xb0
>
> Why you give up mx23/mx28 register define role, which generate from SOC
> xml.

Your macros prevent me from writing short and compact code. If you need more 
than one of these macros you always have to split each line to follow the 80 
columns rule. Unreadable.

> There is a set header files for each mx23/mx28 module, which generate 
> from xml. I know original header files affect run time one Image.
> But I think we can copy common part of such register definition because
> That keep consistent with mx23/mx28 data sheet. Data sheet and header file
> generate from one source xml.
>
> HW_<Module name>_<Register name>.
> BM_<Module name>_<Register name>_Bit name.

IMHO when I define the macros where they belong to, there is not need for this 
redundant HW_<Module name> or BW__<Module name> prefixes. They are just 
needless.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
