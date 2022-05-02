Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655BC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 May 2022 13:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385167AbiEBNNd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 May 2022 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385168AbiEBNNc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 May 2022 09:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E18D19290
        for <linux-fbdev@vger.kernel.org>; Mon,  2 May 2022 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651497002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WaotQP90v4LJiFV9U7D4wGlm3uQ+5ZZcBUavInrV48=;
        b=Z+proRlf13zm9Avmvo9+QkoMJaTo3lq0noMcw/KqrMgEWjSiqoIkaLs7xkWq+nui4NC8pg
        0p1xtbLG7nKXnr+KZQZM7Fy895r8Sgup6Wawa1y1787qdTCsrAteoXbsnIu5Gh6xs6DbCP
        G93ig+5R45LZrvsQlD3n1zFrUhee8EI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-zUn0azRCOh2XWySqXacJdg-1; Mon, 02 May 2022 09:10:01 -0400
X-MC-Unique: zUn0azRCOh2XWySqXacJdg-1
Received: by mail-wr1-f70.google.com with SMTP id d28-20020adf9b9c000000b0020ad4a50e14so5299837wrc.3
        for <linux-fbdev@vger.kernel.org>; Mon, 02 May 2022 06:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WaotQP90v4LJiFV9U7D4wGlm3uQ+5ZZcBUavInrV48=;
        b=GkS9Dk6T5hXsr71WO4ohEOtmcf4GQkkC5leKNm52YHVjDZvxLJYoEQ3ediYEvE6nGG
         zk9JgFuISr9b3E/V6H2IljNmyj0MylqSqLZccfHq5UZabBtXyixf5HG5+kcZX79pHprt
         kgQGqnS1mKzGTmpcjcElTf5q+V7WRdgzgHEX8On6IWa7NTZy6PZ3XsrwiJCiun4xE8lH
         r1ir3ba+aUYRNtX9KpGhkVUtNAY+7B8Sk01BoS1DbxDlt3vvVD9D06NfAa7xSraBPB/s
         XfGMwG4FN/YgKbj5hfjVKXVpaUYmRY9EvXvvm386wVrPrb5xQqdmnTOqG4CT2CyMw3e9
         OW5A==
X-Gm-Message-State: AOAM530q5ttlw4z4HPX6Kxmo8F2yhTJfqQV8kgg1lrNGEeCCRvH1OH9t
        WQpe4tcbYY6Zx7A4Kr7cNa1t+Ceu8YAR0bnpi5hNhSEOcKr8vXl/2+nuKoh6HYIEdJPrp5zIKM0
        yZFGLAF7RFjRyoJznERZcd6M=
X-Received: by 2002:a05:6000:1707:b0:20c:660c:7c78 with SMTP id n7-20020a056000170700b0020c660c7c78mr2875390wrc.150.1651497000465;
        Mon, 02 May 2022 06:10:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjmpu5DF0NDgIenLWQrfwWpzc9ggipOyyqoLLJb25FhgbRN0nzSaLoP3BCeGiVSQj+kuDHOA==
X-Received: by 2002:a05:6000:1707:b0:20c:660c:7c78 with SMTP id n7-20020a056000170700b0020c660c7c78mr2875372wrc.150.1651497000266;
        Mon, 02 May 2022 06:10:00 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y16-20020adfc7d0000000b0020adc114136sm9302081wrg.0.2022.05.02.06.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:09:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/2] fbdev: Check in file_fb_info() if the fb_info was already been freed
Date:   Mon,  2 May 2022 15:09:43 +0200
Message-Id: <20220502130944.363776-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502130944.363776-1-javierm@redhat.com>
References: <20220502130944.363776-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

If real driver probes, the fbdev core kicks out all drivers that are using
a framebuffer that were provided by the system firmware. But it could be a
user-space process still has a file descriptor for the fbdev device node.

This can lead to a NULL pointer dereference, if the framebuffer device is
unregistered and associated data freed, but later in the .release callback
is attempted to access its struct fb_info.

To prevent this, make file_fb_info() to also check the fb_info reference
counter and just return NULL if this equals zero. Since that means it has
already been freed.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 84427470367b..20d8929df79f 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -751,8 +751,13 @@ static struct fb_info *file_fb_info(struct file *file)
 	int fbidx = iminor(inode);
 	struct fb_info *info = registered_fb[fbidx];
 
-	if (info != file->private_data)
-		info = NULL;
+	if (!info)
+		return NULL;
+
+	/* check that the fb_info has not changed or was already freed */
+	if (info != file->private_data || refcount_read(&info->count) == 0)
+		return NULL;
+
 	return info;
 }
 
-- 
2.35.1

