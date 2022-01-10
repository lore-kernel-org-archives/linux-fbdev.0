Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A75AC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 10 Jan 2022 09:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbiAJJ4f (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 10 Jan 2022 04:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243452AbiAJJ4c (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 10 Jan 2022 04:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641808591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGDm1oaaWKUbsURSYDtt3eA6CLvZDH+FDjQaP+AuY/8=;
        b=C3zX4jOmqYap+53SM/TkVYqwkS8y67VK05zxkVEjyNL+H2O+Y2qMJYOJn5ufDNJH0CkU9J
        eDzX71xjvuE+3MNfc7LZQsocqC9YKNW+4rPxRfAU+p1HMDwIvSa/K/H/yjw3p1p51hhyL/
        zcDPQqSgNppra7varnquPFosqjatHGQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-pGOpqlN4OyG6zykx16Eibw-1; Mon, 10 Jan 2022 04:56:30 -0500
X-MC-Unique: pGOpqlN4OyG6zykx16Eibw-1
Received: by mail-wm1-f72.google.com with SMTP id ay41-20020a05600c1e2900b00345a568e6b2so4704945wmb.4
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Jan 2022 01:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGDm1oaaWKUbsURSYDtt3eA6CLvZDH+FDjQaP+AuY/8=;
        b=Imw2PpFfxRm10O1iWNpGhPAk9rD7fayGxY6qcBbDMbe0ggFijE2fp07hcX3KGPsnIS
         YeywxcCaSjSZ8J4dfpjL1fHgoj4vcrrnhkD73b+nezd3nkH4rKCPHpd2/mMN7RyNxfOK
         rOXgnkyVF1HIP2+6q6Wr4RgnsZn8hpU/HrQDpCg94qr+L/wED1xUD2s3As+Nqld3inTi
         tGS0O/5cwrWt0crSUtW0y2hALKepybog3FRXPq/78KyrZdkGV4ROqfNrkGkJSBWHVMWZ
         9B0+sNzPzk/s00Uyj6oH85DMxAf0W65Cy0rjTYJ+w/oPED040ij//yrlVCOBSDI1umzb
         jr0A==
X-Gm-Message-State: AOAM530BfSSfXQZtToR+AgNFNvORowj3HjgXvU46/wYPFOpLBpQg1RJD
        nWGonGeKu+NkTRg7AvXwX3zLizGHuO8anof1rrj46Vt52VzYIwYmy0oKn2dGciMwu2XJ3vqt9aU
        AaZmGdm57R/7ge8DG505hgWM=
X-Received: by 2002:a5d:6302:: with SMTP id i2mr5349403wru.25.1641808589065;
        Mon, 10 Jan 2022 01:56:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6ths/AcE+USA4b9jT9nuUL+2SfOzOGrd7hBLtsih5mHKb9hQ17/vSxnWdP1FKhpwI1kRuhA==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr5349395wru.25.1641808588900;
        Mon, 10 Jan 2022 01:56:28 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b13sm6315167wrf.64.2022.01.10.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:56:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kris Karas <bugs-a21@moonlit-rail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 1/2] video: vga16fb: Fix logic that checks for the display standard
Date:   Mon, 10 Jan 2022 10:56:24 +0100
Message-Id: <20220110095625.278836-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110095625.278836-1-javierm@redhat.com>
References: <20220110095625.278836-1-javierm@redhat.com>
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

All non-x86 architectures though treat orig_video_isVGA as a boolean so
only do the change for x86 and keep the old logic for the other arches.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Make the change only for x86 (Geert Uytterhoeven)

 drivers/video/fbdev/vga16fb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index e2757ff1c23d..8c464409eb99 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1332,7 +1332,12 @@ static int vga16fb_probe(struct platform_device *dev)
 	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
 	par = info->par;
 
+#if defined(CONFIG_X86)
+	par->isVGA = screen_info.orig_video_isVGA == VIDEO_TYPE_VGAC;
+#else
+	/* non-x86 architectures treat orig_video_isVGA as a boolean flag */
 	par->isVGA = screen_info.orig_video_isVGA;
+#endif
 	par->palette_blanked = 0;
 	par->vesa_blanked = 0;
 
-- 
2.33.1

