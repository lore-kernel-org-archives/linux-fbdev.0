From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: SM501: core (mfd) driver
Date: Wed, 13 Dec 2006 20:04:06 +0100
Message-ID: <1166036646.27217.870.camel@laptopd505.fenrus.org>
References: <20061213155134.GA10097@home.fluff.org>
	 <1166030491.27217.844.camel@laptopd505.fenrus.org>
	 <20061213175143.GA11394@home.fluff.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965077AbWLMTEM@vger.kernel.org>
In-Reply-To: <20061213175143.GA11394@home.fluff.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Ben Dooks <ben-fbdev@fluff.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, 2006-12-13 at 17:51 +0000, Ben Dooks wrote:
> > > +
> > > +	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
> > > +
> > > +	dev_dbg(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
> > > +		gate, clock, mode);
> > > +
> > > +	msleep(16);
> > 
> > you're missing a PCI posting flush here
> > (if you don't know what this is please ask)
> 
> Is this a read from an device register to cause the PCI writes
> to happen?

yup

>  Would reading SM501_POWER_MODE_CONTROL be ok, or does
> it require a different register?

any register is ok, you can read the same one just fine.


greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
