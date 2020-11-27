Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5236C63798
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B61D22245
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrtZdKGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgK1Bh2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947EC061A56
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:15 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 142so7095055ljj.10
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZVUjqZPvk9JmE5Zg9zhFjt8GTdbfi/4bsMjlewJUWk=;
        b=XrtZdKGu5/hNrxeMcY7JQje+7wV52fu30Ck/RUr5wsZpyQJcANFJZ39N0KWddETdEX
         fOPkmhKTz1DW+fwvSOBvpDKgWwNZ91XoVSfOPIDK33hQY0hcdC9JHsjlQdYjok5aakxe
         1lDcFQ05uuljUZIeMgpbYUPatcYhMAqNE6jakOSRD6eCrf/VCMhQPcWqVxtIQEk6WaS7
         /EuO9akDGzU266dv9OuffMUYSiox7QhVCEhyN3qTkL+CAKWNhEeQKfxGHd6uqH2Hz+EP
         T4PIJQr2oREk9yV+SGzpgGoKrWxRkM5vR9tVIniIgYrgPTHJ8/gR4vcb+WJm7nPWuFIT
         Jk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bZVUjqZPvk9JmE5Zg9zhFjt8GTdbfi/4bsMjlewJUWk=;
        b=BLWQKacQfxayCXiZmstOvozXYaSaljYXmE8ma3i/+HsxwLSSA/H6OotEZ72p6P/44S
         IN42H9o0MyOwJ6VTdzZQi1GL/+GEbJL4Oj10jne4+icqXpPRDkKPJDkqqlHO+eam4KHq
         aQ0We3E5RkQAV4xqpkNDxajV4zCkhXe2sjP7jRU+oSotsU+Niz2rQ/8oqLxHwwggurSu
         07ZJvlxq4eFSqoAqJJLDJJicuI1ivasZ21/TDC1nJ6M6iLIE7tXdYdj+44mqHEz7+FF8
         x6fFZAPw21IjGYHYovTZG3wk408HQqeiUL8y4EDkeLez0yVRtTIB5SGDwk0o+/mqzs1c
         wqkw==
X-Gm-Message-State: AOAM532quIdkILaIs/6YAT1+ixlG+JZcSemBr/B6tYuXOij2nTGYmivP
        JYKlFlbhixkjPhqD33QgY8PlG3yEyPze/G7O
X-Google-Smtp-Source: ABdhPJzIf2J8nBqop7fmYzkcGAkj+y2xNYn0qrO6QCTJJblj1YqU+JBYf2vFEz2ZVBbbWeDXxgiKVw==
X-Received: by 2002:a2e:9510:: with SMTP id f16mr4618994ljh.408.1606507153729;
        Fri, 27 Nov 2020 11:59:13 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:13 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 15/28] video: fbdev: neofb: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:12 +0100
Message-Id: <20201127195825.858960-16-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnigns by removing unused code

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Evgeny Novikov <novikov@ispras.ru>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>
---
 drivers/video/fbdev/neofb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index 09a20d4ab35f..c0f4f402da3f 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -1843,7 +1843,6 @@ static int neo_init_hw(struct fb_info *info)
 	struct neofb_par *par = info->par;
 	int videoRam = 896;
 	int maxClock = 65000;
-	int CursorMem = 1024;
 	int CursorOff = 0x100;
 
 	DBG("neo_init_hw");
@@ -1895,19 +1894,16 @@ static int neo_init_hw(struct fb_info *info)
 	case FB_ACCEL_NEOMAGIC_NM2070:
 	case FB_ACCEL_NEOMAGIC_NM2090:
 	case FB_ACCEL_NEOMAGIC_NM2093:
-		CursorMem = 2048;
 		CursorOff = 0x100;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2097:
 	case FB_ACCEL_NEOMAGIC_NM2160:
-		CursorMem = 1024;
 		CursorOff = 0x100;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2200:
 	case FB_ACCEL_NEOMAGIC_NM2230:
 	case FB_ACCEL_NEOMAGIC_NM2360:
 	case FB_ACCEL_NEOMAGIC_NM2380:
-		CursorMem = 1024;
 		CursorOff = 0x1000;
 
 		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
-- 
2.27.0

