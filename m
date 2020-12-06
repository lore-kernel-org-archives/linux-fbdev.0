Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CCDC1B0D8
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5CC2333D
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgLFTDy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLFTDx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:03:53 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF0C0613D4
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:07 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d20so14848851lfe.11
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOGcGZuV1pDdyacp1Yj7CCfxSkcEGtk2M7nbhP+rzwQ=;
        b=W4gYsSCFlMC3r/LTQSkwP0qTVDk1kJpWLdduH1jLyAqllGVDMYSQtNHD4blw1N+er2
         BugriDhBiTiR7o1RzujF9NtuuU75bkJ/e1zB98RoTOdqONoDAQjpknt9NtEy0ztGO+Z/
         y0S6SzoEbDhGl5nvhjjQi380hT99I/TFRGMDxK0NV7z8+vp1An2ttsBS7tU/dEoHTVJe
         ImwLOV15MWtZB1Vd6wFU7zHTj1P+UjwUUsxnpSrsz3wDH96Uy4CQSzco7ZyQGkY9zI1F
         qPX/ubbUWILv3tp4AgxnyahY1Y7CDdN1qyjxUQFsTF7qKlWJ4Mup+ExozfOVk0FioVe8
         odMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UOGcGZuV1pDdyacp1Yj7CCfxSkcEGtk2M7nbhP+rzwQ=;
        b=YhquvzMFecZlvHTBmDThRna2pq4bSgRRi2erXIi6IqXgnZt+Jh9708sqMT2L1JYUih
         jP1Q5PWZ6v06AzKQ5NAX0XWZTFDkweMKhtJC6AtPY3GxfQwzpRY9xN4GjH1Mv7YeikDk
         vtpZl9iE9xbUVy1gaIP9RT7ccUryU4TbqpXXXbZPE6AAJhNbW3wd6eT/8raZM4V3qOzC
         U7IOcaT1hGq3gJeN4OAYCbRnNBvFsNuWOKTFCXU9i2w1dpW/vTNFOwUnE/1UQUOiWClH
         tCv7yqd3eYdmxrXMJSmkBO/ROVHmJ2MlbrWlM36DCZyxhjOr4BkuxPV0ue1d7lqJwmaN
         aVRA==
X-Gm-Message-State: AOAM533zBxFsKIWE0GZfVXAlVZkoWoIR0Rwp2gzpTfb/rXxkTP1poTXz
        O/DweS5zXu9MJ89kJ1BA2hEx0JP0l6GpSg==
X-Google-Smtp-Source: ABdhPJxsIP6M5qtkKkVSQDTL6GRkXd2Urg3bP3B6nC0o/in7udaqrBXvv8Nl+MDjf6py3v0d86tqOg==
X-Received: by 2002:a05:6512:78f:: with SMTP id x15mr7093698lfr.370.1607281385343;
        Sun, 06 Dec 2020 11:03:05 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:04 -0800 (PST)
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
        Tony Prisk <linux@prisktech.co.nz>,
        Michal Januszewski <spock@gentoo.org>
Subject: [PATCH v3 04/13] video: fbdev: uvesafb: Fix set but not used warning
Date:   Sun,  6 Dec 2020 20:02:38 +0100
Message-Id: <20201206190247.1861316-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warning by deleting unused local variable.

v2:
  - Updated subject (Lee)

v3:
  - Return early in case of an error (Thomas)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/uvesafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 6c9cfab39313..4df6772802d7 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -560,6 +560,8 @@ static int uvesafb_vbe_getpmi(struct uvesafb_ktask *task,
 	task->t.regs.eax = 0x4f0a;
 	task->t.regs.ebx = 0x0;
 	err = uvesafb_exec(task);
+	if (err)
+		return err;
 
 	if ((task->t.regs.eax & 0xffff) != 0x4f || task->t.regs.es < 0xc000) {
 		par->pmi_setpal = par->ypan = 0;
-- 
2.27.0

