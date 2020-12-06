Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A56BC433FE
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6D32333F
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgLFTE0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLFTE0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:04:26 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E980C061A55
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:16 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l11so14938189lfg.0
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nq89nmYMFAZ5g1yAyMZHjiJetWqkZ/9OgWWUFHRT3b4=;
        b=WGpgX85MCpBc/yupm9apVzhUhe6pthypjQPG+TqhMPGOxcNMlZbUgD+wg1Dz9WkZ52
         vgriXDfWnywMSzvVRm98Or4TXWqplwssuHvJWhqEJlz/RY0tbBcVQYoUNBe1Ci6jflLr
         8gY3anClfRCFGPXzpqZjvmL2R+mgwYrBlDTHfC05x5eTOaodG0nDmLYOfOju5EIxSXn1
         ZfRFbvHkGRzw2FnOdGO64khY4a2egIHyqxk6nkb58s+bIHI2TmpmbDBeP0MachGsWcTV
         4J4WxRLcP6p9CMZds7niw/z1J35TMqzqFMbINUCdLemUADLZ0C8d29H7sgAF/DMu3U8S
         fvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Nq89nmYMFAZ5g1yAyMZHjiJetWqkZ/9OgWWUFHRT3b4=;
        b=ifGEZ4W+0AK5RPYnDhdN6wALQrGL8Vx3uYBc+UOnzwPyeDMmOIkj4wyaOIN/XVT/gq
         n+RFEJUNQRsmK1nI77E0fxt0znFq9fn8FmJeHmch//Fpq7gzG0TZsHWPzTWcuo1goc6t
         +mE4PVsBz5DCV8w+ph8yJh/+QAri1oktUcH8gx5CQQmpBknMujtGjBn5PvxU6/oa0rMk
         3mtMLLLnNSZr6as3p5PDds5wJtP0bxdwsuIEEd7R1/M6BWnMTITyRRv5jd4ZiVHjbi2N
         pyQhNN+pNoXajyfD5Wyor95z+/RrROB5XuUA97HBOed2OlZPqEGdGBHW37DbpQYPtOXg
         V2Rw==
X-Gm-Message-State: AOAM530YK5uH6DIszRPIzta62SwSBE6jNuvjuZD/tGhxU63aZ3pYsQtl
        Fn1uAjlMihz9hmTNWj5GOecXMgOrCe1law==
X-Google-Smtp-Source: ABdhPJzwaADOyAjTA/hARmZgN7KTVo4qobwfMII7N5adWMTLZMzL8lf7NO0ukXa+upxezM5u7zbd4g==
X-Received: by 2002:ac2:4c8e:: with SMTP id d14mr6892427lfl.411.1607281394385;
        Sun, 06 Dec 2020 11:03:14 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:13 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alexander Klimov <grandmaster@al2klimov.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gustavo A R Silva <gustavoars@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rich Felker <dalias@libc.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH v3 10/13] video: fbdev: gbefb: Fix set but not used warning
Date:   Sun,  6 Dec 2020 20:02:44 +0100
Message-Id: <20201206190247.1861316-11-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The variable "x" was set but never used.
Drop the redundant assignments.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/gbefb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 31270a8986e8..c5b99a4861e8 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -198,7 +198,7 @@ static void gbe_reset(void)
 static void gbe_turn_off(void)
 {
 	int i;
-	unsigned int val, x, y, vpixen_off;
+	unsigned int val, y, vpixen_off;
 
 	gbe_turned_on = 0;
 
@@ -249,7 +249,6 @@ static void gbe_turn_off(void)
 
 	for (i = 0; i < 100000; i++) {
 		val = gbe->vt_xy;
-		x = GET_GBE_FIELD(VT_XY, X, val);
 		y = GET_GBE_FIELD(VT_XY, Y, val);
 		if (y < vpixen_off)
 			break;
@@ -260,7 +259,6 @@ static void gbe_turn_off(void)
 		       "gbefb: wait for vpixen_off timed out\n");
 	for (i = 0; i < 10000; i++) {
 		val = gbe->vt_xy;
-		x = GET_GBE_FIELD(VT_XY, X, val);
 		y = GET_GBE_FIELD(VT_XY, Y, val);
 		if (y > vpixen_off)
 			break;
-- 
2.27.0

