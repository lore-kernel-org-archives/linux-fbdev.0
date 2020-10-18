Return-Path: <SRS0=OfnY=DZ=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48BCC433DF
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 18:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763DE22261
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 18:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8N2yrsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgJRSNq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Oct 2020 14:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRSNp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Oct 2020 14:13:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE9C061755;
        Sun, 18 Oct 2020 11:13:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id az3so4068088pjb.4;
        Sun, 18 Oct 2020 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vDtrylS/RN/X5MfRBvgpYbyAlRSg7CP7eSTbD6n1oCk=;
        b=R8N2yrsi/4FgJn1aT/zEzfuuimbi0iHQMrlYFVxTgxngsQUZrsfpszzkQRCNb3i8Xu
         n/SQc+RlIP+oFXu4KRPFSPlBQKRQhnFpc1vhOvDHvvnKDgFOe1R+veHAjuLrbhhQMspS
         /8dfaqardAtvM+LIcKRTi/WG9MpqYKO8rSZgrkFLwmZYwDDP5mjZpSoDJ8i2bNC6DNUy
         Y/bJDL5I86HA0erTJVjtQmn5Sm2M1wKqSDn3bVg1d70jd5SCHek1UVF2qrfnnb3VatiO
         EAJJnLMYwZ6CypDzSURAuDcmaRRqnwDDon1xhHtcX+14a/F6hCl4T7IGhVdII47GVMbB
         0e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDtrylS/RN/X5MfRBvgpYbyAlRSg7CP7eSTbD6n1oCk=;
        b=dryTVmdYeFx/7GOkO5DDmjmbRGXz4AnjjgsPZ6M5a3rk/CmCslukix54xdUhtul3Tr
         yUmH3Z6USOzqVjO75a0cG9uuRQ/ZndjO7iIz6np+49kI7AP/00sRNz5v7CCHkYa7QPAb
         84sR2ZijNdg+ncZdAMT0AtMXUjWXHyWRedbRNM4qu59+kEVOc/SvdY60YKvOsLZjvpQx
         dOiqErkA2otWZZeMrzsusHdLc+6XZaBlEtR8sWPUgy4X24AiqYS4k7Qe58BUE7VAzdl1
         NS287DMMIJ7tM0SoEZI64CXOn30bIvOH5mi6PRNumzrd9LaLp5LuerGpJV3TaFba78Xv
         r2xg==
X-Gm-Message-State: AOAM53226g2V6WbqwHnPR0kpbvv+56UYm+J3A7elXalimx+ErYKj/gRC
        ZUqWGRVUahIAXqG8aCHFoQ==
X-Google-Smtp-Source: ABdhPJxPwJ9YnepNpAc8VVNUt38pK54xtZo++0IDAYsyFQexI7qLah9BoTxyqh/feu646qJFMxVfeQ==
X-Received: by 2002:a17:90a:a111:: with SMTP id s17mr14271776pjp.28.1603044825029;
        Sun, 18 Oct 2020 11:13:45 -0700 (PDT)
Received: from localhost.localdomain ([161.117.41.183])
        by smtp.gmail.com with ESMTPSA id hi22sm9783054pjb.21.2020.10.18.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 11:13:44 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 1/2] Fonts: Support FONT_EXTRA_WORDS macros for font_6x8
Date:   Sun, 18 Oct 2020 14:12:04 -0400
Message-ID: <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820082137.5907-1-s.hauer@pengutronix.de>
References: <20200820082137.5907-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201018181204.PUKZ1WDsV8ccuOPJ46c_WUj7gg3SmTUMrCROiezsRa8@z>

Recently, in commit 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros
for built-in fonts"), we wrapped each of our built-in data buffers in a
`font_data` structure, in order to use the following macros on them, see
include/linux/font.h:

	#define REFCOUNT(fd)	(((int *)(fd))[-1])
	#define FNTSIZE(fd)	(((int *)(fd))[-2])
	#define FNTCHARCNT(fd)	(((int *)(fd))[-3])
	#define FNTSUM(fd)	(((int *)(fd))[-4])

	#define FONT_EXTRA_WORDS 4

Do the same thing to our new 6x8 font. For built-in fonts, currently we
only use FNTSIZE(). Since this is only a temporary solution for an
out-of-bounds issue in the framebuffer layer (see commit 5af08640795b
("fbcon: Fix global-out-of-bounds read in fbcon_get_font()")), all the
three other fields are intentionally set to zero in order to discourage
using these negative-indexing macros.

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 lib/fonts/font_6x8.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/fonts/font_6x8.c b/lib/fonts/font_6x8.c
index e06447788418..700039a9ceae 100644
--- a/lib/fonts/font_6x8.c
+++ b/lib/fonts/font_6x8.c
@@ -3,8 +3,8 @@
 
 #define FONTDATAMAX 2048
 
-static const unsigned char fontdata_6x8[FONTDATAMAX] = {
-
+static struct font_data fontdata_6x8 = {
+	{ 0, 0, FONTDATAMAX, 0 }, {
 	/* 0 0x00 '^@' */
 	0x00, /* 000000 */
 	0x00, /* 000000 */
@@ -2564,13 +2564,13 @@ static const unsigned char fontdata_6x8[FONTDATAMAX] = {
 	0x00, /* 000000 */
 	0x00, /* 000000 */
 	0x00, /* 000000 */
-};
+} };
 
 const struct font_desc font_6x8 = {
 	.idx	= FONT6x8_IDX,
 	.name	= "6x8",
 	.width	= 6,
 	.height	= 8,
-	.data	= fontdata_6x8,
+	.data	= fontdata_6x8.data,
 	.pref	= 0,
 };
-- 
2.25.1

