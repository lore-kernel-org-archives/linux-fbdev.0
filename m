From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH 1/10] fbdev: Add mode changing via
 sysfs
Date: Mon, 7 Mar 2005 18:10:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503071809260.21233@pentafluge.infradead.org>
References: <200503060816.28615.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Mgq-0007Xp-G0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:10:48 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D8Mgp-0005tk-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:10:48 -0800
In-Reply-To: <200503060816.28615.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@gmail.com>


> diff -Nru a/include/linux/fb.h b/include/linux/fb.h
> --- a/include/linux/fb.h	2005-03-05 00:18:26 +08:00
> +++ b/include/linux/fb.h	2005-02-18 15:17:45 +08:00
> @@ -715,8 +715,10 @@
>  	struct fb_pixmap sprite;	/* Cursor hardware mapper */
>  	struct fb_cmap cmap;		/* Current cmap */
>  	struct list_head modelist;      /* mode list */
> +	struct fb_videomode *mode;	/* current mode */
>  	struct fb_ops *fbops;
>  	struct device *device;
> +	struct class_device *class_device; /* sysfs per device attrs */
>  #ifdef CONFIG_FB_TILEBLITTING

Why do we need a mode pointer when we have a function that translates the 
mode to a var?



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
