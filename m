Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE59C4167B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F6C2310B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgLFTEX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLFTEX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:04:23 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347CC061A52
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:11 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t22so12714155ljk.0
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2c8TosX3R/8fyI6+6hbgfajIYltmGAIh3MuAuO3wgI=;
        b=U8MIJ/hnXOrYJTIg5Ty/f9FVT3L8hXf/9YHCObVYWGeyhdDQDyxfUUfBTi+qMkjNEI
         OMTiD6lSuOFYPNUnRzv6kA7UjQTaO5R1tVf6tctjhXhObK4IjjAtiEGPkrtqtNGah3nx
         nit27kclFdW4q+r77Bc9rijfIQBZtU5/yCmxzGAgRBcPA3t3+UWy66kO9NBJ5Q9rom9c
         F+4stSsq2cJzJbR0dNnOEg9WjpJaFvIHHjP3HnUYTVhyHN/D3V/IfR+HiQx9MvNzhWo0
         0QT235RW3/8/oKvO+K8TPKJ7Mrf0FvPUvccFrTjNsdZrFNBYUR+L5iTkIBrehcYMBsgv
         8JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Q2c8TosX3R/8fyI6+6hbgfajIYltmGAIh3MuAuO3wgI=;
        b=Y1YpRXSkqpJmAzfwkEU+i4Ao9u9phv4FoCzQAcBMWP1t1UV4qbVtLBBy9a3tcyKfdq
         r/YOWgmuj0kXKAAwPupm92SAy3WOma6NbqLa8iJxbiBXLC8gN8MNAhWRsttVd8aKSqkN
         59ai9MlzTpMC0FGNdUzXCeTlg0moChcPkoU/XRL73xlwaqMxF56hrnsHIiS0JD2UNXck
         zWzvLrRebZdc/NS3el/zeslNqvQha5haOpdjj9QpFNPrHRM9Sqxg+LgHlXFfO1efmoKY
         0B2edXhHz72MeoTLkm+B7Vhal/x/raRxMQ8QtaBrPsGP2IWbUZPE2B/Z4rmaybzizZZT
         NEmA==
X-Gm-Message-State: AOAM532+oFMi+iTEhE++LeiPrbzMmSUBtdpS/BeECD8xaMoUbz91bHPJ
        ph2Ryd3MWUQ4B0NYyL7l2TztbiOl8/1btQ==
X-Google-Smtp-Source: ABdhPJwh2HgCsQBPCpyq5dqu0dPDQ9AeMbjlOSyw3cv3zGiXAtMUTvcVRxOeuj+jvb/oXUKuQwIJMw==
X-Received: by 2002:a2e:3c15:: with SMTP id j21mr7596976lja.440.1607281389929;
        Sun, 06 Dec 2020 11:03:09 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:09 -0800 (PST)
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
Subject: [PATCH v3 07/13] video: fbdev: mmp: Fix kernel-doc warning for lcd_spi_write
Date:   Sun,  6 Dec 2020 20:02:41 +0100
Message-Id: <20201206190247.1861316-8-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add missing parameter and drop parameter that is not present

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/mmp/hw/mmp_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_spi.c b/drivers/video/fbdev/mmp/hw/mmp_spi.c
index 1911a47769b6..16401eb95c6c 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
@@ -17,8 +17,8 @@
 
 /**
  * spi_write - write command to the SPI port
+ * @spi:  the SPI device.
  * @data: can be 8/16/32-bit, MSB justified data to write.
- * @len:  data length.
  *
  * Wait bus transfer complete IRQ.
  * The caller is expected to perform the necessary locking.
-- 
2.27.0

