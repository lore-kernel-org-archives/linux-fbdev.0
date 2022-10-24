Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E72C38A2D
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Oct 2022 13:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiJXNpM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Oct 2022 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiJXNoH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Oct 2022 09:44:07 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C62E1EAFE
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 05:39:55 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n73so7511135iod.13
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 05:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghtJtVJhPw81MXq6/J6quq2LuUHiKWw8lzS+pFTBsP0=;
        b=cZrJzXH//QTytM0WW2x60eVTJWmr4XlL39TbHpKK3q3WQCrSwZnjVPRWyiABmgouTe
         tcWaVYaRKc8hu79d1xDnlFcNITHqD8aagxIfdW/j33EuRzv9/LyBezR8gcIDeuDjMBdi
         Ipdx3WUUwYagpuujWId9VshSvfmg5KdxiBBTFEGB4woUWAXr+bNyz5W7lNqKncoZTj5V
         OtqnOJcGCmy/ESZHdgjapJ1vmW0D4ruK7a2seAn0eeRS8/38sQjcPxnlad2eAV61+hmK
         GkeCBWxM+dUrzuzssuopdvmaQwwmpmxNgwGhyMJjD/yNfawG/7R+9RDafwqQFOoJ0z9Q
         ANrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghtJtVJhPw81MXq6/J6quq2LuUHiKWw8lzS+pFTBsP0=;
        b=iXQp5c1lzPhy4fM/UaoKjLZBDbvm0K4gwRVtRsw3f9rOu1AwOghjycfCOrfDhpnH/z
         mEN5TGbmElQivPQUNMNn/02OTe5J2yNrEjaxwc+FtIHl2EaVsKsQehYIq7ZjHloEprKJ
         Ub10XVS+9nw6cYGT4VRHtq/1uh+MEgfETf9uXZLwIPYbnjOGIUcj2cX1g07vzjvua9pH
         D+NClx/LhBJYPxi+1+EM49Wt9Sfn8mSuGsdTA4zeg27FKjpVQ2xSn61QKYYv/Ru5t/2e
         nAkKpPGMtekfiW+CPyx+eaG9j0t59RU/RilMA5mhvgE2ycRKHxbaJZ9NuXdRV6TLsu64
         NBEg==
X-Gm-Message-State: ACrzQf3Jc2M0vctr25GOAMnVoCwgBAttk+QH1s+klwSW2GMle0cIoC/p
        uhO+zEgzwvDcE3C5EDje36nmbLNrNNMEc6nP
X-Google-Smtp-Source: AMsMyM7jVfOb4cdFC5JDiHJLWBD4KDzAtatMaD5/Pd8TR8fUHas2SHGFltiDcGGdPiW3YBak6k10IA==
X-Received: by 2002:a63:dc54:0:b0:44c:ce26:fa35 with SMTP id f20-20020a63dc54000000b0044cce26fa35mr28698734pgj.374.1666611492363;
        Mon, 24 Oct 2022 04:38:12 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:38:11 -0700 (PDT)
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
Subject: [PATCH 18/22] platform/x86: toshiba_acpi: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:09 +0900
Message-Id: <20221024113513.5205-19-akihiko.odaki@daynix.com>
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
 drivers/platform/x86/toshiba_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 160abd3b3af8..3d747a901ad8 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2978,7 +2978,7 @@ static int toshiba_acpi_setup_backlight(struct toshiba_acpi_dev *dev)
 		return 0;
 	}
 
-	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
+	if (!(acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR))
 		return 0;
 
 	memset(&props, 0, sizeof(props));
-- 
2.37.3

