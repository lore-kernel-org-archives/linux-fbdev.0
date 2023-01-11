Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AF1C678D7
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Jan 2023 15:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjAKPld (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjAKPl3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEB5B61
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so14668380wms.0
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJcVjf8pDC4yO+skqSU0XKC89Tk1zxOfzlV0lRIff7c=;
        b=aZrY9NQHD2THbetIXlgCj7dIm+IHrmHhq7F17hc477mP1n6APHub6Ck2CJ3DzdinLT
         ElgTJWC47fGty6V4ACS9w2xVnnEuSz4Z9Kz+uIPLYWQdsKohf8UMi7KQUG29Hent2GEo
         Jqem0opQMtn8iekTGOrnsTul/w0T9hALDGZaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJcVjf8pDC4yO+skqSU0XKC89Tk1zxOfzlV0lRIff7c=;
        b=f1xunsX5nhEDW8EnTGummTTh3guGuxsOleixzPpe5Px5vnvHyK9cstLxEsoxlDmqw/
         ccAQrOL39oNhScRLDqBpWTlhGCaSDen5nR7dJ3zaDax/5EPBQ2e5UNegCGnCk0NSfKzd
         LRRPQnkwe5OjdwbmKyj1XUOLwDUtLV4ANiDZzUzuvIlfv0hAvfTXF6O+eZhECys/iDBL
         H1JYrX3NxHmM9DdNRM9YOR2ekvvVJz6/N0SVu9zOJwOTJcTb6zmSbSgWs7yPcb6ITd9T
         H+RIGROrL3eEI455JAvKdVPrhQkwMXKUXc7xmI65t3HjiwUi9+10wRsXQGzQcQR/GwS8
         MEqA==
X-Gm-Message-State: AFqh2krqYZ9XJcRjTparCXwCUononK1H1C06cp97c/tJdnCq5chYPXV+
        3gNZtisriFfb0XIvblE5Nh35BQ==
X-Google-Smtp-Source: AMrXdXtLjz41DgbsTgGEKg48S+bFLaYgDm0CS1oQOQdxAw8CZ2RXHl0aiRV2ZxkGGAbOj+J7AcqZ2Q==
X-Received: by 2002:a05:600c:1d8a:b0:3d9:ebab:ccff with SMTP id p10-20020a05600c1d8a00b003d9ebabccffmr10800367wms.33.1673451687083;
        Wed, 11 Jan 2023 07:41:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:26 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH 05/11] video/aperture: Only kick vgacon when the pdev is decoding vga
Date:   Wed, 11 Jan 2023 16:41:06 +0100
Message-Id: <20230111154112.90575-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Otherwise it's bit silly, and we might throw out the driver for the
screen the user is actually looking at. I haven't found a bug report
for this case yet, but we did get bug reports for the analog case
where we're throwing out the efifb driver.

References: https://bugzilla.kernel.org/show_bug.cgi?id=216303
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/aperture.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 3d8c925c7365..6f351a58f6c6 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -341,6 +341,9 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 			return ret;
 	}
 
+	if (!primary)
+		return 0;
+
 	/*
 	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
 	 * otherwise the vga fbdev driver falls over.
-- 
2.39.0

