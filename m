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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638EDC433DB
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1ED64E25
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhAaUN2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhAaTfs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:35:48 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0AFC061797;
        Sun, 31 Jan 2021 09:31:46 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id gx20so343150pjb.1;
        Sun, 31 Jan 2021 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAFVqpo2auTJUYrtqcdZaCPT+PUXtqA1yzZi4A7sg2M=;
        b=gfsZBKg7cAaipKTK44sZULsayr/Mkqb6cPw3QqfDlqaATzBwAKNvQGRnZ8G9iQJvq6
         y5303HIUVPKino6SaIXwqAu5Tci/Tzt2HbWQqq2MCxJn5iOrkIMyNUeri8O6BmLuVXPi
         87qTgY1RCyNju4kNcPvB8Tw31Emb1d/uI934cKG5o1G7XkB4X8TxFGf0FcJWiMmpvKLE
         5nAwLdxrnWcY6/lu/1MnPS8+GZ3kpEouQrjxhlnbTImavBmUiZ5epzlC3bY5Fnkxj1jl
         e+H0b+dSu9OslMzvEStB9LLe2hkht0pV+jZbsFQZzrpFDBBuwp/SGsCzpZuqu9kk95+9
         G3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAFVqpo2auTJUYrtqcdZaCPT+PUXtqA1yzZi4A7sg2M=;
        b=cFtRF0Wp0zXNd0UQ79DTn7fG/SeSWM/tNxMtPPotfTVYrCl/dn+RaKvW+2vLEBXqN1
         mqVEopeXapFRFuWBXuEz7pnFrw2J6RFybBW60PzU3F6CxbcA58pYjhohUZ/lota2W+pG
         j06waKMlLhXxYflJugcTPF4and3/WsXZXRuf9pBSseXnxvZq1dkutxhhOxKhdiJD9Hib
         AMzVQnfHcyEahQPIFxR9GESco5EfqM2w5YdeF3M41x1ypwJICeMZ0k4AEj4OyysuXzg5
         e46VBFH9KVIlYytmApFS3Wqy57gpQ4NR52l3PjHQfEbaKK/zKmb262ufjnxKkV9pW/n5
         HSYQ==
X-Gm-Message-State: AOAM530tiYLQLNGy+UOoK+Er3sC303QORNSeRJJCNnVkxjsZK7bVI3vJ
        JYsHbAT6uxT5rq4jBX5E+jM=
X-Google-Smtp-Source: ABdhPJydIpBl27zWlFzSU3IhagnDXZPJq2whmVIc4lQaYyGAyMUbLfRKz+PJcImBlqe99k/sZnqEYw==
X-Received: by 2002:a17:90a:7608:: with SMTP id s8mr6952392pjk.105.1612114306505;
        Sun, 31 Jan 2021 09:31:46 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id ge16sm12997426pjb.41.2021.01.31.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:31:45 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rric@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 04/13] staging: most: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:25 +0530
Message-Id: <20210131172838.146706-5-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131172838.146706-1-memxor@gmail.com>
References: <20210131172838.146706-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

strlcpy is marked as deprecated in Documentation/process/deprecated.rst,
and there is no functional difference when the caller expects truncation
(when not checking the return value). strscpy is relatively better as it
also avoids scanning the whole source string.

This silences the related checkpatch warnings from:
5dbdb2d87c29 ("checkpatch: prefer strscpy to strlcpy")

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/staging/most/sound/sound.c | 2 +-
 drivers/staging/most/video/video.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 3a1a59058..c4287994b 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -525,7 +525,7 @@ static int audio_probe_channel(struct most_interface *iface, int channel_id,
 		pr_err("Incompatible channel type\n");
 		return -EINVAL;
 	}
-	strlcpy(arg_list_cpy, arg_list, STRING_SIZE);
+	strscpy(arg_list_cpy, arg_list, STRING_SIZE);
 	ret = split_arg_list(arg_list_cpy, &ch_num, &sample_res);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 829df899b..90933d78c 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -245,8 +245,8 @@ static int vidioc_querycap(struct file *file, void *priv,
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	strlcpy(cap->driver, "v4l2_component", sizeof(cap->driver));
-	strlcpy(cap->card, "MOST", sizeof(cap->card));
+	strscpy(cap->driver, "v4l2_component", sizeof(cap->driver));
+	strscpy(cap->card, "MOST", sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info),
 		 "%s", mdev->iface->description);
 	return 0;
@@ -483,7 +483,7 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	mdev->v4l2_dev.release = comp_v4l2_dev_release;
 
 	/* Create the v4l2_device */
-	strlcpy(mdev->v4l2_dev.name, name, sizeof(mdev->v4l2_dev.name));
+	strscpy(mdev->v4l2_dev.name, name, sizeof(mdev->v4l2_dev.name));
 	ret = v4l2_device_register(NULL, &mdev->v4l2_dev);
 	if (ret) {
 		pr_err("v4l2_device_register() failed\n");
-- 
2.29.2

