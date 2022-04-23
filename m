Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CE3C433F5
	for <linux-fbdev@archiver.kernel.org>; Sat, 23 Apr 2022 12:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiDWM7Z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 23 Apr 2022 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiDWM7Z (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 23 Apr 2022 08:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6376BF9
        for <linux-fbdev@vger.kernel.org>; Sat, 23 Apr 2022 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650718587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fXS1wYFISLzf4YrpSc6l5RCrDLoiak/N6nEId/I9Cks=;
        b=TLtxRDaVaUGeNW0SLK/jaENk8iR4PZeatqvUUNc8ibWVF6yPGVxhLYvZSTQIDJH1GgwV+Z
        uUZPurZF4KtzPi+z/egWayDFMGKcTcihVhAqrp7hFVPd+EL7FGmb3+sZ+FwDGQ66wBu+0k
        zjQ/cfT5yBBKvd2LSpFGluL6ohSwlEc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335--cU-UIINOnS2hd9WBkoinw-1; Sat, 23 Apr 2022 08:56:26 -0400
X-MC-Unique: -cU-UIINOnS2hd9WBkoinw-1
Received: by mail-qv1-f72.google.com with SMTP id eo13-20020ad4594d000000b004466661ece9so8819775qvb.1
        for <linux-fbdev@vger.kernel.org>; Sat, 23 Apr 2022 05:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXS1wYFISLzf4YrpSc6l5RCrDLoiak/N6nEId/I9Cks=;
        b=zR6R5vId0yMpd2Swel/xpLMq35a7LnSap2In/tzFFCWiZvRJkADg3GbJlY5x6+/lXM
         IP+WHkB1T7ZC9bl9Vwvq9ujHG4t4tNqdw8G2QJ2I2IenylYZX+srWY2ywy9D3bH3SoU2
         zf+E6ek+HSHBfM+Jr8uQc48psaEt5WuE1JGd/ku2uulx8pe752VJ9VpSptNp3HQtYTMl
         mmtyX8Dq5WOJZ4zLeLwPi+duHLn1OzMYSXEC+gMJRuHrhFfVHI99V763Yy/nT2Urmu98
         MU3GAj3F9M/Q+iRdUxK1O0xsyh7po8II/qOMQVxVNWe3ADRt3IK6cyag7wpmX9QPeu04
         uBDA==
X-Gm-Message-State: AOAM530TUeKeueDNlD8to1NjlAogUXGb6f3L63QCRLEma3075J6MN+r5
        Hm9knONFwa+dbWKRoY3RgdtExbcT3v9uc4dHi2FVCmqXJ17YS4jgLing6BropB9qIGgTT3mkA+r
        LDhhEhb7c8WA5S344EO1YXv0=
X-Received: by 2002:a05:620a:44c6:b0:69e:9bef:53e3 with SMTP id y6-20020a05620a44c600b0069e9bef53e3mr5447567qkp.481.1650718586189;
        Sat, 23 Apr 2022 05:56:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhlweP7vkujEfw3nfYFCm7iGeT3wgX5eOb2GZoLM/GocC/XMB64gi5W1GtgsEOcxr1gb7hWw==
X-Received: by 2002:a05:620a:44c6:b0:69e:9bef:53e3 with SMTP id y6-20020a05620a44c600b0069e9bef53e3mr5447553qkp.481.1650718585973;
        Sat, 23 Apr 2022 05:56:25 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a12eb00b0069c88d15b6asm2240097qkl.68.2022.04.23.05.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:56:25 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     daniel@ffwll.ch, deller@gmx.de, sam@ravnborg.org,
        tzimmermann@suse.de, javierm@redhat.com, cssk@net-c.es
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] fbcon: change fbcon_*registered_fb variables to static
Date:   Sat, 23 Apr 2022 08:56:18 -0400
Message-Id: <20220423125618.1916005-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Sparse reports these issues
fbcon.c:106:16: warning: symbol 'fbcon_registered_fb' was not declared. Should it be static?
fbcon.c:107:5: warning: symbol 'fbcon_num_registered_fb' was not declared. Should it be static?

These variables are only used in fbcon.c. Single file use variables should
be static, so change their storage-class specifiers to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c4e91715ef00..225ac0fe0143 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -103,8 +103,8 @@ enum {
 
 static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 
-struct fb_info *fbcon_registered_fb[FB_MAX];
-int fbcon_num_registered_fb;
+static struct fb_info *fbcon_registered_fb[FB_MAX];
+static int fbcon_num_registered_fb;
 
 #define fbcon_for_each_registered_fb(i)		\
 	for (i = 0; WARN_CONSOLE_UNLOCKED(), i < FB_MAX; i++)		\
-- 
2.27.0

