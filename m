From: James Simmons <jsimmons@infradead.org>
Subject: Re: vga16fb broke
Date: Wed, 19 May 2004 01:18:43 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0405190117430.16503-100000@phoenix.infradead.org>
References: <20040518171612.516ad43c.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S263580AbUESASu@vger.kernel.org>
In-Reply-To: <20040518171612.516ad43c.akpm@osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: VANDROVE@vc.cvut.cz, vince@kyllikki.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> I have pondered your email at length and have failed to understand it.
> 
> I _think_ you're saying that we need to do this, which will fix x86:
> 
> --- 25/drivers/video/vga16fb.c~vga16fb-fix	Tue May 18 17:10:14 2004
> +++ 25-akpm/drivers/video/vga16fb.c	Tue May 18 17:10:39 2004
> @@ -1347,7 +1347,7 @@ int __init vga16fb_init(void)
>  
>  	/* XXX share VGA_FB_PHYS and I/O region with vgacon and others */
>  
> -	vga16fb.screen_base = ioremap(VGA_MAP_MEM(VGA_FB_PHYS), VGA_FB_PHYS_LEN);
> +	vga16fb.screen_base = VGA_MAP_MEM(VGA_FB_PHYS);
>  	if (!vga16fb.screen_base) {
>  		printk(KERN_ERR "vga16fb: unable to map device\n");
>  		ret = -ENOMEM;

This will make the driver on all platforms. 
_
> 
> and that ARM and others need to teach their VGA_MAP_MEM() to do an internal
> ioremap().
> 
> Or do you mean something else?  Please be more clear?

I like to see the VGA_MAP_MEM hack go away and be replaced with ioremap.
