From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 7/7] fbdev: Add Tile Blitting support
Date: Fri, 10 Sep 2004 16:35:23 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409101635.23527.adaplas@hotpop.com>
References: <200409100534.56680.adaplas@hotpop.com> <Pine.GSO.4.58.0409100957130.93@waterleaf.sonytel.be>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267259AbUIJIeN@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0409100957130.93@waterleaf.sonytel.be>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Petr Vandrovec <vandrove@vc.cvut.cz>

On Friday 10 September 2004 15:58, Geert Uytterhoeven wrote:

> > move a +	 rectangular section of a screen, the rectangle willbe described
> > in
>
>                                                         ^^^^^^
> 							will be
>
> > +	 terms of number of tiles in the x- and y-axis.
> > +
> > +	 This is particularly important to one driver, the matroxfb.  If
>
>                                                        ^^^^^^^^^^^^
> 						       matroxfb?
>

Which proves that documentation is the last thing I check :-)

Thanks.

Tony
