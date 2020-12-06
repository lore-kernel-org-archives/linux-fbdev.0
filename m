Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74739C1B0D9
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392402310B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgLFTEa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgLFTEa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:04:30 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58129C08C5F2
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:19 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id x23so5656132lji.7
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXUs3Mthn2WNxe9bljzB5KJJxtMgTykEfGBU86F6xiE=;
        b=Q4dR21nP1jZzsA/PsBN5qV0FqAKg4TkCjUyfsDCiyitQByJY5pO5fmgCAt3HViK+Vu
         XRUL2l0cD9wsZRjDwcbB0ZkNdr2Ir8Z7fcIEcrCiLQ53YeGHkSqqOUbj4eNSOg27SQ2e
         VuiJFCYExB03CZXF1PU6lkLv//+TmUU088Jb20M90SzVM9CX147uj+6nsdoHGclTz2ug
         h7Enp9lKWI4SeKqcS7nXNJbi6m28/YpB2nLY/XwFy9XMEryms6GgsPuePANX6hSoCvmW
         db092ppYA0YCdY9Z8mQQsgWKkITED7TNoaGGzceIxon6WPvVxvSHD/htfnVZo8eKukOP
         QYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sXUs3Mthn2WNxe9bljzB5KJJxtMgTykEfGBU86F6xiE=;
        b=I2aruokWXu5jzT/515+vDqvY7XsPYVHHEgntazDCobUXikiCP7UrciIAJ3XcyFwE6Q
         dbj8ekfwF3X4ee7oE2v8ZRs/Mx/ILQfQzNYS2JEcNfIQkTraI5kKoSDuJfVIP/RBUgUT
         ps78HIpZFHm6k92/gquuUmA2RRyDQm6z06gXMYa/6W/innhsZ7dtIU8vcOmk/qGo7DdM
         LqF1+A21yyubpeNMK5LZddJnv4BRanL5WrKrsH6ljuCfrOgGsC/AFmXTr2BvftADNIu5
         VFo5cfRJikJdMDQp9AgMWjp7dgDhPFPY6UQ8B1rnxkXcilj4r4uIvsEKvUlI3aP6petd
         iNHA==
X-Gm-Message-State: AOAM531ETIOLINTs0I7bnRqIXi+vUFbVl2Ht5N6IuWeFHpmv1dQ4NfzG
        WTNfPBCOTEpCk++kGjxgR0s8L0XBtC2HAQ==
X-Google-Smtp-Source: ABdhPJzb0KQuWgqAs1QxpFLIbzjo0hp3iVTcDNFOfPyUb7EI83W2N6g7hHXWSCKUuYPdd+iJRhnYvw==
X-Received: by 2002:a05:651c:10d4:: with SMTP id l20mr6957942ljn.389.1607281397682;
        Sun, 06 Dec 2020 11:03:17 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:17 -0800 (PST)
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
Subject: [PATCH v3 12/13] video: fbdev: controlfb: Fix set but not used warnings
Date:   Sun,  6 Dec 2020 20:02:46 +0100
Message-Id: <20201206190247.1861316-13-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The controlfb driver has a number of dummy defines for IO operations.
They were introduced in commit a07a63b0e24d
("video: fbdev: controlfb: add COMPILE_TEST support").

The write variants did not use their value parameter in the
dummy versions, resulting in set but not used warnings.
Fix this by adding "(void)val" to silence the compiler.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/video/fbdev/controlfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 2df56bd303d2..509311471d51 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -64,9 +64,9 @@
 #undef in_le32
 #undef out_le32
 #define in_8(addr)		0
-#define out_8(addr, val)
+#define out_8(addr, val)	(void)(val)
 #define in_le32(addr)		0
-#define out_le32(addr, val)
+#define out_le32(addr, val)	(void)(val)
 #define pgprot_cached_wthru(prot) (prot)
 #else
 static void invalid_vram_cache(void __force *addr)
-- 
2.27.0

