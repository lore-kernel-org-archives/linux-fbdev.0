From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 1/13] viafb: viafb.modes, viafb.txt
Date: Tue, 1 Jul 2008 09:12:44 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7CEA@exchtp03.taipei.via.com.tw>
References: <Pine.LNX.4.64.0806301902390.26408@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDUQL-0001v5-HS for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 18:12:49 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDUQK-0007nS-4I
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 18:12:49 -0700
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0806301902390.26408@anakin>
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
To: geert@linux-m68k.org
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi Geert,

I'll check the possibility with our engineer. Thanks for your comment.

BRs,
Joseph Chan 
-----Original Message-----
From: geert@linux-m68k.org [mailto:geert@linux-m68k.org] 
Sent: Tuesday, July 01, 2008 1:09 AM
To: Joseph Chan
Cc: linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; akpm@linux-foundation.org
Subject: Re: [PATCH 1/13] viafb: viafb.modes, viafb.txt

On Mon, 30 Jun 2008, JosephChan@via.com.tw wrote:
> +[Bootup with viafb]:
> +--------------------
> +    Add the following line to your grub.conf:
> +    append = "video=viafb:viafb_mode=1024x768,via_fb_bpp=32,viafb_refresh=85"

Why not support simply video=1024x768-32@85 (or video=viafb:1024x768-32@85, if you have other video cards too), as can be parsed by fb_find_mode()?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
