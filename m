Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13564C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C225B20809
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+RaYsbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgK1BgG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731071AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E525DC061A4F
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:56 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so7122222ljj.6
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DqPrwDONktOgwN/CoiXWyViY/Qg5UYX+rJPHgpGJjk=;
        b=P+RaYsbOnx2acYAr3uSsgohDNBxSOaEg2p+n2du3Hw9r2lHgqBPN6uoIYzal4dnKPO
         n/72hIZvM5k86IY6eUYZovHeKZjX8JZedbxZF+MsFbRByjtZiO31SwXk1TPL3UVit0j0
         XwTFPFIRGyVaDUSN1Fb3dA2p4y873sq2IrEEXCE2XKc/d9nhLphkUfWi/jAEkPSt377I
         COlmuA9oHxtWkMNQ/Gk8lG3Vt98mr+BIAzo1LdBSNDc75umBhEMDphDOH3C71v2RCwEJ
         xfKSnfq/CwSw3GT8qMAzvJ6qxcGCwergB6dRle+04X1r1S0U/UrOaOelkmujE7c5c+AM
         Vdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3DqPrwDONktOgwN/CoiXWyViY/Qg5UYX+rJPHgpGJjk=;
        b=aQwuFZTxC1UUZNrIXsZZ41qsRVetF9CMeXhRQqOxvVJWHlfWzu9V8R+J3LzQr0hcgV
         uPR/ZOJ47H3sXn8YaMRyEca21Mity78PIdavSdydcQXQX29W18Kghc5skT5/GxhykGUV
         12qxCVf5PaQpX359DgVGx57eadAhJAsHRQ/zT0b2YzTCyez+DQfWL6tq/sCQJqJehG5/
         OZDKk3MpOCUW5OIR9FsGQZVtCGgeMaw+SdgfthW2obqH9Rcjagb8ShAcHlRP9P3ycD6b
         gEVgToepMqjv3mQPCU9GrnxRs54qM5u7K0S3lVXAi6h574ORjHcyRTM7Fusf6SAK1fg7
         Jeow==
X-Gm-Message-State: AOAM533jetp1M32ybjqLhwafndgYAxHZhB3lqdKdOedOZNprIab8Lw3m
        VteSOZWi3L+zkSFGBWCqNY9FSSI2yAdb3opV
X-Google-Smtp-Source: ABdhPJzuQ2Prv1GUopct6yqHR86fQNHT0/F1E6ioU4/Kz0f0Fap2yxzWa6Upc/90vmj8G3YzFJJBsg==
X-Received: by 2002:a2e:164b:: with SMTP id 11mr2781307ljw.34.1606507135224;
        Fri, 27 Nov 2020 11:58:55 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:54 -0800 (PST)
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
Subject: [PATCH v1 08/28] video: fbdev: sis: Fix W=1 warning about SiS_TVDelay
Date:   Fri, 27 Nov 2020 20:58:05 +0100
Message-Id: <20201127195825.858960-9-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warning by commenting unused SiS_TVDelay* variables.

The SiS_TVDelay* variables seem to contain some magic numbers
so looks like data worth keeping around but not as code we build.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/fbdev/sis/oem310.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sis/oem310.h b/drivers/video/fbdev/sis/oem310.h
index 8fce56e4482c..ed28755715ce 100644
--- a/drivers/video/fbdev/sis/oem310.h
+++ b/drivers/video/fbdev/sis/oem310.h
@@ -200,6 +200,7 @@ static const unsigned char SiS310_TVDelayCompensation_651302LV[] =	/* M650, 651,
 	0x33,0x33
 };
 
+#if 0 /* Not used */
 static const unsigned char SiS_TVDelay661_301[] =			/* 661, 301 */
 {
 	0x44,0x44,
@@ -219,6 +220,7 @@ static const unsigned char SiS_TVDelay661_301B[] =			/* 661, 301B et al */
 	0x44,0x44,
 	0x44,0x44
 };
+#endif
 
 static const unsigned char SiS310_TVDelayCompensation_LVDS[] =		/* LVDS */
 {
-- 
2.27.0

