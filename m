From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Tue, 9 Aug 2005 10:05:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508091001010.28068@numbat.sonytel.be>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
 <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>
 <20050807094618.0cc4cadc.akpm@osdl.org> <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
 <42F699DC.20103@gmail.com> <Pine.LNX.4.56.0508090057460.2187@pentafluge.infradead.org>
 <42F8000A.2040605@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2fYR-0005xt-F0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 18:38:51 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2fHs-0005gm-Vg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 18:21:45 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1E2P7G-0004wV-NA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 01:05:45 -0700
In-Reply-To: <42F8000A.2040605@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

On Tue, 9 Aug 2005, Antonino A. Daplas wrote:
> James Simmons wrote:
> 1. If they don't want to use the hardware cursor, set info->fbops->fb_cursor =
> NULL
> in fb_set_par();

Hence that fbops cannot be shared between multiple instances of the same
frame buffer device that need different values for fbops->fb_cursor.

> 2. Or, they can keep info->fbops->fb_cursor() as is, but the function will
> return
> -ENODEV instead.

So this one looks better to me, since it doesn't suffer from the limitation of
1.

(I'm thinking of hardware where the availability of a hardware cursor depends
 on the video mode, e.g. the good old Amiga graphics)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
