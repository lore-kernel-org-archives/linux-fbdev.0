From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Date: Thu, 5 Dec 2002 20:37:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212052035330.31967-100000@phoenix.infradead.org>
References: <20021205180314.GA860@iliana>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021205180314.GA860@iliana>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > Not really. When X closes /dev/fb then fb_release is called which if the 
> 
> That supposes X is fbdev aware (either using the fbdev driver or the
> UseFBDev option), right ? What if X knows nothing about fbdev, it will
> try restoring stuff as if it was in text mode.

That is what X will try. 

> >     X on VESA fb always foobars my system when I exit X.
> 
> With which driver ? (i am happily running the vesa X driver on top of
> vesafb without problems).

G400 X server 4.0.2 ontop of VESA framebuffer.
