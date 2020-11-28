Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693B1C63777
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D64F20771
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoeefBvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbgK1Wne (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbgK1Wne (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:34 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F0C08E862
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:12 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f18so10580150ljg.9
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRt4lLEdkGpEheHIyz2EqOhIIOjIMs1Mga1VdLe78eQ=;
        b=VoeefBvOMOJ6OPNTHJueecfrE6MmXuxLmNAA7cf5fmmxdPCgKYiwLWmH2i/opDC6sb
         t2wUpQXZ0vl5Aq+uHV8XCavGj69kuY9c/wcywlu+r13J3tGkHyrSdt5gMtmDv1Or3Ieo
         yd4NDx9JHaO3gnY3c+ayBjJbt6aOVoHx11VW2VKsVwOOiaPXataGW/2aFjxZPHDZzRnR
         XWtn5MCmb/sz+kQbC/3AxqOkJtdleD6MXcqtqkossYU0oqoWKpofMfqz2eMEv2PIxj1k
         Gs2DOrVRDxy78Lc4rwOQt6RY8+A6k13+Er2FE81M5dM0UojhZULp9TpP5VCeNlliMwkz
         MosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZRt4lLEdkGpEheHIyz2EqOhIIOjIMs1Mga1VdLe78eQ=;
        b=G2hN3cUBBoqqNLzTXNcmsBpovOEcUXPh9aLC3XfPtNms3hSHRQDWu96kVJoSHiRJ0r
         pqs9WBwPQsr3h6s3QJBzIm/hGSGFRntifmdi7/Sem9CM/EtbLwuhHlirrvcFVN1sBKYG
         I/hzh49KitLUbqyDmAINRSB3f6cqgD3TyauULqUezBn+o1avI0BWJwq1TPqjLm3NgZW2
         9Oc7dbxTmhi1BTYEyNIrZ0ZJnN45+OzSG0cGy90vZ2pQMTw8iLq6n308KV4KKZktk7F2
         KRifLHKMZBWo1EANaE3YW1RHUVVmAYng93nETzryTm7822qs3tCusIWkcEd3qIdTQsuu
         C/Mg==
X-Gm-Message-State: AOAM533FMZgs/zGrrwv8Rwuox2HLEEsxzG43pDsixs/H10fxLh6NNSr2
        XxbOzv+DTvGCR8tISH3es5uXWOzctjUCnA==
X-Google-Smtp-Source: ABdhPJw5sH53JFBNC5Ek0t8nEkH9FBrmhoJ3Sp4EDqPZMMaNkgPKGnG3059fsYGH0P8ePoAWQa4rXg==
X-Received: by 2002:a2e:2416:: with SMTP id k22mr6507511ljk.201.1606603331314;
        Sat, 28 Nov 2020 14:42:11 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:42:10 -0800 (PST)
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
Subject: [PATCH v2 26/28] video: fbdev: uvesafb: Fix string related warnings
Date:   Sat, 28 Nov 2020 23:41:12 +0100
Message-Id: <20201128224114.1033617-27-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Two W=1 string related warnings.
- Using strncpy to copy string without null-termination generates a
  warning.  Use memcpy to copy only the relevant chars

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

