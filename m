Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA9C0015E
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 Jul 2023 23:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGCXGc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 Jul 2023 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjGCXGb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 3 Jul 2023 19:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16FEE70
        for <linux-fbdev@vger.kernel.org>; Mon,  3 Jul 2023 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688425544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PPkOUuxZ5llhFetMPklJdNaHUXTC+DjeRtC4vPngfEk=;
        b=fibYtvyQhuBNPrqUUcKVV7MLilskapsiIzz4A1B6yZLJ4oYCruyWdf4gOmkdjuGXRkiZoZ
        tfMwaRO5lO16QnxV+8axLHJaEsTBda/rgRjjzBAsv2J4usAtayEySl7yNqp5TO4FYSWKa0
        fljidcHLJwAX0nC7P80IbDo47atnJV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48--kaDtkV0M7acTb4XBDYuIA-1; Mon, 03 Jul 2023 19:05:43 -0400
X-MC-Unique: -kaDtkV0M7acTb4XBDYuIA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3113da8b778so2619091f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Jul 2023 16:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688425542; x=1691017542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPkOUuxZ5llhFetMPklJdNaHUXTC+DjeRtC4vPngfEk=;
        b=CpBiuyigoz6IX7TQ+nkXl3H21Q2bKPfH8zaE+xpiGmlC45B0xBehNSOkTsSAGajYY2
         KK849DAehNoGjAkdVHBKA7u9eFWaJX97UyABkqAWw2BSjmKurR+aSkxziv/qpePejcQ5
         QM2R+E3grZuAzp3c72Uin9nlisyOYQ7xVTcBdNH8HyNsgPekdloxyjl//196QGi3IU7N
         slW4gdUfznaYuzzZ+XOLnAmCIu2FcWQtTp9SXgWPVekuEcIQNB27bIToAm83Hvl2Dawm
         GODqMoaRX9idNpgGm5IuNTCL0jvDi1c03p3RF/buT8zNBbCl4KVrnlcNYj1plPL2iB82
         XdaA==
X-Gm-Message-State: ABy/qLZ/YmVSTRRmvxj4Drx+gfHY++tWrLaTjRM2EiyAKk7a2Ukd7p7r
        7qyNdlCNxXu3OPNWQgTP4qAk+BSWTuafyYsVgMnw6mEJ7VjnbBjKrPAnRZ0KvitZjIMCzaPUYR0
        W89DEf5OeDxqXNsBh6NtlkVM=
X-Received: by 2002:a5d:4f83:0:b0:314:182a:3d96 with SMTP id d3-20020a5d4f83000000b00314182a3d96mr9283423wru.28.1688425542687;
        Mon, 03 Jul 2023 16:05:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHkY3/kaMZbldsi47jF351XP7Kg1e0/Oy/YC+TGYzIxm3l+o77EQsFnIcbHI+uDkatYVGxuOg==
X-Received: by 2002:a5d:4f83:0:b0:314:182a:3d96 with SMTP id d3-20020a5d4f83000000b00314182a3d96mr9283411wru.28.1688425542423;
        Mon, 03 Jul 2023 16:05:42 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm26504465wrb.85.2023.07.03.16.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 16:05:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v4 1/5] video: Add auxiliary display drivers to Graphics support menu
Date:   Tue,  4 Jul 2023 01:05:25 +0200
Message-ID: <20230703230534.997525-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703230534.997525-1-javierm@redhat.com>
References: <20230703230534.997525-1-javierm@redhat.com>
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
---

(no changes since v1)

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
index 8b2b9ac37c3d..acf02863ac7d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -30,6 +30,8 @@ if HAS_IOMEM
 config HAVE_FB_ATMEL
 	bool
 
+source "drivers/auxdisplay/Kconfig"
+
 source "drivers/char/agp/Kconfig"
 
 source "drivers/gpu/vga/Kconfig"
-- 
2.41.0

