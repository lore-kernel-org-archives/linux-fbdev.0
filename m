From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 01/15] ps3vram: Fix error path (return -EIO) for short read/write
Date: Fri,  8 May 2009 16:01:10 +0200
Message-ID: <1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757490AbZEHOCT@vger.kernel.org>
In-Reply-To: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Jim Paris <jim@jtan.com>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
---
 drivers/block/ps3vram.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 8eddef3..2e79d2c 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -585,6 +585,7 @@ static int ps3vram_make_request(struct request_queue *q, struct bio *bio)
 
 		if (retlen != len) {
 			dev_err(&dev->core, "Short %s\n", op);
+			error = -EIO;
 			goto out;
 		}
 
-- 
1.6.2.4
