Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F2C4167B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A863A2310B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgLFTDu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgLFTDt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:03:49 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971C7C0613D2
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:03 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r24so14873261lfm.8
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AWKed4odfdsIU5AGoPrFhmgmtEnPpwRuMDNnFb1mat8=;
        b=BD38NveQzbi0GZYDlRS4ddm+TOpNJuvzIK01AZxXT3QyMCEPJ4dI5vbixKjs17NbNB
         64eAdShaMM/tV24LtAnyv5OASJu+J6B5OKMKormP1iPZXTd5mQPycd9PKBAGNwtvQzEj
         P3tctVPAhd0gQAhLn533Y/KZQLpN+7LaC17r0O+xQJaFJ/0LpWlN8LX/X0CLAMgyP/44
         8N9p9sAgWvVTT57VjRJEbZJpIUBDWzVooUnWcJm3hrZKWKi8KHlAw/B+f5BOawWAHaYV
         0fBNuY9Wv1RalrCsxj/ueAjI1XFkmU2rTpLi517r2HfYn04yjxOoSDTu83YsvHeFXHjv
         EBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AWKed4odfdsIU5AGoPrFhmgmtEnPpwRuMDNnFb1mat8=;
        b=EjWvgJQej4Hex1J+jdPecFnR/siTbmg4UJFZICVWJMVkw2ljMN6t4JdOBg/F5FPwkp
         vdgrbYYi2yeLsD7LcNA9qv9B6amDBJSEdbNjJtoQx5ux09kmVxqxKrMfN4m8Bvh1WKKj
         PpLiJ73QAL/Yo5usNXT5dEvMMcPdMm/Jota9jcsyRq9+XTD83ugJuLwSF5Z5txmqwIQs
         SUrKomACoKFD1cyhgJAe54nfe4XYkC8+fIddVaC0wyQywT1rv2nvdUHIkH/ErRZacK5K
         DelIKtZBWWPigyl/cezo7NabzLM4DyxqEY9DFoyHIPkzgQZwmtnMDglfG9mIoSttKV1G
         0kBw==
X-Gm-Message-State: AOAM5304VwSp+ysqWVqxwurDaCKyz/ww9mV5oStDI/IHOAs9K0ZrYosr
        pgD7JF2pZJ62c5XPnYAWi6wB9hwlZvjQgg==
X-Google-Smtp-Source: ABdhPJxMMFbAmqvduYmjI39HUAlAX90pPZ/380NwlD2kk4yJ4yuH78VuVYftT/yg8SyxScng+YNcqQ==
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr6523183lfo.2.1607281381884;
        Sun, 06 Dec 2020 11:03:01 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:01 -0800 (PST)
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
Subject: [PATCH v3 02/13] video: fbdev: core: Fix kernel-doc warnings in fbmon + fb_notify
Date:   Sun,  6 Dec 2020 20:02:36 +0100
Message-Id: <20201206190247.1861316-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix kernel-doc warnings reported when using W=1

v2:
  - Improve subject (Lee)

v3:
  - Add RETURNS documentation (Thomas)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
---
 drivers/video/fbdev/core/fb_notify.c | 10 ++++++++++
 drivers/video/fbdev/core/fbmon.c     |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_notify.c b/drivers/video/fbdev/core/fb_notify.c
index 74c2da528884..4e39c61fae1f 100644
--- a/drivers/video/fbdev/core/fb_notify.c
+++ b/drivers/video/fbdev/core/fb_notify.c
@@ -19,6 +19,9 @@ static BLOCKING_NOTIFIER_HEAD(fb_notifier_list);
 /**
  *	fb_register_client - register a client notifier
  *	@nb: notifier block to callback on events
+ *
+ *	RETURNS:
+ *	0 on success, negative error code on failure.
  */
 int fb_register_client(struct notifier_block *nb)
 {
@@ -29,6 +32,9 @@ EXPORT_SYMBOL(fb_register_client);
 /**
  *	fb_unregister_client - unregister a client notifier
  *	@nb: notifier block to callback on events
+ *
+ *	RETURNS:
+ *	0 on success, negative error code on failure.
  */
 int fb_unregister_client(struct notifier_block *nb)
 {
@@ -38,7 +44,11 @@ EXPORT_SYMBOL(fb_unregister_client);
 
 /**
  * fb_notifier_call_chain - notify clients of fb_events
+ * @val: value passed to callback
+ * @v: pointer passed to callback
  *
+ * RETURNS:
+ * The return value of the last notifier function
  */
 int fb_notifier_call_chain(unsigned long val, void *v)
 {
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 1bf82dbc9e3c..b0e690f41025 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -605,6 +605,7 @@ static void get_detailed_timing(unsigned char *block,
  * fb_create_modedb - create video mode database
  * @edid: EDID data
  * @dbsize: database size
+ * @specs: monitor specifications, may be NULL
  *
  * RETURNS: struct fb_videomode, @dbsize contains length of database
  *
@@ -1100,7 +1101,6 @@ static u32 fb_get_hblank_by_hfreq(u32 hfreq, u32 xres)
  *                                    2 * M
  *        M = 300;
  *        C = 30;
-
  */
 static u32 fb_get_hblank_by_dclk(u32 dclk, u32 xres)
 {
-- 
2.27.0

