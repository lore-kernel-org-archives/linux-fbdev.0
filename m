From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2.6][RESEND] fbcon margins colour
 fix
Date: Thu, 18 Mar 2004 10:21:31 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403181020320.10688@waterleaf.sonytel.be>
References: <20040317233135.GB3510@satan.blackhosts>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3tiZ-0004DG-9A
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 01:21:35 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3tiY-0002rn-7C
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 01:21:34 -0800
In-Reply-To: <20040317233135.GB3510@satan.blackhosts>
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
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 18 Mar 2004, Jakub Bogusz wrote:
> I sent it a few times to linux-kernel and at least one to
> linux-fbdev-devel, but haven't seen any comments - and this annoying
> changing margins colour seems to be still there in 2.6.4 (at least on
> tdfxfb).

What happens on `reverse video' (i.e. black on white, like Sun) graphics cards?
In that case the overscan color is white.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
