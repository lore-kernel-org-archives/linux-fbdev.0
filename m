Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34944C433E0
	for <linux-fbdev@archiver.kernel.org>; Sun, 28 Feb 2021 05:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F210B64E01
	for <linux-fbdev@archiver.kernel.org>; Sun, 28 Feb 2021 05:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhB1Fb3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 28 Feb 2021 00:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhB1Fb1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 28 Feb 2021 00:31:27 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423CEC06174A;
        Sat, 27 Feb 2021 21:30:47 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d11so9051636qtx.9;
        Sat, 27 Feb 2021 21:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XUOjIahCE3m3vqcOaZ6XgdoLkVb449SXw7uK1/M5V3g=;
        b=MuwZKT9UvXBdOYHaV4/EciRChdOhh5hxcyYDVfc+5GNOHOaRuNESeLbLfHECxdv4Kn
         CX6aylPzdYia0JEGyukL5sa6k87d2Zk6WCSjDOmjVlix1xLVb0FkeRL1mDhlgtS0jQXw
         qmx/msyYGtB9DR4De6Crf/SCcOF7ZE0gAfcH59pHmY96UjWZHnxCaotxuc+IuHhmOIy3
         jykXM29/CQVg40QGZzAoGonZnHYWZUigAMm8/qYIYgnXjTf/E+YAAFYiqwa2ta5M8ZrF
         rBRYJ5TF+l0GSdD0XRfHF/GAFKi36EqmqneeFBg1SOJ2miWGfqtsWQ6wfYrkbG/NHa0F
         lhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XUOjIahCE3m3vqcOaZ6XgdoLkVb449SXw7uK1/M5V3g=;
        b=kAsDLKu1mTwaiGVbWJNXftZ4eou5lffiepQJIVUbuu6TWeQ0MlU+OgjgqBg+WEydwa
         QB/joV21lasMblsmLmjPskkaLMi22qgp4eHBiGyZfyhOO/moDd3PeqPKGb55eKmBgUZy
         qm0ZCRK/A+F3ZDZvoZAZZELEB/47mh0P2x8DQbeohhla7KnjpgWB+8MQoVWi7Y8rBYQQ
         v6QGWS29gD1nZZuzxGj+sjc9MbwQuQBCFBOWVm27eswShPeMObloshgtOb4TOpu9Lqkl
         GJMuExzd03UaJM2UwG6xOxkBReL69+eSMz+EjvLYA1I+5pCRoemZLt1Qg8xfsJvoVA+E
         2zMA==
X-Gm-Message-State: AOAM532vXQyFLmJP5HkdhcmeBr2qQcokKB+wm59OjTa5hORqhmdQL+A1
        grXat5pkuy26NAyZKtcvhVWYV13cts9DRQ==
X-Google-Smtp-Source: ABdhPJzJqiTDSuCeDvpyz+fZRp4K1vOddRwuBKzeTGhVSvawFga+ywpgxU+0Q1bAlmV0s9/x8bfqyQ==
X-Received: by 2002:ac8:4d07:: with SMTP id w7mr8625447qtv.70.1614490246356;
        Sat, 27 Feb 2021 21:30:46 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:94d2:9984:c3fe:c09a])
        by smtp.googlemail.com with ESMTPSA id i13sm8755906qtv.95.2021.02.27.21.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 21:30:46 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Thomas Winischhofer <thomas@winischhofer.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH] video: fbdev: sis: catch out of bounds in SiS_DoCalcDelay
Date:   Sun, 28 Feb 2021 00:30:40 -0500
Message-Id: <20210228053040.231920-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

idx1 is read from hardware and the range is [0, 30],
the size of ThLowA and ThLowB is 24, so there could possibly an out of
bounds access. This patch catches the OOB access and print a warning.

