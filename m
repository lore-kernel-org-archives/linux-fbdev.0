From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Fri, 23 Apr 2004 21:03:36 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404232059110.5826-100000@phoenix.infradead.org>
References: <15833.171.72.5.12.1082739191.squirrel@www.foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BH6th-0000zP-4c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 13:03:41 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BH6tg-0002AP-Gd
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 13:03:40 -0700
In-Reply-To: <15833.171.72.5.12.1082739191.squirrel@www.foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net


> Just curious, but if this is the case, why isn't pseudo_palette defined as
> a "u32 *" (instead of "void *") in struct fb_info?  If anything outside
> the driver itself is going to be using this, it really should be more
> explicit what format it's supposed to be in.

Because there can cases when the hardware requires a 16 bit value. Here we 
can optimize the pseudo_palette to a smaller size. This is for the case 
where we have hardware acceleration. 

> For that matter, is it really kosher to have the logo code (or other
> things external to the driver) setting pseudo_palette directly anyway? 
> Shouldn't there be some sort of an interface function for this (at the
> very least to let the driver know it's changed, in case it needs to know
> that sort of thing)?

That is totally bad. In fact the code is broken in that when I attempt to 
draw a 4 bpp image on 16 bpp or 32 bpp framebuffers the colors come out 
all wrong. This is not easy to fix. All the drivers need to be brought up 
to date in creating a 256 palette cmap. As I update drivers you wil see 
this fix. Once the drivers are done the logo hacks can go away.




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
