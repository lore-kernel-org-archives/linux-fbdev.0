Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C0C63777
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 00:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5842223F
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 00:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRT/DaQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgK0UCS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731293AbgK0UBR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:17 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A79C08E864
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:44 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so7156225ljk.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTz8UNZSB2sQnZVOY7U0wdeJbPp7ZoKiq9hM9XyTjD8=;
        b=dRT/DaQuxup56pjO/gXvCOHAFRuO1qWDIs0CBnqhSXDTtr/bSWQu2Ap+yUyq+B44+A
         neG0M7I0sJitoqxpbq2Yv0USUFFjoo6QhS/EEYu4HvbE8XHA+xb3ABCMI55iyfqUQdna
         yb0QgRDle+80a4z1OJrF3nyORqFTCGwJYztA3HK+rMcLIgnrNrLdcU0rtjUdmKBHKuLb
         vvInFX+bp4OkZ/2EEZ9lwNd07cypaYMY/o49aMZTVQQMGBaNI3fiK4OyR8I9tos2WUp6
         PnMnXcVo9CxblX4AV3NR0hsMeaf5lyqTZPMM24rlzSTWJHH3vMFitAk61/zxQnCnCFQr
         tJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cTz8UNZSB2sQnZVOY7U0wdeJbPp7ZoKiq9hM9XyTjD8=;
        b=RuCaH+NpY3iucQfhC3cq14w37paSNqejw2OUBS9p1/rTnD2UeG+JIWACZzzrurq86O
         Fm6voDdyojWw2SZ3IAlthY7xjqJwtDIJcG7RyDJtpqW80RWqjhH7DddR+3Y1F1yjEVk7
         +ebdbp2beI0g6T/4HIfV2SjQFZcwSkJ3yRZvS9MXxsvRazLXFMKr5sZQnIpSBYGQR/25
         bEqtXcdS4Knw2z0W1HxlgjExkQOFm2Manls8YOhDp6YqhJ8uRfbCa2q8oiLlakBJP6r9
         bwf84GsHOog5bt9qt0lhnc7uVMRFNwqsFNTauVzjVhh++2Sf2Ct27Q5WPmZXD0rRk0Wq
         aqEQ==
X-Gm-Message-State: AOAM530KarX48OWkfhqNGr/7rTf32DOvmtwXAyly54On3H72u3OM4cFt
        wiBPK1bSGQGHI5xxndNv59Zfso9izcY1SyCz
X-Google-Smtp-Source: ABdhPJw+juNp86cxlqMgAnqmJUMMNTIlemg5zHcEmGRNGhL2jyUtf2DC8PEqnsNHMepTLTQNwgzflA==
X-Received: by 2002:a2e:9951:: with SMTP id r17mr602111ljj.113.1606507182492;
        Fri, 27 Nov 2020 11:59:42 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:42 -0800 (PST)
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
Subject: [PATCH v1 26/28] video: fbdev: uvesafb: Fix W=1 string related warnings
Date:   Fri, 27 Nov 2020 20:58:23 +0100
Message-Id: <20201127195825.858960-27-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Two W=1 string related warnings.
- Using strncpy to copy string wihtout null-termination is not good.
  Use memcpy to copy only the relevant chars

- Fix a potential bug with a very long string, subtract one from the
  length to make room for the termination null.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/uvesafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 8ee0fc9c63cf..45dc8da191e4 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -423,7 +423,7 @@ static int uvesafb_vbe_getinfo(struct uvesafb_ktask *task,
 	task->t.flags = TF_VBEIB;
 	task->t.buf_len = sizeof(struct vbe_ib);
 	task->buf = &par->vbe_ib;
-	strncpy(par->vbe_ib.vbe_signature, "VBE2", 4);
+	memcpy(par->vbe_ib.vbe_signature, "VBE2", 4);
 
 	err = uvesafb_exec(task);
 	if (err || (task->t.regs.eax & 0xffff) != 0x004f) {
@@ -1871,7 +1871,7 @@ static ssize_t v86d_show(struct device_driver *dev, char *buf)
 static ssize_t v86d_store(struct device_driver *dev, const char *buf,
 		size_t count)
 {
-	strncpy(v86d_path, buf, PATH_MAX);
+	strncpy(v86d_path, buf, PATH_MAX - 1);
 	return count;
 }
 static DRIVER_ATTR_RW(v86d);
-- 
2.27.0

