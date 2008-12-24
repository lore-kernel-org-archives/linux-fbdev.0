From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/05] video: deferred io sys helpers V2
Date: Wed, 24 Dec 2008 17:29:46 +0900
Message-ID: <20081224082946.1848.46644.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, jayakumar.lkml@gmail.com

video: deferred io sys helpers V2

[PATCH 01/05] video: deferred io sys helpers - core V2
[PATCH 02/05] video: deferred io sys helpers - sh_mobile_lcdcfb V2
[PATCH 03/05] video: deferred io sys helpers - hecuba / n411 V2
[PATCH 04/05] video: deferred io sys helpers - metronome V2
[PATCH 05/05] video: deferred io sys helpers - xen V2

This patchset extends the deferred io core code with commonly used functions.

The following functions are added to and exported from fb_defio.c:
 - fb_deferred_io_read()
 - fb_deferred_io_write()
 - fb_deferred_io_fillrect()
 - fb_deferred_io_copyarea()
 - fb_deferred_io_imageblit()

The functions above makes use the deferred io delay which so far only
has been used for mmap. This means for instance that the drivers using
these functions no longer will refresh the screen according to the soft
cursor refresh rate, instead the screen refresh rate derived from the
deferred io delay value will be used.

The deferred io core code now keeps track of a dirty area between the
calls to the functions above. Only xen is currently making use of this.

In the future we may want to extend the dirty area tracking code to
instead modify the dirty bits for the pages backing the frame buffer.

Status:
- sh_mobile_lcdcfb: compiles and works well
- hecuba / n411: compiles on superh, but untested
- metronome: compiles on superh, but untested
- xen: unknown

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/Kconfig            |   35 +++---------
 drivers/video/fb_defio.c         |   77 ++++++++++++++++++++++++++
 drivers/video/hecubafb.c         |   86 +----------------------------
 drivers/video/metronomefb.c      |  109 ++++++++------------------------------
 drivers/video/sh_mobile_lcdcfb.c |   39 +------------
 drivers/video/xen-fbfront.c      |   51 +++--------------
 include/linux/fb.h               |   12 ++++
 7 files changed, 145 insertions(+), 264 deletions(-)
