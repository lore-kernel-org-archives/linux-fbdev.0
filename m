From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:07:42 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915220742.G10328@flint.arm.linux.org.uk>
References: <20030915194329.GI16370@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0ZX-0002Ua-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 14:07:47 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19z0ZW-0001zY-Bz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 14:07:46 -0700
Content-Disposition: inline
In-Reply-To: <20030915194329.GI16370@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Mon, Sep 15, 2003 at 09:43:29PM +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

On Mon, Sep 15, 2003 at 09:43:29PM +0200, Kronos wrote:
> Hi,
> this patch converts driver/video/cyber200fb.c to framebuffer_alloc:
> 
> ======== drivers/video/cyber2000fb.c 1.33 ========
> D 1.33 03/09/13 23:21:10+02:00 kronos@kronoz.cjb.net 35 34 108/99/1650
> P drivers/video/cyber2000fb.c
> C switch to framebuffer_alloc
> ------------------------------------------------
> 
> ===== drivers/video/cyber2000fb.c 1.32 vs 1.33 =====
> --- 1.32/drivers/video/cyber2000fb.c	Fri Aug 22 08:27:08 2003
> +++ 1.33/drivers/video/cyber2000fb.c	Sat Sep 13 23:21:10 2003
> @@ -62,7 +62,7 @@
>  #include "cyber2000fb.h"
>  
>  struct cfb_info {
> -	struct fb_info		fb;
> +	struct fb_info		*fb;

Oh god, do we have to add yet another level of indirection all over
the framebuffer code?

> @@ -1635,6 +1638,16 @@
>  	return err;
>  }
>  
> +static void release_cfb_info(struct fb_info *info) {
> +	struct cfb_info *cfb = info->par;
> +
> +	iounmap(cfb->region);
> +	fb_alloc_cmap(&info->cmap, 0, 0);
> +
> +	if (cfb->dev)
> +		pci_release_regions(cfb->dev);
> +}
> +
>  static void __devexit cyberpro_pci_remove(struct pci_dev *dev)
>  {
>  	struct cfb_info *cfb = pci_get_drvdata(dev);

Who says "cfb->dev" remains valid after the PCI device has been removed.
This looks like a perfect use-after-free bug waiting to happen.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
