From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK fbdev updates]
Date: Wed, 1 Jan 2003 02:22:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0212311908120.2235-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.44.0212311746550.8101-100000@home.transmeta.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212311746550.8101-100000@home.transmeta.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Dimitrie O. Paun" <dpaun@rogers.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Thanks for the tip on the script.

Linus, please do a

	bk pull http://fbdev.bkbits.net:8080/fbdev-2.5

This will update the following files:

 drivers/video/console/fbcon-sti.c      |  289 ----
 drivers/video/console/font.h           |   53
 drivers/video/console/sti.h            |  289 ----
 CREDITS                                |    1
 Documentation/fb/intel810.txt          |  272 +++
 MAINTAINERS                            |    2
 arch/m68k/kernel/head.S                |   34
 arch/m68k/kernel/m68k_defs.c           |   16
 drivers/char/vt.c                      |    2
 drivers/video/Kconfig                  |   66
 drivers/video/Makefile                 |   20
 drivers/video/aty/atyfb_base.c         |   65
 drivers/video/aty128fb.c               |  102 -
 drivers/video/cfbcopyarea.c            |    2
 drivers/video/cfbimgblt.c              |   17
 drivers/video/chipsfb.c                |  572 ++------
 drivers/video/console/Kconfig          |   36
 drivers/video/console/Makefile         |   38
 drivers/video/console/dummycon.c       |    6
 drivers/video/console/fbcon.c          |  306 ----
 drivers/video/console/fbcon.h          |   17
 drivers/video/console/font_6x11.c      |    2
 drivers/video/console/font_8x16.c      |    2
 drivers/video/console/font_8x8.c       |    2
 drivers/video/console/font_acorn_8x8.c |    3
 drivers/video/console/font_mini_4x6.c  |    2
 drivers/video/console/font_pearl_8x8.c |    2
 drivers/video/console/font_sun12x22.c  |    2
 drivers/video/console/font_sun8x16.c   |    2
 drivers/video/console/fonts.c          |    2
 drivers/video/console/mdacon.c         |   24
 drivers/video/console/newport_con.c    |    2
 drivers/video/console/sticon.c         |  390 ++++-
 drivers/video/console/sticore.c        | 1134 +++++++++++-----
 drivers/video/controlfb.c              |   37
 drivers/video/fbmem.c                  |  364 ++++-
 drivers/video/fbmon.c                  |  390 ++++-
 drivers/video/i810/Makefile            |   22
 drivers/video/i810/i810.h              |  300 ++++
 drivers/video/i810/i810_accel.c        |  513 +++++++
 drivers/video/i810/i810_dvt.c          |  308 ++++
 drivers/video/i810/i810_gtf.c          |  275 ++++
 drivers/video/i810/i810_main.c         | 2251 ++++++++++++++++++++++++++++++++
 drivers/video/i810/i810_main.h         |  205 ++
 drivers/video/i810/i810_regs.h         |  274 +++
 drivers/video/igafb.c                  |  100 +
 drivers/video/offb.c                   |    5
 drivers/video/radeonfb.c               |   38
 drivers/video/riva/fbdev.c             |  312 +++-
 drivers/video/riva/nv_type.h           |   58
 drivers/video/riva/riva_hw.c           |  134 +
 drivers/video/riva/riva_hw.h           |  128 +
 drivers/video/riva/riva_tbl.h          |   99 +
 drivers/video/riva/rivafb.h            |    7
 drivers/video/skeletonfb.c             |  220 ++-
 drivers/video/sstfb.c                  | 2266 +++++++++++++--------------------
 drivers/video/sstfb.h                  |   68
 drivers/video/sticore.h                |    5
 drivers/video/stifb.c                  |  138 --
 drivers/video/tdfxfb.c                 |   11
 drivers/video/tgafb.c                  | 1544 +++++++++-------------
 drivers/video/vga16fb.c                |   70 -
 drivers/video/vgastate.c               |    7
 include/linux/fb.h                     |   14
 include/linux/font.h                   |   53
 include/linux/pci_ids.h                |   74 +
 include/video/radeon.h                 |  148 +-
 include/video/tgafb.h                  |  210 +++
 70 files changed, 11522 insertions(+), 6972 deletions(-)

through these ChangeSets:

<jsimmons@maxwell.earthlink.net> (02/12/28 1.953)
   Radeon driver port to final api. Cleanup of vga16fb.

<jsimmons@kozmo.(none)> (02/12/28 1.951)
   Fix for m68k. They need the struct font_desc super early in the boot process.

<jsimmons@maxwell.earthlink.net> (02/12/24 1.946)
   Ported Voodoo1 driver to new api.

<jsimmons@kozmo.(none)> (02/12/24 1.943.1.1)
   More STI updates.

<jsimmons@maxwell.earthlink.net> (02/12/21 1.906.2.2)
   Merged with Linus tree. Some conflicts to resolve.

<jsimmons@maxwell.earthlink.net> (02/12/21 1.865.46.3)
   Merge with davem work.

<jsimmons@maxwell.earthlink.net> (02/12/21 1.865.46.2)
   Port of chipsfb driver to new api. Removed the fontwidth8 option. Let the xxxfb_imageblit function handle this. 64 bit m achine fixes.

<jsimmons@maxwell.earthlink.net> (02/12/17 1.865.2.10)
   Voodoo 1 ported to new api. STI and NVIDIA updates. MDA console fixes. Moved the logo code from fbcon to fbdev.

<jsimmons@maxwell.earthlink.net> (02/12/12 1.865.2.5)
   Updates to the NVIDIA driver. We now support more cards. I still have more hacking to do.

<jsimmons@maxwell.earthlink.net> (02/12/12 1.865.2.4)
   Updates for the STI fbdev and console driver.

<jsimmons@maxwell.earthlink.net> (02/12/12 1.865.2.3)
   Anothe rattempt at commting.

<jsimmons@infradead.org> (02/12/11 1.865.2.2)
   Fixes from the PPC guys. Lots of small fixes.

<jsimmons@maxwell.earthlink.net> (02/12/09 1.858.2.3)
   Added in Radeon PCI ids into pci_ids.h from radeon.h. IGA fbdev uses C99 now.
