From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ATI Mach64 accelerated imgblit
 (sligthly improved)
Date: Sat, 17 Jan 2004 19:25:21 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0401171924220.1950@waterleaf.sonytel.be>
References: <200401170120.25603.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahv8V-0006b3-2C
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jan 2004 10:25:31 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahv8U-0004hR-IT
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jan 2004 10:25:30 -0800
In-Reply-To: <200401170120.25603.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: James Simmons <jsimmons@infradead.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 17 Jan 2004, Alexander Kern wrote:
> here is a patch. Now it works with SUN12x22 font and 8, 16 and 32 bpp. I have
> the strange issues with 24bpp. Should we simply drop acceleration for this
> resolution?

All acceleration, or just the imageblit? I don't think there's a problem with
rectangle fill/copy in 24 bpp, or is there?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
