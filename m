From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: HP300 support checked in
Date: Wed, 14 Jul 2004 15:32:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407141532.45514.adaplas@hotpop.com>
References: <1089576608.2555.35.camel@kars.perseus.home> <Pine.GSO.4.58.0407120923340.17199@waterleaf.sonytel.be>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkeG9-0005cW-ML
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jul 2004 00:32:57 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BkeG9-0001ar-7e
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jul 2004 00:32:57 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 48CE06DBC03
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 Jul 2004 06:46:55 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0407120923340.17199@waterleaf.sonytel.be>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>, Kars de Jong <jongk@linux-m68k.org>
Cc: Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Monday 12 July 2004 15:25, Geert Uytterhoeven wrote:
> On Sun, 11 Jul 2004, Kars de Jong wrote:
> > Support for <8 bit framebuffers is probably broken. I don't know how I'm
> > going to support them yet. It used to be "special-cased" in
> > drivers/video/fbcon.c.
> >
> > They are laid out in memory like normal 8 bit chunky framebuffers, but
> > the upper bits are basically ignored.
> >
> > So for blitting purposes the bits_per_pixel == 8 code should be used,
> > but just setting bits_per_pixel to 8 doesn't work because then the
> > amount of colours is assumed to be 256.
> >
> > I think we basically need to distinguish between bpp and depth.
>

> What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
> colors)?
>
> If it's just 1 (monochrome), you can probably get away with setting
> var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Or we can use the fields in var->green, var->red, var->blue, ie,  to describe a 4-color
8-bit chunky framebuffer:

var->red.length = 2;
var->red.offset = 0;
var->green = var->blue = var->red.
var->bits_per_pixel = 8;

We still need to fix fbcon to handle this type of framebuffers, since fbcon always assumes
a packed pixel format.  For instance, we have this kind of code in fbcon.c

vc->vc_can_do_color = (var->bits_per_pixel != 1) ? 1 : 0;

which is incorrect in this case. Better if we test fix->visual instead.

I'll see if I can create a test patch for this. 

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
