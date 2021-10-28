Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9534FC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Oct 2021 11:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7497A604AC
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Oct 2021 11:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhJ1LLW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJ1LLW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Oct 2021 07:11:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C748C061570;
        Thu, 28 Oct 2021 04:08:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e65so6037230pgc.5;
        Thu, 28 Oct 2021 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nulpv/PsHbHxr0CG/x6sRTRQ9BjFwug8L0Dm2Jq6QY=;
        b=LzG1s0sKFcVmxgRJOab3TCFB4S6VETIqqf0jgmYH2Vbu3VkMUYvOahXCMMv3XosvzP
         Af8DjStRBlc0HSp2YNXDWu8gSaqgtkeHGDJnWXWK4EO01O4hhzVkQkO5hxKtFaRccNUx
         u5pneT4GuBIOUcMgSAUcR4roBSPkjvdJLHOFTw23vyYrs+DWyO5fXhoHCabcENdcgYv7
         YeavoViCEMNxiAcTfNoDfp+2zCg7qoMMg7RWfnh3vzxbe9jN8yhN4BBfvtWMWc0Dz+oD
         l2vXdCcQcA4PWBOa44Jn/D6p6RjUxZKSqLR8ZWIYcN+UGGHdZxMfmvqB+jhMSIi120Tf
         L74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nulpv/PsHbHxr0CG/x6sRTRQ9BjFwug8L0Dm2Jq6QY=;
        b=vE8aeE2riYpq05m9JRc7zvohxU1OAyi+vzMjlL25iYKhQ5fZRQPezETGSaGS4S77d8
         KuN8ZKYp+bv4Q+lxGnnc4mPXnHuJPIoFtMPf09cU18T08rECerwF0Wf4N2v3haUrGis4
         ogi7m14PoVGUkiSZdKVV0ZJ9iIMm6qv24G9jFlGBlV2BBxGQl320suG0TRTlfFVQSl20
         XEBQ9zUfDiIUJN7Wjv8GE45EcOtdU7As4OWX6lxayBTaQsWrjvmkTG9zy9FJyZ0uPdFa
         1TbUd+u8Fccdi7pbm8Sd3lsOFBWjMK+/QGBrCdBbG3bV7eCffCy/VEKPTGWGQDxJgUj1
         1DCw==
X-Gm-Message-State: AOAM532YMCIJpfzX7ojDjr/fIW8FrN+PkOUkvXDF00qdhBgr4V/TzaAa
        QlUlyMMgLyJywGIK/1tamjE=
X-Google-Smtp-Source: ABdhPJwYOdpqFrFadto506ERZE8kgIfbKQyR411fTPJCuDdHSnUigcetqFdmEnX1BTJ01fkE/ZYW8g==
X-Received: by 2002:a05:6a00:22c1:b0:47c:28f5:7b9c with SMTP id f1-20020a056a0022c100b0047c28f57b9cmr3585030pfj.80.1635419335104;
        Thu, 28 Oct 2021 04:08:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s2sm8072443pjs.56.2021.10.28.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:08:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     daniel.vetter@ffwll.ch
Cc:     sam@ravnborg.org, willy@infradead.org, deng.changcheng@zte.com.cn,
        thunder.leizhen@huawei.com, jgg@ziepe.ca,
        penguin-kernel@i-love.sakura.ne.jp, zheyuma97@gmail.com,
        xiyuyang19@fudan.edu.cn, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH l] fbdev: fbmem: use swap() to make code cleaner
Date:   Thu, 28 Oct 2021 11:08:47 +0000
Message-Id: <20211028110847.15516-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use swap() in order to make code cleaner. Issue found by coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/video/fbdev/core/fbmem.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 826175ad88a2..2c8e6feef0c9 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -396,18 +396,14 @@ static void fb_rotate_logo(struct fb_info *info, u8 *dst,
 	} else if (rotate == FB_ROTATE_CW) {
 		fb_rotate_logo_cw(image->data, dst, image->width,
 				  image->height);
-		tmp = image->width;
-		image->width = image->height;
-		image->height = tmp;
+		swap(image->width, image->height);
 		tmp = image->dy;
 		image->dy = image->dx;
 		image->dx = info->var.xres - image->width - tmp;
 	} else if (rotate == FB_ROTATE_CCW) {
 		fb_rotate_logo_ccw(image->data, dst, image->width,
 				   image->height);
-		tmp = image->width;
-		image->width = image->height;
-		image->height = tmp;
+		swap(image->width, image->height);
 		tmp = image->dx;
 		image->dx = image->dy;
 		image->dy = info->var.yres - image->height - tmp;
-- 
2.25.1

