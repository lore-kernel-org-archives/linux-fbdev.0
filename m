From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Porting Epson (S1D113A04) video driver from
 kernel 2.6.8 to 2.6.10
Date: Mon, 3 Dec 2007 21:04:31 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712032103001.21374@anakin>
References: <4754247A.20706@one.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzHWy-000743-Iv for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 12:04:43 -0800
Received: from europa.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IzHWw-0000yr-46
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 12:04:40 -0800
In-Reply-To: <4754247A.20706@one.net>
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
To: James Kimble <jkimble@one.net>
Cc: linux-m68k@vger.kernel.org, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 3 Dec 2007, James Kimble wrote:
> I am attempting to port an epson video driver (S1D13A04) that was written for
> the 2.6.8 kernel to the 2.6.10 kernel. The big difference I see is that the
> fbmem.c module in 2.6.8 is a set of conditional declarations that add the
> drivers xxx_init() and xxx_setup() calls as elements to the fb_drivers array.
> I don't see any fb_drivers array or corresponding array of driver function
> calls in the 2.6.10 sources.

In 2.6.9, frame buffer device drivers started using module_init() in the
individual drivers.

Just do a diff of any random frame buffer device driver between 2.6.8
and 2.6.10...

> Can anyone tell me where these calls are registered with the video drivers sub
> section in the 2.6.10 kernel?

Anyway, 2.6.10 is old...

BTW, is this S1D113A04 driver for m68k?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
