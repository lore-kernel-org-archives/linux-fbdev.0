From: Guruswamy Senthilvadivu <svadivu@ti.com>
Date: Tue, 22 Jun 2010 11:57:24 +0000
Subject: [PATCH v4 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
Message-Id: <1277207827-15833-1-git-send-email-svadivu@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy  <svadivu@ti.com>

Please ignore the previous v3 and consider v4.

The changelog till v4 are:
	- Address Multi-omap build issue
	- Added a check to warn the wrong usage of vrfb 
	in non-vrfb omap devices.
	- The patch subject is as per the naming conventions
	- patch 2/3 now has the changes in omap2/omapfb/Kconfig
	instead of omap2/Kconfig.  The functional effect remains
	the same, and the place of implementation is more appropriate.
	

Thanks,
Senthil