[    4.771691] ==================================================================
[    4.771693] BUG: KASAN: global-out-of-bounds in SiS_DoCalcDelay+0xa9/0x160 [sisfb]
[    4.771718] Read of size 1 at addr ffffffffc0048b1f by task modprobe/96
[    4.771722] CPU: 0 PID: 96 Comm: modprobe Not tainted 5.11.0-rc7 #92
[    4.771727] Call Trace:
[    4.771729]  dump_stack+0x7d/0xa3
[    4.771733]  print_address_description.constprop.0+0x1a/0x140
[    4.771738]  ? SiS_DoCalcDelay+0xa9/0x160 [sisfb]
[    4.771760]  ? SiS_DoCalcDelay+0xa9/0x160 [sisfb]
[    4.771782]  kasan_report.cold+0x7f/0x10e
[    4.771786]  ? SiS_DoCalcDelay+0xa9/0x160 [sisfb]
[    4.771808]  SiS_DoCalcDelay+0xa9/0x160 [sisfb]
[    4.771830]  ? SiS_GetFIFOThresholdIndex300+0xb0/0xb0 [sisfb]
[    4.771853]  ? sisfb_probe.cold+0x3a0f/0x4f7d [sisfb]
[    4.771876]  ? SiS_GetRefCRTVCLK+0x6c/0x80 [sisfb]
[    4.771900]  ? SiS_GetVCLK2Ptr+0x28b/0x800 [sisfb]
[    4.771923]  SiSSetMode+0x26de/0x4770 [sisfb]
[    4.771946]  ? SiS_LoadDAC+0x3e0/0x3e0 [sisfb]
[    4.771968]  ? ___slab_alloc+0x412/0x5d0
[    4.771971]  ? set_inverse_trans_unicode.isra.0+0x147/0x170
[    4.771975]  ? sisfb_syncaccel+0x12f/0x140 [sisfb]
[    4.771998]  sisfb_set_mode.isra.0+0x264/0x12b0 [sisfb]
[    4.772020]  ? kasan_module_alloc+0x5f/0xc0
[    4.772023]  sisfb_set_par+0x3b3/0x930 [sisfb]
[    4.772046]  fbcon_init+0x447/0x980
[    4.772049]  ? sisfb_probe+0x1490/0x1490 [sisfb]
[    4.772071]  visual_init+0x182/0x240
[    4.772074]  do_bind_con_driver+0x2db/0x460
[    4.772078]  do_take_over_console+0x205/0x280
[    4.772082]  do_fbcon_takeover+0x80/0x100
[    4.772085]  register_framebuffer+0x301/0x4c0
[    4.772088]  ? do_remove_conflicting_framebuffers+0xf0/0xf0
[    4.772092]  ? fb_copy_cmap+0x10b/0x160
[    4.772096]  sisfb_probe.cold+0x2fca/0x4f7d [sisfb]
[    4.772120]  ? rpm_resume+0x1cd/0xac0
[    4.772124]  ? sisfb_check_var+0x990/0x990 [sisfb]
[    4.772146]  ? pm_runtime_get_if_active+0x190/0x190
[    4.772150]  ? _raw_spin_lock_irqsave+0x7b/0xd0
[    4.772154]  ? _raw_spin_lock_irqsave+0x7b/0xd0
[    4.772157]  ? __mutex_lock_slowpath+0x10/0x10
[    4.772161]  ? sisfb_check_var+0x990/0x990 [sisfb]
[    4.772183]  local_pci_probe+0x6f/0xb0
[    4.772349] The buggy address belongs to the variable:
[    4.772350]  ThLowA.47581+0x1f/0xffffffffffff9500 [sisfb]
[    4.772373]
[    4.772373] Memory state around the buggy address:
[    4.772375]  ffffffffc0048a00: 00 00 00 00 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
[    4.772377]  ffffffffc0048a80: 00 00 05 f9 f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9
[    4.772379] >ffffffffc0048b00: 00 00 00 f9 f9 f9 f9 f9 00 04 f9 f9 f9 f9 f9 f9
[    4.772380]                             ^
[    4.772382]  ffffffffc0048b80: 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 00 07 f9 f9
[    4.772384]  ffffffffc0048c00: f9 f9 f9 f9 00 00 00 f9 f9 f9 f9 f9 00 f9 f9 f9
[    4.772385] ==================================================================

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/video/fbdev/sis/init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index b568c646a76c..fb9815e7af4b 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -2249,6 +2249,10 @@ SiS_GetFIFOThresholdA300(unsigned short idx1, unsigned short idx2)
 		34, 3,37, 5,47, 7, 67,11
    };
 
+   if (idx1>22) {
+     printk(KERN_WARNING "idx1 out of bounds: %d\n", idx1);
+     idx1 = 22;
+   }
    return (unsigned short)((ThLowA[idx1 + 1] * idx2) + ThLowA[idx1]);
 }
 
@@ -2261,6 +2265,10 @@ SiS_GetFIFOThresholdB300(unsigned short idx1, unsigned short idx2)
 		42, 4,45, 6,55, 8, 75,12
    };
 
+   if (idx1>22) {
+     printk(KERN_WARNING "idx1 out of bounds: %d\n", idx1);
+     idx1 = 22;
+   }
    return (unsigned short)((ThLowB[idx1 + 1] * idx2) + ThLowB[idx1]);
 }
 
-- 
2.25.1

