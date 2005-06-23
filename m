From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: PATCH: virtual_printk.patch
Date: Thu, 23 Jun 2005 21:36:38 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506232135210.12535@pentafluge.infradead.org>
References: <9e47339105062312473e885387@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlYRH-0000Vb-8M
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 13:36:43 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DlYRG-0002rz-MR
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 13:36:43 -0700
In-Reply-To: <9e47339105062312473e885387@mail.gmail.com>
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>


Please apply.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>


On Thu, 23 Jun 2005, Jon Smirl wrote:

> Patch to remove unneeded fbsysfs printk.
> 
> --
> Jon Smirl
> jonsmirl@gmail.com
> 
> #Remove unneeded fbsysfs printk
> #Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
> --- a/drivers/video/fbsysfs.c
> +++ b/drivers/video/fbsysfs.c
> @@ -228,8 +228,6 @@ static ssize_t store_virtual(struct clas
>  	if (last - buf >= count)
>  		return -EINVAL;
>  	var.yres_virtual = simple_strtoul(last, &last, 0);
> -	printk(KERN_ERR "fb: xres %d yres %d\n"


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
