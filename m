Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2FDFA3740
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Oct 2022 11:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiJXLkK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Oct 2022 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiJXLjS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Oct 2022 07:39:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBF46D9DE
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 04:38:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p3so7258523pld.10
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 04:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ4fJ8ClD76WOV59defp1HNsujn8j/wysmVCUMoMFP0=;
        b=UR+PH3NVHkn0NXOqzrKguYWXOraM6vc+YMLhwexhonJG8F77DnrNQYz/9Oi32n6IZY
         hZlL47vjA7//LH91lqAnjQLn97I5Vo+uQOT2Mmd2Dn63q/EMVrrHlQ7z/zyp6JLWsxqs
         lxvzOwrP2RQb+dCGiNci0WZm/2NZcPqe1IwnSjthC31l/f7IFTIDv5x71IwBvf93+VC0
         KH/KMjo1itzSNE11bqoR8Syfpkg0shlSYQXBydHoh4+awRZYdMObrO029QbuDisy7sll
         ElVT/CB4tnxnE4FbCm2I0ONWyIQVGy4aFDiuXCQlrYYt0qq7o8pOl51CC0lnDxCtkS9Y
         1uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZ4fJ8ClD76WOV59defp1HNsujn8j/wysmVCUMoMFP0=;
        b=EjfE/SCq9FsGqFMcJN2xd18dXL9xgKEjCeBOT5Nzk1dFFCfjoWBnbW4XhupLWs8DI5
         Gko9Uwkl+mcOywA0NbmS5/MelbQRW4oZOJK865DFdId/W4Tpql7Msdghr1w72B/zZ8HY
         +a29DXe/IFDh6J4o2fB3fWQB7JxHAqTh89rcTs5wMmeSri1uv9JpjBS9iuxgyky/NLng
         JFwPoQK1H1VoGLl+HKF30SWE80LMA/0LDruWe7Nuzrz6IZ5Nwn7TmJnxQZfdPRqUMwx/
         1K/3HTf0eHzuUkn7Dd0DipQFUAP9BdwAz6c6xHZ2ZWiMwketnNpJZk3furVQygYz8RCx
         UJoQ==
X-Gm-Message-State: ACrzQf3d4dmAQcfInDihmP1e/nmMegHkyIOREDI+IR2WXFg7rOwhRWds
        EDOKQPUj3U5Vosj060sLe/TKug==
X-Google-Smtp-Source: AMsMyM4YfAwJenYaMcKn2Z30J0g5OpRvkV9SVYpt/sZWnDEmVOCLuqCwHN7ebOLB73LDTWz/IU7ezA==
X-Received: by 2002:a17:90b:2317:b0:213:26a3:246f with SMTP id mt23-20020a17090b231700b0021326a3246fmr1763172pjb.148.1666611450483;
        Mon, 24 Oct 2022 04:37:30 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:37:29 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 13/22] platform/x86: nvidia-wmi-ec-backlight: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:04 +0900
Message-Id: <20221024113513.5205-14-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024113513.5205-1-akihiko.odaki@daynix.com>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

acpi_video_get_backlight_type() is now deprecated.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/platform/x86/nvidia-wmi-ec-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/nvidia-wmi-ec-backlight.c b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
index baccdf658538..a42e3914c73d 100644
--- a/drivers/platform/x86/nvidia-wmi-ec-backlight.c
+++ b/drivers/platform/x86/nvidia-wmi-ec-backlight.c
@@ -91,7 +91,7 @@ static int nvidia_wmi_ec_backlight_probe(struct wmi_device *wdev, const void *ct
 	int ret;
 
 	/* drivers/acpi/video_detect.c also checks that SOURCE == EC */
-	if (acpi_video_get_backlight_type() != acpi_backlight_nvidia_wmi_ec)
+	if (!(acpi_video_get_backlight_types() & ACPI_BACKLIGHT_NVIDIA_WMI_EC))
 		return -ENODEV;
 
 	/*
-- 
2.37.3

