Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378DEC63798
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF08F22245
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoQV/HRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgK1BgY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31767C061A49
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:54 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o24so7122012ljj.6
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hlmg0QXcyBXkSQsSrsHccJseYumWnCfsbqf3yovwsZQ=;
        b=LoQV/HRoqkupk060ExH+xj6uc2BOYCLe+/fhhXr+djyJrScexTnQiICqX2SijJ5CUX
         sx5Ye76d3HMLlLvA7Kf1y7OzeABMF+DUkMOcrgoS28hcPIaCWKe7M40Eeq/FXGxh82+n
         pHihwnrBdOe8HURp8U9Xy1lh6JW2MeWSw9XBOSAy190vGHjdAuYb0pw7WR6hoxKLdFCj
         O42Rf9Cq4OpSxJejPEixC4sl0teW/2CrwQor6MQUWalB2M5js/5w0L6rPgPz/qLgL04O
         iK9jeSH9y4e9ZE1JFRAQB5Qr5nFOSxiGwLmV9h6wxY5714YuWeAd3KS8GSyO+db1Ud9c
         aCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hlmg0QXcyBXkSQsSrsHccJseYumWnCfsbqf3yovwsZQ=;
        b=XTUx58uxLea0TekE5NGLxT6kTOziaMOMm/X8Rl04nhkiHagkKFAslLv91QGywg84gv
         hExZdch+/Vniw3JlwFmHZsOQL6LLgPJY1N87rYyy2K43lYh0BJOGtbRu0/dqgnWgxXfC
         SHbmNjbGKGVqqiKEWcwHcrg72YQq2zf/eMsIDB5KsrnYblpl8aGOrCIwLTN/KLB2Tqw4
         UiD/1hdkALlZUDv5g9AEtkoamCiSV3CCS/lfxIXGeGaDhp9769QKSTwifXyIW9gPPYoh
         /r8LvPHmueUTVCHWI+BXPt0GNyYlhzeTGsgjlX0doVqpWvS9kDCMalX6lDMSl7A/Kxq6
         O72A==
X-Gm-Message-State: AOAM531Dra3BcmdvIxtQ1vtp7wo+TEgfHG1bEjONErMPigKBlzXebF78
        n1Fum5D9B3sQsY/rD9X3aXhl5YIkRgr8VuVw
X-Google-Smtp-Source: ABdhPJzRLomTEf1vvIm/1TdbxkZYDb34ZllLyKUDbE4zhUrgFXPDrbjJCxhX1h0uR2r7RcekIwtaLg==
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr4110075ljj.174.1606507132537;
        Fri, 27 Nov 2020 11:58:52 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:52 -0800 (PST)
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
Subject: [PATCH v1 07/28] video: fbdev: sis: Fix W=1 warnings about static symbols
Date:   Fri, 27 Nov 2020 20:58:04 +0100
Message-Id: <20201127195825.858960-8-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

init.h define static symbols, so should only be included
once. Drop the include from sis.h as it is not needed.
This fixes a lot of warnings seen with a W=1 build.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
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

