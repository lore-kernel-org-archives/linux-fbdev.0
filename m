Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5959BC38A2D
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Oct 2022 12:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJXMKD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Oct 2022 08:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiJXMJM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Oct 2022 08:09:12 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DBADF3
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 04:52:34 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-132fb4fd495so11466520fac.12
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXmq/hBcZYGs3Gnnq23+P2GdOlxPxnPnQ9tZiYxhvfM=;
        b=ePYd4xhaCLyNOikvZx9ObnR59VTQkSAk7bE/21UiNNJwiT7p8qaz2wxEDyrMa76ZiO
         iTv35XAqYOSWqXDvZUoUvgGmvOlC3hchnWKDqdc2UecEVAX9G/+zMZvtWhcPix3rL/Ze
         /AxIzkOWAuW0TYSGen1kls5ox9wM7QN637haLeOU+iriv1s6P76gXjgwpd8lXRWr5njq
         0kb37LvYd9ImC/Je4pwta7WQUaUhAgxFwdWYk856M8Pz+6Ha/ONDf/yTiB0LbDLwz27I
         DYeq4gLGQYRTSFepUEIMtI9Duv1N/OsA8khwLOQvpXVWzE1RgBOE2QuDDdGxjTnuq5ox
         ChVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXmq/hBcZYGs3Gnnq23+P2GdOlxPxnPnQ9tZiYxhvfM=;
        b=0iIMWQj5YNFYdXZH0phDM1jldwfRQlTkagLFYVi7NIdN8O0dwvPAaDNQt9pQgJ8xCd
         rM40dDRm8GCRREB2qGMibFACsATqjsOoRPVyxSQI1lKv/8kinlI+XiwO97/1hoxQjxVD
         6VYifo9Fiugu6Y/bOi2ebfEZAub2poXrlns8UGUxcY9LaXw2Fngnn0vM1Ch2t8L5w9VU
         9sI08LwuBN/Q/brddthBrpz5EJAFBduABXyaCOI0DPwhxB3+UEWJu54W83J0sONT90AT
         qbGnSnpGqk8/OaqSYxmKvrXnsdathTjBgyS6VuHTj2pzDJ1GhqiprsqETz3T43L5eIpO
         R/Cg==
X-Gm-Message-State: ACrzQf3qPi8tNO2M1bYpigaIEx1i9RhrkcH6IXc7n8fpiYW6TmDQPLq4
        EGXOk2I8MpE7FbDx6fPyROL74sCqC1lrLL3Z
X-Google-Smtp-Source: AMsMyM7vtFWcLRmhWO6df2stQtl+qol38s2TTZF/JGQZTKP8WsWjqXQ3dgWj46xKcZZohQd3w2Vh2A==
X-Received: by 2002:a17:90b:1e0a:b0:212:c44b:fffb with SMTP id pg10-20020a17090b1e0a00b00212c44bfffbmr22703440pjb.113.1666611433791;
        Mon, 24 Oct 2022 04:37:13 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:37:13 -0700 (PDT)
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
Subject: [PATCH 11/22] platform/x86: msi-laptop: Use acpi_video_get_backlight_types()
Date:   Mon, 24 Oct 2022 20:35:02 +0900
Message-Id: <20221024113513.5205-12-akihiko.odaki@daynix.com>
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
 drivers/platform/x86/msi-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index 6b18ec543ac3..19e2f164181f 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -1048,7 +1048,7 @@ static int __init msi_init(void)
 
 	/* Register backlight stuff */
 	if (quirks->old_ec_model &&
-	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
+	    (acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR)) {
 		struct backlight_properties props;
 		memset(&props, 0, sizeof(struct backlight_properties));
 		props.type = BACKLIGHT_PLATFORM;
-- 
2.37.3

