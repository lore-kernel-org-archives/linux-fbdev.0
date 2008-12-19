From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/05] video: deferred io fixes and sh_mobile_lcdcfb support
Date: Fri, 19 Dec 2008 15:33:59 +0900
Message-ID: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, adaplas@gmail.com, linux-sh@vger.kernel.org

video: deferred io fixes and sh_mobile_lcdcfb support

[PATCH 01/05] video: fix deferred io fsync()
[PATCH 02/05] video: deferred io cleanup
[PATCH 03/05] video: deferred io with physically contiguous memory
[PATCH 04/05] video: sh_mobile_lcdcfb deferred io support 
[PATCH 05/05] sh: enable deferred io LCDC on Migo-R

This patchset adds deferred io support to sh_mobile_lcdcfb.

The LCDC hardware block managed by the sh_mobile_lcdcfb driver supports
RGB or SYS panel configurations. SYS panels come with an external display
controller that is resposible for refreshing the actual LCD panel. RGB
panels are controlled directly by the LCDC and they need to be refreshed
by the LCDC hardware.

In the case of SYS panels we can save some power by configuring the LCDC
hardware block in one-shot mode. In this one-shot mode panel refresh is
managed by software. This works well together with deferred io since it
allows us to stop clocks for most of the time and only enable clocks when
we actually want to trigger an update. When there is no fbdev activity
the clocks are kept stopped which allows us to deep sleep.

May I suggest merging the first 3 patches with other framebuffer changes,
but handling patch 4 and 5 with other SuperH changes? That strategy
should be fine since there are no compile time dependencies. To keep
things running please apply patch number 5 when all other changes are in.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c |    2 
 drivers/video/Kconfig             |    1 
 drivers/video/fb_defio.c          |   27 ++++-
 drivers/video/sh_mobile_lcdcfb.c  |  170 ++++++++++++++++++++++++++++++++-----
 include/video/sh_mobile_lcdc.h    |    1 
 5 files changed, 174 insertions(+), 27 deletions(-)
