Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB09C4167D
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386587AbiBHWYB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386732AbiBHVIx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 16:08:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143A4C0612B8
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 13:08:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f17so627580wrx.1
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 13:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ox4yXC0LP8o2wCPaioNRgnQjoBr7m6vhS+hT+ChhFWw=;
        b=S5BqVNPSpXHrqviuw3HJUVHCNuXrwfZETQgddkSqec9Q51qTu/X1Dy3DHTTT/LagCc
         TdfBUwokFJF0o/5jKLoZI4jM9BwZ4q0H1RYvw+h1/Ibn+wlkQIVyJ99QoReMwJFgFFyb
         hL6uv3nX42Ve284n0fZhP+uQl2c3CEhq0yFcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ox4yXC0LP8o2wCPaioNRgnQjoBr7m6vhS+hT+ChhFWw=;
        b=VtvitznklsOF+yQeXnpR5o3fcigJoeqsm71nEPRUvBxBGeER/1KG02UgaY/RqKjinw
         pcjdIK05JMOjMI3wTuV5a2FVJVA2wvIbob+SPqJkCalJ677YxuieXP/ZIRp1mdzwX4qc
         TGMcWNsVR8pcL32c/zimg/VmFkom/rgHND7YrqOHCrq3MiRVLDHgqyB/A50E6BAnOxtb
         t2N9oBC4oeL49pue9HR6msDeMBLHhq8+1XW93tX91Q/hmj4+aEEwVmGnEUCit5dpeVDW
         a8KbDA5jy89K9KcRjIcvMr8iHeeTtyTxdvxpBD+JHQNbmfbld+0dcwKaGgxn6SLGUUPf
         HilQ==
X-Gm-Message-State: AOAM532q38Ocdw8wvsiuNvo7E2uNEpjp66z1s5RPLFaG925nmyBtq6D3
        sESBl8EAnbw5v7plyKB+JpcXYw==
X-Google-Smtp-Source: ABdhPJz+CmlVndGXlugGb0ahxfiZBUSbHrx3Tg5Zrm6dge27t3XQoa5XtM7kt+nVAKioCX2KEMo9QQ==
X-Received: by 2002:a5d:4c41:: with SMTP id n1mr4989076wrt.128.1644354531674;
        Tue, 08 Feb 2022 13:08:51 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:50 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Claudio Suarez <cssk@net-c.es>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 13/19] fbcon: Consistently protect deferred_takeover with console_lock()
Date:   Tue,  8 Feb 2022 22:08:18 +0100
Message-Id: <20220208210824.2238981-14-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This shouldn't be a problem in practice since until we've actually
taken over the console there's nothing we've registered with the
console/vt subsystem, so the exit/unbind path that check this can't
do the wrong thing. But it's confusing, so fix it by moving it a tad
later.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cc960bf49991..4f9752ee9189 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3227,6 +3227,9 @@ static void fbcon_register_existing_fbs(struct work_struct *work)
 
 	console_lock();
 
+	deferred_takeover = false;
+	logo_shown = FBCON_LOGO_DONTSHOW;
+
 	for_each_registered_fb(i)
 		fbcon_fb_registered(registered_fb[i]);
 
@@ -3244,8 +3247,6 @@ static int fbcon_output_notifier(struct notifier_block *nb,
 	pr_info("fbcon: Taking over console\n");
 
 	dummycon_unregister_output_notifier(&fbcon_output_nb);
-	deferred_takeover = false;
-	logo_shown = FBCON_LOGO_DONTSHOW;
 
 	/* We may get called in atomic context */
 	schedule_work(&fbcon_deferred_takeover_work);
-- 
2.34.1

