From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.6.7 fbcon: set_con2fb on current console
 = crash
Date: Sat, 19 Jun 2004 11:28:00 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406191127250.23356@waterleaf.sonytel.be>
References: <20040618215047.GA4723@satan.blackhosts> <200406191413.44439.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbc8q-0003Eq-8N
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 02:28:04 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbc8p-0004g7-M4
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 02:28:03 -0700
In-Reply-To: <200406191413.44439.adaplas@hotpop.com>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Jakub Bogusz <qboosh@pld-linux.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, pld-kernel@pld-linux.org

On Sat, 19 Jun 2004, Antonino A. Daplas wrote:
> Thanks.  Actually there's still a critical flaw in the set_con2fbmap code.
> For one, con2fb_map is never initialized.  It's just fortunate that this
> array happens to be  filled with zeroes so con2fb_map[n] will always return
> zero and registered_fb[0] happens to contain a valid info.  So it works, by
> accident.

According to the C standard, global variables are initialized to zero, unless
specified otherwise.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
