From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: fix for fbcon Oops
Date: Mon, 2 Dec 2002 21:15:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212022112230.20834-100000@phoenix.infradead.org>
References: <1038468191.1092.48.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1038468191.1092.48.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> This fixes fbcon oopsing at load time which is due to the fb_cursor's
> palette index entries being improperly updated.

Fixed.

> A new kind of 'emacs glitch'  appeared, though. This can be described as
> a block of text that is incompletely  copied, ie when "tabbing" a line
> of text.  This is present with all hardware I tested, soft accel and
> hardware accel, which indicates a problem in the higher layers (probably
> fbcon). vgacon works okay.  

Its is fbcon. If you play with the low level driver to draw things you 
noticed everything is okay. I have to track it down.
 
> Other changes:
> 
> 1. optimization of fbcon_accel_putcs()

Applied. If you look at my patch I attempted to make fbcon_pixmap dynamic 
instead of a static memeory area. It oops so I have that code commented 
out for now. Actually I applied it when the fix came out rigth away.

> 2. enabling logo displays at all packed pixel formats (as long as
> fb_imageblit is supported)

This didn't apply well. Only thing missing.

> 3. Various fbcon_accel_cursor() fixes which would have resulted in
> wrong cursor colors or an invisible cursor.

Applied. Worked now :-)
