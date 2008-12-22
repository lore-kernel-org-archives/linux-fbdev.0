From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/05] video: deferred io sys helpers
Date: Mon, 22 Dec 2008 14:52:33 +0900
Message-ID: <20081222055233.27821.68008.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, jayakumar.lkml@gmail.com

video: deferred io sys helpers

[PATCH 01/05] video: deferred io sys helpers - core
[PATCH 02/05] video: deferred io sys helpers - sh_mobile_lcdcfb
[PATCH 03/05] video: deferred io sys helpers - hecuba / n411
[PATCH 04/05] video: deferred io sys helpers - metronome
[PATCH 05/05] video: deferred io sys helpers - xen

This patchset extends the deferred io core code with commonly used functions.

The following functions are added to and exported from fb_defio.c:
 - fb_deferred_io_read()
 - fb_deferred_io_write()
 - fb_deferred_io_fillrect()
 - fb_deferred_io_copyarea()
 - fb_deferred_io_imageblit()

To be backwards compatible with the existing behavior the delay variable
"sysdelay" is introduced. It is a separate timeout value for the functions
above. In the sh_mobile_lcdcfb driver we set it to the same as "delay",
but the other drivers keep it as zero which means flush directly.

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

 drivers/video/Kconfig            |   33 +++---------
 drivers/video/fb_defio.c         |   71 ++++++++++++++++++++++++++
 drivers/video/hecubafb.c         |   86 +-------------------------------
 drivers/video/metronomefb.c      |  102 ++++++--------------------------------
 drivers/video/sh_mobile_lcdcfb.c |   40 ++------------
 drivers/video/xen-fbfront.c      |   52 ++++---------------
 include/linux/fb.h               |   14 +++++
 7 files changed, 135 insertions(+), 263 deletions(-)
