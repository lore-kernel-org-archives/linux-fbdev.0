From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 74/75] metronomefb: declare MODULE_FIRMWARE
Date: Sat, 07 Nov 2009 22:12:50 +0000
Message-ID: <1257631970.15927.510.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753692AbZKGWMs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayalk@intworks.biz>
Cc: linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/metronomefb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index df1f757..46bd386 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -792,3 +792,4 @@ module_exit(metronomefb_exit);
 MODULE_DESCRIPTION("fbdev driver for Metronome controller");
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE("metronome.wbf");
-- 
1.6.5.2
