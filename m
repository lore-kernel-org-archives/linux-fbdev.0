From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fsl_diu_fb: fix build with
 CONFIG_PM=y, plus fix some warnings
Date: Mon, 30 Jun 2008 12:40:24 -0700
Message-ID: <20080630124024.545e4c05.akpm@linux-foundation.org>
References: <20080606145552.GA24276@polina.dev.rtsoft.ru>
	<1212765952.4939.9.camel@tera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDPEt-0004E5-U1 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 12:40:39 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KDPEt-0001rp-GU
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 12:40:39 -0700
In-Reply-To: <1212765952.4939.9.camel@tera>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: York Sun <yorksun@freescale.com>
Cc: avorontsov@ru.mvista.com, linux-fbdev-devel@lists.sourceforge.net, timur@freescale.com, adaplas@gmail.com

On Fri, 06 Jun 2008 10:25:52 -0500
York Sun <yorksun@freescale.com> wrote:

> Anton,
> 
> Thanks for spending time on this. We will verify it soon.
> 

It looks fine to me.  I merged it with the intention of putting it into
2.6.26.


> 
> On Fri, 2008-06-06 at 18:55 +0400, Anton Vorontsov wrote:
> > This patch fixes following build error when CONFIG_PM is set.
> > 
> >   CC      drivers/video/fsl-diu-fb.o
> > drivers/video/fsl-diu-fb.c: In function 'fsl_diu_suspend':
> > drivers/video/fsl-diu-fb.c:1327: error: 'ofdev' undeclared (first use in this function)
> > drivers/video/fsl-diu-fb.c:1327: error: (Each undeclared identifier is reported only once
> > drivers/video/fsl-diu-fb.c:1327: error: for each function it appears in.)
> > drivers/video/fsl-diu-fb.c: In function 'fsl_diu_resume':
> > drivers/video/fsl-diu-fb.c:1337: error: 'ofdev' undeclared (first use in this function)
> > 
> > While I'm at it, also fix this warning:
> > 
> > drivers/video/fsl-diu-fb.c: In function 'fsl_diu_alloc':
> > drivers/video/fsl-diu-fb.c:314: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'phys_addr_t'
> > 
> > And these section mismatches:
> > 
> > ..from the function fsl_diu_remove() to the function .exit.text:uninstall_fb()
> > ..from the function fsl_diu_remove() to the function .exit.text:uninstall_fb()
> > ..from the function install_fb() to the variable .devinit.data:fsl_diu_mode_db
> > ..from the function install_fb() to the variable .devinit.data:fsl_diu_mode_db
> > ..from the function fsl_diu_probe() to the function .exit.text:uninstall_fb()
> > ..from the function fsl_diu_probe() to the function .exit.text:uninstall_fb()
> > 
> > Also, some sparse fixes: make two functions static, and use NULL where
> > appropriate. There are still a lot of sparse warnings, mainly wrt absence
> > of __iomem annotations, but some will require ugly __force stuff. I'll leave
> > them for now, since proper fix would be not that trivial as few one-liners
> > below.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  drivers/video/fsl-diu-fb.c |   29 +++++++++++++++--------------
> >  1 files changed, 15 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index b50bb03..7a78fd5 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -286,7 +286,7 @@ static struct diu_pool pool;
> >   *	rheap and make the furture large allocation fail.
> >   */
> >  
> > -void *fsl_diu_alloc(unsigned long size, phys_addr_t *phys)
> > +static void *fsl_diu_alloc(unsigned long size, phys_addr_t *phys)
> >  {
> >  	void *virt;
> >  
> > @@ -311,12 +311,12 @@ void *fsl_diu_alloc(unsigned long size, phys_addr_t *phys)
> >  		memset(virt, 0, size);
> >  	}
> >  
> > -	pr_debug("rh virt=%p phys=%lx\n", virt, *phys);
> > +	pr_debug("rh virt=%p phys=%llx\n", virt, (unsigned long long)*phys);
> >  
> >  	return virt;
> >  }
> >  
> > -void fsl_diu_free(void *p, unsigned long size)
> > +static void fsl_diu_free(void *p, unsigned long size)
> >  {
> >  	pr_debug("p=%p size=%lu\n", p, size);
> >  
> > @@ -770,7 +770,7 @@ static int map_video_memory(struct fb_info *info)
> >  	info->fix.smem_len = info->fix.line_length * info->var.yres_virtual;
> >  	pr_debug("MAP_VIDEO_MEMORY: smem_len = %d\n", info->fix.smem_len);
> >  	info->screen_base = fsl_diu_alloc(info->fix.smem_len, &phys);
> > -	if (info->screen_base == 0) {
> > +	if (info->screen_base == NULL) {
> >  		printk(KERN_ERR "Unable to allocate fb memory\n");
> >  		return -ENOMEM;
> >  	}
> > @@ -788,7 +788,7 @@ static int map_video_memory(struct fb_info *info)
> >  static void unmap_video_memory(struct fb_info *info)
> >  {
> >  	fsl_diu_free(info->screen_base, info->fix.smem_len);
> > -	info->screen_base = 0;
> > +	info->screen_base = NULL;
> >  	info->fix.smem_start = 0;
> >  	info->fix.smem_len = 0;
> >  }
> > @@ -1158,7 +1158,7 @@ static int init_fbinfo(struct fb_info *info)
> >  	return 0;
> >  }
> >  
> > -static int install_fb(struct fb_info *info)
> > +static int __devinit install_fb(struct fb_info *info)
> >  {
> >  	int rc;
> >  	struct mfb_info *mfbi = info->par;
> > @@ -1233,7 +1233,7 @@ static int install_fb(struct fb_info *info)
> >  	return 0;
> >  }
> >  
> > -static void __exit uninstall_fb(struct fb_info *info)
> > +static void uninstall_fb(struct fb_info *info)
> >  {
> >  	struct mfb_info *mfbi = info->par;
> >  
> > @@ -1287,7 +1287,7 @@ static int request_irq_local(int irq)
> >  	/* Read to clear the status */
> >  	status = in_be32(&hw->int_status);
> >  
> > -	ret = request_irq(irq, fsl_diu_isr, 0, "diu", 0);
> > +	ret = request_irq(irq, fsl_diu_isr, 0, "diu", NULL);
> >  	if (ret)
> >  		pr_info("Request diu IRQ failed.\n");
> >  	else {
> > @@ -1312,7 +1312,7 @@ static void free_irq_local(int irq)
> >  	/* Disable all LCDC interrupt */
> >  	out_be32(&hw->int_mask, 0x1f);
> >  
> > -	free_irq(irq, 0);
> > +	free_irq(irq, NULL);
> >  }
> >  
> >  #ifdef CONFIG_PM
> > @@ -1324,7 +1324,7 @@ static int fsl_diu_suspend(struct of_device *dev, pm_message_t state)
> >  {
> >  	struct fsl_diu_data *machine_data;
> >  
> > -	machine_data = dev_get_drvdata(&ofdev->dev);
> > +	machine_data = dev_get_drvdata(&dev->dev);
> >  	disable_lcdc(machine_data->fsl_diu_info[0]);
> >  
> >  	return 0;
> > @@ -1334,7 +1334,7 @@ static int fsl_diu_resume(struct of_device *dev)
> >  {
> >  	struct fsl_diu_data *machine_data;
> >  
> > -	machine_data = dev_get_drvdata(&ofdev->dev);
> > +	machine_data = dev_get_drvdata(&dev->dev);
> >  	enable_lcdc(machine_data->fsl_diu_info[0]);
> >  
> >  	return 0;
> > @@ -1353,7 +1353,8 @@ static int allocate_buf(struct diu_addr *buf, u32 size, u32 bytes_align)
> >  	dma_addr_t paddr = 0;
> >  
> >  	ssize = size + bytes_align;
> > -	buf->vaddr = dma_alloc_coherent(0, ssize, &paddr, GFP_DMA | __GFP_ZERO);
> > +	buf->vaddr = dma_alloc_coherent(NULL, ssize, &paddr, GFP_DMA |
> > +							     __GFP_ZERO);
> >  	if (!buf->vaddr)
> >  		return -ENOMEM;
> >  
> > @@ -1371,7 +1372,7 @@ static int allocate_buf(struct diu_addr *buf, u32 size, u32 bytes_align)
> >  
> >  static void free_buf(struct diu_addr *buf, u32 size, u32 bytes_align)
> >  {
> > -	dma_free_coherent(0, size + bytes_align,
> > +	dma_free_coherent(NULL, size + bytes_align,
> >  				buf->vaddr, (buf->paddr - buf->offset));
> >  	return;
> >  }
> > @@ -1411,7 +1412,7 @@ static ssize_t show_monitor(struct device *device,
> >  	return diu_ops.show_monitor_port(machine_data->monitor_port, buf);
> >  }
> >  
> > -static int fsl_diu_probe(struct of_device *ofdev,
> > +static int __devinit fsl_diu_probe(struct of_device *ofdev,
> >  	const struct of_device_id *match)
> >  {
> >  	struct device_node *np = ofdev->node;
> 
> 
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
