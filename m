From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: latest patch for atyfb
Date: Fri, 15 Oct 2004 21:25:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410152125.55255.alex.kern@gmx.de>
References: <200410120024.50968.alex.kern@gmx.de> <200410122042.53878.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIXiK-0005UT-4b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 12:26:08 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CIXiE-0002EI-6a
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 12:26:08 -0700
In-Reply-To: <200410122042.53878.adaplas@hotpop.com>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: adaplas@pol.net
Cc: Arnaud FONTAINE <arnaud.fontaine@free.fr>, =?iso-8859-1?q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>, Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Am Dienstag, 12. Oktober 2004 14:42 schrieb Antonino A. Daplas:

> BTW, can you send me a changelog?
>
> Tony

Alphabetical sort, please if I forgot something, add you comment.
=20
Alex Kern
[PATCH] port Daniel Mantione 2.4 driver to 2.6
[PATCH] add more pci_id number
[PATCH] add accelerated imgblit
[PATCH] revert SDRAM_MAGIC_PLL to old behaviour
[PATCH] do a "from BIOS" initialisation only by __i386__

Arnaud FONTAINE
[PATCH atyfb] correction for 3D Rage Mobility L

Geert Uytterhoeven
[PATCH atyfb] Atari Atyfb fixes
[PATCH atyfb] Atyfb on Mach64 GX or Atari
[PATCH 468] m68k sparse floating point

James Simmons
[PATCH add] port to framebuffer_alloc api

Nicolas Souchu
[PATCH] I do not found a copy, but it was incorporated too

Ville Syrj=E4l=E4
[PATCH] fix pan with doublescan
[PATCH] another double scan fix
[PATCH] disable linear aperture register access
[PATCH] Memory type correction
[PATCH] atyfb (2.6): Fix mmio_start
[PATCH] atyfb (2.6): Fix mem_refresh_rate for Mobility
[PATCH] atyfb (2.6): Add RGB565 support
[PATCH] atyfb: Blank LCD by turning off backlight voltage
[PATCH] atyfb: Rage LT LCD register access
[PATCH] atyfb: vblank irq support
[PATCH] atyfb: MTRR support



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
