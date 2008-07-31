From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fix scrolling after logo is cleared
Date: Thu, 31 Jul 2008 01:54:03 -0700
Message-ID: <20080731015403.831e038c.akpm@linux-foundation.org>
References: <20080528225337.9e01d40e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOTvS-0000oP-0M for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 01:54:22 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KOTvP-0002Ox-OX
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 01:54:22 -0700
In-Reply-To: <20080528225337.9e01d40e.krzysztof.h1@poczta.fm>
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
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 28 May 2008 22:53:37 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> If the 'clear' command is used on the frame buffer
> with a logo the upper area is filled by few lines but
> not scrolled anymore.
> Fix this by removing the protected area for the logo
> if any part of the logo is cleared.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> 
> diff -urp linux-rc2/drivers/video/console/fbcon.c linux-new/drivers/video/console/fbcon.c
> --- linux-rc2/drivers/video/console/fbcon.c	2008-05-12 18:16:23.193553990 +0200
> +++ linux-new/drivers/video/console/fbcon.c	2008-05-26 21:10:17.592997192 +0200
> @@ -1312,6 +1310,9 @@ static void fbcon_clear(struct vc_data *
>  	if (!height || !width)
>  		return;
>  
> +	if (sy < vc->vc_top && vc->vc_top == logo_lines)
> +		vc->vc_top = 0;
> +
>  	/* Split blits that cross physical y_wrap boundary */
>  
>  	y_break = p->vrows - p->yscroll;
> 

So I'm trolling linux-fbdev-devel for lost patches and I come across
this one.

It is still good?  If so, do you think it should be in 2.6.27?  And
earlier?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
