Return-Path: <SRS0=OfnY=DZ=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D16C433DF
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6008922261
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 18:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjCP1EX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgJRSPB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Oct 2020 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgJRSPA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Oct 2020 14:15:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DC9C061755;
        Sun, 18 Oct 2020 11:15:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t22so879799plr.9;
        Sun, 18 Oct 2020 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6FHgeh68XrW5HEPqio+CAfOtISNqMru1HN9CgXSmBM=;
        b=QjCP1EX34ML3REAsHj1Tuktcn2Qgs9vEAzg++SANXEotQatxk6cJ78+W/luVFvsA3f
         nZNkGM2go1F8nkwh6yEUQxVkyIZOSgSO3THq+0gpiY9p60SUuVvKhDWBbHi94riAC158
         JDorjfMHTqFwVLz0lpon1zH2WyRinDTgAZqYzF5ngx3ClF81QhYn6cp4wIPpq813dIHK
         s7GRgyT580BXrnwrATopGB49vaMilA8vdkf2slNeGdl9j549H3kzxrpyicj+1Et8ki3p
         9ODKdJhrDhod8Zt2o3IZRnrNOqE1O08i1zPH79d/5aAdF4rk6sX2svj7btVZGfC3j9ov
         5k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6FHgeh68XrW5HEPqio+CAfOtISNqMru1HN9CgXSmBM=;
        b=j4+bSgWeA1DDsCPVpHOUCfKesxlYxnEa0AO7FwYk9Mn2eXcMeH/pYj8UuiIN00r44B
         ik9v0pQp4kdZsDwEDAY5GNdhobw5OLwM8nrXD68CCCN8du9UfNIzdpi1Rc/aCPEuEeQP
         l/W7rJevnTB1Jlpoe8Sg3bv2rKkF/hEgD2PEMFE2LA5OaV/gXcVlZDECRFJuWIOCTVcm
         Xf1ATDNCPGwXdAmDNvizGwhiEU9iSYDSqnqwrSHxeVf8GdyvkMqm7yYYQ6BGeoJ1glol
         QVhhSuBRTudB8Wsr/L8hKJPISl9DDmkn+3BRCwcHpAfO52zhUWNFKUofaBbXe+8JG4cO
         RLaw==
X-Gm-Message-State: AOAM5336zbMIGgDrVUgUa5vpPLdR+laAhxMTFLjQZ32qGUiLoiPVBzA1
        kup/P34X1JW7+VFmmS5tXg==
X-Google-Smtp-Source: ABdhPJyD/RAMVd1M8vP32mGD/W3N7UjeH/8THUOCAjyc/6MDKMhug8g9/itU+OYPPf0q61CKLJRo6g==
X-Received: by 2002:a17:902:8a8a:b029:d5:ab9e:1d5d with SMTP id p10-20020a1709028a8ab02900d5ab9e1d5dmr14061857plo.32.1603044900146;
        Sun, 18 Oct 2020 11:15:00 -0700 (PDT)
Received: from localhost.localdomain ([161.117.41.183])
        by smtp.gmail.com with ESMTPSA id u65sm9511516pfc.11.2020.10.18.11.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 11:14:59 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 2/2] docs: fb: Add font_6x8 to available built-in fonts
Date:   Sun, 18 Oct 2020 14:14:10 -0400
Message-ID: <717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
References: <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201018181410.mlra2zaWuYTZgld6rsM32812_8udwOf04eJF92aZeG0@z>

Recently we added a new 6x8 font in commit e2028c8e6bf9 ("lib/fonts: add
font 6x8 for OLED display"). Add its name to the "compiled-in fonts"
list.

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 Documentation/fb/fbcon.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 9aad964b767c..57f66de2f7e1 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -81,7 +81,7 @@ C. Boot options
 1. fbcon=font:<name>
 
 	Select the initial font to use. The value 'name' can be any of the
-	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
+	compiled-in fonts: 10x18, 6x10, 6x8, 7x14, Acorn8x8, MINI4x6,
 	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
 
 	Note, not all drivers can handle font with widths not divisible by 8,
-- 
2.25.1

