Return-Path: <SRS0=vnRM=EO=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23761C388F9
	for <linux-fbdev@archiver.kernel.org>; Sun,  8 Nov 2020 08:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80142151B
	for <linux-fbdev@archiver.kernel.org>; Sun,  8 Nov 2020 08:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgKHICG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 8 Nov 2020 03:02:06 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44737 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbgKHICG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 8 Nov 2020 03:02:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UEadUVK_1604822521;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEadUVK_1604822521)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Nov 2020 16:02:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: riva: remove some unused varibles
Date:   Sun,  8 Nov 2020 16:01:59 +0800
Message-Id: <1604822519-65607-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Couple of variables are actually useless, remove them to save some gcc
warning:
drivers/video/fbdev/riva/riva_hw.c:250:21: warning: variable ‘mlwm’ set
but not used [-Wunused-but-set-variable]
drivers/video/fbdev/riva/riva_hw.c:665:15: warning: variable ‘vraw’ set
but not used [-Wunused-but-set-variable]
drivers/video/fbdev/riva/riva_hw.c:665:9: warning: variable ‘craw’ set
but not used [-Wunused-but-set-variable]
drivers/video/fbdev/riva/riva_hw.c:659:73: warning: variable ‘align’ set
but not used [-Wunused-but-set-variable]
drivers/video/fbdev/riva/riva_hw.c:659:50: warning: variable
‘color_key_enable’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Antonino Daplas <adaplas@gmail.com> 
Cc: linux-fbdev@vger.kernel.org 
Cc: dri-devel@lists.freedesktop.org 
Cc: linux-kernel@vger.kernel.org 
---
 drivers/video/fbdev/riva/riva_hw.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 4168ac464565..bcf9c4b4de31 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -247,14 +247,13 @@ static int nv3_iterate(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_arb_i
     int mburst_size = 32;
     int mmisses, gmisses, vmisses;
     int misses;
-    int vlwm, glwm, mlwm;
+    int vlwm, glwm;
     int last, next, cur;
     int max_gfsize ;
     long ns;
 
     vlwm = 0;
     glwm = 0;
-    mlwm = 0;
     vfsize = 0;
     gfsize = 0;
     cur = ainfo->cur;
@@ -656,13 +655,12 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
     nv4_sim_state *arb
 )
 {
-    int data, pagemiss, cas,width, video_enable, color_key_enable, bpp, align;
+    int data, pagemiss, cas,width, video_enable, bpp;
     int nvclks, mclks, pclks, vpagemiss, crtpagemiss, vbs;
     int found, mclk_extra, mclk_loop, cbs, m1, p1;
     int mclk_freq, pclk_freq, nvclk_freq, mp_enable;
     int us_m, us_n, us_p, video_drain_rate, crtc_drain_rate;
     int vpm_us, us_video, vlwm, video_fill_us, cpm_us, us_crt,clwm;
-    int craw, vraw;
 
     fifo->valid = 1;
     pclk_freq = arb->pclk_khz;
@@ -672,9 +670,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
     cas = arb->mem_latency;
     width = arb->memory_width >> 6;
     video_enable = arb->enable_video;
-    color_key_enable = arb->gr_during_vid;
     bpp = arb->pix_bpp;
-    align = arb->mem_aligned;
     mp_enable = arb->enable_mp;
     clwm = 0;
     vlwm = 0;
@@ -782,8 +778,6 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
                 mclk_extra--;
             }
         }
-        craw = clwm;
-        vraw = vlwm;
         if (clwm < 384) clwm = 384;
         if (vlwm < 128) vlwm = 128;
         data = (int)(clwm);
@@ -842,7 +836,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
     nv10_sim_state *arb
 )
 {
-    int data, pagemiss, cas,width, video_enable, color_key_enable, bpp, align;
+    int data, pagemiss, cas,width, video_enable, bpp;
     int nvclks, mclks, pclks, vpagemiss, crtpagemiss, vbs;
     int nvclk_fill, us_extra;
     int found, mclk_extra, mclk_loop, cbs, m1;
@@ -863,9 +857,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
     cas = arb->mem_latency;
     width = arb->memory_width/64;
     video_enable = arb->enable_video;
-    color_key_enable = arb->gr_during_vid;
     bpp = arb->pix_bpp;
-    align = arb->mem_aligned;
     mp_enable = arb->enable_mp;
     clwm = 0;
     vlwm = 1024;
-- 
1.8.3.1

