Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB49C1B0E3
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EFA2310E
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgLFTEc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgLFTEb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:04:31 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C7C061A54
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:03:14 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id i15so5315613ljg.9
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kt+OQKqeEYVX/LquXQdXcmS8yIcFdc6k57DQM+M9oPU=;
        b=STZEcMk+wb0l3UdJ+w4DLF0jFXx8DnBowF7giFgGM4j8hOag/FpJ3NUdtoZl01umkO
         CJ0hrczLQanZCBtkp+DClr3pgNMRlx+QAah7U+tqKMY3jNczQ1mp4yq4rk0ZEy66/X4n
         cKs6U/iRyR8LV0FuqV+zjtW5Bz+LVrTGbXizScvbIJzKOo9oiBDofvUrS/8ph0Mhi9lM
         0qke4Q1lpTeGGlUu/5TI+VkjsUjQ05RBsvtLg4khuatGKHZsz2JI0VzkhcG3URBw8dXU
         g86Z/r2lNjTgeaBoeVYgkTD6QL0youwlGJ4BDPY1ABX1cUNmu8mo2cPuqx8mShfk5yEd
         Vftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kt+OQKqeEYVX/LquXQdXcmS8yIcFdc6k57DQM+M9oPU=;
        b=PhS0GtJWjwKAOOm1G/lUSnAbkjnhBSaTmXtpgesIxM2so6BQGrTHCZ6OPmJsXGQNdt
         TlLqN+Qm8L7MDZRkwhqDP3CnRT07pxhSWUcRqlJNwUZrGifcCvz9JwEdEBfVVP4kfBTW
         n+EiWtYgHTuwIyQkkpUUjqTGcWgBzage9sbfqsr909KXFhwUeT9A5ntFZlqO4X/LvqAJ
         kdoHFsPb8n/FY4YKytkIlKgyiZ69oJsnsVWgm36NnAX7Z2IzSy/nXRR32QAYmjVhorOE
         WP0OJXalxS+ryAwTioElP1tQlQ/Qw1TkHgJhD6JxzDwZMinOB1hPaejUDJGhd/w9fiog
         e0+g==
X-Gm-Message-State: AOAM533qc2aWpJYNYnnkWEIn9idGaaDxSJ/ekgpv8ulE88iOtOipwvoK
        DSKodtQuGaoDYR8g93B+rTQtvGlPbUv+Jw==
X-Google-Smtp-Source: ABdhPJwKtkjVCJWvIkTsbN4Y12+y0IxNqsqpikK8ueZbFLo3Nyh8mSQt2+/iNy4h8gmKIAfP/b+CjA==
X-Received: by 2002:a2e:8982:: with SMTP id c2mr7943919lji.121.1607281392832;
        Sun, 06 Dec 2020 11:03:12 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:03:12 -0800 (PST)
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
Subject: [PATCH v3 09/13] video: fbdev: goldfishfb: Fix defined but not used warning
Date:   Sun,  6 Dec 2020 20:02:43 +0100
Message-Id: <20201206190247.1861316-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The goldfish_fb_acpi_match table is only used with ACPI enabled.
Ifdef it out unless it is needed.
This is a similar fix to what other acpi drivers do.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/goldfishfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 9c83ec3f8e1f..2b885cd046fe 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -305,11 +305,13 @@ static const struct of_device_id goldfish_fb_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, goldfish_fb_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id goldfish_fb_acpi_match[] = {
 	{ "GFSH0004", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, goldfish_fb_acpi_match);
+#endif
 
 static struct platform_driver goldfish_fb_driver = {
 	.probe		= goldfish_fb_probe,
-- 
2.27.0

