Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF6C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 12:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359516AbiEEMIR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359505AbiEEMIK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 08:08:10 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A50445527
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651752270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b6FsSuldSV9lRRf+mgtlrrW/HBBrOUZtFamaruZ97h8=;
        b=iyaAo5j4X9IHJgGKyeiTEdgQnyVYmG6o2X8Je/zMWU0ps7SRgtHhfz5tdpRCe7KA59rXaU
        OT0HMrQL4wkw3ysSY0rQx2qkFb/1MMYsfzpyqXX+2fM1TFhxEGV23STUlveyoe8UFc7Nch
        G4nCRGaeMeMb8QoNP1SJyJq5JfsHMoM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-ax6hMUL4PxOwT4PwJAPFIQ-1; Thu, 05 May 2022 08:04:29 -0400
X-MC-Unique: ax6hMUL4PxOwT4PwJAPFIQ-1
Received: by mail-wm1-f70.google.com with SMTP id r186-20020a1c44c3000000b00393f52ed5ceso4393544wma.7
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 05:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6FsSuldSV9lRRf+mgtlrrW/HBBrOUZtFamaruZ97h8=;
        b=JMOK441ZOiZ/dJelOco/BPxEkRnOHLwWSSmu2cRDYNu8MSRXIQuk8uGlngeiKaJcrJ
         CYM3EpdHFmf457lOSZb2vtv269VUYaI9nE+NNv745XiJRf0W29AbdLXCeMzX7MVY6Luu
         5ZiG1XjjnUsGxeentPZw479tpgwBG46JYBPVavFsoEUdNl8RTtwUJZ3BzGUh8jzHZ56B
         rkQsSPJIbLeu1TBuu6oakla5EHEihHyPcq7g4PiNc9xwYp2f6Ig+IaRqu4p4pCCg60dI
         A2OXu15eUyIq0vWZj6Fp9vWKGRr4CAm1NDaKuxB0m1b2TgHsQfm+5WBYuBJNc+aSsKKo
         ihBg==
X-Gm-Message-State: AOAM531cShO81ZwloGvZR4jlEaBWYFdWu3g/uxIIgUADdaL3OgUrqrP8
        xn6fsszsCMLD9sAoS3YAbWpEBNLQiLPHrERv/7qbVyuCS6jiG3cCSNEIf+5qOMJODx7fVSe6G6H
        xCeqcJWYoN2/Mb9tmWshY+rg=
X-Received: by 2002:a5d:64ac:0:b0:20c:62a1:b4c9 with SMTP id m12-20020a5d64ac000000b0020c62a1b4c9mr15253774wrp.491.1651752267944;
        Thu, 05 May 2022 05:04:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKBH1eP1dtXBfBIGG5Mc+1TNDzXh/v6Q5kMSQ2I645JQ2mXPp/4I/aDUd/MM9H8r/X0NxYFg==
X-Received: by 2002:a5d:64ac:0:b0:20c:62a1:b4c9 with SMTP id m12-20020a5d64ac000000b0020c62a1b4c9mr15253754wrp.491.1651752267730;
        Thu, 05 May 2022 05:04:27 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg19-20020a05600c3c9300b003942a244edasm1267350wmb.31.2022.05.05.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 05:04:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: vesafb: Allow to be built if COMPILE_TEST is enabled
Date:   Thu,  5 May 2022 14:04:18 +0200
Message-Id: <20220505120419.314136-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The driver has runtime but no build time dependency with X86, so it can
be built for testing purposes if the COMPILE_TEST option is enabled.

This is useful to have more build coverage and make sure that the driver
is not affected by changes that could cause build regressions.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index f2a6b81e45c4..bd849013f16f 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -616,7 +616,7 @@ config FB_UVESA
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on (FB = y) && X86
+	depends on (FB = y) && (X86 || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.35.1

