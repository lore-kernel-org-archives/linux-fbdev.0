Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D49FC56201
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73C222228
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiCAKIXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgKLMOL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLMOL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 12 Nov 2020 07:14:11 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5840C0613D1;
        Thu, 12 Nov 2020 04:14:09 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g11so2668511pll.13;
        Thu, 12 Nov 2020 04:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qI9FK/WV51uzQ+5U+ONFL1fdnGeKCbg3gawqygIR1rw=;
        b=LiCAKIXoQ/iIwwnWehfp70HaCZr7hqUs5nQurinaasuuQkf5shQk2yCWppH8DeypON
         FzjE8L9P9rmFDKm0sxcmuuMRBV6goxWjSJMk4AXeNaCAjqGl1MYPH81SgieJGYWE336i
         iLgXInHsw+34YgQ8Zqr/BlP5QQ3USAvuNR32SJgYj1dIWft9aXiddAZ+6VPl+CZEPk3g
         ZfUochzcS6e4jOYFecwZ0z3c+q/WgoiynQA7Ooo8DXSXjnPXcHducT25lhexyv9jRv6o
         zObOThTte/W3XhNeOXUgFxealnGRNjSg/1Q5DCjA/kK14X1rWf9WlkUdo4SRKOUq44KP
         eNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qI9FK/WV51uzQ+5U+ONFL1fdnGeKCbg3gawqygIR1rw=;
        b=GDBbq095NKyZZ97jwtZKg+AwApRkF22GjJklPGBrWdtAnFwLFzxKrCioDa6gNSOtDp
         h2okTHXVwvcRlqYWdAm9VXIolPky2Ma9w80wSIa4hGn/knlUSamkN03/dzggg/K/OGlW
         dIk7WKGlM/hLjZ1v2PV0dZmw8yQvxk3UZ6Cp+BfOvfQf83rBOn7fzQ6C0YG4DcSPiaE/
         nF+6k6v0dRVJCx9dVE8mPd4MFk7jYTFxj8UOpaB/gpWcEK3sGs6RRdCRJMz04+Qxm8RS
         rzrIb50hD0qaiXQ2fteVOgFlF8+DpeGB5HrDx7360tm3Wu3gRiJ98XU5rGj9QutrfoGz
         Y3pw==
X-Gm-Message-State: AOAM5339aPwuccgrJi5MD3INvpIhITPpzwvsvoxXgMJrO9OtZei+3Fy7
        pC0NihGjdOmNJggzxZa3sw==
X-Google-Smtp-Source: ABdhPJzxKGVRreaxt+hicCEYOLKxX4XkRjA1eKqizBS4+nlzy24IRoAfLir/N/deiS8Yr2k49PvPyQ==
X-Received: by 2002:a17:902:7c16:b029:d8:ac5d:3e9c with SMTP id x22-20020a1709027c16b02900d8ac5d3e9cmr12467169pll.68.1605183247901;
        Thu, 12 Nov 2020 04:14:07 -0800 (PST)
Received: from localhost.localdomain ([221.124.243.27])
        by smtp.gmail.com with ESMTPSA id a20sm6062637pff.118.2020.11.12.04.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:14:07 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v3 3/5] Fonts: Add charcount field to font_desc
Date:   Thu, 12 Nov 2020 07:13:34 -0500
Message-Id: <65952296d1d9486093bd955d1536f7dcd11112c6.1605169912.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1605169912.git.yepeilin.cs@gmail.com>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Subsystems are hard-coding the number of characters of our built-in fonts
as 256. Include that information in our kernel font descriptor, `struct
font_desc`.

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
v2: https://lore.kernel.org/lkml/20201028060533.1206307-1-yepeilin.cs@gmail.com/

Change in v3:
  - Rebase onto linux-next.

