From: Senthilvadivu Guruswamy <svadivu@ti.com>
Date: Thu, 13 May 2010 15:32:26 +0000
Subject: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
Message-Id: <1273764028-25822-1-git-send-email-svadivu@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy  <svadivu@ti.com>

Hi all,

This patch series replaces the patch 
"DSS2 Include VRFB into omap2-3build only"
Thanks for the review comments. 

The intent of this series is to split the patch into 2 logical
patches and also to incorporate the comments on multi-omap build.

In this series, Kconfig is changed to have 
OMAP2_VRFB depend on ARCH_OMAP2 and ARCH_OMAP3.
This change takes care of the multi-omap builds. 

This patch would allow successful build of omap_4430sdp_defconfig 
when OMAP2_DSS and FB_OMAP2 is enabled from menuconfig.

For verification: Generated the .config on omap3_defconfig with DSS
and FB enabled. Generated .config is same with and without the patch.

List of Changed Files:
arch/arm/plat-omap/include/plat/vrfb.h
drivers/video/omap2/Kconfig
drivers/video/omap2/omapfb/Kconfig

Thanks,
Senthil
