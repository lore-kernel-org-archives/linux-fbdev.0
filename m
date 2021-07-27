Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E97C4338F
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AB360F41
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhG0TUX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Jul 2021 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhG0TUV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Jul 2021 15:20:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F24C0613C1;
        Tue, 27 Jul 2021 12:20:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i10so14097968pla.3;
        Tue, 27 Jul 2021 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uO7kQ42xSTAH3+3Dd4r+058TnMUPwUJwWEreFhwbiJ4=;
        b=XrG6NfXeZJF2h4g6w7+A3bstUDqrEF6qjbBGUEjH4N8/44iFl0VC3sMUocTpGbGzut
         dzKBjRuWT6Oi+cWY9jnprPf9Nth5xSEZqmmW4V2K8glOA3ocQ+L7iHqOcvkKj6xwVuwy
         IKR0JsgSbUvDhozXTRrL5Y0ofAgbXnmityuRrS+Ssq8LNfc0Bk7lg6LgE2UeCGPv4OwS
         0ZcKxpE/IeOOHNMZB8KFg0lwU+GsdSFFQg2zs4wabdICMOh5x0oWrAJiITfXknn8+JMa
         oe2gDrqX375oEST4VKrT6XfARbuTeR2leeTFM5z05Qk+8j8LBtmjTFyOVfPwRbssqK/4
         gydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uO7kQ42xSTAH3+3Dd4r+058TnMUPwUJwWEreFhwbiJ4=;
        b=aW48ZayuqS2hjTW6G7IBCz/B3bDnXYVcT4q2NyLolqExr3ZEb9z2av6iStfny3vHM/
         nVxIhNG0zpw4y9Y+pw/LNXCzppoCw7UpH/9oGxRoLBSGOLO1keoUk82e54ZxammNJ4IA
         F/f++D1rrrs4fqFHEZKbeJdarhngi8DV8Trat7k3/Z2R0IWXUuBhb+IOY6AtGiAM8ESu
         UcCqyCBklGVyTtroA2S3v6MKeRhMVI2yIhlhG+MavkltD+5UrpSs3znEXxdFWyuxdNkI
         HyNTdnkfBOEclyTWljeuv7a2eDHAzL1HxbNQjf5HMcmrGyXXsAJCo/Xo2ob8QMtuuZIF
         tZBQ==
X-Gm-Message-State: AOAM5323CCYFcWzdW2QApqnz9vSkWbfTo1ZDQbnGzNXciDs8IzcFeQvZ
        DJsXo7AqX9HS/gmOIbtVexc=
X-Google-Smtp-Source: ABdhPJyx+Om6fO6BkBy8rKT1fjJbR3aHCZ09gTN9jElT1zRxPVnyyxJl0kW2X0Z3cXJU0fejK+/5qQ==
X-Received: by 2002:a17:90a:d816:: with SMTP id a22mr16713760pjv.180.1627413620528;
        Tue, 27 Jul 2021 12:20:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id f7sm4317096pfc.111.2021.07.27.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:20:20 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Benjamin Philip <benjamin.philip495@gmail.com>
Subject: [PATCH 4/4] staging: sm750fb: Rename vScreen to v_screen in lynxfb_crtc
Date:   Wed, 28 Jul 2021 00:49:53 +0530
Message-Id: <52db14bfc2f39e246aed7fdf866845a72e503b36.1627413010.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627413010.git.benjamin.philip495@gmail.com>
References: <cover.1627413010.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The struct lynxfb_crtc has a member named vScreen. This name is
CamelCase and is frowned upon. This commit renames it to v_screen
and makes the necessary changes for the module to build.

This change also fixes the following checkpatch CHECKs:

CHECK: Avoid CamelCase: <vScreen>
454: FILE: sm750.c:454:
+		memset_io(crtc->vScreen, 0x0, crtc->vidmem_size);

CHECK: Avoid CamelCase: <vScreen>
136: FILE: sm750.h:136:
+	unsigned char __iomem *vScreen; /* virtual address of on_screen */

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 18 +++++++++---------
 drivers/staging/sm750fb/sm750.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 202d8f47365c..dbd1159a2ef0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -451,7 +451,7 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
 		memset_io(cursor->vstart, 0x0, cursor->size);
-		memset_io(crtc->vScreen, 0x0, crtc->vidmem_size);
+		memset_io(crtc->v_screen, 0x0, crtc->vidmem_size);
 		lynxfb_ops_set_par(info);
 		fb_set_suspend(info, 0);
 	}
@@ -463,7 +463,7 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
 		memset_io(cursor->vstart, 0x0, cursor->size);
-		memset_io(crtc->vScreen, 0x0, crtc->vidmem_size);
+		memset_io(crtc->v_screen, 0x0, crtc->vidmem_size);
 		lynxfb_ops_set_par(info);
 		fb_set_suspend(info, 0);
 	}
@@ -615,27 +615,27 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->vScreen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pvMem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->vScreen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pvMem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->vScreen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pvMem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->vScreen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -643,7 +643,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->vScreen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pvMem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -651,7 +651,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->vScreen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -801,7 +801,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 			    crtc->line_pad);
 
 	info->pseudo_palette = &par->pseudo_palette[0];
-	info->screen_base = crtc->vScreen;
+	info->screen_base = crtc->v_screen;
 	pr_debug("screen_base vaddr = %p\n", info->screen_base);
 	info->screen_size = line_length * var->yres_virtual;
 	info->flags = FBINFO_FLAG_DEFAULT | 0;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 8952154739ac..aff69661c8e6 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -133,7 +133,7 @@ struct lynx_cursor {
 
 struct lynxfb_crtc {
 	unsigned char __iomem *v_cursor; /* virtual address of cursor */
-	unsigned char __iomem *vScreen; /* virtual address of on_screen */
+	unsigned char __iomem *v_screen; /* virtual address of on_screen */
 	int o_cursor; /* cursor address offset in vidmem */
 	int o_screen; /* onscreen address offset in vidmem */
 	int channel;/* which channel this crtc stands for*/
-- 
2.31.1

