Return-Path: <SRS0=wnYw=ED=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CB2C4363A
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 23:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FCB20725
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 23:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmrKOPgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgJ1X4E (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389299AbgJ1Xzw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Oct 2020 19:55:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA17C0613CF;
        Wed, 28 Oct 2020 16:55:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b12so433335plr.4;
        Wed, 28 Oct 2020 16:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnlZYxkwJJLo9grLc9JR4ofLfA3mMxlZOcb0oXJV6X8=;
        b=dmrKOPgjnpuio2WPYe9adMQ5Fu8pVE3k4Wi/w03k/0u6JF+2rd0CiH+0Bioi2yJkcC
         S0deV5TasPlwPkn0cQ4MyyEsBtFUV/qXm3YWEqeGjPMze4Y1UezS34Xjk3nTyRSEmRaB
         4ZPAsRflprWHhwz59G/UPag11Tt5MfNKVvXNQ3Md89Dt+bciLRUmTwNXF710LuduiIj0
         GfAhD+R42h0mpcHdPG1QIdwpalnkLuTvghNpsRVxlJPerJI0ClVKrLxU2mDPYwD5t5Bd
         VI1jYEUq6axZxTzfqZjeCeRHg8AsI51n6n7wbUK0L/rJuJUxviZmt8VM0oQlZB77Dbaf
         ASRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnlZYxkwJJLo9grLc9JR4ofLfA3mMxlZOcb0oXJV6X8=;
        b=a1iLuOcUw/X2Tb7xcp75OxMUl3alzsOPL9sXuEzAsiYbDCxH3+pO1QSJh8VLNy6esC
         Y1VX6vF8kD+gFgn23ov0g+CHwTJYmuZMUX2Alx9D9w5plMGFGSUBBchmd+w3wo/8yEKX
         7ENcjg9AYBbiBQw9IMaD6Dxvqju+7Xr9fKTcklqVYXjt3qHrRYg7uhmL/VFn2q7VIkxV
         XpfsfWOI36wZt82heQHEd0H0EnPxZc9zk87DH9yVQF8Tv4jOFiM0gJm7OouUlfK8R7qC
         heug422PVIO7MVwarEbtB28sOTGkK7qSkNdAyaNbN940N6Ja+jlwbsDMA/XNzSl1iy9f
         roeA==
X-Gm-Message-State: AOAM533K5dT5EHWyaHDPN1ujgk4xqeumoxh5SedHkZXy59D9RH9ERgv6
        +OB68LOHrmzfyjGskxe3o7hURclKojwB
X-Google-Smtp-Source: ABdhPJwN9pWc6SgNrQdHQVoHdTi/4KewCbxwqHjDs5apNgsRBCqiaB/UFtHbcNuOSzCUB8UzBnLflA==
X-Received: by 2002:a17:902:bf43:b029:d6:19b1:7942 with SMTP id u3-20020a170902bf43b02900d619b17942mr5920732pls.61.1603865166424;
        Tue, 27 Oct 2020 23:06:06 -0700 (PDT)
Received: from localhost.localdomain (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id o22sm4021658pgb.83.2020.10.27.23.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 23:06:05 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 3/5 v2] Fonts: Add charcount field to font_desc
Date:   Wed, 28 Oct 2020 02:05:33 -0400
Message-Id: <20201028060533.1206307-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6c28279a10dbe7a7e5ac3e3a8dd7c67f8d63a9f2.1603788512.git.yepeilin.cs@gmail.com>
References: <6c28279a10dbe7a7e5ac3e3a8dd7c67f8d63a9f2.1603788512.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Subsystems are assuming the number of characters of our built-in fonts.
Include that information in our kernel font descriptor, `struct
font_desc`.

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
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
index b5b312c19e46..54e60ad2252b 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -17,6 +17,7 @@ struct font_desc {
     int idx;
     const char *name;
     int width, height;
+    unsigned int charcount;
     const void *data;
     int pref;
 };
diff --git a/lib/fonts/font_10x18.c b/lib/fonts/font_10x18.c
index 0e2deac97da0..4096c6562494 100644
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
index 87da8acd07db..32786674cf65 100644
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
index 5e975dfa10a5..81e4a3aed44a 100644
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
index 700039a9ceae..5618ae7ef9fa 100644
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
index 86d298f38505..7708e73d491f 100644
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
index 37cedd36ca5e..74125d3570cf 100644
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
index 8ab695538395..96da4bb31ae4 100644
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
index 069b3e80c434..ba74053fec7b 100644
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
index 1449876c6a27..637708e8c67e 100644
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
index 32d65551e7ed..06cde43c7bd2 100644
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
index 641a6b4dca42..d0290d79df2c 100644
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
index 193fe6d988e0..7d83760354a6 100644
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
index 91b9c283bd9c..a2cc25b9f8e3 100644
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

