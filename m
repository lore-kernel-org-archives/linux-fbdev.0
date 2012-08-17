From: Archit Taneja <archit@ti.com>
Date: Fri, 17 Aug 2012 10:51:28 +0000
Subject: [PATCH 0/3] OMAPDSS: Miscellaneous cleanup patches
Message-Id: <1345200551-28712-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <343817088-29645-1-git-send-email-archit@ti.com>
In-Reply-To: <343817088-29645-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

These are minor cleanup patches which will be useful for the future series on
outputs. It's harder to add output entities in DSS when there are more
omap_dss_device references in the driver. The first 2 reduces that a bit. The
third patch just removes some left over fields from omap_dss_device

Refenence Tree:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 1-misc-clean-for-outputs

Archit Taneja (3):
  OMAPDSS: DSI: Pass dsi platform device wherever possible
  OMAPDSS: APPLY: Remove omap_dss_device references in wait_for_go
    functions
  OMAPDSS: Remove unnecessary acb/acbi pin fields from omap_dss_device

 drivers/video/omap2/dss/apply.c |   32 +++++++++-----
 drivers/video/omap2/dss/dsi.c   |   89 +++++++++++++++++----------------------
 include/video/omapdss.h         |    4 --
 3 files changed, 60 insertions(+), 65 deletions(-)

-- 
1.7.9.5

