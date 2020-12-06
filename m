Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301C4C19425
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CF92310B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLFTE3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLFTE2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:04:28 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB92C061A51
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:10 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id t22so12714116ljk.0
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4gGS7Km1zSYBw+OXt/rDintJ7WruXibpnRy/u4JXrI=;
        b=fBHDvYnIKyIRCluPZ7LsGvsmKUja4Il5k9Lf5O94usbRxBlR9tUbQ/bj7xs4Y55UDC
         PvZeuekZWwvbTIMp7AawS+pSAp+ZlvIcgscgg/WgcNch+3jmT4atQ1sTtGh6eV//VdQB
         ziLw++ePlEDVRPd8H0hEwR7irC/O2fqf7kXXXWFZvuuQnY2bzSnOaVyUfNwpUyOj8Iqm
         nJ8z2q2Zuhmvpjd6gL6oWRhwHsGqYN87Ci/JK4r1qXZ+TSl8JyNdJhiZWkeMLxKzGFla
         OtxWhtPzX1VbXj5zHIYjAkGYtm6WPHDpzB7BWdPo73FcGGw52BdocCqVRBON+ZHBAwhM
         PDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=A4gGS7Km1zSYBw+OXt/rDintJ7WruXibpnRy/u4JXrI=;
        b=N73MqG8hESTLOajy72GK/k43qe8Jd+ImOH4KyMVlyDTvv4oFm8WLiPSA5ghLfk0mUg
         kBg5+ZKZFSqqX6kAdwIGjmFfqbIKTdJSs7678wJo3mrA5VT9gqQklx9VG+g6kSN20XFa
         A5qcZwpCw4q+m7HdOCsDGhiom2xTJ5v8ZlEILgZpJE+j8PgBWTokE6UhLednR+91/EAY
         9FrUQ56s5yu1pBYvA7U6TMiN2ZSiLb5uXTCWARW9RhmN8g/cTsDBERByiBB485XGywAf
         ih0buFfSvym3gyq7tkJ4aMk3v//CmCPu7x+n9HZVXCwhuQJnYvw7eboNhAXHrRUMsgUd
         JvJg==
X-Gm-Message-State: AOAM532EgFTRf2XTzhiRfzwzdPdYuCrw31l085bXmSF5IVxNjvQQjDCt
        Q6JYSadS+tujzJ1SgBI0RBYIZbL6qEmDig==
X-Google-Smtp-Source: ABdhPJwCMgEC3zvaWm+zhlV8Koc6bx4J+FYHGrzJzPNlmyIbiTwpIPLsURBYMA9deDpFJaDtgElnrw==
X-Received: by 2002:a2e:9710:: with SMTP id r16mr6994169lji.462.1607281388344;
        Sun, 06 Dec 2020 11:03:08 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:07 -0800 (PST)
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
Subject: [PATCH v3 06/13] video: fbdev: sparc drivers: fix kernel-doc warnings for blank_mode
Date:   Sun,  6 Dec 2020 20:02:40 +0100
Message-Id: <20201206190247.1861316-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix kernel-doc warnings caused by a wrong parameter name
blank_mode => blank

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/bw2.c   | 2 +-
 drivers/video/fbdev/cg3.c   | 2 +-
 drivers/video/fbdev/cg6.c   | 2 +-
 drivers/video/fbdev/ffb.c   | 2 +-
 drivers/video/fbdev/leo.c   | 2 +-
 drivers/video/fbdev/p9100.c | 2 +-
 drivers/video/fbdev/tcx.c   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/bw2.c b/drivers/video/fbdev/bw2.c
