Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2967AC63777
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D860820771
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roBw2ATo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbgK1WnG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388271AbgK1WnE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:04 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6EC08E85E
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:01 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f18so10579763ljg.9
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrtndvvG0M5u09IYAUmRgX+zXZ1Dkud8V3tonnF9qQM=;
        b=roBw2ATop181hwYHcBLwFp1eSYJ/3/IlOEUmM3XZ1UHyuImT3vGnihkTeWdY0tW/BR
         ZZLJkQCFGPYMa/9rFLwT7E9hMJB2ha1AP3M5hse1/JnNbV2HgbEJ/A2asaPZAFhoIYj+
         y/p9IFjpDDgMJy0ocfW+t9R7UN4xlxwToILq5UWaU29JuKYKgOLBBZLA+zzwfqDPSBxX
         TuaSidpPotdrN2+xi0bm6Y7APaz055RaavQDWBWtsDvi9t/4XGiWN5UfYM9alWp5N8kp
         Bx3AqdyWOfABLwLjIdxppZznIYAeDrTpoeCh4aLtegGE9We6EU9Ly/FLg2Mio1QnrhLW
         1vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mrtndvvG0M5u09IYAUmRgX+zXZ1Dkud8V3tonnF9qQM=;
        b=SgDNmnvtReRbmw+E882q4ge4pW6MxLWOfmSYQIMo/TpAoUyB2BBXQNuf7hnJ9xrQLq
         6+sA63DlEyZNUDYM2u93pGomrDZTGCISg7WyU/XG3K3csDt2xk/5rq48FLti7oNrnu4D
         M0pMpUtO5u82T3ZkWidTyy487eRVeKEhqGNS4pIAT+UYQ//mcn79kyux/erpxY4eYliX
         m2hmr3e946aWSVhtBYeZrzimgv3DhpOJozwUBPfWNtfV6JXpCaybanI+vi3qCxcYuh/N
         +NOq7KM6NSH447wd+ImdwwE6vdG1KCQMBrgUdBPOLgrr1nZlYyzvXll4Wcn6Xi4ZscYd
         NIBA==
X-Gm-Message-State: AOAM5336e4XuD/ZILukzHGUgkngkM55KL+y88zibNeVVU3AjoCFJKMpK
        d1vdrWPejqGginhfkIPrdJTlM+EH+cSVZg==
X-Google-Smtp-Source: ABdhPJwNL3q+1JGxkJO+BEF4jOeWF1Djf3ezGNvxKzq2WbzTn2QNUr+I3reU8uOJYba+vVxHu5OrzA==
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr6335837ljk.150.1606603320153;
        Sat, 28 Nov 2020 14:42:00 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:59 -0800 (PST)
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
Subject: [PATCH v2 20/28] video: fbdev: nvidia: Fix set but not used warnings
Date:   Sat, 28 Nov 2020 23:41:06 +0100
Message-Id: <20201128224114.1033617-21-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix warnings by deleting unused code. The register reads are
kept as it is unknown if there are any hidden side-effects.

v2:
  - Update subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>
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

