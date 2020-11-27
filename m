Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F2C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370B920809
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPkJdyjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgK1C2h (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303CBC061A53
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:07 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 142so7094636ljj.10
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXPr2PFUFWtOrSiCc92D4zReH+aBrw7KABxE1MmXvi0=;
        b=MPkJdyjnuRSSFVuV23mC35hdVygag39YRqbpZT90vWELA3QzBsTFq5Yj9kSg+3cQNc
         ehjZjlOlpghvpSYf8mUACbykYk+t4mdLMypoZ3CkNsjJV5/cjbDoKpa/zgbdOZqcICmI
         WeobA167yuRyuQvK0HL0M5KbICRjhmxNrEAj+IDE+gAs8fkt16WXbP8/cB3y6BsxWn2a
         epRXQAtIusQjKM//TwjYCGvNTt1cW/Ar46c8TsUJrGKIRs0W9kLClsN2mpRr8GpoDOvU
         LHeTKRTPtcLetlVpF6WgFtVfLZX4kUksh0X7OdA83X1QAzzuq5DDKqBKdnLKhj/aCyrA
         +FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UXPr2PFUFWtOrSiCc92D4zReH+aBrw7KABxE1MmXvi0=;
        b=CxeEwPsXmgbc6vCloyZCS1pZVobQpI5bsfVMpcDtP20Amifs2gDrktJUTLHnj1bLL/
         s/uXFuxeuQZXRxElew2k8RoZAoNs5Yqt2kgJgei/IIdXafrotmhcNwazpqsrvTuAR+6L
         7T8qWxL3g/t8sO1khY9v3tB8Jez9mlo3j2hURBmB3oTIHb9mjKa4eX+mbcGV3pj+ngnv
         ULvLnOu17btcndAapno2Q1bsq81brvgHfJJo2VcJUBTqmBbF2kDpameMs/rBg84ouVtl
         SyZlLKQg1ZLx+vkVo0YGP/osoEzIXMx8xq4WxIHZMz8a5g9hbdrte3BxPHDgTmQhHrwo
         4tBQ==
X-Gm-Message-State: AOAM533qHxvL0gAL9JWYhdQ+DykI6V80/D/XK/bWvmc+XbQCmpQNBWVQ
        rrMe9LrS49WVnDQWMwrAm+EcYkMH3ZCw+3uV
X-Google-Smtp-Source: ABdhPJzRp6Ac5f6uTM6zm36JYhmvj2mN3ZcYz0U/kr++s/q2VudV3yV5yPzJI8O3dXqZ1ktxoeYNYg==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr4537919ljj.32.1606507145500;
        Fri, 27 Nov 2020 11:59:05 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:05 -0800 (PST)
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
Subject: [PATCH v1 12/28] video: fbdev: tdfx: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:09 +0100
Message-Id: <20201127195825.858960-13-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warning about unused assignment.
Fix by dropping the local variable.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/tdfxfb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index f056d80f6359..67e37a62b07c 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -206,9 +206,7 @@ static inline u8 crt_inb(struct tdfx_par *par, u32 idx)
 
 static inline void att_outb(struct tdfx_par *par, u32 idx, u8 val)
 {
-	unsigned char tmp;
-
-	tmp = vga_inb(par, IS1_R);
+	vga_inb(par, IS1_R);
 	vga_outb(par, ATT_IW, idx);
 	vga_outb(par, ATT_IW, val);
 }
-- 
2.27.0

