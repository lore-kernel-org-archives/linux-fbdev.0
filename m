Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9228C63798
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B9E20702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdE+tpdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbgK1WnG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbgK1WnE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:04 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F98C08C5F2
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:59 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so10557821ljo.11
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ly/Z1yYuSnGcVTY2GvWV0FTJyRU84GpNxZ//3QWCM8=;
        b=XdE+tpdRtCE6buzA19hei71zINn4l4fFqUFVe6IoD1/xcVmv3ktBz40TsQO/8S+Y5M
         KloOnjhUZh9VgpR+4eQIYrWDVFO8UbYu+nhrLggsPyJjRJXkiGlqREHjn4Xr/My8Gzj3
         yXsc07B+W64ChsaDNIxi0waUEMK9W3NJMvPP8XLizVCXXGYr2wFU5XiKXgKgmn6cJ+yc
         gaeT2zwHv/QLpbRyyUvcOVyeVIQu7fK3B7QU8ZUy8Jxb2l2dhdnCXo5t/wBry3pNXSPO
         YuN7G8+aKJj+KHnzSlscrc1hclR9raQgczphM2tw2h6Xx7tyTgQZajeYvbQ3R6Sf2O0o
         6ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6ly/Z1yYuSnGcVTY2GvWV0FTJyRU84GpNxZ//3QWCM8=;
        b=md58JwC9cQp5vHqEZlYZQl8zx6Gn69OLP7ASyiyjb4hgMhkOD9AFR6oq3nvXSfCgbM
         AaWhe8pfg/3wLbqKrd6gm0PDjZSfDK02raqJ4KFc+C7Ustc23mMJ2XzSPqyfC5i2yRBa
         Ju7BtyM1Nwe+cjX15rlaYQQkDzDLXL2LgoMAXu/bEbQwoHQzmWw72yE78zfpSdS2ZwGY
         1+aE2qIpqiv4OcBEoD+boWXghTQ5SexaKRJ5L0Keb1MlVFG+O5Fe99tieJ+PNtecRc6l
         7GA03LYnlnA+VDX9YC9Nqesa0hbKv6YyHnwPeL8B3nT2ECs0PrFSWnK9lOjp3g2Bk3kJ
         CnOA==
X-Gm-Message-State: AOAM530/wvXrtvfelLKvKMZX1Lned2GOi6jvD5c5sUQ1Fy76iDCdYeTh
        mOvtk5uIkrghuTvuHC5YzGJ4CJpMpN+dXw==
X-Google-Smtp-Source: ABdhPJzxpWU9gC8X+uyFS5KiJHbVQ53c0gnB+Hw2Pp+j5BbMcnz5pe+A0pF19jy6LZS7IWaJHxicpw==
X-Received: by 2002:a2e:9652:: with SMTP id z18mr6752831ljh.106.1606603318096;
        Sat, 28 Nov 2020 14:41:58 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:57 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 19/28] video: fbdev: sstfb: Updated logging to fix set but not used warnings
Date:   Sat, 28 Nov 2020 23:41:05 +0100
Message-Id: <20201128224114.1033617-20-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix set but not used warnings by introducing no_printk variants
for the internal logging system for this driver.

Fix a new warning that popped up now that logging was checked for
correct printf format strings.

A more invasive fix had been to replace all the internal logging with
standard logging primitives - thats for another day.

v2:
  - Update subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Alex Dewar <alex.dewar90@gmail.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sstfb.c | 2 +-
 include/video/sstfb.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index c05cdabeb11c..27d4b0ace2d6 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -1390,7 +1390,7 @@ static int sstfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	        fix->smem_start, info->screen_base,
 	        fix->smem_len >> 20);
 
-	f_ddprintk("regbase_virt: %#lx\n", par->mmio_vbase);
+	f_ddprintk("regbase_virt: %p\n", par->mmio_vbase);
 	f_ddprintk("membase_phys: %#lx\n", fix->smem_start);
 	f_ddprintk("fbbase_virt: %p\n", info->screen_base);
 
diff --git a/include/video/sstfb.h b/include/video/sstfb.h
index 28384f354773..d4a5e41d1173 100644
--- a/include/video/sstfb.h
+++ b/include/video/sstfb.h
@@ -23,7 +23,7 @@
 #  define SST_DEBUG_FUNC 1
 #  define SST_DEBUG_VAR  1
 #else
-#  define dprintk(X...)
+#  define dprintk(X...)		no_printk(X)
 #  define SST_DEBUG_REG  0
 #  define SST_DEBUG_FUNC 0
 #  define SST_DEBUG_VAR  0
@@ -48,7 +48,7 @@
 #if (SST_DEBUG_FUNC > 1)
 #  define f_ddprintk(X...)	dprintk(" " X)
 #else
-#  define f_ddprintk(X...)
+#  define f_ddprintk(X...)	no_printk(X)
 #endif
 #if (SST_DEBUG_FUNC > 2)
 #  define f_dddprintk(X...)	dprintk(" " X)
-- 
2.27.0

