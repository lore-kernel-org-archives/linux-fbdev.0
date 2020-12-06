Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE59C19425
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921CD23123
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgLFTDq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgLFTDp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:03:45 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C127C0613D3
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:05 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u19so14884916lfr.7
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdC3cUaEksOqJq+sL/p6xZwzgeMpzcgI0nIv+Qg+xyQ=;
        b=LCBIul2FmmPrZESM+8qeYwN4OpnDb/dxDTYb/TiWt4o7mkEP7BJ4PlysJm6Y5kv6cm
         2yPblL1lGNYWg1YGC9G+7m6Co8kBZFPZLz2Uy3dbDRkCPrSEPMecaLr81BdW5cD7mB1P
         va/jfswFmn5bqS10GISBYJlGnsk3XnjICDxGoZsbFcgfL1Sf+6hViT6mpO+37EYQxVor
         9+N0WtMJB9YjvTfQ9Wj1wNO0ok/4BmtLr9CQJ4/FyRaZKlHq9kjVUIQmCNdFBqfGh8l5
         sKeTwGF96uqPdP4j46KjJrJlY4JDDVT1N28YO6RznAQVKa7gkckmUdT1nySCBt2pWgco
         ewew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tdC3cUaEksOqJq+sL/p6xZwzgeMpzcgI0nIv+Qg+xyQ=;
        b=oGlEpQRDFjw4J6bP73du3iOU4iDBiUtfIVO+cs/v0thN2N3AAaGSK3a5pE1M0wajvs
         RB41Zo6iaaFWglGJZ1DZ1Rcp5x+3ShCcDmlRtZGoTPQCYqHIpXKMdDMnDKj4GbcHirkH
         UwDJ8PNDd5fMzrgEO30+3Bb9FGmawETs7yy79ik5AdyVLQfu0YXqvhkRuX63ECNMfyDj
         ydfmENHm8arfcNMkNQPgRdDm0GdVi80+3jLQeSANZP3nW5tTdSsHN20T/6QL4XRr3XoJ
         Z8LTlTe5SzzBuRKSevhUsgc2xQn7Dd55FKrpxdtFe9foXSGXH4g+OMe7b/womi4ujBVM
         vEYg==
X-Gm-Message-State: AOAM530xH6cqSKB8IwnUkHddNIr0R9s+9hkhd1snENYvmmueTX+FP2Xu
        U8BF2JmCAenJCGGSTdl0ZgkTe5tU0q1uyw==
X-Google-Smtp-Source: ABdhPJzbrijhCUfWaTPNks1kyBh2XAUFgM6PlyUutCGUNASmv4YuSYakKEIu1GH46R6if5yf5aFAbA==
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr7344980lfg.538.1607281383548;
        Sun, 06 Dec 2020 11:03:03 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:03 -0800 (PST)
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
Subject: [PATCH v3 03/13] video: fbdev: omapfb: Fix set but not used warnings in hdmi*_core
Date:   Sun,  6 Dec 2020 20:02:37 +0100
Message-Id: <20201206190247.1861316-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix a few W=1 warnings about unused assignments.
Drop the unused error code.

v2:
  - Subject updated (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Qilong Zhang <zhangqilong3@huawei.com>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c | 4 ++--
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
index 726c190862d4..e6363a420933 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
@@ -679,7 +679,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	struct hdmi_audio_format audio_format;
 	struct hdmi_audio_dma audio_dma;
 	struct hdmi_core_audio_config acore;
-	int err, n, cts, channel_count;
+	int n, cts, channel_count;
 	unsigned int fs_nr;
 	bool word_length_16b = false;
 
@@ -741,7 +741,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 		return -EINVAL;
 	}
 
-	err = hdmi_compute_acr(pclk, fs_nr, &n, &cts);
+	hdmi_compute_acr(pclk, fs_nr, &n, &cts);
 
 	/* Audio clock regeneration settings */
 	acore.n = n;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
index eda29d3032e1..cb63bc0e92ca 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
@@ -790,7 +790,7 @@ int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	struct hdmi_audio_format audio_format;
 	struct hdmi_audio_dma audio_dma;
 	struct hdmi_core_audio_config core_cfg;
-	int err, n, cts, channel_count;
+	int n, cts, channel_count;
 	unsigned int fs_nr;
 	bool word_length_16b = false;
 
@@ -833,7 +833,7 @@ int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 		return -EINVAL;
 	}
 
-	err = hdmi_compute_acr(pclk, fs_nr, &n, &cts);
+	hdmi_compute_acr(pclk, fs_nr, &n, &cts);
 	core_cfg.n = n;
 	core_cfg.cts = cts;
 
-- 
2.27.0