Change in v2:
  - Rebase onto 5.10-rc1.

 include/linux/font.h       | 1 +
 lib/fonts/font_10x18.c     | 1 +
 lib/fonts/font_6x10.c      | 1 +
 lib/fonts/font_6x11.c      | 1 +
 lib/fonts/font_6x8.c       | 1 +
 lib/fonts/font_7x14.c      | 1 +
 lib/fonts/font_8x16.c      | 1 +
 lib/fonts/font_8x8.c       | 1 +
 lib/fonts/font_acorn_8x8.c | 1 +
 lib/fonts/font_mini_4x6.c  | 1 +
 lib/fonts/font_pearl_8x8.c | 1 +
 lib/fonts/font_sun12x22.c  | 1 +
 lib/fonts/font_sun8x16.c   | 1 +
 lib/fonts/font_ter16x32.c  | 1 +
 14 files changed, 14 insertions(+)

diff --git a/include/linux/font.h b/include/linux/font.h
index 4f50d736ea72..abf1442ce719 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -17,6 +17,7 @@ struct font_desc {
     int idx;
     const char *name;
     unsigned int width, height;
+    unsigned int charcount;
     const void *data;
     int pref;
 };
diff --git a/lib/fonts/font_10x18.c b/lib/fonts/font_10x18.c
index e02f9df24d1e..5d940db626e7 100644
--- a/lib/fonts/font_10x18.c
+++ b/lib/fonts/font_10x18.c
@@ -5137,6 +5137,7 @@ const struct font_desc font_10x18 = {
 	.name	= "10x18",
 	.width	= 10,
 	.height	= 18,
+	.charcount = 256,
 	.data	= fontdata_10x18.data,
 #ifdef __sparc__
 	.pref	= 5,
diff --git a/lib/fonts/font_6x10.c b/lib/fonts/font_6x10.c
index 6e3c4b7691c8..e65df019e0d2 100644
--- a/lib/fonts/font_6x10.c
+++ b/lib/fonts/font_6x10.c
@@ -3083,6 +3083,7 @@ const struct font_desc font_6x10 = {
 	.name	= "6x10",
 	.width	= 6,
 	.height	= 10,
+	.charcount = 256,
 	.data	= fontdata_6x10.data,
 	.pref	= 0,
 };
diff --git a/lib/fonts/font_6x11.c b/lib/fonts/font_6x11.c
index 2d22a24e816f..bd76b3f6b635 100644
--- a/lib/fonts/font_6x11.c
+++ b/lib/fonts/font_6x11.c
@@ -3346,6 +3346,7 @@ const struct font_desc font_vga_6x11 = {
 	.name	= "ProFont6x11",
 	.width	= 6,
 	.height	= 11,
+	.charcount = 256,
 	.data	= fontdata_6x11.data,
 	/* Try avoiding this font if possible unless on MAC */
 	.pref	= -2000,
diff --git a/lib/fonts/font_6x8.c b/lib/fonts/font_6x8.c
index e7442a0d183d..06ace7792521 100644
--- a/lib/fonts/font_6x8.c
+++ b/lib/fonts/font_6x8.c
@@ -2571,6 +2571,7 @@ const struct font_desc font_6x8 = {
 	.name	= "6x8",
 	.width	= 6,
 	.height	= 8,
+	.charcount = 256,
 	.data	= fontdata_6x8.data,
 	.pref	= 0,
 };
diff --git a/lib/fonts/font_7x14.c b/lib/fonts/font_7x14.c
index 9cc7ae2e03f7..a2f561c9fa04 100644
--- a/lib/fonts/font_7x14.c
+++ b/lib/fonts/font_7x14.c
@@ -4113,6 +4113,7 @@ const struct font_desc font_7x14 = {
 	.name	= "7x14",
 	.width	= 7,
 	.height	= 14,
+	.charcount = 256,
 	.data	= fontdata_7x14.data,
 	.pref	= 0,
 };
diff --git a/lib/fonts/font_8x16.c b/lib/fonts/font_8x16.c
index bab25dc59e8d..06ae14088514 100644
--- a/lib/fonts/font_8x16.c
+++ b/lib/fonts/font_8x16.c
@@ -4627,6 +4627,7 @@ const struct font_desc font_vga_8x16 = {
 	.name	= "VGA8x16",
 	.width	= 8,
 	.height	= 16,
+	.charcount = 256,
 	.data	= fontdata_8x16.data,
 	.pref	= 0,
 };
diff --git a/lib/fonts/font_8x8.c b/lib/fonts/font_8x8.c
index 109d0572368f..69570b8c31af 100644
--- a/lib/fonts/font_8x8.c
+++ b/lib/fonts/font_8x8.c
@@ -2578,6 +2578,7 @@ const struct font_desc font_vga_8x8 = {
 	.name	= "VGA8x8",
 	.width	= 8,
 	.height	= 8,
+	.charcount = 256,
 	.data	= fontdata_8x8.data,
 	.pref	= 0,
 };
diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
index fb395f0d4031..18755c33d249 100644
--- a/lib/fonts/font_acorn_8x8.c
+++ b/lib/fonts/font_acorn_8x8.c
@@ -270,6 +270,7 @@ const struct font_desc font_acorn_8x8 = {
 	.name	= "Acorn8x8",
 	.width	= 8,
 	.height	= 8,
+	.charcount = 256,
 	.data	= acorndata_8x8.data,
 #ifdef CONFIG_ARCH_ACORN
 	.pref	= 20,
diff --git a/lib/fonts/font_mini_4x6.c b/lib/fonts/font_mini_4x6.c
index 592774a90917..8d39fd447952 100644
--- a/lib/fonts/font_mini_4x6.c
+++ b/lib/fonts/font_mini_4x6.c
@@ -2152,6 +2152,7 @@ const struct font_desc font_mini_4x6 = {
 	.name	= "MINI4x6",
 	.width	= 4,
 	.height	= 6,
+	.charcount = 256,
 	.data	= fontdata_mini_4x6.data,
 	.pref	= 3,
 };
diff --git a/lib/fonts/font_pearl_8x8.c b/lib/fonts/font_pearl_8x8.c
index a6f95ebce950..b1678ed0017c 100644
--- a/lib/fonts/font_pearl_8x8.c
+++ b/lib/fonts/font_pearl_8x8.c
@@ -2582,6 +2582,7 @@ const struct font_desc font_pearl_8x8 = {
 	.name	= "PEARL8x8",
 	.width	= 8,
 	.height	= 8,
+	.charcount = 256,
 	.data	= fontdata_pearl8x8.data,
 	.pref	= 2,
 };
diff --git a/lib/fonts/font_sun12x22.c b/lib/fonts/font_sun12x22.c
index a5b65bd49604..91daf5ab8b6b 100644
--- a/lib/fonts/font_sun12x22.c
+++ b/lib/fonts/font_sun12x22.c
@@ -6156,6 +6156,7 @@ const struct font_desc font_sun_12x22 = {
 	.name	= "SUN12x22",
 	.width	= 12,
 	.height	= 22,
+	.charcount = 256,
 	.data	= fontdata_sun12x22.data,
 #ifdef __sparc__
 	.pref	= 5,
diff --git a/lib/fonts/font_sun8x16.c b/lib/fonts/font_sun8x16.c
index e577e76a6a7c..81bb4eeae04e 100644
--- a/lib/fonts/font_sun8x16.c
+++ b/lib/fonts/font_sun8x16.c
@@ -268,6 +268,7 @@ const struct font_desc font_sun_8x16 = {
 	.name	= "SUN8x16",
 	.width	= 8,
 	.height	= 16,
+	.charcount = 256,
 	.data	= fontdata_sun8x16.data,
 #ifdef __sparc__
 	.pref	= 10,
diff --git a/lib/fonts/font_ter16x32.c b/lib/fonts/font_ter16x32.c
index f7c3abb6b99e..1955d624177c 100644
--- a/lib/fonts/font_ter16x32.c
+++ b/lib/fonts/font_ter16x32.c
@@ -2062,6 +2062,7 @@ const struct font_desc font_ter_16x32 = {
 	.name	= "TER16x32",
 	.width	= 16,
 	.height = 32,
+	.charcount = 256,
 	.data	= fontdata_ter16x32.data,
 #ifdef __sparc__
 	.pref	= 5,
-- 
2.25.1

