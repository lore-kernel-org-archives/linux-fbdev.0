From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/5] SM501: Restructure init to
 allow only 1 fb on an SM501
Date: Mon, 23 Jun 2008 23:54:02 -0700
Message-ID: <20080623235402.0ab2e49c.akpm@linux-foundation.org>
References: <20080622210439.018928412@fluff.org.uk>
	<20080622210614.414283871@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KB2Ql-0006PK-3U for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Jun 2008 23:55:07 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KB2Qk-0001Nx-Rz
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Jun 2008 23:55:07 -0700
In-Reply-To: <20080622210614.414283871@fluff.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, 22 Jun 2008 22:04:41 +0100 Ben Dooks <ben-linux@fluff.org> wrote:

> Add the ability to register only one of the two possible
> main framebuffer devices on the SM501 by passing platform
> data for only the framebuffer that you are interested in
> having.
> 
> As a side note, we update the init sequence to commonise
> the code that is executed twice, and fix a pair of missing
> frees that we didn't do on framebuffer exit, such as freeing
> the fb's cmap.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> Index: linux-2.6.26-rc6-quilt1/drivers/video/sm501fb.c
> ===================================================================
> --- linux-2.6.26-rc6-quilt1.orig/drivers/video/sm501fb.c	2008-06-18 19:02:14.000000000 +0100
> +++ linux-2.6.26-rc6-quilt1/drivers/video/sm501fb.c	2008-06-18 19:48:01.000000000 +0100
> @@ -143,6 +143,8 @@ static int sm501_alloc_mem(struct sm501f
>  			   unsigned int why, size_t size)
>  {
>  	unsigned int ptr = 0;
> +	unsigned int end;
> +	struct fb_info *fbi;
>  
>  	switch (why) {
>  	case SM501_MEMF_CURSOR:
> @@ -152,7 +154,9 @@ static int sm501_alloc_mem(struct sm501f
>  
>  	case SM501_MEMF_PANEL:
>  		ptr = inf->fbmem_len - size;
> -		if (ptr < inf->fb[0]->fix.smem_len)
> +		fbi = inf->fb[0];
> +
> +		if (fbi && ptr < fbi->fix.smem_len)
>  			return -ENOMEM;
>  
>  		break;
> @@ -162,11 +166,18 @@ static int sm501_alloc_mem(struct sm501f
>  		break;
>  
>  	case SM501_MEMF_ACCEL:
> -		ptr = inf->fb[0]->fix.smem_len;
> +		fbi = inf->fb[0];
> +		ptr = fbi ? fbi->fix.smem_len : 0;
> +
> +		fbi = inf->fb[1];
> +		if (fbi)
> +			end = (fbi->fix.smem_start - inf->fbmem_res->start);

Local variable `end' doesn't have an appropriate type.

It could be that overflows here are not possible due to hardware and
architecture limitations, but still, it's best to get these things
right.


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
