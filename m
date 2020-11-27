Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7123DC3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E18120809
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNd5jXk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgK1C3Z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgK0T6o (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:58:44 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A79FC0613D4
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:43 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id z1so7129307ljn.4
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVfT86QX+ZDTrJRF8dQQHF/3gUwiFpKsxjnoB2Y1zu0=;
        b=pNd5jXk94PdmMLkBuGrzXr5VZIBW1q4/xg/xvm8uzlWcYxvNlIoog29ix8O5eeFt69
         tDiNvMPfY65I0w27OPdUQpExtBaF1oC03M6/njKb87rLyTOAqe9X3s8YvSpmrZK7GSTy
         pN4AHHdFO0/+yVCNc/xawLRkTrtjdIfnFkQKwAta5zkNKDrkhdcd4UgR+yOOKyZ5rRQA
         zNaj3P+Aa3W4vi6QSkptOCD7yJDl/nzgZnCOd3103/rTMcaYvblNF42qdxGTSZIWGwTl
         KO5iUJB3JAh/gbw1Hco1syS42CJWlYzO4rvzedDiIdjlxoHecchXXRIF+i1fVfLvQTXk
         lrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EVfT86QX+ZDTrJRF8dQQHF/3gUwiFpKsxjnoB2Y1zu0=;
        b=Ggqx2Wo0fZbXgKDjBhQaxTBKX7hOwJazgoltuYzZx387Q83irQ1wtB5M3BpE8h9QTP
         1eC14g+fL1CNofE6TcIF5K/5oqaSHChSZzbumKF3H8BPokjnBAc/7XjhXDEHvgTlGZMF
         zpxLfEU6kZdqbBARCL0WqTnTsLUiHemdwkWt/Trm9391AaVvvV+IQCexK5vOKNv7QcY6
         Jflhj/dlnZY90khkFDcviNYuMyLFiq473kd+eriusXceAPTaMBZFVRt1nAWozG1kceFS
         5px0ivwLttj7AzUnbJCxuBhVL4uByETeuYqRFAYiAsniL4BiCjWMQY6kBGqTsFzFGnz3
         HfEQ==
X-Gm-Message-State: AOAM530+hoC1Aj5WtgpkUrW3BbLIQLVSx/3NKpy58HdmBJnhL+1zU7wJ
        Olf6TeUrHmm8C23KXx5bPkekyeGAqV4xgy2A
X-Google-Smtp-Source: ABdhPJzXp9uTUQQnInL9K0DV22npUNTpOloTCcvJ9aj3htoMz9+JJ2m34eR+Chve2GRiCw8Q4sNScw==
X-Received: by 2002:a2e:b529:: with SMTP id z9mr4499212ljm.307.1606507121906;
        Fri, 27 Nov 2020 11:58:41 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:41 -0800 (PST)
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
Subject: [PATCH v1 03/28] video: fbdev: core: Fix W=1 warnings in fbmon + fb_notify
Date:   Fri, 27 Nov 2020 20:58:00 +0100
Message-Id: <20201127195825.858960-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings by updating kernel-doc to follow the correct syntax.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
---
 drivers/video/fbdev/core/fb_notify.c | 3 ++-
 drivers/video/fbdev/core/fbmon.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_notify.c b/drivers/video/fbdev/core/fb_notify.c
index 74c2da528884..d85717b6e14a 100644
--- a/drivers/video/fbdev/core/fb_notify.c
+++ b/drivers/video/fbdev/core/fb_notify.c
@@ -38,7 +38,8 @@ EXPORT_SYMBOL(fb_unregister_client);
 
 /**
  * fb_notifier_call_chain - notify clients of fb_events
- *
+ * @val: value passed to callback
+ * @v: pointer passed to callback
  */
 int fb_notifier_call_chain(unsigned long val, void *v)
 {
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 1bf82dbc9e3c..b0e690f41025 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -605,6 +605,7 @@ static void get_detailed_timing(unsigned char *block,
  * fb_create_modedb - create video mode database
  * @edid: EDID data
  * @dbsize: database size
+ * @specs: monitor specifications, may be NULL
  *
  * RETURNS: struct fb_videomode, @dbsize contains length of database
  *
@@ -1100,7 +1101,6 @@ static u32 fb_get_hblank_by_hfreq(u32 hfreq, u32 xres)
  *                                    2 * M
  *        M = 300;
  *        C = 30;
-
  */
 static u32 fb_get_hblank_by_dclk(u32 dclk, u32 xres)
 {
-- 
2.27.0

