Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCBAC71156
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CFF20771
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+8fbCu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbgK1Wmz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbgK1Wmx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:53 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1368C061A4F
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:46 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o24so10578040ljj.6
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=if4pzrzCg3q6ofCtFvf6yx5yT56Fowc0s0Pn6h0Zotc=;
        b=n+8fbCu6wuPRFXEnwNsFn69z5xcEOmjQjYUGqkvFjrF9Oz2C7XLsj5B831CoAIPv7Y
         a40kM24PL2nZRS0LvIpGjGHGBeIh8iv2Mv2+Gqxa14fcXzINfbbCuECej+XJPknAZZQs
         /8Z8ZT6RbCfihIhMpVsrjqAoKDaDfVDuNfTDB+CrIHaReoZMc3aoZdpmWWkH/KqGuUD1
         L/x3DSWTEwgGLKR/oPR4rafJLUtHa/s6n5JDX3eN6Sy92VZtGrwt56i4LuJPklmR21RB
         JZmbXKkYy90cUr9l/P5trM9dzq6I559NeXapOEPQs6RL/SSqRIDLq34Cl5QCvYaI6CM7
         mZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=if4pzrzCg3q6ofCtFvf6yx5yT56Fowc0s0Pn6h0Zotc=;
        b=uSeYpmLv0deo/zumJjEqc2wZSeA8WpMCC4XLnsoMA046GnAi9Qijv1Hejv6yIUudKw
         IkkxiTOMLXA+b4YkLyQ4hLr0vb+F4/KFQ93kXU4C2IKnHMgHTLGfZ++sbshTpjpP+BqA
         7VkBEzxEZuWh3LPMaVljPTRdvd7DiQ/SLxoIvldoFXOaZU9hmJhM4c3XmG0Ll3VSL7bk
         gkEWzlD2SRRoRagJA4jjbwGSXpYeqqXPGY1hBwRvlboZ+oDbEBoFDSD1HilQ4Hz6CyII
         6jpQP9JMT52KoSVI/A1TxPSNWxUBoOM84nT71EGKTrGY3/JhnW4gX18iHLpB6GOekyDm
         +DFA==
X-Gm-Message-State: AOAM532IuN2+ErsO9jwJ90SkSjqrMl9BfyMqxOa+uooLclyLfTeIKlf+
        2agNcxw7/ffrGcP/g/G45JvQYrR5HEcaGA==
X-Google-Smtp-Source: ABdhPJxjEjieR1eWGnWmOrKK7EqGckvOLz6a81CIg52CDCjBQ0NqMQcG6SpsgadZ2EWXdh3aRqGGYQ==
X-Received: by 2002:a2e:9694:: with SMTP id q20mr6409864lji.279.1606603305138;
        Sat, 28 Nov 2020 14:41:45 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:44 -0800 (PST)
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
Subject: [PATCH v2 12/28] video: fbdev: tdfx: Fix set but not used warning in att_outb()
Date:   Sat, 28 Nov 2020 23:40:58 +0100
Message-Id: <20201128224114.1033617-13-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The tmp variable were assigned but the result was never used,
so delete the tmp variable.

v2:
  - Update subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>
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

