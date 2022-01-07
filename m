Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA0C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jan 2022 11:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbiAGLHg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:07:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232906AbiAGLHf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 7 Jan 2022 06:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641553655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58zbRN1g/CU6F0V6Z7/ygK3GmWeTFgdq63VOW5AeL6U=;
        b=VNpYDy8ZFcOe2bOKxaFR8Tq3ifDvbCCdn9Gv8OuuLUufJr9RZ3YBO8klNilfXD9z3RZZje
        3D1tbbQOjxGM4+dvZscGnxi15S/Na3qfQmI/1ciU3lYAX+LDQCMHEYkw4uYZHaHjjY0/bL
        Ml/kXp8aNVct57NbJ3tKIuFCzA4sR4k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-PSblWPw_MxSs2QTC5MWgYA-1; Fri, 07 Jan 2022 06:07:34 -0500
X-MC-Unique: PSblWPw_MxSs2QTC5MWgYA-1
Received: by mail-wr1-f70.google.com with SMTP id r1-20020adfb1c1000000b001a4852a806cso2127521wra.9
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Jan 2022 03:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58zbRN1g/CU6F0V6Z7/ygK3GmWeTFgdq63VOW5AeL6U=;
        b=J90s8UB1u+0K7POQXygQnSnPCzkLX7d2Q+h60+7cnQsNPXjmRIrKrbXizPammpZ33D
         I2+AuslxfcZQ10CaSCAj1LT8oF2zuKOIi5snXaw9Y2X9k5FtIpUVcKo1xl0MHcpRBtGf
         qgn0+jzX/i4a4Dfb1/GrEXyJJqdJKElVXZSwE17BKrdfvJ1VXv8f0MRhURiLnW3fd7KH
         hMl3qU8DTI5OQ18hKdd95T2gdPxu9VnPdoZlraYpf18Zt2AgWRZOU09v1BH3dogQaMtw
         wcZRU4Uq5d60Qnteexgq1po4unNLv8SGHT2sOn7lcyPkVzJE4nOq50oC32BA8H1lddla
         3/QQ==
X-Gm-Message-State: AOAM533FQODAW6V6TnrNdjVndZJ9mSCdN5GL+nKj11b5AnXUbN1Ejtpm
        0/zI7emBlITXijfsaEHsG0CiWHPEv4cSO7WDLNFK2g/zWRBYOhv69x4B4GNrzFYvYXFobRkHRyl
        wrA2g/ed41TXnwPODFwEDRug=
X-Received: by 2002:a05:6000:184f:: with SMTP id c15mr55611166wri.632.1641553653069;
        Fri, 07 Jan 2022 03:07:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8FiBkwupY26l2VOQFCBjlQX2PiwGOdMzcc0tazi6OhYPBwayO3s/sLvIG8bnzF/tTNPF5NQ==
X-Received: by 2002:a05:6000:184f:: with SMTP id c15mr55611147wri.632.1641553652846;
        Fri, 07 Jan 2022 03:07:32 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r9sm9337273wmq.18.2022.01.07.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 03:07:32 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kris Karas <bugs-a21@moonlit-rail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/2] video: vga16fb: Fix logic that checks for the display standard
Date:   Fri,  7 Jan 2022 12:07:22 +0100
Message-Id: <20220107110723.323276-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107110723.323276-1-javierm@redhat.com>
References: <20220107110723.323276-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The vga16fb framebuffer driver supports both Enhanced Graphics Adapter
(EGA) and Video Graphics Array (VGA) 16 color graphic cards.

But the logic to check whether the EGA or VGA standard are used is not
correct. It just checks if screen_info.orig_video_isVGA is set, but it
should check if is set to VIDEO_TYPE_VGAC instead.

This means that it assumes to be VGA even if is set to VIDEO_TYPE_EGAC.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/vga16fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index e2757ff1c23d..3347c9b6a332 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1332,7 +1332,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
 	par = info->par;
 
-	par->isVGA = screen_info.orig_video_isVGA;
+	par->isVGA = screen_info.orig_video_isVGA == VIDEO_TYPE_VGAC;
 	par->palette_blanked = 0;
 	par->vesa_blanked = 0;
 
-- 
2.33.1

