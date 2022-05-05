Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA93AC433FE
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 11:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiEELfW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 07:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351993AbiEELfV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 07:35:21 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C28A325C70
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 04:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651750301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncwUrPXa6D//xAE+gUKX4W9jlEJvsWNrctcaxVQSCb8=;
        b=Sw25yEomYGdfy2bhmc3ZIBgyH+keQoLz6Z6KY5RLndheY9V99sPT8fJ3oYIuRtr+q3pc+t
        TSCcX9kTAJ/JiVmVNG8f0d6pBCv1i93NQPKoA2wvIyTpxlVH016jZxUgPLAevjDWRnovL5
        PLNjMhg3C08ZsTExcjKB8oE0z0b8As4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-A6ffjPjdOW68Br5fQ2VA5w-1; Thu, 05 May 2022 07:31:39 -0400
X-MC-Unique: A6ffjPjdOW68Br5fQ2VA5w-1
Received: by mail-wm1-f69.google.com with SMTP id h6-20020a7bc926000000b0039470bcb9easo142198wml.1
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 04:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncwUrPXa6D//xAE+gUKX4W9jlEJvsWNrctcaxVQSCb8=;
        b=HBG8AJkAtRoHlGpbInpLxxUrQ8m5tybTtJuF4yd39nATYsQZ9aIUqYHcKKv48/TCxF
         Nj4RgbyXKtNaZf6v740ZQHQTzl0nItionmdibqUgW6ljgdcLI1VNrRugwkUWqlk1WYjL
         eKFHX+6zqOUXBPMyPLSbMquwc7VY0BoEbPhZ/7pFdKehsXpU61fwujtRNt+CYo2xPZ1l
         fNMslXIZyM4mSXcvr72wc0LiMovMKka31WpIgBHyNQwpMey2c9v11dvZr9VNgEF6qj8x
         l9gmABt6jrbTyTJxitWXihmk+83c/OOUzs3sroABjZQLdglIV20dKXNx2khAYsVby5nQ
         AzkQ==
X-Gm-Message-State: AOAM5309aXuj9CVYH2jBgWAsS5EC88rXg9kS/q4s9gFsTOom+5xXhW4R
        wk8Sr2iZIpdyda9K7kwno36xU826j3J1lenYQkXNSXvqsZZ9FsbN0mH4W1otrk0I+YuKOJhWE9V
        CP8Dt9OiRnq8cXc0dP20y0Kk=
X-Received: by 2002:a7b:ce82:0:b0:394:2514:6f07 with SMTP id q2-20020a7bce82000000b0039425146f07mr4288630wmj.56.1651750298622;
        Thu, 05 May 2022 04:31:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTaX+emZRGME2XrbVDdeWq3PLdol9IHOXQKtajyniJm9UY0h9+OnzRg+JdW6I4XRxCo9UumA==
X-Received: by 2002:a7b:ce82:0:b0:394:2514:6f07 with SMTP id q2-20020a7bce82000000b0039425146f07mr4288610wmj.56.1651750298397;
        Thu, 05 May 2022 04:31:38 -0700 (PDT)
Received: from minerva.. ([90.167.94.135])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d5181000000b0020c5253d8f5sm995809wrv.65.2022.05.05.04.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:31:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 1/4] fbdev: Prevent possible use-after-free in fb_release()
Date:   Thu,  5 May 2022 13:31:24 +0200
Message-Id: <20220505113128.264963-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505113128.264963-1-javierm@redhat.com>
References: <20220505113128.264963-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

Most fbdev drivers have issues with the fb_info lifetime, because call to
framebuffer_release() from their driver's .remove callback, rather than
doing from fbops.fb_destroy callback.

Doing that will destroy the fb_info too early, while references to it may
still exist, leading to a use-after-free error.

To prevent this, check the fb_info reference counter when attempting to
kfree the data structure in framebuffer_release(). That will leak it but
at least will prevent the mentioned error.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 drivers/video/fbdev/core/fbsysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 8c1ee9ecec3d..c2a60b187467 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -80,6 +80,10 @@ void framebuffer_release(struct fb_info *info)
 {
 	if (!info)
 		return;
+
+	if (WARN_ON(refcount_read(&info->count)))
+		return;
+
 	kfree(info->apertures);
 	kfree(info);
 }
-- 
2.35.1

