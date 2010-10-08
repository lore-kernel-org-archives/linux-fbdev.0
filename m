From: Guruswamy Senthilvadivu <svadivu@ti.com>
Date: Fri, 08 Oct 2010 06:56:30 +0000
Subject: [PATCH v6 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
Message-Id: <1286520273-4892-1-git-send-email-svadivu@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@nokia.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

The changelog till v6 are:
	- Address Multi-omap build issue
	- Added a check to warn the wrong usage of vrfb 
	in non-vrfb omap devices.
	- The patch subject is as per the naming conventions
	- patch 2/3 now has the changes in omap2/omapfb/Kconfig
	instead of omap2/Kconfig.  The functional effect remains
	the same, and the place of implementation is more appropriate.
	- Provide details of non-vrfb devices in commit description in patch 3/3
	- Removed extra paranthesis in cpu checks


Senthilvadivu Guruswamy (3):
  OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
  OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
  OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only for omap2,3

 arch/arm/plat-omap/include/plat/vrfb.h   |   16 ++++++++++++++++
 drivers/video/omap2/omapfb/Kconfig       |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c |   10 ++++++++++
 3 files changed, 27 insertions(+), 1 deletions(-)

