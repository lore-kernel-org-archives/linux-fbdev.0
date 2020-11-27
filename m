Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E56C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146BC20809
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbyG5HWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgK1C3y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730990AbgK0T6i (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:58:38 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C22CC0617A7
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:38 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d8so8583486lfa.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mlrk2a7fx8lHdZe7HNocdybelF9nJ2xwpzGpya7/neM=;
        b=nbyG5HWv8PYaV2MYSK/V9y026abFr5qp19r6Mx+qPclojBrt+pbh0WG2/n1piQOA3P
         uiimF504mugGaPERuOR019mjir/88EOl6cR5iCAfGJTPcIV/2G+i+ESDivkT2zpess2j
         1zVJKOceqHS6J/oZQFCYH6/3zFxVW9iPqVljmIiQSu3iKYWtG1vTsRSoW9MjLNOTxidQ
         wncSiavaru70qkQme1ffLM4DzwQTHZpSpnNLSekMRwjhEuJKCVX9e8Hjqh4OpS5gIN1G
         yUBhSTjZ85t0S4j2PKLTjbd7Dk/oAsAN77B0d4QfWUSLXQslevnjmXOg7FipUasZZZj+
         Ub+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Mlrk2a7fx8lHdZe7HNocdybelF9nJ2xwpzGpya7/neM=;
        b=KS01arImDUwZyPvIvzSkUhvwa2SCW3ilgi3l83tx2Mao25cOEhYgC1IVGHOKnMCfFd
         8LHnT80UPPNk4lBCSiTh16IGhs8JMeYwMqHJIqDz3RqpCGQ3pH+qrotugPWfblqqCU0i
         Z8pZHx0MImJnDugVvgsQjIheusuYgjYxzI1owDbg8LANE+DSIpxXBdOCJ6G/TkY5plEG
         uuigAWIwkqmw39y+6kYSQUmv+BrVHicPgyHYq3ThI6h9dWtmzOcSDyjvj1qObvsG+xu/
         ILR1AQzhz/TXX80i1jzNwMXN00ututFq25Kdiee6Y76VKWh6YmFPr5Yvp8qrmLAk3O8N
         AlFA==
X-Gm-Message-State: AOAM530GSCzwNkIaBrn98AsC05pxKA2kXadppCOIguD8B8Gxt0liE5qc
        tGwrUEDvTim/9BPzJKn746ZF6m7f0se2ao55
X-Google-Smtp-Source: ABdhPJy1IKpFfgA/xgo2/hiiEZA4+34JhNpEV0cwiEJVzRGd+sjjU7oUZDTPsmHJEcur9GoPNNk63w==
X-Received: by 2002:a19:f243:: with SMTP id d3mr3981629lfk.534.1606507116602;
        Fri, 27 Nov 2020 11:58:36 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:36 -0800 (PST)
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
Subject: [PATCH v1 01/28] video: Fix W=1 warnings in of_videomode + of_display_timing
Date:   Fri, 27 Nov 2020 20:57:58 +0100
Message-Id: <20201127195825.858960-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix trivial W=1 warnings.
Update kernel-doc to avoid the warnings.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
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

