Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A6C2BB3F
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E71E2310B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgLFTEg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgLFTEg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:04:36 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D5C061A56
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:17 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id w13so2185765lfd.5
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/SfLL6p8Oi2QG40QnuZputxs/YKRkVGSLvwvUqAWetc=;
        b=dzhegX2f5Ql3PjQBuil9z4sEYgr3337KW2qQckQ6pQGqbvHHs3CVckmYm5Un20ZhkN
         wdkTRTeoGd4YUyQFFb9U0U8n93rtfAEylUq//N9tgc51Uj0heyF4pNIBSnYX3+NsBMg3
         VlU4KJFbgS+nYglZ1sGrjauXI4h68vGNSOgCJRgtnTxfmkIhYAinfPZNDvHX3dZZVEpJ
         D8Uhz593GGEn0bnW/ZX+fvM/7cLfUcJ5KPkfia0Y4F+7Jzk8Drd3lORKZBfzTHoV+FZS
         vBppZ4WLbjFRLdfxltCmYT0j7Y1+AMNgraJP+91Ox1B9CubxR0yjYf9zDFUhIyR8iYzU
         sulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/SfLL6p8Oi2QG40QnuZputxs/YKRkVGSLvwvUqAWetc=;
        b=qbjuPUrG/AEwVxm82nAidkinMSql6dBFg7gPPdUA0Hrsryb1l9NTCQg/V0IlONyOZd
         2RwU/oARZJKtJyZuxJTmbw8LIGnsNre7lm4zkx2SlS10iLj5PhCNRjMOF0rcG4+3GYLX
         VZyTJVOm/MCIS+8M7y40Lt35cFqsXqKMc1ohVlXzj7FllItU5YZ9o3wZww34Rk0g52Hs
         Gopgner+6k5UF6GxubmU38esgRr0JnRXsGJxMiPAlgzmRuwwLSiXUfsr0j9pEMz7RU4Y
         /aYZN5usvH4piGHYAGogtjdNLErvGIX4bwqUmcATdMp1mq6DaSApsc+bXSTXaFnHSLDc
         RsPQ==
X-Gm-Message-State: AOAM532vydpoj4FOJv4evKT+X3/YTyVFGmsZe9tuUODqX4TitjpSuREU
        +8aPzIsfW5Bi/teXDCzl1wfrLm7t5nTo6g==
X-Google-Smtp-Source: ABdhPJwxko1cTuuCkRnEsGsx7KovNmq7vPKRcW8CEJXVJu5saQZRJ120DnppqSpeigQFs93cZ9Bi5g==
X-Received: by 2002:ac2:46f3:: with SMTP id q19mr7197990lfo.76.1607281396030;
        Sun, 06 Dec 2020 11:03:16 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:15 -0800 (PST)
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
Subject: [PATCH v3 11/13] video: fbdev: efifb: Fix set but not used warning for screen_pitch
Date:   Sun,  6 Dec 2020 20:02:45 +0100
Message-Id: <20201206190247.1861316-12-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

screen_pitch was asssigned a value which was never used.
Drop it to fix the warning

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/efifb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index e57c00824965..b80ba3d2a9b8 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -139,7 +139,7 @@ static bool efifb_bgrt_sanity_check(struct screen_info *si, u32 bmp_width)
 
 static void efifb_show_boot_graphics(struct fb_info *info)
 {
-	u32 bmp_width, bmp_height, bmp_pitch, screen_pitch, dst_x, y, src_y;
+	u32 bmp_width, bmp_height, bmp_pitch, dst_x, y, src_y;
 	struct screen_info *si = &screen_info;
 	struct bmp_file_header *file_header;
 	struct bmp_dib_header *dib_header;
@@ -193,7 +193,6 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 	bmp_width = dib_header->width;
 	bmp_height = abs(dib_header->height);
 	bmp_pitch = round_up(3 * bmp_width, 4);
-	screen_pitch = si->lfb_linelength;
 
 	if ((file_header->bitmap_offset + bmp_pitch * bmp_height) >
 				bgrt_image_size)
-- 
2.27.0

