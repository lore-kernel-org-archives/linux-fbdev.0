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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFFDC433B4
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 May 2021 11:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419A660FE3
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 May 2021 11:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhEMLoa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 13 May 2021 07:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbhEMLo0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 13 May 2021 07:44:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08BBC061574;
        Thu, 13 May 2021 04:43:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q2so21419525pfh.13;
        Thu, 13 May 2021 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1VuF8QYDuULXzkDfZzy2fYjCpqH9mbnMRRACxdLFrE=;
        b=TcHAG5oowcHzcZI3mZ6g/K6KCH4Z0Hjv7UqYycquOg3rs0MeFZbVCnw6Vr+ddIuGSu
         O2n+75OX5WnDTAjsBeztQEjQLky5rTU4tFtNpWqdDnzBrCla+1xBpNtY6wmGVpao0zs6
         XZFGs7NAr65B7izFpBpgthOCF6EvSDRKDgaqdTgZGDX/TyI1mLNPL3zIJi5ShShfU9S+
         RycAJfSj3unFOB26oPv+GHF3ynwkExSd1I2wDyDHiKzP09WLRXfWWpmx79vcuYvuc7r3
         rqPVOjB0wsd/WIuozpp6FGTdiPYtg9kUqZ7qek6gvyM0soLqj4BQ6NdaePYyoZRiW9CB
         urVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1VuF8QYDuULXzkDfZzy2fYjCpqH9mbnMRRACxdLFrE=;
        b=N7TzuzTwpNBrtTV0xKeCeuuLIL9G3YNl4G5BXgy4nl+FRtlpKe9Emv5ay5zYlcSkB3
         LD8HoL67ScYPiZBF1WNQS1SJFMdOdGcWvQBdukmW6btAX558zX58A2DHDESjiPuwErHo
         s0axRll+XHfnPZDDKdrpdc0pql7ANxiuEOzJrxHLJydFHroogMZCRfun3gR19teGJSbc
         weQdSYd0TlUrK7oQV6x/yZ0kyVPkwu6CSmwbjhul9XOzgVSqy6j9Zgz8TRI2c2+hkrtq
         eneq+Ln7DTZ+3Wq308ZjS2PPX/EFC1/ri+RvwsxTV5n7+LtMqfgSi16pmK/883Ye0410
         bZXw==
X-Gm-Message-State: AOAM532wjofWbZyJmUAnYWnTjeGxHLHcqrLwTyobCR2oVawpdSkJMZ5K
        3QNt3/ND5fiUXNte2epSSEE=
X-Google-Smtp-Source: ABdhPJzxxUnjWpzts/4jkztJsshg+Yh+/d8t7Zesn8LcEpPJsUjbyVJUF5Mo/eZk4k1uN9Od8zNFlg==
X-Received: by 2002:a17:90b:f97:: with SMTP id ft23mr14653681pjb.164.1620906194574;
        Thu, 13 May 2021 04:43:14 -0700 (PDT)
Received: from yguoaz-VirtualBox.hz.ali.com ([106.11.30.42])
        by smtp.googlemail.com with ESMTPSA id f3sm6341949pjo.3.2021.05.13.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 04:43:14 -0700 (PDT)
From:   Yiyuan GUO <yguoaz@gmail.com>
To:     deller@gmx.de
Cc:     geert@linux-m68k.org, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        yguoaz@gmail.com
Subject: [PATCH v2] video/logo: protect against divide by zero when reading image
Date:   Thu, 13 May 2021 19:42:09 +0800
Message-Id: <20210513114209.60457-1-yguoaz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2105121353530.1204552@ramsan.of.borg>
References: <alpine.DEB.2.22.394.2105121353530.1204552@ramsan.of.borg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

In video/logo/pnmtologo.c, the function read_image can read from the
image file an integer 0 and pass it to function get_number255, leading
to a divide by zero problem.

Signed-off-by: Yiyuan GUO <yguoaz@gmail.com>
---
 drivers/video/logo/pnmtologo.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/video/logo/pnmtologo.c b/drivers/video/logo/pnmtologo.c
index 4718d7895..d9e8d1d5b 100644
--- a/drivers/video/logo/pnmtologo.c
+++ b/drivers/video/logo/pnmtologo.c
@@ -116,6 +116,16 @@ static unsigned int get_number(FILE *fp)
     return val;
 }
 
+static unsigned int get_maxval(FILE *fp)
+{
+    unsigned int maxval = get_number(fp);
+
+    if (!maxval)
+	die("%s: invalid maxval zero\n", filename);
+
+    return maxval;
+}
+
 static unsigned int get_number255(FILE *fp, unsigned int maxval)
 {
     unsigned int val = get_number(fp);
@@ -182,7 +192,7 @@ static void read_image(void)
 
 	case '2':
 	    /* Plain PGM */
-	    maxval = get_number(fp);
+	    maxval = get_maxval(fp);
 	    for (i = 0; i < logo_height; i++)
 		for (j = 0; j < logo_width; j++)
 		    logo_data[i][j].red = logo_data[i][j].green =
@@ -191,7 +201,7 @@ static void read_image(void)
 
 	case '3':
 	    /* Plain PPM */
-	    maxval = get_number(fp);
+	    maxval = get_maxval(fp);
 	    for (i = 0; i < logo_height; i++)
 		for (j = 0; j < logo_width; j++) {
 		    logo_data[i][j].red = get_number255(fp, maxval);
-- 
2.25.1

