Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19ABC4361B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A5923122
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgLFTEX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgLFTEW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:04:22 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C497C061A4F
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:08 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id b4so7268680lfo.6
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eLxsg7EkjCm+oZc7/H4MeQJFzAKzFuMyJlMAucG5j6M=;
        b=ILdNiwFfM7J4+SrpF1knMWis/rnjLfkL9BW6opbCU1Tht72uZsNuwawgHaGa/TYKPf
         uzszEFxJDJHoljJLRysYP0ao1o/tHtZZd7QR4kMaCMZXf3naGJ2ARncpPHw0yQRwyPzf
         gg8YpdlAHdUuc6y0g726nvK95UCQgpT78x3PC/fAZgYGseaf/YNQ8p3l1n1VrCf7kEst
         uH81FAX3+vFTNjbGmFRV8NcLQwLM70sDtyAfAlw4toa6bIdQK8MbkzqN4OD8tSDh9Jb0
         UT4vJb9IwDqTlso6A9fQtuUqykaBwOa0H/dlMcgUhOiZDeAkhu6PPjI4W1jeoSJU4E6T
         M4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eLxsg7EkjCm+oZc7/H4MeQJFzAKzFuMyJlMAucG5j6M=;
        b=SBKUWZ7nyT1dZOUnL3Ff+NOz9omVJu/6R0e3FLP99Ct2E7gcegXvQKZ1aepejueJ2i
         SKB81qe9S7LYI0mEkiKKNrCBG4iFOl3LCPFcj2e4irqEdp8JR7Qurecng7id/PMcsBoT
         dO1zL3M16OItB9YKbsfsYxbKZuPA3owt2Eb5i7ZkDUREFtmI0DNabJtxpviWkAlI2+FB
         hP2qX+XE9jCgmRuJyzXoWHchvCiJID6tOebpyfk/G8kPYGOMeOM5Nd6Ri4A3rn7tzq1r
         B4yLgp2Sp4Q0xbP+qBzICj4uRePttEwDFAlpvux2vMlcunNvOeRn6hi9E0I6ewVdBf6h
         Og9g==
X-Gm-Message-State: AOAM53067fXgZiOzs2V9jeigX3so/Crofth3nnP3SY6iAHu7E93Q4+nd
        qVwr0v8qCBm3dGl7nX+zNrTE7GqRx2MzUQ==
X-Google-Smtp-Source: ABdhPJxnM6yBu1jRcx8Og5RErbaxtRURZRQTgDs7BZFG81dlhoGPg5ALRRskqOrkcPkDhwvsIpFv1g==
X-Received: by 2002:a19:23d8:: with SMTP id j207mr4911471lfj.153.1607281386823;
        Sun, 06 Dec 2020 11:03:06 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:06 -0800 (PST)
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
Subject: [PATCH v3 05/13] sh: Fix set but not used warnings with !CONFIG_MMU
Date:   Sun,  6 Dec 2020 20:02:39 +0100
Message-Id: <20201206190247.1861316-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Building fbdev drivers for sh with W=1 produces the following warning:

    tmiofb.c: In function ‘tmiofb_remove’:
    tmiofb.c:805:21: warning: variable ‘par’ set but not used

This is with allmodconfig and ARCH=sh

This boiled down to iounmap() defined as empty for !CONFIG_MMU.
Fix this by by adding "(void)addr;" to tell the compiler the
argument to iounmap() should be considered used.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/sh/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 6d5c6463bc07..5ad56c6c1e1e 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -271,7 +271,7 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 #endif /* CONFIG_HAVE_IOREMAP_PROT */
 
 #else /* CONFIG_MMU */
-#define iounmap(addr)		do { } while (0)
+#define iounmap(addr)		do { (void)addr; } while (0)
 #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
 #endif /* CONFIG_MMU */
 
-- 
2.27.0

