From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] viafb: Use sizeof struct rather than pointer
Date: Sat, 21 Nov 2009 20:01:05 +0100
Message-ID: <4B0838F1.4090202@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756773AbZKUSsJ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Joseph Chan <JosephChan@via.com.tw>, Scott Fang <ScottFang@viatech.com.cn>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vge>

The sizeof the struct should be used rather than of the pointer

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/video/via/viafbdev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Unless I am mistaken?

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 56ec696..6cf4cb8 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -680,7 +680,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 		if (!viafb_gamma_table)
 			return -ENOMEM;
 		if (copy_from_user(viafb_gamma_table, argp,
-				sizeof(viafb_gamma_table))) {
+				sizeof(*viafb_gamma_table))) {
 			kfree(viafb_gamma_table);
 			return -EFAULT;
 		}
