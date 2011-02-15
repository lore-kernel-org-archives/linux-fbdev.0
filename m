From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 15 Feb 2011 01:51:47 +0000
Subject: [PATCH 0/1] sh_mobile_lcdc: Add NV12 input framebuffer support
Message-Id: <1297734708-20803-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

These patches add initial support for YUV 4:2:0 (NV12) framebuffer input for the
LCDC.

Due to the encoding of the NV12 color format, writing 0s to the entire
framebuffer memory area produces a green, rather than a black screen.

Specifying .bpp = 12 and .yuv = 1 when configuring the LCDC channel will enable
NV12 input support.

Damian Hobson-Garcia (1):
  Add NV12 input support for framebuffer

 drivers/video/sh_mobile_lcdcfb.c |   45 ++++++++++++++++++++++++++++++++-----
 drivers/video/sh_mobile_lcdcfb.h |    2 +-
 include/video/sh_mobile_lcdc.h   |    3 ++
 3 files changed, 43 insertions(+), 7 deletions(-)

