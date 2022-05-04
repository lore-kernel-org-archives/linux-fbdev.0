Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDACC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 21:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbiEDVzq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 17:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbiEDVzp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 17:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41FB950066
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 14:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651701127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tx5EF/oHY4MnR+1kAy1pN1/nvTcQ0mL5kPtxJFa0zjA=;
        b=WaFxzVxPN+neN0iSbgbxeMGerHlRUra3p8GCxcBOTAcKORXoVz2e9Esdnl3nPefl5nR4A4
        lyVgZz2m6PG4CLNf18PkDgxKJ4NjpvEFH/4ri7NMW8CVGilb9Q/eymm6Wqr8YX2TZLv8lK
        OWH6kgQnCve0bNo9NsuZd55KJT6fFdw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-uLdE6pexPy61xAGB3f_4IA-1; Wed, 04 May 2022 17:52:05 -0400
X-MC-Unique: uLdE6pexPy61xAGB3f_4IA-1
Received: by mail-wm1-f69.google.com with SMTP id i131-20020a1c3b89000000b00393fbb0718bso3594025wma.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 14:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tx5EF/oHY4MnR+1kAy1pN1/nvTcQ0mL5kPtxJFa0zjA=;
        b=uC/5DEOZfcmBisOAYCRfV8K5FiRvqoq/G5ZJWiwO++RYY8RoBqEiDTWrSYxACdsju6
         N80oqRaWwOAFoFip4lp07ZlIYDNJzHem4ZR1Dr4bj6V1I81US6C+KZepy0+46iUYofAg
         i2JIvccRy/SftdVOCDe5JyqdgjswAFqQrRgQ5g9ZHApZynthaO8FtmC0rf+aqXdjYAGd
         i/o/RXb0Fj5V75eleQTe3Q3ru8xL/up9Ga0S5eTu7PSm8a10nwtfvG3n5+gNg0OebOFP
         LX2I6xg8CBFFDb85HE0ctvFZ5Tq30tWyc4VrFisFuuc9Xv45nnKTg2QJpvwz2Ugd7rwQ
         sgrQ==
X-Gm-Message-State: AOAM531EZMj0sFSgyFhPjQvTkW4BVnFpO3iUdW6XyfgrwrZz7p9XfVD7
        Veka5NuCpql+VBjqAb4I+hKfspR+nFq1O+EGJdJratS4ZFI8veFofvozYQ0wOONvuhh+T9bss3L
        5SkQwS7k1JHJhzLcNDeBv8as=
X-Received: by 2002:a5d:4307:0:b0:207:8e25:6cfa with SMTP id h7-20020a5d4307000000b002078e256cfamr18100076wrq.434.1651701124560;
        Wed, 04 May 2022 14:52:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXSDPAjTAE9apOh0uk1c6QEqTiB3+5xlkiYFpJB/o+TcAsRLgUFfpZkBdZBhnJzHSrHqLJZA==
X-Received: by 2002:a5d:4307:0:b0:207:8e25:6cfa with SMTP id h7-20020a5d4307000000b002078e256cfamr18100060wrq.434.1651701124337;
        Wed, 04 May 2022 14:52:04 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q14-20020adfaa4e000000b0020c5253d91fsm12822310wrd.107.2022.05.04.14.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 14:52:03 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 0/3] fbdev: Fix use-after-free caused by wrong fb_info cleanup in drivers
Date:   Wed,  4 May 2022 23:51:48 +0200
Message-Id: <20220504215151.55082-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

This series contains patches suggested by Daniel Vetter to fix a use-after-free
error in the fb_release() function, due a fb_info associated with a fbdev being
freed too early while a user-space process still has the fbdev dev node opened.

The is cuused by a wrong management of the struct fb_info lifetime in drivers,
but the fbdev core can also be made more resilient about it an leak

This can easily be reproduced with the simplefb driver doing the following:

$ cat < /dev/fb0 &
$ echo simple-framebuffer.0 > /sys/bus/platform/drivers/simple-framebuffer/unbind
$ kill %1

[  257.490471] ------------[ cut here ]------------
...
[  257.495125] refcount_t: underflow; use-after-free.
[  257.495222] WARNING: CPU: 0 PID: 975 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x144
...
[  257.637482] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  257.644441] pc : refcount_warn_saturate+0xf4/0x144
[  257.649226] lr : refcount_warn_saturate+0xf4/0x144
[  257.654009] sp : ffff80000a06bbf0
[  257.657315] x29: ffff80000a06bbf0 x28: 000000000000000a x27: 000000000000000a
[  257.664448] x26: 0000000000000000 x25: ffff470b88c6a180 x24: 000000000000000a
[  257.671581] x23: ffff470b81706480 x22: ffff470b808c2160 x21: ffff470b8922ba20
[  257.678713] x20: ffff470b891f5810 x19: ffff470b891f5800 x18: ffffffffffffffff
[  257.685846] x17: 3a725f7463656a62 x16: ffffbb18c6465fd4 x15: 0720072007200720
[  257.692978] x14: 0720072d072d072d x13: 0a2e656572662d72 x12: 657466612d657375
[  257.700110] x11: 203b776f6c667265 x10: 646e75203a745f74 x9 : ffffbb18c58f6c90
[  257.707242] x8 : 75203b776f6c6672 x7 : 65646e75203a745f x6 : 0000000000000001
[  257.714373] x5 : ffff470bff8ec418 x4 : 0000000000000000 x3 : 0000000000000027
[  257.721506] x2 : 0000000000000000 x1 : 0000000000000027 x0 : 0000000000000026
[  257.728638] Call trace:
[  257.731075]  refcount_warn_saturate+0xf4/0x144
[  257.735513]  put_fb_info+0x70/0x7c
[  257.738916]  fb_release+0x60/0x74
[  257.742225]  __fput+0x88/0x240
[  257.745276]  ____fput+0x1c/0x30
[  257.748410]  task_work_run+0xc4/0x21c
[  257.752066]  do_exit+0x170/0x370
[  257.755288]  do_group_exit+0x40/0xb4
[  257.758858]  get_signal+0x8e0/0x90c
[  257.762339]  do_signal+0x1a0/0x280
[  257.765733]  do_notify_resume+0xc8/0x390
[  257.769650]  el0_da+0xe8/0xf0
[  257.772613]  el0t_64_sync_handler+0xe8/0x130
[  257.776877]  el0t_64_sync+0x190/0x194
[  257.780534] ---[ end trace 0000000000000000 ]---

Patch #1 adds a WARN_ON() to framebuffer_release() to prevent the use-after-free
to happen.

Patch #2 and patch #3 fixes the simplefb and efifb drivers respectively, to
free the resources at the correct place.


Daniel Vetter (1):
  fbdev: Prevent possible use-after-free in fb_release()

Javier Martinez Canillas (2):
  fbdev/simplefb: Cleanup fb_info in .fb_destroy rather than .remove
  fbdev/efifb: Cleanup fb_info in .fb_destroy rather than .remove

 drivers/video/fbdev/core/fbsysfs.c | 4 ++++
 drivers/video/fbdev/efifb.c        | 9 ++++++++-
 drivers/video/fbdev/simplefb.c     | 8 +++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.35.1

