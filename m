From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/13] viafb: viafb.modes, viafb.txt
Date: Mon, 30 Jun 2008 19:09:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806301902390.26408@anakin>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7705@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDMsO-0005o1-KC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 10:09:16 -0700
Received: from edna.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDMsM-0002V3-CH
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 10:09:15 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7705@exchtp03.taipei.via.com.tw>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: JosephChan@via.com.tw
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 30 Jun 2008, JosephChan@via.com.tw wrote:
> +[Bootup with viafb]:
> +--------------------
> +    Add the following line to your grub.conf:
> +    append = "video=viafb:viafb_mode=1024x768,via_fb_bpp=32,viafb_refresh=85"

Why not support simply video=1024x768-32@85 (or
video=viafb:1024x768-32@85, if you have other video cards too), as can be
parsed by fb_find_mode()?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
