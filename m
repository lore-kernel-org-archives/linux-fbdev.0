From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: patch fixing background next to penguin logo in monochrome
Date: Wed, 11 Aug 2004 22:23:11 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409120616.43518.adaplas@hotpop.com>
References: <1092254183.4209.16.camel@joy.home>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bv1Qf-0002bM-Mn
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Aug 2004 15:18:41 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bv1Qf-0004hk-5w
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Aug 2004 15:18:41 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8160975ACEC
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Aug 2004 21:24:24 +0000 (UTC)
In-Reply-To: <1092254183.4209.16.camel@joy.home>
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
Date: Sun, 12 Sep 2004 06:16:41 +0800
Content-Type: text/plain; charset="us-ascii"
To: Petr Stehlik <pstehlik@sophics.cz>, linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Christian T. Steigies" <cts@debian.org>

On Thursday 12 August 2004 03:56, Petr Stehlik wrote:
> Hi all,
>
> I have developed a simple workaround for a problem existing in
> framebuffer when it interprets VGA attribute bits in monochrome mode.
> Instead of empty chars we get underlines - you can see what I mean at
> http://joy.sophics.cz/horizlines.jpg - the image shows the background
> where the penguin logo will appear during linux kernel boot up. The logo
> then looks like incorrectly drawn (due to the horizontal lines) and
> people are complaining or reporting this as a sign of a kernel problems
> with their hardware setup or something.

During the take_over_console() part in drivers/char/console.c, the
the framebuffer is initialized first before the character attributes are
updated. So, during the framebuffer initialization, when the space for
the logo is created, the space is erased using vc->vc_video_erase_char.  And
because the attributes are not updated yet, the vc_video_erase_char has still
the attributes of the initial console. If the initial console happens to be
color capable (vc->vc_can_do_color != 0), then the attributes will be 
misinterpreted when the monochrome console redraws the space for the logo.
You get the underline.

Anyway, the simplest solution is to use a vc->vc_video_erase_char with the
underline attribute removed.  Check drivers/video/fbcon.c and look at the
function fbcon_setup. Note, the logo space is erased using the scr_memsetw
function with conp->vc_video_erase_char. Just replace them with
(conp->vc_video_erase_char & ~0x400) if conp->can_do_color is false. (0x400
is the underline attribute). 

I haven't tried this in 2.4, but a similar fix is already present in the latest 2.6 rc
and mm tree. (I still need to add the bold attribute support though).

Tony




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
