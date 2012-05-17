From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 May 2012 22:23:19 +0000
Subject: [PULL for v3.4] SH Mobile LCDC fix
Message-Id: <26224047.6PR9YZjWoc@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

Is it still possible for the following patch to go to v3.4 ? I've only 
realized now that MERAM support was broken in some use cases (one of them 
being fbcon) due to a v3.4-rc regression - thanks to Guennadi Liakhovetski for 
reporting this.

If this is too late for v3.4 please let me know and I'll CC stable on the 
patch and resend a pull request for v3.5.

The following changes since commit 5e7b911f9a3e582635801675b7fe935b16cd4af5:

  drivers/video: fsl-diu-fb: don't initialize the THRESHOLDS registers 
(2012-05-13 13:08:56 +0000)

are available in the git repository at:
  git://linuxtv.org/pinchartl/fbdev.git fixes

Laurent Pinchart (1):
      fbdev: sh_mobile_lcdc: Don't confuse line size with pitch

 drivers/video/sh_mobile_lcdcfb.c |    5 +++--
 drivers/video/sh_mobile_lcdcfb.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart

