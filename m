From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: HP300 support checked in
Date: Mon, 12 Jul 2004 09:25:12 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0407120923340.17199@waterleaf.sonytel.be>
References: <1089576608.2555.35.camel@kars.perseus.home>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkIKy-0004cT-E6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 01:08:28 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BkIKw-00008q-Ma
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jul 2004 01:08:28 -0700
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i6D88MXK003079
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Jul 2004 10:08:23 +0200 (MEST)
In-Reply-To: <1089576608.2555.35.camel@kars.perseus.home>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kars de Jong <jongk@linux-m68k.org>
Cc: Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 09:44:53 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407120944530.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--

--i6C7ivXJ010717.1089618297/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 13:03:41 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407121303410.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 09:44:53 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407120944530.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--

--i6C7ivXJ010717.1089618297/witte.sonytel.be--

--i6CB3kXJ003893.1089630226/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 16:24:28 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407121624280.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 09:44:53 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407120944530.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--

--i6C7ivXJ010717.1089618297/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 13:03:41 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407121303410.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 09:44:53 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407120944530.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--

--i6C7ivXJ010717.1089618297/witte.sonytel.be--

--i6CB3kXJ003893.1089630226/witte.sonytel.be--

--i6CEOWXJ026457.1089642272/witte.sonytel.be--
ReSent-Date: Tue, 13 Jul 2004 10:08:20 +0200 (MEST)
ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Subject: Re: HP300 support checked in
ReSent-Message-ID: <Pine.GSO.4.58.0407131008200.6985@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 09:44:53 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407120944530.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--

--i6C7ivXJ010717.1089618297/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 13:03:41 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407121303410.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 09:44:53 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407120944530.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--

--i6C7ivXJ010717.1089618297/witte.sonytel.be--

--i6CB3kXJ003893.1089630226/witte.sonytel.be--
ReSent-Date: Mon, 12 Jul 2004 16:24:28 +0200 (MEST)
ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Subject: Re: HP300 support checked in
ReSent-Message-ID: <Pine.GSO.4.58.0407121624280.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--
X-ReSent-Date: Mon, 12 Jul 2004 09:44:53 +0200 (MEST)
X-ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
X-ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
X-ReSent-Subject: Re: HP300 support checked in
X-ReSent-Message-ID: <Pine.GSO.4.58.0407120944530.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--

--i6C7ivXJ010717.1089618297/witte.sonytel.be--
ReSent-Date: Mon, 12 Jul 2004 13:03:41 +0200 (MEST)
ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Subject: Re: HP300 support checked in
ReSent-Message-ID: <Pine.GSO.4.58.0407121303410.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--
ReSent-Date: Mon, 12 Jul 2004 09:44:53 +0200 (MEST)
ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
ReSent-To: 
    Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Subject: Re: HP300 support checked in
ReSent-Message-ID: <Pine.GSO.4.58.0407120944530.17199@waterleaf.sonytel.be>

On Sun, 11 Jul 2004, Kars de Jong wrote:
> Support for <8 bit framebuffers is probably broken. I don't know how I'm
> going to support them yet. It used to be "special-cased" in
> drivers/video/fbcon.c.
>
> They are laid out in memory like normal 8 bit chunky framebuffers, but
> the upper bits are basically ignored.
>
> So for blitting purposes the bits_per_pixel == 8 code should be used,
> but just setting bits_per_pixel to 8 doesn't work because then the
> amount of colours is assumed to be 256.
>
> I think we basically need to distinguish between bpp and depth.

What are the possible values of depth? Just 1 (monochrome)? Or also 4 (16
colors)?

If it's just 1 (monochrome), you can probably get away with setting
var.bits_per_pixel = 256 and fix.visual = FB_VISUAL_MONO01 (or MONO10).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

--i6C7PIXJ008765.1089617118/witte.sonytel.be--

--i6C7ivXJ010717.1089618297/witte.sonytel.be--

--i6CB3kXJ003893.1089630226/witte.sonytel.be--

--i6CEOWXJ026457.1089642272/witte.sonytel.be--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
