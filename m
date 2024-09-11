Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF03185606;
	Wed, 11 Sep 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065062; cv=none; b=KeKjVNi4LDOBe9pLnzGschQG6yPej/ipb6Qcvnlmk/ttdXg1nvVvls1AE5MDPAf4p240i4GUMbfyUGDtWuerR6TOO1KIMltf9JCE4NQgF/Zv4hGtABNwzslIfLnGPJ0CarGf2pmStb8dqSpKUDjaI1l5hC0knn+bf6T6LIgXTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065062; c=relaxed/simple;
	bh=+0RRQI371JwlBeboT9GF49cq6sF+GAbP9dyGVitN45E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IaRxBqgPI64bEii9hDJhxysgLgHshZ4wBQhaHha00MZpNZDW4tLwL4mU862hV1JV7Yb6eGJTUTv4sHD/4oXrxv7+cawUReUDDW9mh8O7+U/QtqN4Hhw9rx+zhHySo8oKoD/SQzULzUzUXf4dcA5jO+FYKMCIc7lParG4LFAKkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpsz2t1726064993t5ok0ar
X-QQ-Originating-IP: P6ukSmdqm9PfLsf7wEuHBvtMtOeR6xq2pUfo5KSx/GY=
Received: from fastnlp.. ( [202.120.234.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Sep 2024 22:29:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3987430628644740193
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: deller@gmx.de
Cc: 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kuninori.morimoto.gx@renesas.com,
	laurent.pinchart@ideasonboard.com,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH] fbdev: pxafb: Fix use after free vulnerability in pxafb_driver Driver Due to Race Condition
Date: Wed, 11 Sep 2024 22:29:52 +0800
Message-Id: <20240911142952.833223-1-kxwang23@m.fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

In the pxafb_probe function, it calls the pxafb_init_fbinfo function,
after which &fbi->task is associated with pxafb_task. Moreover,
within this pxafb_init_fbinfo function, the pxafb_blank function
within the &pxafb_ops struct is capable of scheduling work.

If we remove the module which will call pxafb_remove to make cleanup,
it will call unregister_framebuffer function which can call
do_unregister_framebuffer to free fbi->fb through
put_fb_info(fb_info), while the work mentioned above will be used.
The sequence of operations that may lead to a UAF bug is as follows:

CPU0                                                CPU1

                                   | pxafb_task
pxafb_remove                       |
unregister_framebuffer(info)       |
do_unregister_framebuffer(fb_info) |
put_fb_info(fb_info)               |
// free fbi->fb                    | set_ctrlr_state(fbi, state)
                                   | __pxafb_lcd_power(fbi, 0)
                                   | fbi->lcd_power(on, &fbi->fb.var)
                                   | //use fbi->fb

Fix it by ensuring that the work is canceled before proceeding
with the cleanup in pxafb_remove.

Note that only root user can remove the driver at runtime.

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
---
 drivers/video/fbdev/pxafb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 2ef56fa28aff..5ce02495cda6 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2403,6 +2403,7 @@ static void pxafb_remove(struct platform_device *dev)
 	info = &fbi->fb;
 
 	pxafb_overlay_exit(fbi);
+	cancel_work_sync(&fbi->task);
 	unregister_framebuffer(info);
 
 	pxafb_disable_controller(fbi);
-- 
2.25.1

