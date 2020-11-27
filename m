Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438A3C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF30E22255
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjuKWshb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgK1BXB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbgK0UBJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:09 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97193C08E863
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:41 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s27so8562150lfp.5
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dUZy5AyOXYDj2k6s63lZ9ADEngOOXb1VvoVlRiIbSA=;
        b=MjuKWshbXzpQxhEMy1+a7PgY3BUmh4NKhTLvba9JMkrPSZAUulqFr2FQHBqGVk9Cgc
         Jsue6qrqGil2Huy/DKFQ8LjxZ/TGXPJUG/4d172uj1o/ffbZjypW7fMNlskOPL8R82Qb
         4jSwKbPC+Ec+57sXNmOzpM1PUlydBVZuRD2+aeSJT8yGM1xbZQ/PZwva2SUtdLdjdhqq
         stBM+vQgRx44O7SxwewScrN8T4iqOymIm8aKr+9g8wAI9X93wrxdlNkK5QN/VMok5pB6
         kUOcpS5nDqX8JlWdiAQ+VTORorBfMhjM91S/c2qf2uIrjnfgrJogZfUWj6mtVz6X12Vb
         2DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0dUZy5AyOXYDj2k6s63lZ9ADEngOOXb1VvoVlRiIbSA=;
        b=en0oJDejw5VNrF6uYxLhupb62oXzM+fnj0WXSmZXWDH0u3khNEZZoT9sZgHQE5Lnxz
         slKeM0mQpS+2+j8wqAiCIastiTro4ceXln+6W7gKAbCJgLaI0LgqKLatL/8h1mas22Xb
         uAPPNVg3Qa38NSkSvXslSYRl9Sw/soJfY4ffOwKxDPdK7XFBgYKTWDz+WG0kC5vMCCjj
         NEC0VlG/uNsP+7pwu8anZfyGBUZ0aQAGUPzciYYdprOklAWDLFW08cnZj8+g9SNqNts8
         ZxBL9z4Y8A12YMipmvTV/dc7zBhAKIDpblxyotANPP3M+WUBKQMUpSH4SBUfhunHzU3a
         E2Jw==
X-Gm-Message-State: AOAM533mfk/zf/DD0Aov2PfV7d/nFDwksDPPahnqWL1RlezQHzUG3J/f
        xNBgToX7OD6cNeq6tYwIKmqGT3Jr0BlONL9p
X-Google-Smtp-Source: ABdhPJy2ZKM89RK3vlOw0vIIpP/pIYwaQgPn9/q3zJF7dVDoEGUxmqssdj4WEHCuxoR1HWo+YV/lHQ==
X-Received: by 2002:ac2:550d:: with SMTP id j13mr4446626lfk.301.1606507179931;
        Fri, 27 Nov 2020 11:59:39 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:39 -0800 (PST)
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
Subject: [PATCH v1 25/28] video: fbdev: uvesafb: Fix W=1 warning
Date:   Fri, 27 Nov 2020 20:58:22 +0100
Message-Id: <20201127195825.858960-26-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warning by deleting unused local variable.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/uvesafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index def14ac0ebe1..8ee0fc9c63cf 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -554,12 +554,12 @@ static int uvesafb_vbe_getmodes(struct uvesafb_ktask *task,
 static int uvesafb_vbe_getpmi(struct uvesafb_ktask *task,
 			      struct uvesafb_par *par)
 {
-	int i, err;
+	int i;
 
 	uvesafb_reset(task);
 	task->t.regs.eax = 0x4f0a;
 	task->t.regs.ebx = 0x0;
-	err = uvesafb_exec(task);
+	uvesafb_exec(task);
 
 	if ((task->t.regs.eax & 0xffff) != 0x4f || task->t.regs.es < 0xc000) {
 		par->pmi_setpal = par->ypan = 0;
-- 
2.27.0

