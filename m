Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC0C63777
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9042224E
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF9fwez/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgK1B1U (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731215AbgK0UAz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 15:00:55 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96808C061A48
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:28 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id i17so7139167ljd.3
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kSOTWA+7s6AOb+69TSTraRrpPzvQt0NSKodoDw/MKE=;
        b=qF9fwez/8eaHyKOX5BvHZDGWBo8OtRqL2a/PzPIQyIbhyLEOO7waJR7Z0THGhHMceD
         RckmI4o1wQh67jeR6LjecdUPPo5kDcu117113Z9ni218DuH6CkR8YoQtniRJbgO7Eu5p
         BD/aCCHWbEkkxq2ZRld7/VYfPoeEA5KAieFBVOWJSyZnwDMV9Qx0kAGGXW2d6ORuxaFV
         ng7b0pFUuDPJyq0J2aGoG4aHLBIk6yh4PL8gax6RSGwlyAYQk1H3+mj3cC77H9I4TI43
         YS5lOmapuee8ceUM8hT+sW2koepygnS6aJwBOs3blDtAmFM0q/Iud2UzmOkzjbOq0TYQ
         1eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9kSOTWA+7s6AOb+69TSTraRrpPzvQt0NSKodoDw/MKE=;
        b=EhRT4O1AjLBTeg7tQtpy5xl+XmbXY31loILHj/LxcGfiwBji83d5SU6rbmBBObhhmt
         uljr4BzvPWETTdha9uu7Cpu+efQ5vBI2JAxEUoBP99OWLDLADd0wOduACZ5ikzYV1f+O
         GLEBl89+hYiUp+ANhq8X+sB2zcmdHwKRoS59tyhMvx5d9fhvCxOjzYz03vi8XN4gXClN
         EWcKXh8fDBJkkRifE7qrPzq4elGAPqED7+hR7GdJQCzPSRaQXyMuefAPWGQLG1inKTmS
         n55CCul6o417iXZL8fKxW/2rpMXVZ88Ti7TZ9B3ztpoAfFlSq+haSjAOI+p9zTZVfuAl
         bnTA==
X-Gm-Message-State: AOAM532u5eu0zUce4CL3CqlaZNCfJet8L9BmHCvt8lNA7bikcFZJS1+Q
        /J08qHGu1cc4DYZnIZveB7HJySXIuQM2elmO
X-Google-Smtp-Source: ABdhPJyiPskz8/EA3qnZwsG8Wc64GE4af1+UWpYPCXIfNajx7wDDAG0cU5XuIvRrf/LNtcypwTCcqQ==
X-Received: by 2002:a2e:7803:: with SMTP id t3mr4447881ljc.176.1606507166788;
        Fri, 27 Nov 2020 11:59:26 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:26 -0800 (PST)
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
Subject: [PATCH v1 20/28] video: fbdev: nvidia: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:17 +0100
Message-Id: <20201127195825.858960-21-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix warnings by deleting unused code

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/nvidia/nv_setup.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_setup.c b/drivers/video/fbdev/nvidia/nv_setup.c
index 2fa68669613a..5404017e6957 100644
--- a/drivers/video/fbdev/nvidia/nv_setup.c
+++ b/drivers/video/fbdev/nvidia/nv_setup.c
@@ -89,9 +89,8 @@ u8 NVReadSeq(struct nvidia_par *par, u8 index)
 }
 void NVWriteAttr(struct nvidia_par *par, u8 index, u8 value)
 {
-	volatile u8 tmp;
 
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
+	VGA_RD08(par->PCIO, par->IOBase + 0x0a);
 	if (par->paletteEnabled)
 		index &= ~0x20;
 	else
@@ -101,9 +100,7 @@ void NVWriteAttr(struct nvidia_par *par, u8 index, u8 value)
 }
 u8 NVReadAttr(struct nvidia_par *par, u8 index)
 {
-	volatile u8 tmp;
-
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
+	VGA_RD08(par->PCIO, par->IOBase + 0x0a);
 	if (par->paletteEnabled)
 		index &= ~0x20;
 	else
-- 
2.27.0

