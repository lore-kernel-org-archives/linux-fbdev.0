From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: New logo code
Date: Sun, 12 Jan 2003 23:20:31 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301122209290.20640-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XqTd-0000rp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Jan 2003 14:21:09 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id XAA21346
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Jan 2003 23:20:31 +0100 (MET)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


The current logo code is messy, complex, and inflexible. So I decided to
rewrite it. My goals were:
  - Logos must be accessible easily by an image editor (currently: hex C source
    data must be converted to another format first)
  - Logos must be stored in ASCII-form in the source tree
  - Support arbitrary logo sizes (currently: fixed 80x80)
  - Allow the logo to be selected statically (at compile time) and/or
    dynamically (at run-time, based on machine type) (currently: at compile
    time only).
  - Allow simple adition of new logos
  - Support grayscale logos (not used yet)

The patch achieves all of these. Logos are stored in ASCII PNM format in
drivers/video/logo/, and automatically converted to hex C source arrays using
scripts/pnmtologo. I chose ASCII PNM because (a) it's ASCII, (b) it's very
simple to parse without an external library (XPM is more difficult to parse),
and (c) it can be handled by many image manipulation programs.

Code that wants to display a logo just calls fb_find_logo(), specifying the
wanted logo type, and receives a pointer to a suitable logo (or NULL).

I also modified fb_show_logo() to return the number of scanlines that are used
by the logo, so fbcon knows how many lines to reserve.

So far I tested it on Amiga only (with amifb), using the standard 3 logos
(mono, vga16, and clut224, all 80x80), and using resized (171x171) versions of
the standard logos, to verify that arbitrary logo sizes are working.

Initial logo display is still a bit weird, because fbcon is initialized before
the logo is drawn. What you see is this:
  - Initial text screen contents are drawn, starting at the top of the screen,
  - The logo is drawn,
  - New kernel messages are printed, until the bottom of the screen is reached,
  - The logo is drawn again, and the top of the screen is reserved for the
    logo,
  - New kernel messages are printed, and scrolling scrolls the text part only,
    leaving the logo at the top

To do:
  - More testing
  - Clean ups:
      o Protect all drawing code by CONFIG_FB_LOGO
      o Move logo drawing code from fbmem.c to logo/logo.c?
      o Logo selection in Kconfig and logo.c?

Diffstat output:

 arch/mips64/Kconfig                        |    4 
 arch/ppc/syslib/prom.c                     |    3 
 arch/ppc/syslib/prom_init.c                |   28 
 arch/ppc64/kernel/prom.c                   |   27 
 drivers/video/Kconfig                      |    1 
 drivers/video/Makefile                     |    1 
 drivers/video/console/fbcon.c              |   11 
 drivers/video/console/newport_con.c        |   28 
 drivers/video/fbmem.c                      |  142 +-
 drivers/video/hgafb.c                      |   21 
 drivers/video/logo/Kconfig                 |   62 +
 drivers/video/logo/Makefile                |   26 
 drivers/video/logo/logo.c                  |   95 +
 drivers/video/logo/logo_dec_clut224.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_linux_clut224.ppm  | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_linux_mono.pbm     |  202 +++
 drivers/video/logo/logo_linux_vga16.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_mac_clut224.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_sgi_clut224.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_sun_clut224.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_superh_clut224.ppm | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_superh_mono.pbm    |  202 +++
 drivers/video/logo/logo_superh_vga16.ppm   | 1603 +++++++++++++++++++++++++++++
 include/asm-alpha/linux_logo.h             |   27 
 include/asm-arm/linux_logo.h               |   19 
 include/asm-i386/linux_logo.h              |   27 
 include/asm-ia64/linux_logo.h              |   28 
 include/asm-m68k/linux_logo.h              |  924 ----------------
 include/asm-m68knommu/linux_logo.h         |   13 
 include/asm-mips/linux_logo.h              |   43 
 include/asm-mips/linux_logo_dec.h          |  907 ----------------
 include/asm-mips/linux_logo_sgi.h          |  919 ----------------
 include/asm-mips64/linux_logo.h            |  919 ----------------
 include/asm-parisc/linux_logo.h            |   27 
 include/asm-ppc/linux_logo.h               |   24 
 include/asm-ppc64/linux_logo.h             |   26 
 include/asm-sh/linux_logo.h                | 1418 -------------------------
 include/asm-sparc/linux_logo.h             |  934 ----------------
 include/asm-sparc64/linux_logo.h           |  934 ----------------
 include/asm-um/linux_logo.h                |    6 
 include/asm-x86_64/linux_logo.h            |   29 
 include/linux/fb.h                         |    2 
 include/linux/linux_logo.h                 | 1435 -------------------------
 scripts/Makefile                           |    2 
 scripts/pnmtologo.c                        |  498 +++++++++
 45 files changed, 14090 insertions(+), 8748 deletions(-)

