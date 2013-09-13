From: Archit Taneja <archit@ti.com>
Date: Fri, 13 Sep 2013 10:41:31 +0000
Subject: [PATCH 0/7] omapdss: HDMI: Fix register definitions and reg dump functions
Message-Id: <1379068178-17312-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

These patches complete the OMAP4 HDMI register definitions for HDMI submodules
and make sure all the corresponding regdump functions dump all the registers.

Ricardo Neri (7):
  OMAPDSS: HDMI: OMAP4: Complete register definitions for wrapper
  OMAPDSS: HDMI: OMAP4: Complete dumping of wrapper registers
  OMAPDSS: HDMI: OMAP4: Complete register definitions for DPLL
  OMAPDSS: HDMI: OMAP4: Complete dumping of DPLL registers
  OMAPDSS: HDMI: OMAP4: Rename the HDMI_CORE_CTRL1 register
  OMAPDSS: HDMI: OMAP4: Complete register definitions for core
  OMAPDSS: HDMI: OMAP4: Complete dumping of core registers

 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | 70 ++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h | 65 ++++++++++++++++++++++++----
 2 files changed, 118 insertions(+), 17 deletions(-)

-- 
1.8.1.2

