Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05FCC3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63A021D46
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCNLiQfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgK1BhR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE76C061A54
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:10 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s27so8560253lfp.5
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHnHNejv7AhApH+VUvGdbMBEjvsQK7oM4lZgYgyuVAY=;
        b=vCNLiQfeEvpoIJt7SkD1g+b4b3Ux90ZWyPNnAZRBnotTZmnTAUWU24s2YoBHrsdvZD
         HxCRM7514OVQW17o980p5GXoRkXivoEpKQ+Mbn1TsTqssE0/ETcE4LevBAFVQYCf3fxw
         8PDMHFg7CPWi6zn3b8FQAiFWakurLLmFHcHT4Iu5+Ly0rVqLJnOvvt63qr90NUTDZI0w
         3jU04Ie3q4YJyF+uyVwbgnBr45gi2ciRZhmOWquwHel6eJD8KH3teklR9iVM0UIH719O
         DtM7VwC1rO120zJbdy6NnmM65ymFjDpfT/hdbp9TLDP0uZAdNkfBZ/HoyN6o9Sq23tve
         w4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DHnHNejv7AhApH+VUvGdbMBEjvsQK7oM4lZgYgyuVAY=;
        b=JN6ol0oc4zCUC9t3lZcvYxQ0KqzuyLFH9kEs+Q22eh5eI60ULudD0v21pB28gsWu1D
         gvAR966h5aUI+fLECOczMY0Twq04CfGjVnY5uNGwAwL2wlT+HYEco6at4Kd6D8WJUmPw
         fwADVfxqXFT16LhTui4JAdza5O5Iab/MWTx3ZCLyEHlDHK+AYwfvtymCo2gAJ+4/6beO
         UOfjbCCFsNXVOwY6uUDtJmCCh5App4+4GzJaNhKWRCFFB7eJUpk8v3YRc55okQraiwxJ
         OfpE6HxzWCO2h8VmHwRuv00B8T9ooY7XriBJB4LhPvBiebl12Rp9l/7eYzA0CSFHihh/
         USWg==
X-Gm-Message-State: AOAM5320dZfMbB8SqLCNqPaqevA2IQv0SSnrwf/EF6J9P/oATlxlda8l
        Vlp7a+uERO1oy89KlCUsUhUbLuHCi67XLWbY
X-Google-Smtp-Source: ABdhPJzmN19Ex+rToaLJQVEF+FVjbO2OJIoM/NZahowAyuob0kZlMAKXt1B+fW7Gczozaeltl7O2fA==
X-Received: by 2002:ac2:4acd:: with SMTP id m13mr4323957lfp.69.1606507148319;
        Fri, 27 Nov 2020 11:59:08 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:07 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v1 13/28] video: fbdev: riva: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:10 +0100
