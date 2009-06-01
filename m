From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] fb: add support of LCD display
 controller on pxa168/910 (base layer)
Date: Mon, 1 Jun 2009 17:28:15 +0200
Message-ID: <20090601172815.c1631cf6.krzysztof.h1@poczta.fm>
References: <f17812d70905210203se23d5e7ya60cbb6eb93815aa@mail.gmail.com>
	<20090521094157.GA24078@n2100.arm.linux.org.uk>
	<f17812d70905210728k1349adb6se4ffc26bd5d9cf53@mail.gmail.com>
	<20090524134304.fcf906ad.krzysztof.h1@poczta.fm>
	<f17812d70905270121od092964m673984c427942727@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MB9KP-0006oH-DL
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 15:21:33 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MB9KL-00049m-Mk for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 15:21:33 +0000
In-Reply-To: <f17812d70905270121od092964m673984c427942727@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Green Wan <gwan@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Jun Nie <njun@marvell.com>, Peter Liao <pliao@marvell.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Lennert Buijtenhek <buytenh@marvell.com>, Kevin Liu <kliu5@marvell.com>

On Wed, 27 May 2009 16:21:11 +0800
Eric Miao <eric.y.miao@gmail.com> wrote:

> Hi Krzysztof,
> 
> Sorry for late reply, and thanks for the time reviewing this.
> See the revised version below with changes:
> 
> 1. removed the unnecessary error checking of pseudo color
> in check_var(). The pseudo color mode is actually be well
> supported.
> 
> 2. determine_best_pix_fmt() moved into check_var(), and
> set_pix_fmt() is called to ensure a correct var.
> 
> 3. set_graphics_start() removed from set_par
> 
> 4. removed duplicate fields in pxa168fb_info and fb_info
> 
> 5. correct the error exiting path
> 
> 6. add __init attribute to pxa168fb_init_mode()
> 
> ===================>8=======================
> 
> From 27a53df0467f379de5ca2d6d117852fbaf93c2fc Mon Sep 17 00:00:00 2001
> From: Lennert Buytenhek <buytenh@marvell.com>
> Date: Wed, 11 Feb 2009 17:25:24 +0800
> Subject: [PATCH] fb: add support of LCD display controller on
> pxa168/910 (base layer)
> 
> This driver is originally written by Lennert, modified by Green to be
> feature complete,  and ported by Jun Nie and Kevin Liu for pxa168/910
> processors.
> 
> The patch adds support for the on-chip LCD display controller, it
> currently supports the base (graphics) layer only.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
> Signed-off-by: Green Wan <gwan@marvell.com>
> Cc: Peter Liao <pliao@marvell.com>
> Signed-off-by: Jun Nie <njun@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

You probably want to sent this patch to the RMK's tree. 
If not please sent it to Andrew Morton.

Kind regards,
Krzysztof


----------------------------------------------------------------------
Chcesz miec nawigacje GPS ?
Zamow lub przedluz umowe na neostrade, a nawigacja bedzie Twoja.
Kliknij na link po szczegoly! http://link.interia.pl/f219a



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
