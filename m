From: Tony Prisk <linux@prisktech.co.nz>
Date: Sun, 09 Dec 2012 10:21:53 +0000
Subject: Re: [PATCH] drivers/video/wm8505fb.c: use devm_ functions
Message-Id: <1355048513.9812.7.camel@gitbox>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1354984288-773-1-git-send-email-Julia.Lawall@lip6.fr>
 <1355002958.14981.11.camel@gitbox>
 <alpine.DEB.2.02.1212090820270.2028@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.02.1212090820270.2028@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, 2012-12-09 at 08:21 +0100, Julia Lawall wrote:
> > Rather than the goto, add the fail path code in directly, and return.
> >
> >
> > ret = register_framebuffer(&fbi->fb);
> > if (ret < 0) {
> >  dev_err(&pdev->dev,
> >  "Failed to register framebuffer device: %d\n", ret);
> >  if (fbi->fb.cmap.len)
> >    fb_dealloc_cmap(&fbi->fb.cmap);
> >  return ret;
> > }
> 
> So there is no need for the platform_set_drvdata(pdev, NULL); ?

Unless there is some kind of reference counting, I can't see any reason
for this.

> 
> Also, do you know if it is correct that the original code does not include
> a call to dma_free_coherent?

No, that is not correct - there definitely should be a
dma_free_coherent, both in the fail path and in the remove(). Appears
they are both missing.

Regards
Tony P

