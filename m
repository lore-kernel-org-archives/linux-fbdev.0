From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: fbdev driver and sysfs question.
Date: Wed, 11 Feb 2004 22:57:24 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040211225724.GN21151@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0402112225360.25659-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar3JB-0005qN-OZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 14:58:17 -0800
Received: from parcelfarce.linux.theplanet.co.uk
	([195.92.249.252] helo=www.linux.org.uk ident=93)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Ar3IO-0008QG-Ly
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 14:57:28 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402112225360.25659-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Feb 11, 2004 at 10:26:45PM +0000, James Simmons wrote:
> +	info = framebuffer_alloc(0, &dev->dev); 
> +	if (!info)
> +		return -ENOMEM;
> +	dev_set_drvdata(&dev->dev, info);
> +	
> +        info->screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
> +	if (!info->screen_base) {
>  		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
>  		printk(KERN_ERR
>  		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",

	Who will free info?

> -	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
> +	fb_alloc_cmap(&info->cmap, video_cmap_len, 0);
>  
> -	if (register_framebuffer(&fb_info)<0)
> +	if (register_framebuffer(info) < 0)

	Who will undo allocations?  BTW, that applies to the old code too -
even if fb_alloc_cmap() doesn't require any actions on cleanup, ioremap()
definitely does.

>  		return -EINVAL;


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
