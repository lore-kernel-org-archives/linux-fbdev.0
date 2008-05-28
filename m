From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fbcon: fix wrong vmode bits copied
	on console switch
Date: Tue, 27 May 2008 20:38:58 -0700
Message-ID: <20080527203858.79061fef.akpm@linux-foundation.org>
References: <20080523100934.27232c7b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1CVb-00037p-7s for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 May 2008 20:39:27 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K1CVa-0001C3-VX
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 May 2008 20:39:27 -0700
In-Reply-To: <20080523100934.27232c7b.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Uytterhoeven <geert@linux-m68k.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, stable@kernel.org, Geert@sc8-sf-spam2.sourceforge.net

On Fri, 23 May 2008 10:09:34 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> The interlaced and double line mode bits should not be
> copied to new console when the console is switched.
> Otherwise, the new console may be set to incorrect refresh
> rate.
> 
> Also, the x and y offsets does not need to be copied.
> 
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> diff -urp linux-2.6.25/drivers/video/console/fbcon.c linux-new/drivers/video/console/fbcon.c
> --- linux-2.6.25/drivers/video/console/fbcon.c	2008-05-23 10:06:04.144074130 +0200
> +++ linux-new/drivers/video/console/fbcon.c	2008-05-23 09:44:50.544333721 +0200
> @@ -2274,9 +2274,7 @@ static int fbcon_switch(struct vc_data *
>  	 * in fb_set_var()
>  	 */
>  	info->var.activate = var.activate;
> -	var.yoffset = info->var.yoffset;
> -	var.xoffset = info->var.xoffset;
> -	var.vmode = info->var.vmode;
> +	var.vmode |= info->var.vmode & ~FB_VMODE_MASK;
>  	fb_set_var(info, &var);
>  	ops->var = info->var;

Do you think this is a needed-in-2.6.26 fix?

And 2.6.25.x?

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
