From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] atyfb accel capabilities
Date: Sun, 6 Jun 2004 13:10:33 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406061308510.4558@waterleaf.sonytel.be>
References: <20040603024052.GC20951@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWvXw-0003Dc-Hs
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 04:10:36 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BWvXw-0002x2-13
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 04:10:36 -0700
In-Reply-To: <20040603024052.GC20951@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2 Jun 2004, David Eger wrote:
> The following patch updates atyfb for the new fb accel capabilities
> patch I'm sending upstream.  Please test the core patch + this patch,
> and let me know it works for you.  You ought to be able to use fbset

Looks OK. Unfortunately I cannot test it on my RAGE II+, since my PPC box died
2 weeks ago :-(

I _could_ still give it a try on the laptop from work (Mobility M1), but I
first need to get atyfb in 2.6 work on that one...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
