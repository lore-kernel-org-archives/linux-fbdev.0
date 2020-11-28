Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B64C83010
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F013420702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+e7aw5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbgK1Wm5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbgK1Wm4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:56 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5546C061A51
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:48 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so12760847lfh.2
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GO4HyonQKM+uiRKyJhgt5Ae8eU+jCIwu9BQ+Y1bEdq0=;
        b=l+e7aw5uXxHSu6BWfxEs9s+vt+LQqdRgEY7AVwx/9rFVC/UlPyCplyoadMVzY4btdI
         wWfAztM2iw9Zjnb5iyJoqjibcPyZSoK+W8uageWe9XEX5uaH6exFHhuoy4mIiwWd7i/H
         NAp90wUPSvDWPfpcfFWzbxBqAJ3T7M4MVNRu6AOixDEjfgEzAieEF5Ivx9tnLj2iux12
         IOLUuQ0fNyeQiFv2cInR4CBBkQHkUD0jULK1e9o1q74jpi1BLUq3CoHJILRlnWqKln3D
         kUaBSSoXiDSHmJZmVUkZwzakyojzy3AXh2bymPJA2b53gUPL/pGPOBjuc0YkC5LcaClc
         DkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GO4HyonQKM+uiRKyJhgt5Ae8eU+jCIwu9BQ+Y1bEdq0=;
        b=JxGGQnLs1yEI7X+wRyoYxeOrVcJvajlrEIT3CbKtzN3bafZ7hAhoyyLZaqYFkDdE1v
         7r0aJBjtlBvnbu/HvH0DGT7+KC8P6NRgZ1BawMdbYrTGWBvtPpjvpfTjCMflFIkM1CNT
         4dt6s4s/Gc4I+h8MBLY1Nwf3bAQIKzk3b9Csfj6rdBYHdbnLz4Jy+9Hmib6sHX/Aaw6p
         fPg1N273AfH9q1RdCVyC4KLRcAJHcNNJq6otVGcA57iXPdy2/hsi52s3w3MVucpbUuvv
         bDgOZRw4a0jOrAbqmeEgceZFFI7ChAq4arH3fx0MZTFwW+RQp0HIreuFsejHQ8T9gKV6
         gq3w==
X-Gm-Message-State: AOAM531u7ztuANrk/U7klWytc0BFbBSazkZutD0nTF+Lk9x3lyKAKMqp
        y91Evg3uBnqRrxHIKIZ0CC2FYR+HEbZR0A==
X-Google-Smtp-Source: ABdhPJzf7rpIocaqr7UuHf7lkRCgNvHSRQYgfFjw/JeQSkuWTfMrys3Za/nY803MZlmSagJSSAnR0w==
X-Received: by 2002:a19:4815:: with SMTP id v21mr5654157lfa.368.1606603307034;
        Sat, 28 Nov 2020 14:41:47 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:46 -0800 (PST)
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
Subject: [PATCH v2 13/28] video: fbdev: riva: Fix kernel-doc and set but not used warnings
Date:   Sat, 28 Nov 2020 23:40:59 +0100
Message-Id: <20201128224114.1033617-14-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings:
- Fix kernel-doc
- Drop unused variables/code

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>
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

