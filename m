Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00FAC432BE
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 10:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8630660EBC
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 10:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbhH0KGz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Aug 2021 06:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244788AbhH0KGx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Aug 2021 06:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630058763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p4aikmi0g6nX7SuLm/Bk6aLBr61zFNCjsy8EnVkGMSU=;
        b=gjSHhqy3Vn41gF5/dSYnOI1kao7HgOOJRZSMePSoYIGLhNRArnCedE6XMVtvqytsu+LkBQ
        Kiw02mc9x6ZmsiIMjzjbS3JS+GMLnN8IO80nYV8YFaFyC/JCISR7LTEWmICNAIXwWcAbaE
        HQ5Wgy358MUsV2lUNYIA5a/ojffhdmQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-I_eJTddKPWaDhzR9sezaLQ-1; Fri, 27 Aug 2021 06:06:02 -0400
X-MC-Unique: I_eJTddKPWaDhzR9sezaLQ-1
Received: by mail-wm1-f69.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so1892202wmc.9
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Aug 2021 03:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p4aikmi0g6nX7SuLm/Bk6aLBr61zFNCjsy8EnVkGMSU=;
        b=GKfOeGFMYivVaVZKbP5Tx/AWn/ljcYTrU4hsQBJ15ssXvswVpZMd8ncnDA8FPJchfK
         Ggql8dil76UCFaPhAWqYTd8ZUpK4583GoJj8nMy2YVXhaecHnJI0RViqdI/vTFmHnmxR
         2o3ABamJwd+FNLs0aDmVDLOWorF9EQNTVGtFIcGykfEluJSTJsBZupwUda62Fhgb5uT0
         j39rhFN+OrjjwzP1gBd9oCLYB6NrSoMkcqnTX9+ZzJkVFgi+reRmdkfrlm5UV+IZQsun
         wUq5f52/xMulkL09dizR+hwERiDQaw6Y1AcFoZ00vIHywTtbs8y1TjVueZzjikwIredQ
         RRZA==
X-Gm-Message-State: AOAM530GNaWL9V5tu6hdZimo1IqNL1TI5Bv57XTvqU9NydM41cLYNpRA
        oCKmk/lESndYIRpNoTzX0sDgEMMh83EdSXY+UVPjaN6OHodyKWRvOoV+vzyGBeVcodyWWtPGOTL
        R4q2xqmIIa14g+SlxYEO+MHQ=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr13186002wml.47.1630058760665;
        Fri, 27 Aug 2021 03:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweQKtGcTVQCT5oK+T9jojfllLFKvn1d+zXGWWo3Yar8zcxTOTUijovtCiHgZqBsq9Js5k20w==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr13185978wml.47.1630058760467;
        Fri, 27 Aug 2021 03:06:00 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d28sm4834317wrc.4.2021.08.27.03.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:06:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [RFC PATCH 4/4] drm: Make fbdev emulation depend on FB_CORE instead of FB
Date:   Fri, 27 Aug 2021 12:05:57 +0200
Message-Id: <20210827100557.1578746-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Now that the fbdev core has been split in FB_CORE and FB, make DRM fbdev
emulation layer to just depend on the former.

This allows to disable the CONFIG_FB option if is not needed, which will
avoid the need to explicitly disable all the legacy fbdev drivers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8fc40317f2b..7806adb02f1 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -103,7 +103,7 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
 	depends on DRM
-	depends on FB
+	depends on FB_CORE
 	select DRM_KMS_HELPER
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
-- 
2.31.1

