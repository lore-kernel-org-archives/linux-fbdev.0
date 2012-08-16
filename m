From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:54 +0000
Subject: [PATCH 19/19] fbdev: sh_mobile_lcdc: Make sh_mobile_lcdc_sys_bus_ops static
Message-Id: <1345122054-16013-20-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The structure isn't used outside of its compilation unit, make it
static.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index dd8dd41..e78fe4b 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -438,7 +438,7 @@ static unsigned long lcdc_sys_read_data(void *handle)
 	return lcdc_read(ch->lcdc, _LDDRDR) & LDDRDR_DRD_MASK;
 }
 
-struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {
+static struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {
 	lcdc_sys_write_index,
 	lcdc_sys_write_data,
 	lcdc_sys_read_data,
-- 
1.7.8.6

