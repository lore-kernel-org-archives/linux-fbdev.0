From: Ian Campbell <icampbell@arcom.com>
Subject: Re: [PATCH] PXA255 LCD Driver
Date: Wed, 17 Mar 2004 11:07:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1079521633.13370.39.camel@icampbell-debian>
References: <1079518182.13373.27.camel@icampbell-debian>
	 <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>


> > +For example:
> > +	modprobe pxafb options=xres:640,yres:480,bpp:8,passive
> 
> Not much comments, except: why don't you use the standard modedb mode parameter
> style?

I was trying too (I mostly copied the i810 driver). How wrong did I get
it? I'm willing to rework it to make it the same as the standard.

> > I posted it to the fbdev list @ sf.net (from MAINTAINERS) but that list
> > seems to be pretty quiet and www.linux-fbdev.org (also from MAINTAINERS)
> 
> It's not quiet, though.

OK, I just hadn't seen many messages since I subscribed...

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200
