From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 06 Dec 2011 14:37:16 +0000
Subject: Re: [PATCH 2/2] video: s3c-fb: Convert to devm style allocation
Message-Id: <20111206143715.GH17731@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322434268-25525-2-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1322434268-25525-2-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Dec 06, 2011 at 09:04:43PM +0900, Kukjin Kim wrote:

> > -	sfb->regs = ioremap(res->start, resource_size(res));
> > +	sfb->regs = devm_request_and_ioremap(dev, res);
> >  	if (!sfb->regs) {
> >  		dev_err(dev, "failed to map registers\n");

> Don't we need dev_err here because the devm_request_and_ioremap() includes
> dev_err() for each error case?

Oh, if it already logs we can just drop that.  I was just doing the
transformation based on the API, I didn't actually look at the
implementation.

> And don't we need devm_release_mem_region() or devm_iounmap() in error
> handling?

My expectation was that this was only if you needed to release at
runtime, if the driver fails to bind then devm_ ought to clean up after
you otherwise there's little win from using it.  Unless there's a reason
I can't think of right now I'd expect that if we need those we should
fix the core rather than the driver.

> >  err_sfb:
> > -	kfree(sfb);

> Maybe we need devm_kfree here?

Similarly here, I'd expect us to only need that if we need to free at
runtime for some reason.
