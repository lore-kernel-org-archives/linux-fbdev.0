From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 29 Mar 2011 03:35:55 +0000
Subject: [RFC][PATCH 0/3] MERAM support for LCDC
Message-Id: <1301369758-18394-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch series is based on the fbdev tree.  

This series adds support for read-ahead cache access through the ICBs and
MERAM available on SH devices.  The exact ICBs to use are chip specific
and are specified in the platform data. 

Damian Hobson-Garcia (3):
  sh_mobile_meram: MERAM framework for LCDC
  sh_mobile_meram: Add support for NV24 framebuffers
  sh_mobile_meram: MERAM platform data for LCDC

 arch/arm/mach-shmobile/board-ap4evb.c |   69 ++++
 drivers/video/Kconfig                 |   12 +
 drivers/video/Makefile                |    1 +
 drivers/video/sh_mobile_lcdcfb.c      |  104 ++++++-
 drivers/video/sh_mobile_lcdcfb.h      |    1 +
 drivers/video/sh_mobile_meram.c       |  567 +++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_meram.h       |   41 +++
 include/video/sh_mobile_lcdc.h        |    2 +
 include/video/sh_mobile_meram.h       |   69 ++++
 9 files changed, 857 insertions(+), 9 deletions(-)
 create mode 100644 drivers/video/sh_mobile_meram.c
 create mode 100644 drivers/video/sh_mobile_meram.h
 create mode 100644 include/video/sh_mobile_meram.h

