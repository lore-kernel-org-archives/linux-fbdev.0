From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Wed, 21 Mar 2012 09:52:45 +0000
Subject: [PATCH V2 0/3] OMAPDSS: DISPC: Enable predecimation for DMA and VRFB
Message-Id: <1332323484-8975-1-git-send-email-cmahapatra@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone,
the following patch set directs to enable predecimation for DMA and VRFB
which consists of two pacthes.

The first patch is based on code written by Lajos Molnar <lajos@ti.com> in
Android Kernel, which updates the code with predecimation logic thereby
increasing the downscaling ability of the DISPC module.
In version 2 patch description has been modified include reason for maximum
predecimation limit of 16.

The second patch is based on code written by Ville Syrjälä
<ville.syrjala@nokia.com> which aims to avoid synclost errors occurring
in OMAP3 due to some undocumented horizontal position and timing related
limitations which I faced during testing of the previous patch.
In version 2 the pcd factor has been replaced lclk / pclk to support HDMI and
tv output as pointed out by Ville Syrjälä.

The third patch corrects the usage of dispc fclk in scaling checks by
replacing it with dispc_core_clk as per suggestions of Ville Syrjälä.

I have tested these patches successfully on OMAP2, OMAP3 AND OMAP4 on the
mainline kernel v3.3. Horizontal and vertical predecimation worked fine
but skewed images were seen on OMAP2 and OMAP3 on HDMI tv during horizontal
predecimation which will be addressed in the future patches.

All your comments and suggestions are welcome.

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (3):
  OMAPDSS: DISPC: Enable predecimation
  OMAPDSS: DISPC: Handle synclost errors in OMAP3
  OMAPDSS: DISPC: Correct DISPC functional clock usage

 drivers/video/omap2/dss/dispc.c |  360 +++++++++++++++++++++++++++------------
 1 files changed, 254 insertions(+), 106 deletions(-)

