From: Emil Goode <emilgoode@gmail.com>
Date: Mon, 28 May 2012 15:34:19 +0000
Subject: Re: [PATCH] video: bfin_adv7393fb: Fix cleanup code
Message-Id: <1338219259.3521.1.camel@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1338216019-1288-1-git-send-email-emilgoode@gmail.com>
	 <20120528152601.GE4637@mwanda>
In-Reply-To: <20120528152601.GE4637@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Thanks Dan, I'll resend with these modifications.

Best regards, 
Emil Goode
On Mon, 2012-05-28 at 18:26 +0300, Dan Carpenter wrote:
> On Mon, May 28, 2012 at 04:40:19PM +0200, Emil Goode wrote:
> > This patch fixes the cleanup code of the bfin_adv7393_fb_probe
> > function by changing the order in which cleanup is performed
> > and by adding one label.
> > 
> 
> Could you list the actual bugs which were fixed:
> 
> 1) The resources were not freed in the order that we allocated them
>    so we call dma_free_coherent() before it was allocated.
> 2) The labels weren't in the right place which also meant that we
>    freed resources that weren't allocated.
> 3) We should free gpio_free(P_IDENT(P_PPI0_FS3)) before returning.
> 
> The new gpio_free() is more important than the added label.
> 
> Since you're changing all these, you may as well fix the label names
> as well.  The out_9 style labels suck.  The right way is to give
> them meaningful labels instead of GW-BASIC style labels.
> 
> Labels should be named after what happens when you arrive.  Some
> people name them after the start of the journey but that's a
> mistake.  It's just like the town of Chicago is still called Chicago
> even though you might goto Chicago starting from Boston.  Like this:
> 
> err_ppi:
> 	free_dma(CH_PPI);
> 	fb_dealloc_cmap(&fbdev->info.cmap);
> err_palette:
> 	kfree(fbdev->info.pseudo_palette);
> 
> regards,
> dan carpenter


