From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
Date: Tue, 7 Jan 2003 21:51:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301072147070.17129-100000@phoenix.infradead.org>
References: <20030104233008.GB1188@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030104233008.GB1188@ppc.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>


> Why? (a) only those which will use putcs, and (b) I see no 512 chars limit
> anywhere in new code. And in old code it is there only because of passed
> data are only 16bit, not 32bit wide... With simple search&replace you can
> extend it to any size you want, as long as you'll not use sparse font
> bitmap.

The current "core" console code screen_buf layout is designed after VGA 
text mode. 16 bits which only 8 bits are used to represent a character, 9 
if you have high_fonts flag set. The other 8,7 bits are for attributes. 
This is very limiting and it does effect fbcon.c :-( I like to the console
system remove these awful limitation in the future. This why I like to see 
fbdev drivers avoid touching strings from the console layer.
