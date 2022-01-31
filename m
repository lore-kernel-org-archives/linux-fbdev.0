Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC4C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350569AbiAaUMt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 15:12:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378097AbiAaUMm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 15:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643659961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cCZTFH2Jz9n7CnT5wyJgHCMwnAI//gCfT+1J887Hbp8=;
        b=g0mU89ESmBFNkHs22z4mDbzViGppeC7QfXUl7QUk4gBQ6LAuePlh3Xl5xyHSmtBJZijFUW
        OaIlHJ0O+77Tg2q4F+tsomPNTwXH/hm5l04TW/bOEryBJ5tUJoiW8/aHrxug8yy+qdX3C8
        CHSSHxkmqxhRqNYsqjs8OVEDGdd7mgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-1oOduU-UMg-bLpDNTHB6Nw-1; Mon, 31 Jan 2022 15:12:39 -0500
X-MC-Unique: 1oOduU-UMg-bLpDNTHB6Nw-1
Received: by mail-wm1-f71.google.com with SMTP id q71-20020a1ca74a000000b003507f38e330so114584wme.9
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 12:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cCZTFH2Jz9n7CnT5wyJgHCMwnAI//gCfT+1J887Hbp8=;
        b=BqYFggNQvaAAXsO1Cr+/aL1ZIQOTPVuww34VesYf1jnuwB6P7BoNszbiDAYK6pqEIU
         eQFs5+Hw+UFfoXixyRUCknm4xmtDtylxd2fFYFM+HQOAKRcygK5kW+bsXAchXV47o/f+
         R41BWXyKO2BX1mRXNDtyCsoqjpgAvyfxzUiFkdTL8kzD+ZFnMmQX9nSHIoZcPvUseFmQ
         pPwW3ocDZxnAtjKXaeFFJL7FG7sQKsJfB1QMEr084s3QT8JDdqtV/oP4LJv7VHXWQstL
         HNOGn6oXUL9UVjxQZQzAkGgrC4aSI1U4hkGXl6jpbGVUJ9MOvjGijVc0v4v1CMlWhzKt
         CZSg==
X-Gm-Message-State: AOAM5309MRVZLEDIShAUyhaQQVfMkyygMF5CSuTBYQCRfaR//6VCSVll
        ji6UVsCsmDhd5e7UHk1t1mJ8gu9X8Cz/CH07DNlzqyAEMF7ueWxVjP7/f8WEBeelgGjggUzVayp
        TaD0UdfvG+S2RmMLCIwY3ukk=
X-Received: by 2002:a05:600c:358d:: with SMTP id p13mr8847540wmq.107.1643659958794;
        Mon, 31 Jan 2022 12:12:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVR5gg/GkWjplwAp2GCFjYULewNFaqtbWuaY9/kEdRUVdrcLHpHcgr6Utqd0EVs24QXTKHkA==
X-Received: by 2002:a05:600c:358d:: with SMTP id p13mr8847515wmq.107.1643659958507;
        Mon, 31 Jan 2022 12:12:38 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i9sm15124660wry.32.2022.01.31.12.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:12:38 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
Date:   Mon, 31 Jan 2022 21:12:20 +0100
Message-Id: <20220131201225.2324984-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.

Using the DRM fb emulation, all the tests from Geert Uytterhoeven's fbtest
(https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes:

     ./fbtest -f /dev/fb1
    Using drawops cfb32 (32 bpp packed pixels)
    Available visuals:
      Monochrome
      Grayscale 256
      Truecolor 8:8:8:0
    Using visops truecolor
    Running all tests
    test001: PASSED
    test002: PASSED
    test003: PASSED
    test004: PASSED
    test005: PASSED
    test006: PASSED
    test008: PASSED
    test009: PASSED
    test010: PASSED
    Benchmarking... 10x10 squares: 412.99 Mpixels/s
    Benchmarking... 20x20 squares: 857.46 Mpixels/s
    Benchmarking... 50x50 squares: 1593.51 Mpixels/s
    test012: PASSED
    Benchmarking... R5 circles: 237.07 Mpixels/s
    Benchmarking... R10 circles: 501.24 Mpixels/s
    Benchmarking... R25 circles: 947.86 Mpixels/s
    test013: PASSED

Patch #1 adds an I2C connector type since currently there isn't one and
I2C drivers use DRM_MODE_CONNECTOR_Unknown or DRM_MODE_CONNECTOR_VIRTUAL.

Patch #2 adds a drm_fb_gray8_to_mono_reversed() DRM format helper since
most DRM/KMS user-space don't support bpp 1 displays, so drivers expose
a common format that's converted to greyscale and then to monochrome.

Patch #3 adds the driver. The name ssd1307 was used instead of ssd130x
(which would be more accurate) to avoid confusion for users who want to
migrate from the existing ssd1307fb fbdev driver.

Patch #4 just adds a MAINTAINERS entry for this new DRM driver.

Best regards,
Javier


Javier Martinez Canillas (4):
  drm: Add I2C connector type
  drm/format-helper: Add drm_fb_gray8_to_mono_reversed()
  drm/tiny: Add driver for Solomon SSD1307 OLED displays
  MAINTAINERS: Add entry for Solomon SSD1307 OLED displays DRM driver

 MAINTAINERS                         |   7 +
 drivers/gpu/drm/drm_connector.c     |   1 +
 drivers/gpu/drm/drm_format_helper.c |  35 +
 drivers/gpu/drm/tiny/Kconfig        |  12 +
 drivers/gpu/drm/tiny/Makefile       |   1 +
 drivers/gpu/drm/tiny/ssd1307.c      | 976 ++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |   2 +
 include/uapi/drm/drm_mode.h         |   1 +
 8 files changed, 1035 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/ssd1307.c

-- 
2.34.1