Message-Id: <20201127195825.858960-14-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings:
- Fix kernel-doc
- Drop unused variables/code

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/riva/fbdev.c   |  9 ++++-----
 drivers/video/fbdev/riva/riva_hw.c | 28 ++++++++--------------------
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index ce55b9d2e862..55554b0433cb 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -464,7 +464,7 @@ static inline void reverse_order(u32 *l)
 
 /**
  * rivafb_load_cursor_image - load cursor image to hardware
- * @data: address to monochrome bitmap (1 = foreground color, 0 = background)
+ * @data8: address to monochrome bitmap (1 = foreground color, 0 = background)
  * @par:  pointer to private data
  * @w:    width of cursor image in pixels
  * @h:    height of cursor image in scanlines
@@ -843,9 +843,9 @@ static void riva_update_var(struct fb_var_screeninfo *var,
 /**
  * rivafb_do_maximize - 
  * @info: pointer to fb_info object containing info for current riva board
- * @var:
- * @nom:
- * @den:
+ * @var: standard kernel fb changeable data
+ * @nom: nom
+ * @den: den
  *
  * DESCRIPTION:
  * .
@@ -1214,7 +1214,6 @@ static int rivafb_set_par(struct fb_info *info)
 /**
  * rivafb_pan_display
  * @var: standard kernel fb changeable data
- * @con: TODO
  * @info: pointer to fb_info object containing info for current riva board
  *
  * DESCRIPTION:
diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index bcf9c4b4de31..8b829b720064 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -836,17 +836,17 @@ static void nv10CalcArbitration
     nv10_sim_state *arb
 )
 {
-    int data, pagemiss, cas,width, video_enable, bpp;
-    int nvclks, mclks, pclks, vpagemiss, crtpagemiss, vbs;
-    int nvclk_fill, us_extra;
+    int data, pagemiss, width, video_enable, bpp;
+    int nvclks, mclks, pclks, vpagemiss, crtpagemiss;
+    int nvclk_fill;
     int found, mclk_extra, mclk_loop, cbs, m1;
     int mclk_freq, pclk_freq, nvclk_freq, mp_enable;
-    int us_m, us_m_min, us_n, us_p, video_drain_rate, crtc_drain_rate;
-    int vus_m, vus_n, vus_p;
-    int vpm_us, us_video, vlwm, cpm_us, us_crt,clwm;
+    int us_m, us_m_min, us_n, us_p, crtc_drain_rate;
+    int vus_m;
+    int vpm_us, us_video, cpm_us, us_crt,clwm;
     int clwm_rnd_down;
-    int craw, m2us, us_pipe, us_pipe_min, vus_pipe, p1clk, p2;
-    int pclks_2_top_fifo, min_mclk_extra;
+    int m2us, us_pipe_min, p1clk, p2;
+    int min_mclk_extra;
     int us_min_mclk_extra;
 
     fifo->valid = 1;
@@ -854,16 +854,13 @@ static void nv10CalcArbitration
     mclk_freq = arb->mclk_khz;
     nvclk_freq = arb->nvclk_khz;
     pagemiss = arb->mem_page_miss;
-    cas = arb->mem_latency;
     width = arb->memory_width/64;
     video_enable = arb->enable_video;
     bpp = arb->pix_bpp;
     mp_enable = arb->enable_mp;
     clwm = 0;
-    vlwm = 1024;
 
     cbs = 512;
-    vbs = 512;
 
     pclks = 4; /* lwm detect. */
 
@@ -924,17 +921,11 @@ static void nv10CalcArbitration
       us_min_mclk_extra = min_mclk_extra *1000*1000 / mclk_freq;
       us_n = nvclks*1000*1000 / nvclk_freq;/* nvclk latency in us */
       us_p = pclks*1000*1000 / pclk_freq;/* nvclk latency in us */
-      us_pipe = us_m + us_n + us_p;
       us_pipe_min = us_m_min + us_n + us_p;
-      us_extra = 0;
 
       vus_m = mclk_loop *1000*1000 / mclk_freq; /* Mclk latency in us */
-      vus_n = (4)*1000*1000 / nvclk_freq;/* nvclk latency in us */
-      vus_p = 0*1000*1000 / pclk_freq;/* pclk latency in us */
-      vus_pipe = vus_m + vus_n + vus_p;
 
       if(video_enable) {
-        video_drain_rate = pclk_freq * 4; /* MB/s */
         crtc_drain_rate = pclk_freq * bpp/8; /* MB/s */
 
         vpagemiss = 1; /* self generating page miss */
@@ -993,7 +984,6 @@ static void nv10CalcArbitration
               else if(crtc_drain_rate * 100  >= nvclk_fill * 98) {
                   clwm = 1024;
                   cbs = 512;
-                  us_extra = (cbs * 1000 * 1000)/ (8*width)/mclk_freq ;
               }
           }
       }
@@ -1010,7 +1000,6 @@ static void nv10CalcArbitration
 
       m1 = clwm + cbs -  1024; /* Amount of overfill */
       m2us = us_pipe_min + us_min_mclk_extra;
-      pclks_2_top_fifo = (1024-clwm)/(8*width);
 
       /* pclk cycles to drain */
       p1clk = m2us * pclk_freq/(1000*1000); 
@@ -1038,7 +1027,6 @@ static void nv10CalcArbitration
               min_mclk_extra--;
         }
       }
-      craw = clwm;
 
       if(clwm < (1024-cbs+8)) clwm = 1024-cbs+8;
       data = (int)(clwm);
-- 
2.27.0

