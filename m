From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:40:42 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915224042.I10328@flint.arm.linux.org.uk>
References: <20030915194329.GI16370@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z15U-0005NN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 14:40:48 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19z15T-0000Zn-MQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 14:40:48 -0700
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
> @@ -1645,12 +1658,10 @@
>  		 * we will be leaving hooks that could cause
>  		 * oopsen laying around.
>  		 */
> -		if (unregister_framebuffer(&cfb->fb))
> +		if (unregister_framebuffer(cfb->fb))
>  			printk(KERN_WARNING "%s: danger Will Robinson, "
>  				"danger danger!  Oopsen imminent!\n",
> -				cfb->fb.fix.id);
> -		iounmap(cfb->region);
> -		cyberpro_free_fb_info(cfb);
> +				cfb->fb->fix.id);
>  
>  		/*
>  		 * Ensure that the driver data is no longer
> @@ -1659,8 +1670,6 @@
>  		pci_set_drvdata(dev, NULL);
>  		if (cfb == int_cfb_info)
>  			int_cfb_info = NULL;
> -
> -		pci_release_regions(dev);
>  	}
>  }

There is another reason why the above is fundamentally flawed - who says
that "release_cfb_info" will still be in module space by the time you
need to call it?

Eg, you unload your framebuffer driver module immediately after the device
has gone away, but someone is keeping the sysfs files associated with
the fb_info open.  They close them, you call the release function - oops.

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
