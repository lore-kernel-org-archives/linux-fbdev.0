From: Inki Dae <inki.dae@samsung.com>
Date: Fri, 12 Nov 2010 10:40:16 +0000
Subject: RE: [PATCH 3/4] s3c-fb: Add support S5PV310 FIMD
Message-Id: <000001cb8255$feb050b0$fc10f210$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1287406528-15324-4-git-send-email-sbkim73@samsung.com>
In-Reply-To: <1287406528-15324-4-git-send-email-sbkim73@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> -----Original Message-----
> From: Paul Mundt [mailto:lethal@linux-sh.org]
> Sent: Friday, November 12, 2010 7:09 PM
> To: Inki Dae
> Cc: 'Kukjin Kim'; 'Sangbeom Kim'; linux-arm-kernel@lists.infradead.org;
> linux-samsung-soc@vger.kernel.org; linux-fbdev@vger.kernel.org; ben-
> linux@fluff.org; akpm@linux-foundation.org; 'Jonghun Han'
> Subject: Re: [PATCH 3/4] s3c-fb: Add support S5PV310 FIMD
> 
> On Fri, Nov 12, 2010 at 06:54:29PM +0900, Inki Dae wrote:
> > @@ -1314,13 +1319,22 @@ static int __devinit s3c_fb_probe(struct
> > platform_device *pdev)
> >  	sfb->pdata = pd;
> >  	sfb->variant = fbdrv->variant;
> >
> > -	sfb->bus_clk = clk_get(dev, "lcd");
> > -	if (IS_ERR(sfb->bus_clk)) {
> > -		dev_err(dev, "failed to get bus clock\n");
> > +	/* if sclk_name is NULL then it would use bus clock as default. */
> > +	if (!pd->sclk_name)
> > +		sfb->lcd_clk = clk_get(dev, "lcd");
> > +	else
> > +		sfb->lcd_clk = clk_get(dev, pd->sclk_name);
> > +
> No, this is totally pointless. Simply establish a clk lookup for the
> configuration you are running on in your board code
You mean, call the function at s3c_fb_probe() establishing clk lookup in
board code?
Sorry but I could understand. Please give me more detail.

> and always have
> clk_get() operate on a fixed id. You can use this same scheme with any
> optional clocks you have too, and reconfigure according to whether the
> lookups for optional clocks succeeded or not.

optional clocks could be sclk_name?

I will glad to show me some example for it.
thank you.

