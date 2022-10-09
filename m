Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD243C433F5
	for <linux-fbdev@archiver.kernel.org>; Sun,  9 Oct 2022 09:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJIJtF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 9 Oct 2022 05:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJIJtF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 9 Oct 2022 05:49:05 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14C1E27CF8;
        Sun,  9 Oct 2022 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mUcFp
        mLT9kUT2t0x+XHFcFsDP2OugdtWyw1w9L5Qguk=; b=awivc3c6tiAxfF2D/lDPG
        QtYEzbEDb3vMoLqZTVMVo7baYc0/7+AzHuAetLB+G3cYKYBq6Sly1J7/m1tLEgi7
        C4BWlu6nKPq4yQ9sTTbuU8xuPeUyT60b7KbdKIDhZ5bfpiqarbddxHsgJLeOtUvh
        lMmihNlMt7kd3hLkMl2fhE=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp4 (Coremail) with SMTP id HNxpCgDXceDcmEJj+Wl6jQ--.51310S2;
        Sun, 09 Oct 2022 17:48:12 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] staging: sm750fb: fix spelling typo in comment
Date:   Sun,  9 Oct 2022 17:48:09 +0800
Message-Id: <20221009094809.3171319-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDXceDcmEJj+Wl6jQ--.51310S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury3WF45CFWDJw1UWr1fXrb_yoWkXrb_C3
        Z2qw4Iqrn2kFyxAr1jkayaqFyFva15Wr4ku3Z09rZxX39xArZ8Xryqvr47Z3s8uayxtFyS
        9r98XFy3K3WUJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1Tmh3UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbi8B2V+1uoiZvhHwAAsc
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

K2CI (Kylin Kernel Continuous Integration) is a code pre-verification tool
independently developed by KylinSoft, which is used for ensuring the
code quality of code submission. K2CI includes the comment check tool
notes_check.

This spelling typo was found using notes_check tool.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/staging/sm750fb/ddk750_dvi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index c2518b73bdbd..afdfdb17ffce 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -2,7 +2,7 @@
 #ifndef DDK750_DVI_H__
 #define DDK750_DVI_H__
 
-/* dvi chip stuffs structros */
+/* dvi chip stuffs structures */
 
 typedef long (*PFN_DVICTRL_INIT)(unsigned char edge_select,
 				 unsigned char bus_select,
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

