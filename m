From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND][PATCH 1/2] fbdev: add new TMIO
 framebuffer driver
Date: Tue, 30 Sep 2008 11:17:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0809301116460.19769@anakin>
References: <1222763910-22816-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1Kkbin-00020S-Vn
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Sep 2008 09:40:45 +0000
Received: from yorgi.telenet-ops.be ([195.130.133.69])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kkbie-00071u-OK for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Sep 2008 09:40:45 +0000
Received: from harold.telenet-ops.be (harold.telenet-ops.be [195.130.133.65])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id 7943D5A0029
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 30 Sep 2008 11:17:19 +0200 (CEST)
In-Reply-To: <1222763910-22816-1-git-send-email-dbaryshkov@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Ian Molton <spyro@f2s.com>, Samuel Ortiz <sameo@openedhand.com>, linux-fbdev-devel@lists.sourceforge.net

On Tue, 30 Sep 2008, Dmitry Baryshkov wrote:

Going for the low hanging fruits...

> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1876,6 +1876,28 @@ config FB_SH_MOBILE_LCDC
>  	---help---
>  	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
>  
> +config FB_TMIO
> +	tristate "Toshiba Mobice IO FrameBuffer support"
                              ^
			      l

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
