From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Date: Thu, 5 Dec 2002 21:44:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021205204442.GA1103@iliana>
References: <20021205180314.GA860@iliana> <Pine.LNX.4.44.0212052035330.31967-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212052035330.31967-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Dec 05, 2002 at 08:37:08PM +0000, James Simmons wrote:
> 
> > > Not really. When X closes /dev/fb then fb_release is called which if the 
> > 
> > That supposes X is fbdev aware (either using the fbdev driver or the
> > UseFBDev option), right ? What if X knows nothing about fbdev, it will
> > try restoring stuff as if it was in text mode.
> 
> That is what X will try. 

Mmm, is it enough for X to just save/restore the registers it modifies ?

Also, i suppose if i am comming from fbdev, what X saves or restores
does not really count, since fbdev knows what relevant thing to save.

Still i sense that there may be some issues involved here, especially
if you switch from text mode to fbdev or between fbdevs while not in X.

> > >     X on VESA fb always foobars my system when I exit X.
> > 
> > With which driver ? (i am happily running the vesa X driver on top of
> > vesafb without problems).
> 
> G400 X server 4.0.2 ontop of VESA framebuffer.

And i suppose the VESA driver will work, right ?

Friendly,

Sven Luther