index 0d9a6bb57a09..e7702fe1fe7d 100644
--- a/drivers/video/fbdev/bw2.c
+++ b/drivers/video/fbdev/bw2.c
@@ -116,7 +116,7 @@ struct bw2_par {
 
 /**
  *      bw2_blank - Optional function.  Blanks the display.
- *      @blank_mode: the blank mode we want.
+ *      @blank: the blank mode we want.
  *      @info: frame buffer structure that represents a single frame buffer
  */
 static int
diff --git a/drivers/video/fbdev/cg3.c b/drivers/video/fbdev/cg3.c
index 77f6470ce665..bdcc3f6ab666 100644
--- a/drivers/video/fbdev/cg3.c
+++ b/drivers/video/fbdev/cg3.c
@@ -179,7 +179,7 @@ static int cg3_setcolreg(unsigned regno,
 
 /**
  *      cg3_blank - Optional function.  Blanks the display.
- *      @blank_mode: the blank mode we want.
+ *      @blank: the blank mode we want.
  *      @info: frame buffer structure that represents a single frame buffer
  */
 static int cg3_blank(int blank, struct fb_info *info)
diff --git a/drivers/video/fbdev/cg6.c b/drivers/video/fbdev/cg6.c
index a1c68cd48d7e..97ef43c25974 100644
--- a/drivers/video/fbdev/cg6.c
+++ b/drivers/video/fbdev/cg6.c
@@ -511,7 +511,7 @@ static int cg6_setcolreg(unsigned regno,
 /**
  *	cg6_blank - Blanks the display.
  *
- *	@blank_mode: the blank mode we want.
+ *	@blank: the blank mode we want.
  *	@info: frame buffer structure that represents a single frame buffer
  */
 static int cg6_blank(int blank, struct fb_info *info)
diff --git a/drivers/video/fbdev/ffb.c b/drivers/video/fbdev/ffb.c
index 948b73184433..b3d580e57221 100644
--- a/drivers/video/fbdev/ffb.c
+++ b/drivers/video/fbdev/ffb.c
@@ -667,7 +667,7 @@ static int ffb_setcolreg(unsigned regno,
 
 /**
  *	ffb_blank - Optional function.  Blanks the display.
- *	@blank_mode: the blank mode we want.
+ *	@blank: the blank mode we want.
  *	@info: frame buffer structure that represents a single frame buffer
  */
 static int ffb_blank(int blank, struct fb_info *info)
diff --git a/drivers/video/fbdev/leo.c b/drivers/video/fbdev/leo.c
index 40b11cce0ad6..3eb0f3583f4f 100644
--- a/drivers/video/fbdev/leo.c
+++ b/drivers/video/fbdev/leo.c
@@ -308,7 +308,7 @@ static int leo_setcolreg(unsigned regno,
 
 /**
  *      leo_blank - Optional function.  Blanks the display.
- *      @blank_mode: the blank mode we want.
+ *      @blank: the blank mode we want.
  *      @info: frame buffer structure that represents a single frame buffer
  */
 static int leo_blank(int blank, struct fb_info *info)
diff --git a/drivers/video/fbdev/p9100.c b/drivers/video/fbdev/p9100.c
index 6da672e92643..4e88a0a195ad 100644
--- a/drivers/video/fbdev/p9100.c
+++ b/drivers/video/fbdev/p9100.c
@@ -175,7 +175,7 @@ static int p9100_setcolreg(unsigned regno,
 
 /**
  *      p9100_blank - Optional function.  Blanks the display.
- *      @blank_mode: the blank mode we want.
+ *      @blank: the blank mode we want.
  *      @info: frame buffer structure that represents a single frame buffer
  */
 static int
diff --git a/drivers/video/fbdev/tcx.c b/drivers/video/fbdev/tcx.c
index 34b2e5b6e84a..1638a40fed22 100644
--- a/drivers/video/fbdev/tcx.c
+++ b/drivers/video/fbdev/tcx.c
@@ -196,7 +196,7 @@ static int tcx_setcolreg(unsigned regno,
 
 /**
  *      tcx_blank - Optional function.  Blanks the display.
- *      @blank_mode: the blank mode we want.
+ *      @blank: the blank mode we want.
  *      @info: frame buffer structure that represents a single frame buffer
  */
 static int
-- 
2.27.0

