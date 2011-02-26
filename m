From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sat, 26 Feb 2011 16:39:46 +0000
Subject: Re: [PATCH v2 1/3] ARM: PXA: PXAFB: Fix double-free issue
Message-Id: <201102261839.46806.anarsoul@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110217110321.GF24627@n2100.arm.linux.org.uk>
	<1298214147-11578-1-git-send-email-anarsoul@gmail.com>
	<201102201946.20681.marek.vasut@gmail.com>
In-Reply-To: <201102201946.20681.marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sunday 20 February 2011 20:46:20 Marek Vasut wrote:

> > @@ -629,6 +629,9 @@ static void overlay1fb_disable(struct pxafb_layer
> > *ofb)
> > 
> >  {
> >  
> >  	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
> > 
> > +	if (!(lcd_readl(ofb->fbi, OVL1C1) & OVLxC1_OEN))
> > +		return;
> > +
> 
> Maybe you can even avoid reading LCCR5 above ;-)

Agreed.

Will resend soon.
