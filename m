From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 10:07:09 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409101004320.93@waterleaf.sonytel.be>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com>
 <1094796002.14398.118.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5gTn-0002WM-5S
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 01:09:59 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5gTT-0002Qh-0W
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 01:09:46 -0700
In-Reply-To: <1094796002.14398.118.camel@gaston>
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
Cc: Antonino Daplas <adaplas@pol.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Fri, 10 Sep 2004, Benjamin Herrenschmidt wrote:
> I submited a patch moving offb to the bottom of the Makefile to at
> least restore normal drivers. For ofonly, a bit more hackish, but

Just in case they aren't, vesafb and vga16fb should also be at the bottom, cfr.
the old order in fbmem.c.

> what about failing register_framebuffer for anything but offb ?

Humm, indeed hackerish...

But the advantage of this is that we can finally exercise the failure path of
many frame buffer device drivers in the wild ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
