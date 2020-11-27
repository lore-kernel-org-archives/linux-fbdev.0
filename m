Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0F6C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 20:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B17020B80
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 20:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL9dM0QX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgK0UB7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731213AbgK0UAz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 15:00:55 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB7C0617A7
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:25 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id t6so8512666lfl.13
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJCCs701PuH94ttSnntK7aHGLX4n+uQaWh7rvZc4+5Q=;
        b=XL9dM0QX7eZv3hWcOJkyWShIDYFHGB5p6irIlZjigyIw419igo35AjyGfLQqAEOLxD
         Y29Vq3/y99v858NZeFa5Bf/kzx/WzccNpEAfg87SsnOxwFbV/Rl8WsDSnRBlsupsdtrT
         Rqv6Mm7W9Y+fCHyVe0jEsEng0Eqs2rjSVvcLP3XqYlgCv8MWe9pmIJAV+RkFW2Zklfxl
         qjUV3x9lu4KLkcw6yVeKhtJz0T3+DYFnUYK7do+Ral39li6kU5xeeQiVX5fGj5SpHOj9
         DwwyX3xP41+mI96xwf3oG9xNwyrFYEW1ZrpBx1rlS9Nghj4S2HUEffR6yhTwBZxewAlW
         JLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HJCCs701PuH94ttSnntK7aHGLX4n+uQaWh7rvZc4+5Q=;
        b=cBKVISfEHXIDQZB32S3uH7zSkFWzCjxVAG24bZiwcH3eZkXFZlpJetnc1p/2/4B/IR
         q4Zk8xTxaeS1OQnthc4rOmVQMbkNWSCGowaCh80O4Zdw/LwgdR7RTFdifUfq7TdC+SII
         RsAKWv3x2n+pW98HTkDqSPPwIlk7Tn9bBcBChbiB0TWs7mxFqa9ufKMpBFvy8O+Ht1+u
         MBebhUSOtLC+MxcQPEdGDPSGQodkHCi5JLTFSflMq41pRyY7S8pFIhsT8FTT9KYg/og3
         KiF/c3g8jUadmcU6lF8HdxC8AcAElv+FHl3tYA/TB/1kfgA37IKXOBWEiw31vlSlXw4D
         TBFw==
X-Gm-Message-State: AOAM530mFySJfxkTZgGayud1w0E60ZOGzIQcVKMO+JIdwpUjtThRegrB
        Yp/GBk3GoTu6bXOgIWtHcg4uJzbBOBjjF86f
X-Google-Smtp-Source: ABdhPJwcJUOl3IK06p2KacexTdtmQMu4TmgBVRIEsQFXz2LTtqcUCQU49x1lagy1jQZE0TiE5VjMuA==
X-Received: by 2002:a19:f809:: with SMTP id a9mr4026574lff.314.1606507164062;
        Fri, 27 Nov 2020 11:59:24 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:23 -0800 (PST)
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
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
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
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
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
Subject: [PATCH v1 19/28] video: fbdev: sstfb: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:16 +0100
Message-Id: <20201127195825.858960-20-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings by introducing no_printk variants for the
internal logging system for this driver.

Fix a new warning that popped up now that logging was checked for
correct printf format strings.

A more invasive fix had been to replace all the internal logging with
standard logging primitives - thats for another day.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Alex Dewar <alex.dewar90@gmail.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org
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

