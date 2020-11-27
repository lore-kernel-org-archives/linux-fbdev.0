Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB9FC5519F
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 20:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BCB20B80
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 20:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc+1a4MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgK0UCr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbgK0UBR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:17 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EA2C08ED7E
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:49 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id r18so7137674ljc.2
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hn1HA37yirdAV/UjfmF48pGZwDbporw/jjkHdVOHiV8=;
        b=Kc+1a4MS9x48X+CFz9W2lhSniC6B+kSQ7Y2VOn2DxjY9IskQPu0QtRF7074l+zzQ0o
         FC6vBfaX/wqSVzFgf0m9/2XUepVxAUvFjD0zVIQuEDxi41hoqGTYDvMy7P3LNpY1GTwu
         CW+zKFMNLRM4b1ebwIqOWq2jmpIJCJATB+kidIJ8ahXHatH3z/isgMdvMK7c7cAngZpe
         b70bVLyrD0tt7U1tn5CmZH1qM7pVe+YmCpbZCJmwZl2QJCsqLUtrgCV3wSjTiB3g/jCe
         kt4Lk5IoxUtOHxdVWc0fI6S507woMnhnVElZmBvTcZKJiyE0zyca9xXxU/UHNh2/UP8S
         KXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Hn1HA37yirdAV/UjfmF48pGZwDbporw/jjkHdVOHiV8=;
        b=e2Q2gbEKAG4YhZDr4rHHwdjxbwXb1CuC//mtzrAxCCYKwxBptyizlIIghoHlDPGGAA
         9TI/GOlnF4zn5cGpeh/Tu5OPMtRLtoGOST6FU9bZzIknFIilHwWNp7n07WhnsFAk6x0z
         Mo6DlZ1Zgl1ygNB9A+S6lFbzqx20wwobbabxzO8mUcSQHG7xmIstTUnnw6hsGJsYad/r
         vQnxARCdDdiSp5RLELTZi4PL9wkBiIg2U7MeHL7ZmkJKqDV8swjGFzP39G05R9HPz5kB
         R9PSNBaFtWPTQ3CL32Q8aMxjeXKAkRyZEqMAtaQ/ydp2Q5mqvEHSrQkvJ51CgUimH+aZ
         IVzw==
X-Gm-Message-State: AOAM533nee8BrW8kDM791NiZeGPnV+gSsOxdl972MnZLuYPIOE8dNxk2
        A6S8cDUlRDS77Wev2m/8YtMyWiFnB/XTz+JL
X-Google-Smtp-Source: ABdhPJyzKPfjBJ5WwV+z5m3Tu11O89a2OWEhNjm0qFsqqtcN5Z3T2NeQjCb+HQfsRR8Vvz2tIYOo+Q==
X-Received: by 2002:a2e:b047:: with SMTP id d7mr4294964ljl.63.1606507187607;
        Fri, 27 Nov 2020 11:59:47 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:47 -0800 (PST)
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
Subject: [PATCH v1 28/28] video: fbdev: s1d13xxxfb: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:25 +0100
Message-Id: <20201127195825.858960-29-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix following W=1 warnings:
- Fix unused variables for variables used only for logging.
  Fixed by introducing no_printk() to trick compiler to think variables
  are used
- Fix kernel-doc warning by deleting an empty comment line

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
---
 drivers/video/fbdev/s1d13xxxfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 4541afcf9386..d1b5f965bc96 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -45,7 +45,7 @@
 #if 0
 #define dbg(fmt, args...) do { printk(KERN_INFO fmt, ## args); } while(0)
 #else
-#define dbg(fmt, args...) do { } while (0)
+#define dbg(fmt, args...) do { no_printk(KERN_INFO fmt, ## args); } while (0)
 #endif
 
 /*
@@ -512,7 +512,6 @@ s1d13xxxfb_bitblt_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 }
 
 /**
- *
  *	s1d13xxxfb_bitblt_solidfill - accelerated solidfill function
  *	@info : framebuffer structure
  *	@rect : fb_fillrect structure
-- 
2.27.0

