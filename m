Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893BEC64E8A
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4CE221FD
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1FrkInr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbgK1WmO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387681AbgK1WmM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:12 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA8C0613D2
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:26 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id r18so10598494ljc.2
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gw87Y4IiQJRQFmGErQUGgzYt7CqBei5ZQnPlbru6PWM=;
        b=D1FrkInrUH9DKh9fBfCgXd8dBK46ZCmcALKbGOKNCiK+J9hf4uOuz98FBOxfEXnucr
         +yylo65m4rrV2di8RnAgj5Y3xtMIVWmwHK0r4kWr8QqQyyYycl969jJnWwZQSs5JHn3U
         wpJ+39OsTa2yXN2ZFeLVX1D1iZKKh7eXpE4Qebgnf6Q2PCSKV36TTz10/Q/Qo9cct1YC
         3DCHIYsu0/XEo74ZCp7ArxmjnsfRRPkh6RJl0kWdqHF7Ynq6yBnXnACAnjLVH1Lyp8zr
         niO+HMd0wJ2ntb9UDdh1rVKc91e//OPtykv5hCMzix3yLvonvcYyhjdjznACbj+w1bDE
         x8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gw87Y4IiQJRQFmGErQUGgzYt7CqBei5ZQnPlbru6PWM=;
        b=cCAsHzjd4+4wtEqYWZMFVcBbR4k7hhf9ffstgF+KxC3mUfwfZnw2kGPbLC63bBCWMY
         J0i294V0qfVpe4e6xx3L/+4m2nf7om1rHQzoV6BnaCUAtR9QYKg8TCD31BoPuOBVAdwG
         Jvz4yhQ/nDLf0T5TQwzae0ytmV6qAizJWbNjq+6/U+orFY+ChA0NtABpnA/3tM/+OyZY
         EWco40VpHcIDw+DDzEFYg4SnCr9PJB6pkbeo17iBWOb/m4ljiF/6DECYlIhcof8wK1RA
         NIvPOIuGjKsXMndOwfhMM37ggbhViGylCniQAKQFUpugBtnlW/U6AhC4hS0XOHHtHs9r
         KSxA==
X-Gm-Message-State: AOAM533dP8BR+73zFduxKbPiaDXQFcEF6FADh9htV1vVoeIJ9oUvaJ3f
        oiX6GxQbK70vdVzkPJWyXRoau3wPqyPE6Q==
X-Google-Smtp-Source: ABdhPJwHtAja16Il25CYWJK9GBsVfOJBjtSMVre8TMUl/j8LWRHFKxCZY9K1/6bDzlvVdCzO3dScqw==
X-Received: by 2002:a2e:6e06:: with SMTP id j6mr6627173ljc.282.1606603284768;
        Sat, 28 Nov 2020 14:41:24 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:24 -0800 (PST)
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
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 01/28] video: Fix kernel-doc warnings in of_display_timing + of_videomode
Date:   Sat, 28 Nov 2020 23:40:47 +0100
Message-Id: <20201128224114.1033617-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix kernel-doc warnings reported when using W=1.

v2:
  - Improve subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/of_display_timing.c | 1 +
 drivers/video/of_videomode.c      | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index abc9ada798ee..f93b6abbe258 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -52,6 +52,7 @@ static int parse_timing_property(const struct device_node *np, const char *name,
 /**
  * of_parse_display_timing - parse display_timing entry from device_node
  * @np: device_node with the properties
+ * @dt: display_timing that contains the result. I may be partially written in case of errors
  **/
 static int of_parse_display_timing(const struct device_node *np,
 		struct display_timing *dt)
diff --git a/drivers/video/of_videomode.c b/drivers/video/of_videomode.c
index 67aff2421c29..a5bb02f02b44 100644
--- a/drivers/video/of_videomode.c
+++ b/drivers/video/of_videomode.c
@@ -13,10 +13,10 @@
 #include <video/videomode.h>
 
 /**
- * of_get_videomode - get the videomode #<index> from devicetree
- * @np - devicenode with the display_timings
- * @vm - set to return value
- * @index - index into list of display_timings
+ * of_get_videomode: get the videomode #<index> from devicetree
+ * @np: devicenode with the display_timings
+ * @vm: set to return value
+ * @index: index into list of display_timings
  *	    (Set this to OF_USE_NATIVE_MODE to use whatever mode is
  *	     specified as native mode in the DT.)
  *
-- 
2.27.0

