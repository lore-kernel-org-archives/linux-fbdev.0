Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1856C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507AE20B80
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 20:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhdxkWmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgK0UC1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731156AbgK0UBR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:17 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C105C08E85F
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:31 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so7094203ljo.11
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVb7kx4jWo/2x//FtaTHCinUwYboF6da4/HiQYT27Ks=;
        b=DhdxkWmu2HCF3oKhPnt7WYf+9MAgkg+Km+yd6SRatM/3r3is1dT+DaXrkQ8rSgFavv
         DX0i0f31hM7FQ2N0ALQPr0hFERsaJ+qPKdtrsAi5GOfnpzfWwJ8iDj6pJDCQ/kAyP7y7
         00kUBE1g2M3nNXwSq1iIx1JI1Pd8r1NO5SVAh/w4G89+4CCAIjgo1CD22Zc0uRf4ZZEo
         ITozi7jwnM0WKuQxKdMhk1YVPMW+yDWru7kH8vDhTbLFcDGYbi4+0+oTiqj5DNjt2cVw
         IclvTUdidm7N/DOPgjPidmbwVGZtVtweZWVsgcli+KBB8il6oVWpueUCX1m8goMAocr6
         mXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jVb7kx4jWo/2x//FtaTHCinUwYboF6da4/HiQYT27Ks=;
        b=jCjmYMh58PHmA4JOMfqHKNVgxuUpBSImEsZ3qwKlYYVEaWtJhr9XaHVnrOH/DwdIuE
         yzUkp5nfZt7lO/Aju0ROXbTw8mEUf8chec4yVdOzUSullNqQmpe/YRv/v2YzoGwAeY1j
         O095TeCrhoWroEmysVdKMdH22VAtjKglh0vcvhe56x5ind1xiACmBBknUqFyxtT+wMaG
         S4Exlc3MTm1rZu5Dvv6vqMkAYnr1RBoRGJjwV+kWRBpIB8z0wIWKCpp6VXx228x9qgqA
         ufH+glT7TwvLMs/9jj08urIeV9g547E56zE8ZitEouNvQyiiAz6MJHlqfl3F2zkSq8hr
         SjQw==
X-Gm-Message-State: AOAM531eFG0sBCtXACq++Kcdj798e8IonqFRbSuAQivMSu6m0BPkN4Y1
        x+0JHuxEjQLx2IoWzh7q7ig8BPahOPYrBgb7
X-Google-Smtp-Source: ABdhPJyvGuhMzkR8UpVgq1X9d5l4d3Sk5qK0Lj6aoZPnFFRd6TL29IQGgk3UvpTPgVbijIdATGYAmg==
X-Received: by 2002:a2e:9a95:: with SMTP id p21mr4547132lji.245.1606507169401;
        Fri, 27 Nov 2020 11:59:29 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:28 -0800 (PST)
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
Subject: [PATCH v1 21/28] video: fbdev: tmiofb: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:18 +0100
Message-Id: <20201127195825.858960-22-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings by avoiding local variables and use direct references.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/tmiofb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/tmiofb.c b/drivers/video/fbdev/tmiofb.c
index 50111966c981..b70faa3850f2 100644
--- a/drivers/video/fbdev/tmiofb.c
+++ b/drivers/video/fbdev/tmiofb.c
@@ -802,10 +802,8 @@ static int tmiofb_remove(struct platform_device *dev)
 	const struct mfd_cell *cell = mfd_get_cell(dev);
 	struct fb_info *info = platform_get_drvdata(dev);
 	int irq = platform_get_irq(dev, 0);
-	struct tmiofb_par *par;
 
 	if (info) {
-		par = info->par;
 		unregister_framebuffer(info);
 
 		tmiofb_hw_stop(dev);
@@ -816,8 +814,8 @@ static int tmiofb_remove(struct platform_device *dev)
 		free_irq(irq, info);
 
 		iounmap(info->screen_base);
-		iounmap(par->lcr);
-		iounmap(par->ccr);
+		iounmap(((struct tmiofb_par *)info->par)->lcr);
+		iounmap(((struct tmiofb_par *)info->par)->ccr);
 
 		framebuffer_release(info);
 	}
-- 
2.27.0

