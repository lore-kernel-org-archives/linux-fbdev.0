Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E151C433DB
	for <linux-fbdev@archiver.kernel.org>; Sat, 20 Feb 2021 23:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1074F64E92
	for <linux-fbdev@archiver.kernel.org>; Sat, 20 Feb 2021 23:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBTXDg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 20 Feb 2021 18:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBTXDe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 20 Feb 2021 18:03:34 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4DEC06178A;
        Sat, 20 Feb 2021 15:02:54 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t62so9249585qke.7;
        Sat, 20 Feb 2021 15:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWfJvWy4MeY0dPBUb0Lz06mKddy7aIG1Spk574Wm71k=;
        b=DWeTG4n9V/oLWJrJ9ssTGlEvrb5A+Ag3qTHXw5zdnLD9cSomjKNc4JwvqA1WLwbMsY
         /8cIo8UwTChASyJdInz8DvuRLOXoJ5dZkP8KJiCtEPgEIFqxxTmj9l51xf9QSefDURZd
         8AO1J4jtloSV9AIn98Pr6TfRbzqL2EMeiYHLNmoXzV4OwdBwr1RYbZ3WUsU+/A8F82v3
         iuwR3EBZXnrp+5Gd09cz8r6wjmHEikNgCZl1U19NkVUHipCA6aLescPEcvacIPHjEu+b
         DR7JUSFUEbfFJG/7noSQDQSt2taIw32xSDAn/liMsRVf6Iqmf2Gwokkj/MXYM0Tyc4pw
         s0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWfJvWy4MeY0dPBUb0Lz06mKddy7aIG1Spk574Wm71k=;
        b=NiSu0wSlOq2yby6eviMHLdwUNREJqX1nFE6dvCoWhJPR2HG8u5atjdUGjhjV/3aVfh
         4muLKbWPonShVpRI7N6rsrR/X87npzmhLMsdj2LvQl2cpJwAcvXgB36oFi6FQfmnCqWd
         BhRmt9Cz3PDv3Q6n6AtWA9VYR/WtBrAG2MvsQj93U2plafv+u71VXir3bN3VGutx1ug3
         D7/6vGyaCzQhSZopFRfqTrLHbTOoAW6F38sV31XTyGHusnXihNnH7TN/nsrCQt55CjbZ
         /0id5DkFiclYO8DBjoopIDpPjaQt7Tq8JxNbb/v7MrwTN3F68EnbikXz8Uq20FR4uc60
         AoSQ==
X-Gm-Message-State: AOAM532t+FIjPzoeqCQol9yv//Ainzp7P2AQES5rXTxhYa5SlKHhiUen
        ZBCBq3pRRD7Dhat8qbSIBcY=
X-Google-Smtp-Source: ABdhPJyWW8md1n+D4MNvm2riIF5RM8MpeXYpTgm4V2SVAC2l+QDg4Rv+tW+56ZycOhpIPu1Glg5B+Q==
X-Received: by 2002:a05:620a:22f3:: with SMTP id p19mr15531903qki.221.1613862173403;
        Sat, 20 Feb 2021 15:02:53 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:21e3:ddd4:1a2b:a77e])
        by smtp.googlemail.com with ESMTPSA id n4sm8372602qtl.77.2021.02.20.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 15:02:53 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: pm2fb: avoid stall on fb_sync
Date:   Sat, 20 Feb 2021 18:02:47 -0500
Message-Id: <20210220230248.320870-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

pm2fb_sync is called when doing /dev/fb read or write.
The original pm2fb_sync wait indefinitely on hardware flags which can
possibly stall kernel and make everything unresponsive.
Instead of waiting indefinitely, we can timeout to give user a chance to
get back control.

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/video/fbdev/pm2fb.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 27893fa139b0..8578c64a0c54 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -183,12 +183,23 @@ static inline void pm2v_RDAC_WR(struct pm2fb_par *p, s32 idx, u32 v)
 
 #ifdef CONFIG_FB_PM2_FIFO_DISCONNECT
 #define WAIT_FIFO(p, a)
+#define WAIT_FIFO_TIMEOUT(p, a) (0)
 #else
 static inline void WAIT_FIFO(struct pm2fb_par *p, u32 a)
 {
 	while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a)
 		cpu_relax();
 }
+static int inline void WAIT_FIFO_TIMEOUT(struct pm2fb_par *p, u32 a)
+{
+	int timeout = 10000;
+	while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a) {
+		cpu_relax();
+		if (--timeout==0)
+			return 1;
+	}
+	return 0;
+}
 #endif
 
 /*
@@ -1031,15 +1042,27 @@ static int pm2fb_blank(int blank_mode, struct fb_info *info)
 static int pm2fb_sync(struct fb_info *info)
 {
 	struct pm2fb_par *par = info->par;
+	int timeout_sync = 10000;
+	int timeout_fifo;
 
-	WAIT_FIFO(par, 1);
+	if (WAIT_FIFO_TIMEOUT(par, 1))
+		goto end;
 	pm2_WR(par, PM2R_SYNC, 0);
 	mb();
 	do {
-		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0)
+		timeout_fifo = 10000;
+		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0) {
 			cpu_relax();
-	} while (pm2_RD(par, PM2R_OUT_FIFO) != PM2TAG(PM2R_SYNC));
+			if (--timeout_fifo==0)
+				goto end;
+		}
+		if (pm2_RD(par, PM2R_OUT_FIFO) == PM2TAG(PM2R_SYNC))
+			break;
+	} while (--timeout_sync>0);
 
+end:
+	if ((!timeout_sync) || (!timeout_fifo))
+		printk_ratelimited(KERN_WARNING "pm2fb: sync timeout!\n");
 	return 0;
 }
 
-- 
2.25.1

