From: James Simmons <jsimmons@infradead.org>
Subject: Re: Changing modes with fbset
Date: Tue, 6 Jan 2004 00:06:04 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org>
References: <3FDBB97F.4070207@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdejX-00057i-JT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:06:07 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AdejW-0008JJ-Ue
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:06:07 -0800
In-Reply-To: <3FDBB97F.4070207@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: linux-fbdev-devel@lists.sourceforge.net


Applied. Thanks for finding that.

On Sat, 13 Dec 2003, John Zielinski wrote:

> Found it.  It's a bug in fbcon.c where the rows and cols were mixed up 
> so fbcon_resize tries to set the mode again with xres and yres 
> reversed.  Didn't happen during boot as fbcon_state_manager is 
> registered after the console is taken over.
> 
> 
> diff -urNX dontdiff linux.old/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
> --- linux.old/drivers/video/console/fbcon.c	2003-12-13 19:32:14.000000000 -0500
> +++ linux/drivers/video/console/fbcon.c	2003-12-13 19:34:48.000000000 -0500
> @@ -2261,8 +2261,8 @@
>  			// Switch resolution size
>  			int rows, cols;
>  			
> -			rows = info->var.xres / vc->vc_font.height;
> -			cols = info->var.yres / vc->vc_font.width;
> +			rows = info->var.yres / vc->vc_font.height;
> +			cols = info->var.xres / vc->vc_font.width;
>          		fbcon_resize(vc, cols, rows);
>  			info->state |= flag;
>  			}
> 
> 
> 
> John
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
