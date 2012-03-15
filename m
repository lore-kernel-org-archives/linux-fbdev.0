From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Thu, 15 Mar 2012 11:49:12 +0000
Subject: [PATCH 0/2] OMAPDSS: DISPC: Enable predecimation for DMA and VRFB
Message-Id: <1331812083-9739-1-git-send-email-cmahapatra@ti.com>
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

The second patch is based on code written by Ville Syrjälä
<ville.syrjala@nokia.com> which aims to avoid synclost errors occurring
in OMAP3 due to some undocumented horizontal position and timing related
limitations which I faced during testing of the previous patch.

I have tested these patches successfully on OMAP2, OMAP3 AND OMAP4 on the
mainline kernel v3.3-rc5. Horizontal and vertical predecimation worked fine
but skewed images along with underflow errors were seen on OMAP2 and OMAP3
during horizontal predecimation which will be addressed in the future patches.

All your comments and suggestions are welcome.

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (2):
  OMAPDSS: DISPC: Enable predecimation
  OMAPDSS: DISPC: Handle synclost errors in OMAP3

 drivers/video/omap2/dss/dispc.c |  323 +++++++++++++++++++++++++++++----------
 1 files changed, 242 insertions(+), 81 deletions(-)

