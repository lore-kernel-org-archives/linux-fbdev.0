From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: Fw: [Bugme-new] [Bug 4218] New: Radeon
 fb doesn't have correct resolution for lcd screen
Date: Thu, 17 Feb 2005 10:15:54 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0502171015260.30106@numbat.sonytel.be>
References: <20050215133933.61769fd0.akpm@osdl.org> <1108504048.13376.11.camel@gaston>
 <200502160948.51781.bart@verwilst.be> <Pine.LNX.4.56.0502161955370.23410@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1hlT-0006aW-TJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 01:16:03 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D1hlS-0000Yz-86
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 01:16:03 -0800
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j1H9FvGU028366
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 10:15:58 +0100 (MET)
In-Reply-To: <Pine.LNX.4.56.0502161955370.23410@pentafluge.infradead.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 16 Feb 2005, James Simmons wrote:
> Be careful. Don't run radeonfb and vesa fb at the same time!!!

So vesafb should start checking request_mem_region() again, to avoid this.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
