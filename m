From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Wed, 26 Sep 2012 05:27:25 +0000
Subject: [PATCH V2 0/2] OMAPDSS: Enable dynamic debug printing
Message-Id: <cover.1348636132.git.cmahapatra@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
In-Reply-To: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone,
this patch series aims at cleaning up of DSS of printk()'s enabled with
dss_debug and replace them with generic dynamic debug printing.

The 1st patch 
 * replaces printk() in DSSDBG definition with pr_debug()
 * removes DSSDBGF definition and replaces its instances with DSSDBG() 
The 2nd patch
 * cleans up printk()'s in omap_dispc_unregister_isr() and 
   _dsi_print_reset_status() with pr_debug()
 * removes dss_debug variable

Changes with respect to V1:
 * added debug messages to DSSDBG calls replacing DSSDBGF
 * added patch "OMAPDSS: Remove dss_debug variable"

All your comments and suggestions are welcome.

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (2):
  OMAPDSS: Cleanup DSSDBG with dynamic pr_debug function
  OMAPDSS: Remove dss_debug variable

 drivers/video/omap2/dss/apply.c |    8 +++----
 drivers/video/omap2/dss/core.c  |    5 ----
 drivers/video/omap2/dss/dispc.c |   39 +++++++++++--------------------
 drivers/video/omap2/dss/dsi.c   |   49 ++++++++++++++++-----------------------
 drivers/video/omap2/dss/dss.h   |   34 +++++----------------------
 5 files changed, 44 insertions(+), 91 deletions(-)

-- 
1.7.10

