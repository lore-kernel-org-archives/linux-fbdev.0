From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Mach64 GX driver problems in post 2.4.22
 kernels
Date: Mon, 21 Jun 2004 10:52:01 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406211050370.6543@waterleaf.sonytel.be>
References: <20040605185647.GG5668@mercury.jahnsnet.de>
 <20040606104530.GA2231@mercury.jahnsnet.de> <20040618094852.GA9466@mercury.jahnsnet.de>
 <20040621080858.GA11936@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcKXE-0001Np-Ul
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Jun 2004 01:52:12 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BcKXE-0000cC-Dl
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Jun 2004 01:52:12 -0700
In-Reply-To: <20040621080858.GA11936@havoc.gtf.org>
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
Cc: Thomas Jahns <Thomas.Jahns@epost.de>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 21 Jun 2004, David Eger wrote:
> You're posting to the right list; you're probably not getting responses
> because none of the active framebuffer developers have a setup similar
> enough to yours :-/

Indeed. Mach64 GX are old and rare. And since they didn't have an integrated
clock generator and RAMDAC, they used (many different) external parts, leading
to lots of possible combinations to support...

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
