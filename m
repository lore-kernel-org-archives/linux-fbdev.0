From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: coverity-fbsysfs-fix-null-pointer-check.patch
 added to -mm tree
Date: Sat, 2 Jul 2005 00:53:22 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507020040320.14405@pentafluge.infradead.org>
References: <200507010553.j615rbmw022839@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.92] (helo=sc8-sf-mx2-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoVK6-00007I-P4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 16:53:30 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DoVK5-0007B4-F0
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 16:53:31 -0700
In-Reply-To: <200507010553.j615rbmw022839@shell0.pdx.osdl.net>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: kambarov@berkeley.edu, zkambarov@coverity.com, mm-commits@vger.kernel.org


Good find. I noticed a problem with transp. The transp field might or 
might not be there. That needs fixing as well.


On Thu, 30 Jun 2005 akpm@osdl.org wrote:

> 
> The patch titled
> 
>      coverity: fix fbsysfs null pointer check
> 
> has been added to the -mm tree.  Its filename is
> 
>      coverity-fbsysfs-fix-null-pointer-check.patch
> 
> Patches currently in -mm which might be from kambarov@berkeley.edu are
> 
> coverity-fbsysfs-fix-null-pointer-check.patch
> 
> 
> 
> From: "KAMBAROV, ZAUR" <kambarov@berkeley.edu>
> 
> Correctly test for a null pointer before going and dereferencing it.
> 
> This defect was found automatically by Coverity Prevent, a static analysis
> tool.
> 
> Signed-off-by: Zaur Kambarov <zkambarov@coverity.com>
> Cc: <linux-fbdev-devel@lists.sourceforge.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/video/fbsysfs.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/video/fbsysfs.c~coverity-fbsysfs-fix-null-pointer-check drivers/video/fbsysfs.c
> --- devel/drivers/video/fbsysfs.c~coverity-fbsysfs-fix-null-pointer-check	2005-06-30 22:52:31.000000000 -0700
> +++ devel-akpm/drivers/video/fbsysfs.c	2005-06-30 22:52:31.000000000 -0700
> @@ -256,7 +256,7 @@ static ssize_t show_cmap(struct class_de
>  	unsigned int offset = 0, i;
>  
>  	if (!fb_info->cmap.red || !fb_info->cmap.blue ||
> -	    fb_info->cmap.green || fb_info->cmap.transp)
> +	    !fb_info->cmap.green || !fb_info->cmap.transp)
>  		return -EINVAL;
>  
>  	for (i = 0; i < fb_info->cmap.len; i++) {
> _
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
