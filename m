From: Kronos <kronos@people.it>
Subject: Re: Get the line length from sysfs.
Date: Thu, 22 Sep 2005 01:27:59 +0200
Message-ID: <20050921232759.GA5988@dreamland.darkstar.lan>
References: <Pine.LNX.4.56.0509212202030.10847@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIE0J-0003fE-2v
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Sep 2005 16:27:55 -0700
Received: from apollo2.tiscali.it ([213.205.33.82] helo=cp3a.criticalpath.priv)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EIE0H-0001Cm-HP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Sep 2005 16:27:55 -0700
Received: from dreamland.darkstar.lan (84.222.33.29) by cp3a.criticalpath.priv (7.2.062.1)
        id 43204FDB001C6221 for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Sep 2005 01:27:54 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0509212202030.10847@pentafluge.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Il Wed, Sep 21, 2005 at 10:03:29PM +0100, James Simmons ha scritto: 
> --- linus-2.6/drivers/video/fbsysfs.c	2005-07-31 15:45:22.000000000 -0700
> +++ fbdev-2.6/drivers/video/fbsysfs.c	2005-09-21 13:54:02.000000000 -0700
> @@ -242,6 +242,13 @@
>  			fb_info->var.yres_virtual);
>  }
>  
> +static ssize_t show_stride(struct class_device *class_device, char *buf)
> +{
> +	struct fb_info *fb_info =
> +		(struct fb_info *)class_get_devdata(class_device);

class_get_devdata returns a void*, you can remove the cast and use just
one line :)

> +	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->fix.line_length);
> +}
> +
>  /* Format for cmap is "%02x%c%4x%4x%4x\n" */
>  /* %02x entry %c transp %4x red %4x blue %4x green \n */
>  /* 256 rows at 16 chars equals 4096, the normal page size */
> @@ -432,6 +439,7 @@
>  	__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
>  	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
>  	__ATTR(name, S_IRUGO, show_name, NULL),
> +	__ATTR(stride, S_IRUGO, show_stride, NULL),
>  };
>  
>  int fb_init_class_device(struct fb_info *fb_info)


Luca
-- 
Home: http://kronoz.cjb.net
Se non puoi convincerli, confondili.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
