Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C0C433FE
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600D82310B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgLFTDm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLFTDm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:03:42 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7C0C0613D1
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:02 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o24so12679554ljj.6
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awoxLOM24BlPDDqXjccUiIDJsTqNec5B33IQuldBAcA=;
        b=P5PNaFqQt3Yi6PZWkmUYqAJgQuDA/89Ks30XOudshL9zK381d4NWbc1uodB//UHAfc
         HTvn64yb6lGi9hcQh9QITUkTv7+fUOaS7TKiKVbVSuKdPrxFND1N3fXGyyEw7nKng+7s
         +mf+kOMFsoBz/AElgTQboTbNhPzEgGAzuHyrT8cJ0S0zxOqEFPBXjUl8emTYeZu97F4A
         laCvoGTSEqnMc08Y40jy5iVbAC86aMm8Xs54zO1wU4rnMsFRsk8/eUiYNxBqfyzpYpiT
         vYJe6IToXWhfEKlCngFRlpJcolu6GUdOlepGDbYPvysd6DwHh3Fr467MliJ9uYaqKsVQ
         P54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=awoxLOM24BlPDDqXjccUiIDJsTqNec5B33IQuldBAcA=;
        b=jQwnvWZFDqbVY2DFeFhFbdxkRjdF8piaXH6uBKivSipud/hWFLSl/FrxvyBQGj2I5v
         MiyeRW0UByPaTqh9wpjRRBwsblzfoR+92z0qDCi3F5SN9hOj78n1mth11fqbTuhpvfKi
         +bVZMF5lPfxBEqmrXE0FjxYCgZXVhCvqWuMugc9P+1Bcc2RlByzFedXruXAdnAj/gOFh
         DSLQR2vlohLMpWba08QufNpYnUgbCpqNe9D1hFlsHeH7sdIeBZ70AihYAL07zwiO9m+K
         U5uTgZWcquJrBETcg5l5SEcZSkAGC0T0vln+9NAqnsrctIU+YUZTQvIc3tXeLGGji9hL
         zBHw==
X-Gm-Message-State: AOAM532atqcvwJLEZvuwX3FHxzEM/Z23d9ooZ6KdjtCNTqVNG9M6QmWM
        xEg3BvcMt+R4BT7iR9xjUCmea/LTzRHlmA==
X-Google-Smtp-Source: ABdhPJwFKM/Zl7jOyF45tkIXB6X8zzxGd1xx4NWx6nsFo3s5UcMXstc7DIYYaoWF/J47Mjh04zw6vw==
X-Received: by 2002:a2e:a40e:: with SMTP id p14mr4886244ljn.63.1607281380392;
        Sun, 06 Dec 2020 11:03:00 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:02:59 -0800 (PST)
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
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        linux-nvidia@lists.surfsouth.com
Subject: [PATCH v3 01/13] video: fbdev: hgafb: Fix kernel-doc warnings
Date:   Sun,  6 Dec 2020 20:02:35 +0100
Message-Id: <20201206190247.1861316-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix kernel-doc comments.

v2:
  - Updated subject (Lee)

v3:
  - Add space after ':' (Randy)
  - Fix name of function in comment

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
Cc: linux-nvidia@lists.surfsouth.com
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/hgafb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index a45fcff1461f..8bbac7182ad3 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -357,8 +357,8 @@ static int hga_card_detect(void)
 
 /**
  *	hgafb_open - open the framebuffer device
- *	@info:pointer to fb_info object containing info for current hga board
- *	@int:open by console system or userland.
+ *	@info: pointer to fb_info object containing info for current hga board
+ *	@init: open by console system or userland.
  */
 
 static int hgafb_open(struct fb_info *info, int init)
@@ -370,9 +370,9 @@ static int hgafb_open(struct fb_info *info, int init)
 }
 
 /**
- *	hgafb_open - open the framebuffer device
- *	@info:pointer to fb_info object containing info for current hga board
- *	@int:open by console system or userland.
+ *	hgafb_release - open the framebuffer device
+ *	@info: pointer to fb_info object containing info for current hga board
+ *	@init: open by console system or userland.
  */
 
 static int hgafb_release(struct fb_info *info, int init)
-- 
2.27.0

