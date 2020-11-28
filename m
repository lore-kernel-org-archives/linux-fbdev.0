Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C2EC64E7B
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D72020702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rr082/bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgK1Wmt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgK1Wmt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:49 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01BEC061A48
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:37 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 142so10557904ljj.10
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vo4cr0mfLt51Py8FoFo5ySrp+3Uu+WbwThawmdg5uCQ=;
        b=rr082/bfmcgQVh1oGNkvsycPHb7jgLYqu/HTlitaos9mo8dFk+MxNnQcAMKYhTOz1G
         nj1LrdF1YUNQ9IAMe2k6I+uAp+9pySXOyogw/6aYwtvF0oj11SXGTjG+hDZOVwfUW4Vh
         9LbkkP5yNUVSUdx21hrIgKOLXf+4I11SveX5JuUtwoT3jlqF5CiaXb9QZLtnQY8nZoW7
         qS7J1V4thgMvocrZcf/rGKX4zsMr7A3kx9KfFseFz/dT2giLnxQUxWawESs4WL+NuwP/
         6XE0j4Lm9xbpiCeaHhQgEO9SE8T9yzD83V6/YvBVED/MIr9LPm4A7pawwrUFNAhv83yN
         3ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vo4cr0mfLt51Py8FoFo5ySrp+3Uu+WbwThawmdg5uCQ=;
        b=MlwnJVVwRJ1ayf39U/6Ca5eU6olUP2mTnakYtJ3p4IiaMJeGFLHI9Qf+8dG+fDo2Zv
         SDKmhLJqJYhhmA1olFgMwOdbsvegjNEZzyJsmRpicFgaFnG77i7nQTB2LYLUf8VoAVA1
         m4S8Ynlz+fa+A5/7lruErXdnay+EBG2mEB24jVr4XfS5IFjBJuomZBW4h7ypn6epDkaz
         YEnfYaGhLgKqPDBmGtYAnWY3HYRsUPQckCUFJny7OdcTecdwh/W4iMyzftk5IALJqKFg
         BaiDY6bSE+e58nvD9Nv7eCz9FFmcL1/c7oMVe80nhtE3q/DVmbiKdE7Y9KS75j2yjbPu
         tfbQ==
X-Gm-Message-State: AOAM530l+l+bBJ91IbBnzhKpjgr63hCuTvA24o2LYdLtYOEUh3T49hgS
        EIYNT6WyKCTJeMvpo3V/ImGI9Wzk9mHkTg==
X-Google-Smtp-Source: ABdhPJztBDdAKHiSNBdw1ZXYn1VBf8Peg+KZ0RY/iaTzhAAH+LYmPfiKXZsj0Hc9jhgaMObrsDNovA==
X-Received: by 2002:a2e:580d:: with SMTP id m13mr6673046ljb.141.1606603295928;
        Sat, 28 Nov 2020 14:41:35 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:35 -0800 (PST)
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
Subject: [PATCH v2 07/28] video: fbdev: sis: Fix defined but not used warnings
Date:   Sat, 28 Nov 2020 23:40:53 +0100
Message-Id: <20201128224114.1033617-8-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

init.h define static symbols, so should only be included
once. Drop the include from sis.h as it is not needed.
This fixes a lot of warnings seen with a W=1 build.

v2:
  - Update subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sis/sis.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis.h b/drivers/video/fbdev/sis/sis.h
index 9f4c3093ccb3..d632f096083b 100644
--- a/drivers/video/fbdev/sis/sis.h
+++ b/drivers/video/fbdev/sis/sis.h
@@ -15,7 +15,6 @@
 
 #include "vgatypes.h"
 #include "vstruct.h"
-#include "init.h"
 
 #define VER_MAJOR		1
 #define VER_MINOR		8
-- 
2.27.0

