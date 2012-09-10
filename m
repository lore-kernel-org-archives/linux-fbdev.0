From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 10 Sep 2012 04:37:24 +0000
Subject: Re: [PATCH] fbdev: Add Renesas vdc4 framebuffer driver
Message-Id: <001801cd8f0d$f97da400$ec78ec00$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344428095-12203-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1344428095-12203-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Monday, September 10, 2012 1:31 PM Jingoo Han wrote
> 
> On Wednesday, August 08, 2012 9:15 PM Phil Edworthy wrote
> 
> Hi Phil Edworthy,
> 
> I reviewed your patch.
> Please refer to my comments.
> Good luck.
> 
> Best regards,
> Jingoo Han
> 
> >
> > The vdc4 display hardware is found on the sh7269 device.
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Please insert one line between the commit message and Signed-off-by.
> 
> > ---
> >  drivers/video/Kconfig      |   10 +
> >  drivers/video/Makefile     |    1 +
> >  drivers/video/ren_vdc4fb.c |  653 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/video/ren_vdc4fb.h |   19 ++
> >  4 files changed, 683 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/ren_vdc4fb.c
> >  create mode 100644 include/video/ren_vdc4fb.h
> >

.....

> > +
> > +static int ren_vdc4_setup_clocks(struct platform_device *pdev,
> > +	int clock_source,
> > +	struct ren_vdc4_priv *priv)
> > +{
> > +	priv->clk = clk_get(&pdev->dev, "vdc4");
> 
> How about using devm_clk_get() instead of kzalloc()?
> It makes the code simpler.

Sorry, it's a typo.
It is not kzalloc(), but clk_get().

> 
> > +	if (IS_ERR(priv->clk)) {
> > +		dev_err(&pdev->dev, "cannot get clock \"vdc4\"\n");
> > +		return PTR_ERR(priv->clk);
> > +	}
> > +
> > +	if (clock_source = VDC4_PERI_CLK) {
> > +		priv->dot_clk = clk_get(&pdev->dev, "peripheral_clk");
> 
> How about using devm_clk_get() instead of kzalloc()?
> It makes the code simpler.

Same as above.

> 
> 


