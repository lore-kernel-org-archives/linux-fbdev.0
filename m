From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: w100 fb driver
Date: Sat, 20 Nov 2004 10:45:42 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411201044400.5005@waterleaf.sonytel.be>
References: <021601c4ce58$1111a730$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVRoV-0006OW-1y
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Nov 2004 01:45:51 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CVRoR-0007Yp-QR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Nov 2004 01:45:50 -0800
In-Reply-To: <021601c4ce58$1111a730$0f01a8c0@max>
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
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 19 Nov 2004, Richard Purdie wrote:
> made in 2.6.10-rc2 need to be applied to this file. Are there any other
> problems with the driver as it stands that would prevent its inclusion, or
> areas in the driver that it would be advisable to change/improve?

Can you please match the implementation of w100fb_check_var() with its comments
(`If a value doesn't fit, round it up, if it's too big, return -EINVAL.')?

And some more C99-style initializers never hurt.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
