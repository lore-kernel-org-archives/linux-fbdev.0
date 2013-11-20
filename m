From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Wed, 20 Nov 2013 19:13:30 +0000
Subject: Re: [PATCH v2] video: add OpenCores VGA/LCD framebuffer driver
Message-Id: <20131120191328.GA30494@chokladfabriken.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384920820-18740-1-git-send-email-stefan.kristiansson@saunalahti.fi>
 <000701cee5b8$9b61e3b0$d225ab10$%han@samsung.com>
In-Reply-To: <000701cee5b8$9b61e3b0$d225ab10$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>

On Wed, Nov 20, 2013 at 03:20:28PM +0900, Jingoo Han wrote:
> On Wednesday, November 20, 2013 1:14 PM, Stefan Kristiansson wrote:
> 
> > +static int ocfb_probe(struct platform_device *pdev)
> > +{
> > +	int ret = 0;
> > +	struct ocfb_dev *fbdev;
> > +	struct ocfb_par *par = &ocfb_par_priv;
> > +	struct resource *res;
> > +	struct resource *mmio;
> > +	int fbsize;
> > +
> > +	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
> 
> Please use devm_kzalloc() instead of kzalloc().
> In this case, kfree() can be removed from ocfb_probe()
> and ocfb_remove(). Thus, it will make the code smaller.
> 

Nice, thanks for the hint!
Consider it done.

> [.....]
> 
> > +
> > +#ifdef MODULE
> 
> I don't think that '#ifdef MODULE' is necessary.
> Is there any reason?
> 

You're right, that's not necessary, I'll remove that.

Thanks alot for taking the time to review it!

Stefan
