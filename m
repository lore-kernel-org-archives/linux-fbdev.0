From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
Date: Sat, 14 Dec 2002 00:01:43 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212132355040.19622-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212131347240.10159-100000@home.transmeta.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212131347240.10159-100000@home.transmeta.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> James,
>  the fbcon update seems to have broken the plain VGA console. I get a page
> fault at vgacon_scroll+0x144, the call sequence seems to be:
> 
> 	vt_console_print+0x203
> 	set_cursor+0x78
> 	vgacon_cursor+x0xb5

> 	scrup+0x122

Calling scrup is out of place. It is only called by lf() and csi_M() in 
the vt.c. lf() is used in vt_console_print but it is called before 
set_cursor(). Also vgacon_cursor doesn't call vgacon_scroll. It can call 
vgacon_scrolldelta. Now scrup does call vgacon_scroll. It looks like The 
code jumped from the middle of vt_console_print to scrup. Do you get the 
same error all the time? Also do you have Preemptible Kernel turned on?

> 	vgacon_scroll+0x144
> 
> I don't know what triggers it, since it seems to happen pretty randomly.
> 
> 		Linus
> 
> 
