From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Fw: [Bugme-new] [Bug 2916] New: Console font
 became black on black after upgrade from 2.6.6 to 2.6.7
Date: Sat, 19 Jun 2004 11:22:14 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406191115180.23356@waterleaf.sonytel.be>
References: <20040618152036.3f5cd6b3.akpm@osdl.org> <20040619012057.GA14319@havoc.gtf.org>
 <20040618184023.62611839.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbc3Z-0002ym-S6
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 02:22:37 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbc3Z-0003A2-9x
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 02:22:37 -0700
In-Reply-To: <20040618184023.62611839.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: David Eger <eger@havoc.gtf.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, spamhole@gmx.at, dfnsonfsduifb@gmx.de

On Fri, 18 Jun 2004, Andrew Morton wrote:
> David Eger <eger@havoc.gtf.org> wrote:
> > Please let me know if any of these three setups work.  I wouldn't select
> > both VESA and a specific driver.... eww... I'd guess they would get
> > confused and try to access the same hardware...
>
> This all sounds hard to express via kernel config, but it sounds pretty
> easy to avoid via a few state variables in the kernel.
>
> Do you think it's possible to prevent illegal things from happening at
> runtime?

Originally vesafb did a request_mem_region() on the frame buffer, to avoid
having 2 drivers drive the same hardware. But it was changed because it caused
problems on some hardware.

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
