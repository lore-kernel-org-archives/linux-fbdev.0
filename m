From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
Date: Tue, 7 Jan 2003 21:46:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301072143230.17129-100000@phoenix.infradead.org>
References: <20030104231729.GA1188@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030104231729.GA1188@ppc.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>


> > > I'll be happier with character coordinates for text mode. 
> > 
> > Yuck!! Using fbcon for text modes is just bloat. For hardware text mode it 
> > is much better to write a nice small console driver like newport_con.c
> 
> When I said before christmas that I'll have to write matroxcon to get
> reasonable functionality, you laughed... Now, it is clear that there is
> no other way...

No I didn't laugh. I didn't like the idea of another fbcon like system 
being developed just to support this text mode. I have no problem with 
a matroxcon. 

> You can throw anything in and out, of course... It is GPL, after all.
> Only question left is whether I'll be satisfied with functionality you
> offer.

:-) I'm working on your driver the latest few days. I managed to shrink 
most of the accel code into one common base.I still have alot to go tho.
You have a matroxfb_check_var which makes my life much easier. 
