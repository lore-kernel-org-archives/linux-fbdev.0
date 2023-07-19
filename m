Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E492BC001DC
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jul 2023 08:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGSIQ6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGSIQr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jul 2023 04:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0871737
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jul 2023 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689754556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pl7rDesBC4To4uNjgzRPqO8NIm8bPxHEaiAgd1Bj9kg=;
        b=PfSa6n63zHE8uNzDWqdIszLbwAAWuipTPAHdMKmS5SispHpM2kYNzUdDFTqtgFOxUL3T3E
        3xTbB5/Zo1MIz3LudN3xAtbiZHVsW+rI110E4PUfg2mFrmQvyee8h4NzZBDKPG344UYFLJ
        wBgVMq1wiYEpEezBLL0qG+5Trv8UXD8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-7shd19faNmKqc6z17dg9ng-1; Wed, 19 Jul 2023 04:15:55 -0400
X-MC-Unique: 7shd19faNmKqc6z17dg9ng-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31443e13f9dso3833203f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jul 2023 01:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754554; x=1690359354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl7rDesBC4To4uNjgzRPqO8NIm8bPxHEaiAgd1Bj9kg=;
        b=dgKGgM0IN9vC/cjUIrGkA51bJPhakYg5iUSnODkekZa9YL8mCiLyrqN+LXOkpHOqn0
         mH4e0Co5wsGo9FRmkR3TBz5R6Yjb31pfuF4hpompp/h3bYbFH+JTYQxsyED2GFd30GM5
         me1jrx72X1moZN37+UYM9fOaJVyyLbDY5iXcB2ZJ+aTUMs84NzjVqp/EfO8ROKxIlDmf
         QBvxMS3/AiPKfYIe+DdEDEXDaoUxNI/zOa8cqM1McQi5nB5Lg0XSFKsf5WvNRv3ddmk2
         bcufOAqNQJJIheg7RwOIEgR1A7uSKlSLD6S2a9powAlmJ8fWmdRCaE9OfvYPlVO/Cs+w
         e5KQ==
X-Gm-Message-State: ABy/qLY5YgaIWkXan+sYkOl6RcwLMqvpgBMnV880mKhz8M+Dq5lkCNjh
        9dBjPzD+yYqNLcRVfNYqN5hu7eAyz2C3t5gEK9NazksZo990yd4xSbiH+xaGvBiYrcDe6Wp2JZw
        Xrc/+M+5MghjYYlzO0RMxeec=
X-Received: by 2002:adf:f087:0:b0:314:4c78:8b84 with SMTP id n7-20020adff087000000b003144c788b84mr4142560wro.17.1689754554399;
        Wed, 19 Jul 2023 01:15:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpqnqhnG2ZCWh/0oWIuDm9np5hx9FVZp0cyJdayt5CqHwUybqL7yFTlLi+cxoPwsgimsvCTw==
X-Received: by 2002:adf:f087:0:b0:314:4c78:8b84 with SMTP id n7-20020adff087000000b003144c788b84mr4142546wro.17.1689754554100;
        Wed, 19 Jul 2023 01:15:54 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d5385000000b0031423a8f4f7sm4574354wrv.56.2023.07.19.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:15:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v6 1/4] video: Add auxiliary display drivers to Graphics support menu
Date:   Wed, 19 Jul 2023 10:15:35 +0200
Message-ID: <20230719081544.741051-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719081544.741051-1-javierm@redhat.com>
References: <20230719081544.741051-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The drivers in this subsystem are for character-based LCD displays, which
can fall into the same category of the DRM/KMS and fbdev drivers that are
located under the "Graphics support" menu. Add auxdisplay there as well.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
---

(no changes since v5)

Changes in v5:
- Take the auxdisplay/Kconfig source out of "if HAS_IOMEM" (Geert Uytterhoeven).

 drivers/Kconfig       | 2 --
 drivers/video/Kconfig | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 514ae6b24cb2..496ca02ee18f 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -129,8 +129,6 @@ source "drivers/dma-buf/Kconfig"
 
 source "drivers/dca/Kconfig"
 
-source "drivers/auxdisplay/Kconfig"
-
 source "drivers/uio/Kconfig"
 
 source "drivers/vfio/Kconfig"
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8b2b9ac37c3d..e5b1cc54cafa 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -25,6 +25,8 @@ config VIDEO_NOMODESET
 	bool
 	default n
 
+source "drivers/auxdisplay/Kconfig"
+
 if HAS_IOMEM
 
 config HAVE_FB_ATMEL
-- 
2.41.0

