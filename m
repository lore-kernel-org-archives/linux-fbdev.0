From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: patch fixing background next to penguin logo in monochrome
Date: Sun, 15 Aug 2004 00:43:02 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409150839.00693.adaplas@hotpop.com>
References: <1092254183.4209.16.camel@joy.home> <200409130746.32631.adaplas@hotpop.com> <Pine.GSO.4.58.0408131002030.28832@waterleaf.sonytel.be>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bw93v-0000g3-B9
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Aug 2004 17:39:51 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bw93u-0002nA-Vo
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Aug 2004 17:39:51 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D3E06798B8C
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Aug 2004 23:44:41 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0408131002030.28832@waterleaf.sonytel.be>
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
Date: Wed, 15 Sep 2004 08:38:58 +0800
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Stehlik <pstehlik@sophics.cz>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Christian T. Steigies" <cts@debian.org>

On Friday 13 August 2004 16:05, Geert Uytterhoeven wrote:
> >
> > diff -uprN linux-2.4-orig/drivers/video/fbcon.c
> > linux-2.4/drivers/video/fbcon.c ---
> > linux-2.4-orig/drivers/video/fbcon.c	2004-09-13 07:40:18.194333488 +0800
> > +++ linux-2.4/drivers/video/fbcon.c	2004-09-13 07:41:52.302026944 +0800
> > @@ -1930,6 +1930,7 @@ static int fbcon_switch(struct vc_data *
> >  	(*info->switch_con)(unit, info);
> >      if (p->dispsw->clear_margins && vt_cons[unit]->vc_mode == KD_TEXT)
> >  	p->dispsw->clear_margins(conp, p, 0);
> > +    conp->vc_can_do_color = p->var.bits_per_pixel != 1;
> >      if (logo_shown == -2) {
> >  	/* G.S.: Display a line above the Boot Logo to state what
> >  	* version of the kernel we are booting.
>
> I don't think it's needed: I saw no artifacts when switching between a
> monochrome and a color VC or vice versa.
>
> When looking at the source, conp->vc_can_do_color is initialized in
> fbcon_setup(), which is called from fbcon_changevar(), which is called by
> the fbdev if the resolution or color depth was changed.
>

Okay.  I wasn't too sure of that since I'm not very familiar with the 2.4
code.

Tony




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
