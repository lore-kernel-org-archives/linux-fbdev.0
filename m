Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81535C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D00221EB
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R58XIdGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgK1BgJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C5C061A55
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:12 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id j10so7135799lja.5
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgiE3cPN0UhMAdrlJWfRmuc0aOS7JyS2T35N0ifDz8w=;
        b=R58XIdGE58Q9Aqsn5XSsimwgH605ifHUH233P5OBuNNPP/RYguS8aO5o3GlEgZt581
         spr/LRdVgVkbi1AhiYsfC98VaQ3JqvMaoBzBhZ4flEJST452YUwa9iU93QtLCCrczo3e
         5cj9BzzHIAPRW5R/tWshMPWP5b4aWah2WsZPbTharCUvcAoIo77TXv4iEblCxXgm+QNh
         m/vcUOofhBOYXTHjdheU9gMIhM37Sd67xTqxYEjjpfdxZvhz69VQQ4G9dwRMBBYSkS+g
         uIAzMJJ1kqWn6ChaKymZa7rRNHDvTBbTPWH88HuvvjZOqQku8AY2DvaN6D25/XODOKZR
         8SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dgiE3cPN0UhMAdrlJWfRmuc0aOS7JyS2T35N0ifDz8w=;
        b=D/lf65md5xcstJXg/he9j3ttV/4TxDs0ZgpEarKnXyM6NjpR5/1avbaO/nZR0PcWrA
         ttgUbquOeum+r+dTuPFCsYRG9ZPxKfwFonEWJKYvgDKacqTrckJH/aFx72jfhnvhaZib
         w69EV2QInQ2Z7ZS6Cp6coRAxEMhtzoMnCTqNNFrqy5fu51QrzfPQnubgCJ2pD3jfJ3Yk
         4pybxP/tpu7oVj/Dhhg22mkRs50SzIlGYP7MK6ua2h0fuhlaiF+g+iXCzkBvDg8FXy/e
         eErpPjtY3gbLFuQmuaX2TkniwzbWQdQMt1yCGBNKukIf1HxHNhZ04vHxvKUXhUGi1enm
         hsfg==
X-Gm-Message-State: AOAM532C5R2tsY6q2ucddJYQiy5A4TpWhMAp7/8O6poCHWFAMmq5hxTF
        PS4TOBECEzTBwbIv8OOvDbaLrzjC2x5ShtFL
X-Google-Smtp-Source: ABdhPJx/A+ivNr8kMaMUsxMdcnxwLhpbFPdQSjML9Bzel1DEIBHBsJjnBMP5knP9/Ca+mACkvp9t9w==
X-Received: by 2002:a2e:95c7:: with SMTP id y7mr1233763ljh.115.1606507150978;
        Fri, 27 Nov 2020 11:59:10 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:10 -0800 (PST)
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
Subject: [PATCH v1 14/28] video: fbdev: pm2fb: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:11 +0100
Message-Id: <20201127195825.858960-15-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixed a few kernel-doc issues to fix the warnings.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/pm2fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 27893fa139b0..c68725eebee3 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -1508,8 +1508,8 @@ static const struct fb_ops pm2fb_ops = {
  *
  * Initialise and allocate resource for PCI device.
  *
- * @param	pdev	PCI device.
- * @param	id	PCI device ID.
+ * @pdev:	PCI device.
+ * @id:		PCI device ID.
  */
 static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -1715,7 +1715,7 @@ static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  *
  * Release all device resources.
  *
- * @param	pdev	PCI device to clean up.
+ * @pdev:	PCI device to clean up.
  */
 static void pm2fb_remove(struct pci_dev *pdev)
 {
@@ -1756,7 +1756,7 @@ MODULE_DEVICE_TABLE(pci, pm2fb_id_table);
 
 
 #ifndef MODULE
-/**
+/*
  * Parse user specified options.
  *
  * This is, comma-separated options following `video=pm2fb:'.
-- 
2.27.0

