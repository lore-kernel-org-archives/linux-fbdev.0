Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9CEC197BF
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3BB2310E
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLFTE3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgLFTE3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:04:29 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F36BC061A53
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:13 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so12712701ljk.1
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YJ8hNiC7fcBnhr6W4yRKfHMapnKQoLUJY6svzs3To0=;
        b=LaLHUm1Z4gGqnGZ3KZ7SHqaALYkoq/yZxYDzkQbZYV0PMY0w52MBCPt//V8+5dKQSB
         g+UgMgIcXOB/tO/E/S/ZOeqmDZyduyPkSz6vCyBp1j0j0R/blDyXa5ncboNUSyWNMmMF
         7z4bu82pAwrOMfKemks/fqOWwajOskvq7e+ffV9CjCxa+f0cR7uOpNMx1E+RO/dH8/pA
         8ku81TvvuYNVjpeSAv5GkdkAwNrotvjHD2EbOid95GXlW7DZFpHvs5+mNU86MN3GadvI
         RKAzjz2ik6cq7BN/9mn2RHD6G9PdUsn7mATzpH4xmVpu2xIiZ3Uf98S7duMImpKVvfVl
         +15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9YJ8hNiC7fcBnhr6W4yRKfHMapnKQoLUJY6svzs3To0=;
        b=OplR5t5/Fro9OT3+vK2IjUikfsmXDN+CxDGm01+UhNk5jvwi3FUE43i9yk83H3iFnt
         bVdhZ/J52IdifGqUw9+YCGdrd6L6efWidkoIFcXOM8yhG27ywEH7E4kEPS3AuhQukpb2
         j69BHcGNziZ9MJearzFEUWSr6kOZOP9UxHJ1Uyk+Z2VwiO+k7QXaCHHPJnEnw007D+k8
         /CdfTRqoq4kpUDUVgo5OSFAZ3MljsEUTIynQurvs9SZI/YCFzIaWdxNoJxsDQEv4ozyB
         Lce0pDugNQYbVWC8LFOU4x2fK6ozlWJj757+NzpaQQrEQaeyS/y5UZDR6ziN/xhpXKuJ
         DnzA==
X-Gm-Message-State: AOAM533XRKE8vqA8Zy9qqJqgOhuUfHkic+XQ3gWEe3/KtDf0BBCpMBEC
        y9RkECx3EkuClDv0DjUOrGGCqdeHV5lzfA==
X-Google-Smtp-Source: ABdhPJziPsnplTe7NiMrRGdNc3o7SXo2FpWEV9XqodakF7dSDg151GPsQjMackM7Ag3jGTKj591jlg==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr7761708ljk.439.1607281391398;
        Sun, 06 Dec 2020 11:03:11 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:10 -0800 (PST)
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
Subject: [PATCH v3 08/13] video: fbdev: wmt_ge_rops: Fix function not declared warnings
Date:   Sun,  6 Dec 2020 20:02:42 +0100
Message-Id: <20201206190247.1861316-9-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Include own header to fix "function not declared" warnings.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/video/fbdev/wmt_ge_rops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/wmt_ge_rops.c b/drivers/video/fbdev/wmt_ge_rops.c
index 2445cfe617a9..42255d27a1db 100644
--- a/drivers/video/fbdev/wmt_ge_rops.c
+++ b/drivers/video/fbdev/wmt_ge_rops.c
@@ -11,6 +11,7 @@
 #include <linux/fb.h>
 #include <linux/platform_device.h>
 #include "core/fb_draw.h"
+#include "wmt_ge_rops.h"
 
 #define GE_COMMAND_OFF		0x00
 #define GE_DEPTH_OFF		0x04
-- 
2.27.0

