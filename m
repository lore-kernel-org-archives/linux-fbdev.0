From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: patch fixing background next to penguin logo in monochrome
Date: Thu, 12 Aug 2004 23:53:37 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409130746.32631.adaplas@hotpop.com>
References: <1092254183.4209.16.camel@joy.home> <Pine.GSO.4.58.0408122158550.18214@waterleaf.sonytel.be> <200409130625.07250.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BvPJh-0007m6-Mi
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Aug 2004 16:49:05 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BvPJh-0005uA-8V
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Aug 2004 16:49:05 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AA94378CE5B
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Aug 2004 22:53:17 +0000 (UTC)
In-Reply-To: <200409130625.07250.adaplas@hotpop.com>
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
Date: Mon, 13 Sep 2004 07:46:32 +0800
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>, Petr Stehlik <pstehlik@sophics.cz>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Christian T. Steigies" <cts@debian.org>

On Monday 13 September 2004 06:25, Antonino A. Daplas wrote:
> On Friday 13 August 2004 04:01, Geert Uytterhoeven wrote:
> > P.S. There are still problems when switching from color to monochrome
> >      (underlines appear everywhere) or vice versa (text becomes blue),
> > but I cannot expect you to fix all old bugs in one week ;-)
>
> This one is a little difficult since there is currently no method to
> convert monochrome attributes to color and vice versa.  The best one can do
> is to clear all attributes when switching from mono<->color.
>
> When switching, one will get plain text only.  This is  probably better
> than having text with incorrect attributes.
>
> Attached patch is completely untested, but it's the same one in 2.6.
>

I think the conp->vc_can_do_color field also needs to be updated during fbcon_switch.

Tony
---

diff -uprN linux-2.4-orig/drivers/video/fbcon.c linux-2.4/drivers/video/fbcon.c
--- linux-2.4-orig/drivers/video/fbcon.c	2004-09-13 07:40:18.194333488 +0800
+++ linux-2.4/drivers/video/fbcon.c	2004-09-13 07:41:52.302026944 +0800
@@ -1930,6 +1930,7 @@ static int fbcon_switch(struct vc_data *
 	(*info->switch_con)(unit, info);
     if (p->dispsw->clear_margins && vt_cons[unit]->vc_mode == KD_TEXT)
 	p->dispsw->clear_margins(conp, p, 0);
+    conp->vc_can_do_color = p->var.bits_per_pixel != 1;
     if (logo_shown == -2) {
 	/* G.S.: Display a line above the Boot Logo to state what
 	* version of the kernel we are booting.




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
