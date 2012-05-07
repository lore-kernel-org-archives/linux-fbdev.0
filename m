From: Archit Taneja <archit@ti.com>
Date: Mon, 07 May 2012 13:32:26 +0000
Subject: [PATCH 0/2] OMAPDSS: HDMI: Fix register dump of CORE registers
Message-Id: <1336396828-29311-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The HDMI CORE registers are dumped incorrectly due to incorrect register offset
calculations. They are also dumped in a random order, with some of the registers
repeated. This series fixes these issues.

The patches apply over:

git://gitorious.org/linux-omap-dss2/linux.git dev

Tested on OMAP4 SDP.

Archit Taneja (2):
  OMAPDSS: HDMI: Fix ti_hdmi_4xxx_core_dump
  OMAPDSS: HDMI: define and dump CORE registers in correct order

 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  163 +++++++++++++++--------------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   57 +++++------
 2 files changed, 109 insertions(+), 111 deletions(-)

-- 
1.7.5.4

