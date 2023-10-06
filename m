Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9667EE94116
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Oct 2023 20:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjJFUmQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 Oct 2023 16:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjJFUmM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 Oct 2023 16:42:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CD7C2
        for <linux-fbdev@vger.kernel.org>; Fri,  6 Oct 2023 13:42:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-693375d2028so2243844b3a.2
        for <linux-fbdev@vger.kernel.org>; Fri, 06 Oct 2023 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696624929; x=1697229729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBMYWbpbrSBVp77rMXiQ5aEdCcdBzlEfucMC9y2SIB4=;
        b=EwZ2xzA2BQEa1kQNQo6MN04vU8U9ck2dX672UzXYK0cbjqv7bMUa+phbg2Mb296cX/
         4/JV1A31qak2G68Aw24gS7QI+4a3Ku7FpLijFLsfohjLU0kyZeUOsmdiwD+oBZCQz9rb
         jOeERPUDL/DL+oUwX1bBrM/FUXnG0Gg/4Cg7jIk9Uk6zizTGH1IDLW2+0f18L7KLgymh
         4bnFbLX32SXpYS+4/Bw/fMc0FLWXBLtdSU4FWS0sMoTunU25NbUCw1QkqoOpea6JY40d
         xC/kdCJG8HSE8siKrhjx3KXTdKwH+aKwbLE09GT+q6+uFEU0DCwbZs+GKeKgQ3M/uINS
         SLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624929; x=1697229729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBMYWbpbrSBVp77rMXiQ5aEdCcdBzlEfucMC9y2SIB4=;
        b=QkQESHgc2zU/yEC/KFslYFlIZTYLXhdP/05AJys2S0AE778lxYtBRUGasJZ4L+v+0D
         472uJrWPlpgAM1AUFVDYt9li63ntqbtYYkmIg3Sg62Kd0LYU1sWP+X+ggm4DC4goJ4sZ
         FsWEOG0IIv5KdNu4XZaEX7wSGmTz5krBZzv9qunn2KrPpgTI5ChIG+M35yRV1yqRwB0V
         ksuNbBfm/R2pooLi4zy0OBgzqD/LuB1ngjeN9MQl8QCvBUNQ2ZhvE4GF78zkeks91ZnE
         8z8HHtRGIgNanc+l5bZtZI742Cqjwchn+HcG63U2E17gmoq2kEEfJg6ilIiM+aC9482G
         3QNQ==
X-Gm-Message-State: AOJu0Ywtus5Tk5SDgEljDJuxCyXpmpSLaHwiBnC3ornPb+TmwKnO7J+X
        dtQXcYZM7j2a1SBv3vNGxGk=
X-Google-Smtp-Source: AGHT+IFa1/kBnIsWAzQU0Ku07Ss5y1KElb0VFLIfeqm2Jxt2+RNafilfVdzo9PDcPLXoWFZp/0VLPA==
X-Received: by 2002:a05:6a20:1455:b0:10f:be0:4dce with SMTP id a21-20020a056a20145500b0010f0be04dcemr11141772pzi.8.1696624929602;
        Fri, 06 Oct 2023 13:42:09 -0700 (PDT)
Received: from local.lan ([181.197.224.5])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c20a00b001ae0152d280sm4355712pll.193.2023.10.06.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:42:09 -0700 (PDT)
From:   Jorge Maidana <jorgem.linux@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jorge Maidana <jorgem.linux@gmail.com>
Subject: [PATCH 2/2] fbdev/uvesafb: Call cn_del_callback() at the end of uvesafb_exit()
Date:   Fri,  6 Oct 2023 17:43:47 -0300
Message-Id: <20231006204347.2594-2-jorgem.linux@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231006204347.2594-1-jorgem.linux@gmail.com>
References: <20231006204347.2594-1-jorgem.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Delete the v86d netlink only after all the VBE tasks have been
completed.

Fixes initial state restore on module unload:
uvesafb: VBE state restore call failed (eax=0x4f04, err=-19)

Signed-off-by: Jorge Maidana <jorgem.linux@gmail.com>
---
 drivers/video/fbdev/uvesafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index a1a67830f..e1f421e91 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1928,10 +1928,10 @@ static void uvesafb_exit(void)
 		}
 	}
 
-	cn_del_callback(&uvesafb_cn_id);
 	driver_remove_file(&uvesafb_driver.driver, &driver_attr_v86d);
 	platform_device_unregister(uvesafb_device);
 	platform_driver_unregister(&uvesafb_driver);
+	cn_del_callback(&uvesafb_cn_id);
 }
 
 module_exit(uvesafb_exit);
-- 
2.30.2

