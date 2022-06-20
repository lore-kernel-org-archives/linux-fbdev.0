Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA9DC43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 20 Jun 2022 14:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiFTO5h (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 20 Jun 2022 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbiFTO5P (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 20 Jun 2022 10:57:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F6CBED
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jun 2022 07:17:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso10927689pjg.1
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jun 2022 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f/whsAbM/v/HZBxdRShiRBxKS9Q1LnvUwkp4gP/bLT8=;
        b=VVG6WagCQGOflOt3+rQHA8r0tzrXltqEBLgD1gjjGC/9PEJUQKfDR440HrM725Fbw4
         CPFSnj5y//sXSM/6XudkkWGP1AocQXPqzWdg+hTGqHGeG/zryfVzicxRMztIkoOhiojQ
         MiiJ/yCqEQjoBgRBn++FQuVe7JNVg7wocXBy3mK/nIrpSPmwJj54cgfVAsYcFCixcGIf
         FoDvqZqhxTjAw5NbsviGqZ2P3meTte4RIFMYBTJmm4hLwAcE8t5y0BSi36ypHaFZbz8o
         GzG1XhOH8P2slHJC9FMr5kcEyIuYwjkkDbD7NBX34ALA+eEl8MxbY4YiC384G9I+HGMX
         xdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/whsAbM/v/HZBxdRShiRBxKS9Q1LnvUwkp4gP/bLT8=;
        b=6gUqSvQQdprn7yVxY1908MQFNXdugPnTCA8UKthJWO79RrFyi0dwSaib9c8LT5kfJ3
         pRnKI/5l74JcmkDrxp3GtjXY28ha/xEevUuCIlEByFSohQPD6DPq0G/Kyx12WpiUfnYy
         wIa49MliCveYhp9lCM+l+OoZJgfw1+MeiOkr/odTMA9jPEvpy9c82+FDSQQSsAgqaVJq
         RnO4WllJgg9OUC7hZ0t6f2A9ek+6DsZBriW0oXfg9EQZJRcIq6dtASoTfwZa3cODZqNe
         7lH+jVjBumXRLjc1NjAEWPRecddHOtKjeMPO5LrN1SJSgB1v8YJkNYLgW9T9VQTw+KZB
         zDfA==
X-Gm-Message-State: AJIora+3pZ+xRVpSh+sTgs30UJo1ol8NO1xsMiE3J1eikYK1Pam8KIWd
        MMhfkuXJEDnNiFPZJTPZp+otaZg4GbL47w==
X-Google-Smtp-Source: AGRyM1uTjY0/P9+3uexluwob8Hz02o9HN/f2gno2e+ygKeaLDoIJ34rQcUlHmeSXk2SmmP+qgHP4Tg==
X-Received: by 2002:a17:90b:4cd0:b0:1ec:b260:db49 with SMTP id nd16-20020a17090b4cd000b001ecb260db49mr3887067pjb.193.1655734672231;
        Mon, 20 Jun 2022 07:17:52 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id n14-20020a056a00212e00b005184d1e838dsm9607189pfj.12.2022.06.20.07.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 07:17:50 -0700 (PDT)
Date:   Mon, 20 Jun 2022 07:17:46 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Message-ID: <20220620141746.GA688683@ubuntu>
References: <20220611192851.GA482606@ubuntu>
 <a12be485-3708-a84f-0120-d6938b322e96@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a12be485-3708-a84f-0120-d6938b322e96@gmx.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From 1c55d1e084071caf02e7739e71e65f52206e872c Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Mon, 20 Jun 2022 07:00:10 -0700
Subject: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write

In pxa3xx_gcu_write, a count parameter of
type size_t is passed to words of type int.
Then, copy_from_user may cause a heap overflow because
it is used as the third argument of copy_from_user.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 043cc8f9ef1c..c3cd1e1cc01b 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -381,7 +381,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff,
 	struct pxa3xx_gcu_batch	*buffer;
 	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);

-	int words = count / 4;
+	size_t words = count / 4;

 	/* Does not need to be atomic. There's a lock in user space,
 	 * but anyhow, this is just for statistics. */
--
2.25.1

Hello Helge,

Fixed the patch as requested.

Regards,
Hyunwoo Kim
