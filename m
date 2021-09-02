Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A8C432BE
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Sep 2021 06:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143EE60FDC
	for <linux-fbdev@archiver.kernel.org>; Thu,  2 Sep 2021 06:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhIBGD5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 2 Sep 2021 02:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhIBGD4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 2 Sep 2021 02:03:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F9FC061575;
        Wed,  1 Sep 2021 23:02:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x16so516031pll.2;
        Wed, 01 Sep 2021 23:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Re97f8GY8el/iMPEVsgvs7BOVwiJIsCI6/eriuguFs=;
        b=qYM0fQHbJkFQBDJkvzUuDFiPIL9wUxxedWDBsnxtjqQ1jsEMrFcnKPeCW00LVfmuDv
         lpej30BlLxCHsbjmobKInFNUsVZ5oBG7ihweYbzozYQhwdkcYaqSq+05fCQp22eP61hN
         +YhPn6xJ+lzUN/5dHRS9CN7zauoJMAJGZ3PTANaRxmClQgMzc3YgKRzxHA7x27IMzbBP
         AsD3gWqNBPXRixc4QuEXQDomuj1tk4txgCRK7SSKnmEw1/O0EN/+Asx9nzBFcVrJZgNq
         88mP5GH2RWnHm7bxs3H5s12BKPyf+a+XDM6b4730vlA+uo3BWc+agCQxHEejXtGyA+v8
         bzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Re97f8GY8el/iMPEVsgvs7BOVwiJIsCI6/eriuguFs=;
        b=ZolzaEBRJ7zVbM2FdLt8Ti7DIfmLQz1a1Ke2jYbKHZlPMDUtZ0PPU6ELEr1bEeisFc
         TI6JuTkNlkit6sVfE78RL4KaXTRQ5RuVn95f2/jk2hmDs+D6nRIERKnGFPmz2w/1uB6z
         JtFFrtHgt+dbc9xvFIbqehd9Ok8u1xNArJHIXZwakG1W7rL4fOsbAbRcIO6L0aO5afVu
         a8BRytgudIBMFPz2Bzbheduth6qYy/wRP62tO3rakU/0lBLJxt6/YZOY2gWtl6cV/LQI
         bommoDwhPFjBXuOtMtHbC8YhdCwD2A5yB9q8oWi5axBy3MNXPhD+74lW1bKX+Nv32RUO
         Mfng==
X-Gm-Message-State: AOAM5312qDkyz/eTtU+eAhiaLY3bx/DVCsWgDn2RzlMIlcbF/8ofGqo4
        QiDEUqgPSuQEoPz4q1VyC+0iR3UurkdPe64Y
X-Google-Smtp-Source: ABdhPJwWPxm9CgEPO6s+JVRKWITau8HOy+nSIb3lsNVCGvxW2B4ol2HQM+TcVuR4Z2k+TCFscKBoLw==
X-Received: by 2002:a17:902:e291:b0:138:de28:bee5 with SMTP id o17-20020a170902e29100b00138de28bee5mr1522293plc.40.1630562578473;
        Wed, 01 Sep 2021 23:02:58 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.48])
        by smtp.gmail.com with ESMTPSA id g17sm844047pfi.168.2021.09.01.23.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 23:02:57 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        George Kennedy <george.kennedy@oracle.com>,
        syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.19] fbmem: add margin check to fb_check_caps()
Date:   Thu,  2 Sep 2021 14:02:08 +0800
Message-Id: <20210902060213.1702544-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

[ Upstream commit a49145acfb975d921464b84fe00279f99827d816 ]

A fb_ioctl() FBIOPUT_VSCREENINFO call with invalid xres setting
or yres setting in struct fb_var_screeninfo will result in a
KASAN: vmalloc-out-of-bounds failure in bitfill_aligned() as
the margins are being cleared. The margins are cleared in
chunks and if the xres setting or yres setting is a value of
zero upto the chunk size, the failure will occur.

Add a margin check to validate xres and yres settings.

Note that, this patch needs special handling to backport it to linux
kernel 4.19, 4.14, 4.9, 4.4.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reported-by: syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1594149963-13801-1-git-send-email-george.kennedy@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 84845275dbef..de04c097d67c 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -991,6 +991,10 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 			goto done;
 		}
 
+		/* bitfill_aligned() assumes that it's at least 8x8 */
+		if (var->xres < 8 || var->yres < 8)
+			return -EINVAL;
+
 		ret = info->fbops->fb_check_var(var, info);
 
 		if (ret)
-- 
2.25.1

