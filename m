From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 16 Oct 2020 09:53:56 +0000
Subject: Re: [PATCH] omapfb/dss: Remove redundant null check before clk_prepare_enable/clk_disable_unprepare
Message-Id: <20201016115356.34c1620b@linux-uq9g>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20201014084920.25813-1-vulab@iscas.ac.cn>
 <20201015100827.1115fa9b@linux-uq9g>
In-Reply-To: <20201015100827.1115fa9b@linux-uq9g>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Xu Wang <vulab@iscas.ac.cn>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, yuehaibing@huawei.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, pakki001@umn.edu, linux-omap@vger.kernel.org

On Thu, 15 Oct 2020 10:08:27 +0200 Thomas Zimmermann <tzimmermann@suse.de>
wrote:

> On Wed, 14 Oct 2020 08:49:20 +0000 Xu Wang <vulab@iscas.ac.cn> wrote:
> 
> > Because clk_prepare_enable() and clk_disable_unprepare() already checked
> > NULL clock parameter, so the additional checks are unnecessary, just
> > remove them.
> > 
> > Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 

Merged into drm-misc-next. Thanks!

> > ---
> >  drivers/video/fbdev/omap2/omapfb/dss/venc.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> > b/drivers/video/fbdev/omap2/omapfb/dss/venc.c index
> > 0b0ad20afd63..8895fb8493d8 100644 ---
> > a/drivers/video/fbdev/omap2/omapfb/dss/venc.c +++
> > b/drivers/video/fbdev/omap2/omapfb/dss/venc.c @@ -890,8 +890,7 @@ static
> > int venc_remove(struct platform_device *pdev) 
> >  static int venc_runtime_suspend(struct device *dev)
> >  {
> > -	if (venc.tv_dac_clk)
> > -		clk_disable_unprepare(venc.tv_dac_clk);
> > +	clk_disable_unprepare(venc.tv_dac_clk);
> >  
> >  	dispc_runtime_put();
> >  
> > @@ -906,8 +905,7 @@ static int venc_runtime_resume(struct device *dev)
> >  	if (r < 0)
> >  		return r;
> >  
> > -	if (venc.tv_dac_clk)
> > -		clk_prepare_enable(venc.tv_dac_clk);
> > +	clk_prepare_enable(venc.tv_dac_clk);
> >  
> >  	return 0;
> >  }
> 
> 
> 



-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
