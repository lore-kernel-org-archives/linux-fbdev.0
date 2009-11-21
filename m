From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] viafb: Use sizeof struct rather than pointer
Date: Sat, 21 Nov 2009 20:02:47 +0100
Message-ID: <4B083957.3040500@gmail.com>
References: <4B0838F1.4090202@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753018AbZKUSty@vger.kernel.org>
In-Reply-To: <4B0838F1.4090202@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Joseph Chan <JosephChan@via.com.tw>, Scott Fang <ScottFang@viatech.com.cn>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

The returned error should be negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/video/via/viafbdev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

> Unless I am mistaken?

There was another in the same file:

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 56ec696..7b181e7 100644
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
@@ -694,7 +694,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 			return -ENOMEM;
 		viafb_get_gamma_table(viafb_gamma_table);
 		if (copy_to_user(argp, viafb_gamma_table,
-			sizeof(viafb_gamma_table))) {
+			sizeof(*viafb_gamma_table))) {
 			kfree(viafb_gamma_table);
 			return -EFAULT;
 		}
