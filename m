From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] [Resend] fbcon : fix color
 generation for monochrome framebuffer
Date: Fri, 1 Feb 2008 13:24:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802011322450.18111@anakin>
References: <Pine.LNX.4.64.0801281052480.4385@lxtpfaff.pcs.ditec.de>
	<20080131140701.b584430e.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0802011128210.5425@lxtpfaff.pcs.ditec.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKuwi-0001qI-Ep for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 04:24:45 -0800
Received: from harold.telenet-ops.be ([195.130.133.65])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JKuwf-000619-PX
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 04:24:40 -0800
In-Reply-To: <Pine.LNX.4.64.0802011128210.5425@lxtpfaff.pcs.ditec.de>
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
To: Thomas Pfaff <tpfaff@pcs.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Fri, 1 Feb 2008, Thomas Pfaff wrote:
> On Thu, 31 Jan 2008, Andrew Morton wrote:
> > On Mon, 28 Jan 2008 11:03:38 +0100 (CET)
> If the functions should be deinlined someone should decide where to put them. 
> Since they must be exported i would avoid to put them into fbcon.c, this would 
> lead to cross dependencies.
> I would suggest to put the prototype into <linux/fb.h> and the definition into 
> fbcmap.c instead, but i am unsure whether they really belong there.

General note: functions in header files must be inline, else you get
multiple definitions of the same symbol.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
