Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AFAC63777
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DE620771
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbvH5lO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgK1WnQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgK1WnP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:15 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23526C08E861
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:11 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d8so12778439lfa.1
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjZfskooFlaX/DGp4t6swfhL0OZzCmQsrAHog/enb2E=;
        b=kbvH5lO6M/0b24ppZEXXjkELi137m8NHaDUi5sHcw9rgj9eEAMN+y8qSrVKSah43ZB
         kNzlmzEdaaOYOIiqJKn1QuTx4HECFGiNG5kIYtZVLjmzMMCYE8XksdHL9QrRejfF2L4k
         tc+pZ7F6yRNKZTfx/4k0M/8aHNQca6Le//TxOPNQg21tKPG0fpjao+tSkG0zUUx4C/p4
         Do2QuSanQTDFC5byyaFn272MmfSydSeWIcEeX7J1u6P/GHak3TWpJ9leOcXx3/rkepbU
         0rENcy6xxB0X63NjVUvqHntifA7cH13M+jadh0Cqw6o1lQjgi4jhld/Dj9XzIOnlgCBa
         Rg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CjZfskooFlaX/DGp4t6swfhL0OZzCmQsrAHog/enb2E=;
        b=c88pPIAdexRljtxSHPXZ8qwk2huLTDxDV8bpSoRPCAtvlzVblw6BuvlZvud0ec2K+z
         qanGkLulBFN5UKD9WzpWqsiO8A6a619PPH6QDZCfzH37O/vAzrmXUF9NxG4Wve/I+yl4
         Tt2k8IiE5FjVU4wPok+WJJt6yiFJihfC7ew/YlZyeiTzUCTQ5ucu9kqHrvHb04JIHt+p
         StCh6h0AVDrfiSx+a59/5KYkfjBlq6z0PUoScrSkFkeTuFFNZKg29Z03SFSqVaqsroaV
         j5YiT49IGlzHyRwQ5g+BslijYzhLje+s/7ktyRn2EFiNdGMnyEExHgcVRPGfoDzH87N4
         XJgA==
X-Gm-Message-State: AOAM5339PZ7KTkY47l1ETZb/gH8et6qvofIKvaRkosx321vwAwdpu7QR
        GrakIv0HHdZcQKMTtnkZLrRpNKuNsGoKyA==
X-Google-Smtp-Source: ABdhPJw+VsDQ4zX/JWQzp6JQylXffQeZeYKR1WVyqNC7V1IDBPsnpo4ION23xSBTKahJANEMfTaLxA==
X-Received: by 2002:a05:6512:5d7:: with SMTP id o23mr6317203lfo.272.1606603329464;
        Sat, 28 Nov 2020 14:42:09 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:42:08 -0800 (PST)
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
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Michal Januszewski <spock@gentoo.org>
Subject: [PATCH v2 25/28] video: fbdev: uvesafb: Fix set but not used warning
Date:   Sat, 28 Nov 2020 23:41:11 +0100
Message-Id: <20201128224114.1033617-26-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warning by deleting unused local variable.

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>
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

