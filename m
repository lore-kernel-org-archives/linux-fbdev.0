From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] C99 initializers for drivers/video
Date: Tue, 26 Nov 2002 23:57:45 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211262342300.3719-100000@phoenix.infradead.org>
References: <20021125213059.GF22546@debian>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Gpaw-0006Re-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Nov 2002 15:58:23 -0800
In-Reply-To: <20021125213059.GF22546@debian>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Art Haas <ahaas@airmail.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-fbdev-devel@lists.sourceforge.net


> --- linux-2.5.49/drivers/video/aty128fb.c.old	2002-08-27 19:11:02.000000000 -0500
> +++ linux-2.5.49/drivers/video/aty128fb.c	2002-11-22 19:56:35.000000000 -0600

Updated to new api. Those structs are gone.

> --- linux-2.5.49/drivers/video/controlfb.c.old	2002-08-27 19:11:02.000000000 -0500
> +++ linux-2.5.49/drivers/video/controlfb.c	2002-11-22 19:56:20.000000000 -0600

Have to look. It has been updated but I don't have hardware to test it. I 
think those structs are gone.

> +++ linux-2.5.49/drivers/video/fbcon-afb.c 2002-11-22 19:56:18.000000000
[snip]

All fbcon-*.c files are gone. The framebuffer console is now acceleration 
driven via fillrect, copyarea, and image blits.

> +++ linux-2.5.49/drivers/video/g364fb.c	2002-11-23 10:03:25.000000000 -0600
Applied.

> +++ linux-2.5.49/drivers/video/neofb.c	2002-11-22 19:56:18.000000000 -0600

Been applied for awhile.

> +++ linux-2.5.49/drivers/video/pm2fb.c	2002-11-22 19:56:39.000000000 -0600

Being rewritten to new api.

> --- linux-2.5.49/drivers/video/retz3fb.c.old	2002-08-27 19:11:03.000000000 -0500

Needs to ported to new api.

The aty128 driver also needs a few updates to C99. I will do that tonight.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
