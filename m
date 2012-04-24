From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Apr 2012 11:31:13 +0000
Subject: [PULL for v3.5] SH Mobile LCDC overlay support
Message-Id: <5022250.LOHRC1DPLO@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

Could you please pull the following patches that add overlay support for the 
SH Mobile LCDC ? They have been posted for review as part of a bigger series 
some time ago.

The following changes since commit d313a86d2efb2c5568832389663322e93e291c59:

  i.MX28: Shut down the LCD controller to avoid BootROM sampling bug 
(2012-04-21 21:53:12 +0000)

are available in the git repository at:
  git://linuxtv.org/pinchartl/fbdev.git planes

Laurent Pinchart (3):
      fbdev: sh_mobile_lcdc: Constify sh_mobile_lcdc_fix structure
      fbdev: sh_mobile_lcdc: Rename fb operation handlers with a common prefix
      fbdev: sh_mobile_lcdc: Implement overlays support

 drivers/video/sh_mobile_lcdcfb.c | 1004 +++++++++++++++++++++++++++++++++----
 include/video/sh_mobile_lcdc.h   |    7 +
 2 files changed, 915 insertions(+), 96 deletions(-)

-- 
Regards,

Laurent Pinchart