Detailed changes:

  - arch/mips64/Kconfig

    Add missing CONFIG_MIPS64

  - arch/ppc/syslib/prom.c

    Removed unused #include <asm/linux_logo.h>

  - arch/ppc/syslib/prom_init.c
    arch/ppc64/kernel/prom.c

    Modify PPC prom startup to use logo_linux_clut224 (if available)
    FIXME: verify RELOCs on ppc64

  - drivers/video/Kconfig

    Include drivers/video/logo/Kconfig

  - drivers/video/Makefile

    Enter drivers/video/logo if logo drawing is enabled

  - drivers/video/console/fbcon.c

    Remove obsolete LOGO_* definitions
    fb_show_logo() returns the logo height

  - drivers/video/console/newport_con.c

    Updates to call fb_find_logo()

  - drivers/video/fbmem.c

    Updates to call fb_find_logo()
    Support arbitrary logo sizes

  - drivers/video/hgafb.c

    Updates to call fb_find_logo()
    Support arbitrary logo sizes

  - drivers/video/logo/Kconfig

    Static logo selection code

  - drivers/video/logo/Makefile

    Logo makefile

  - drivers/video/logo/logo.c

    Dynamic logo selection code

  - drivers/video/logo/logo_dec_clut224.ppm
    drivers/video/logo/logo_linux_clut224.ppm
    drivers/video/logo/logo_linux_mono.pbm
    drivers/video/logo/logo_linux_vga16.ppm
    drivers/video/logo/logo_mac_clut224.ppm
    drivers/video/logo/logo_sgi_clut224.ppm
    drivers/video/logo/logo_sun_clut224.ppm
    drivers/video/logo/logo_superh_clut224.ppm
    drivers/video/logo/logo_superh_mono.pbm
    drivers/video/logo/logo_superh_vga16.ppm

    Logos in ASCII PNM format, converted from old logo includes

  - include/asm-alpha/linux_logo.h
    include/asm-arm/linux_logo.h
    include/asm-i386/linux_logo.h
    include/asm-ia64/linux_logo.h
    include/asm-m68k/linux_logo.h
    include/asm-m68knommu/linux_logo.h
    include/asm-mips/linux_logo.h
    include/asm-mips/linux_logo_dec.h
    include/asm-mips/linux_logo_sgi.h
    include/asm-mips64/linux_logo.h
    include/asm-parisc/linux_logo.h
    include/asm-ppc/linux_logo.h
    include/asm-ppc64/linux_logo.h
    include/asm-sh/linux_logo.h
    include/asm-sparc/linux_logo.h
    include/asm-sparc64/linux_logo.h
    include/asm-um/linux_logo.h
    include/asm-x86_64/linux_logo.h

    Remove old logo includes

  - include/linux/fb.h

    Make fb_image.data const

  - include/linux/linux_logo.h

    New logo definitions

  - scripts/Makefile

    Add pnmtologo

  - scripts/pnmtologo.c

    Logo conversion program (ASCII PNM to hex C source data)


The patch is quite large (+1 MiB uncompressed), so I put it up for download:

    http://home.tvd.be/cr26864/Linux/fbdev/linux-logo-2.5.56.diff.bz2

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
