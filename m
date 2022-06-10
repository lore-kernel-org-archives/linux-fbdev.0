Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B5FC43334
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Jun 2022 08:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiFJIzF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 10 Jun 2022 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243080AbiFJIzA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 10 Jun 2022 04:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 338A7271A88
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Jun 2022 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654851296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CVVKI4thPicYfGWEh0/VZSA/WgrtJPotaQ3dMufekN0=;
        b=Wfwu9IooefvZvqMD1Jc709TJQ3Kt19RXbOUovhUqlTUIfeXWDR4ptT601lg/ks1871CK7u
        cR/aMgU7IdRV1SfBHenIdluVKFSkxxKHiaWv6SWNSIw8nl7un3Kch2MB94jZnnIIz1mKpu
        G7NWeKkVX/hCbxmfYXV/BzXaJSytWyo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-PghtMpvRP6ulOB648wX0YQ-1; Fri, 10 Jun 2022 04:54:55 -0400
X-MC-Unique: PghtMpvRP6ulOB648wX0YQ-1
Received: by mail-wm1-f72.google.com with SMTP id ay1-20020a05600c1e0100b0039c3a3fc6a4so1023569wmb.4
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Jun 2022 01:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVVKI4thPicYfGWEh0/VZSA/WgrtJPotaQ3dMufekN0=;
        b=Tstf+fk7vuyKMpFNy5D3lKHwlQ+VFcRQgL3fujwH2HbRI+MzRwSy4+y4Pdu5rEN4+x
         lrsfj7CmCkWnjUwFnzY7E5LUERFi/1k5y6NufjNjLoawvs9+0ljeK2DsBFDGDLStm+x4
         hhWGH7g23Ughdf6Zc+s1K00IgfX1NfzuNR6doqiCTyQeW0G1YClaCXnsuWEMEom8fPTW
         judf9fUmrC0xmSOIYfORAC1zNWbKm1XpmorofN4271ap642/wBJboiIHAndf2gsFA29M
         GVU5q4zbv9LKOUw0LLp/nbrUD0KDQmhsFcTdbum5NdVJipccVweKOrm495yvxEnf1UbN
         DJwg==
X-Gm-Message-State: AOAM532eYEXGJ54487sJu8MNYkeh+4lDWLiMcusVf8WIYnK7fdu1toOn
        IU3N187mqI/9vyJGI45a32fJfksjyb++R8mlpI197HGWvNUlYiA5FX+DC73XbuD4msM7qmgRWrW
        Hqn8kjwSAljc1F0Kyo5X9BX0=
X-Received: by 2002:adf:e70e:0:b0:210:2b0f:723 with SMTP id c14-20020adfe70e000000b002102b0f0723mr42414568wrm.47.1654851294389;
        Fri, 10 Jun 2022 01:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRaUo7tvKddPeRO3iR2vMIJXWPBMkMuQ1f5xqNCYbyRxuzm4GDWk8ljLiP3gvkDwiWfLSALw==
X-Received: by 2002:adf:e70e:0:b0:210:2b0f:723 with SMTP id c14-20020adfe70e000000b002102b0f0723mr42414548wrm.47.1654851294148;
        Fri, 10 Jun 2022 01:54:54 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h7-20020a7bc927000000b0039740903c39sm2267836wml.7.2022.06.10.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:54:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Javier Martinez Canillas <javierm@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] Revert "fbdev: vesafb: Allow to be built if COMPILE_TEST is enabled"
Date:   Fri, 10 Jun 2022 10:54:50 +0200
Message-Id: <20220610085450.1341880-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This reverts commit fa0e256450f27a7d85f65c63f05e6897954a1d53. The kernel
test robot reported that attempting to build the vesafb driver fails on
some architectures, because these don't define a `struct screen_info`.

This leads to linking errors, for example on parisc with allyesconfig:

  hppa-linux-ld: drivers/video/fbdev/vesafb.o: in function `vesafb_probe':
>> (.text+0x738): undefined reference to `screen_info'
>> hppa-linux-ld: (.text+0x73c): undefined reference to `screen_info'
   hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>> (.init.text+0x28): undefined reference to `screen_info'
>> hppa-linux-ld: (.init.text+0x30): undefined reference to `screen_info'
   hppa-linux-ld: (.init.text+0x78): undefined reference to `screen_info'

The goal of commit fa0e256450f2 ("fbdev: vesafb: Allow to be built if
COMPILE_TEST is enabled") was to have more build coverage for the driver
but it wrongly assumed that all architectures would define a screen_info.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index bd849013f16f..f2a6b81e45c4 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -616,7 +616,7 @@ config FB_UVESA
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on (FB = y) && (X86 || COMPILE_TEST)
+	depends on (FB = y) && X86
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.36.1

