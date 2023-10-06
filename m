Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7471DE94115
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Oct 2023 20:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjJFUmQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 Oct 2023 16:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjJFUmM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 Oct 2023 16:42:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7F7FF
        for <linux-fbdev@vger.kernel.org>; Fri,  6 Oct 2023 13:42:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c0ecb9a075so19700935ad.2
        for <linux-fbdev@vger.kernel.org>; Fri, 06 Oct 2023 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696624928; x=1697229728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkHUGyeeQEUIOHI53+FOR6+UrclISQhPbCFOjW4q478=;
        b=HtPbQM5cN3FW0q71ZOxhtyCkOfuwf84ZCUIG6T5MX5+7UTVvxkPri5jtuNvBpNSxfG
         AsOW8m2XDsIqDXT8p1zLuddSCjPPWdjdc0OkU9jRbgRlEv6+DMeW1mnV4wOa8Ov5llNJ
         GPaQFfkkCKE5IQkKMmOlevrp8+ABnarrWDt+ZN+kcC+xwTB8CJMIvS704piuMdHpeHjZ
         hhHhE9/19AcmMTQlUaNxGK58eKuMZ4208jJ/XcEtMbugxP4+hx/myj3ebrYtXC+qXboY
         e19o9nAxoKzNm5nkTMxJwp3ATZiDGF7dR6MJU2YLxP6WHn+jJGr0OF+t129EyPYZrOCI
         xvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624928; x=1697229728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkHUGyeeQEUIOHI53+FOR6+UrclISQhPbCFOjW4q478=;
        b=pPv9I8f7NDfFBwENmiTlGkFNHUmXhuKWHEHPwhVRQiPYXbSA857o+qWSGKLf2v3j2K
         l7pfHQKS3ogBaGLzb7NCS6gPzvd30dv2f/38T2oplr007DmUHVUbvs/noGdy8PVdwdCc
         atn2TFshVznjC8b8KS3U+Tyi9t9wIPgQF1CXACYsvXMa+sQY42RF7ur9BVw1JBWfEYtb
         mxrvSwCTHh45TMendZiM8QPMZRe4lyJOlliIxc4HRr2TYpYUovSLxQ2cQg19az5TIk4G
         e55Zj1HNAkUwdad9Ptl1eE04Vr/a+7L3Fs1Tpfj06JVnW8FassaA3TZMJP7PcNWz+tIM
         SA3A==
X-Gm-Message-State: AOJu0Ywyr3oh6PYRw0MNysQSOUxu9aks4w+IzHNyFhCKCN0N9r4PB8nb
        5/5bgSrjebSQRzUn3AT55zU=
X-Google-Smtp-Source: AGHT+IFfUzWXcx4HOcloTttGcPyfnC7vf2Gwxm544SnsMKXrXiCHSuB4oHgc+C+zXJDGFPPHZUnsvg==
X-Received: by 2002:a17:902:d2ce:b0:1c6:291e:24b6 with SMTP id n14-20020a170902d2ce00b001c6291e24b6mr11062023plc.37.1696624927793;
        Fri, 06 Oct 2023 13:42:07 -0700 (PDT)
Received: from local.lan ([181.197.224.5])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c20a00b001ae0152d280sm4355712pll.193.2023.10.06.13.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:42:07 -0700 (PDT)
From:   Jorge Maidana <jorgem.linux@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jorge Maidana <jorgem.linux@gmail.com>
Subject: [PATCH 1/2] fbdev/uvesafb: Remove uvesafb_exec() prototype from include/video/uvesafb.h
Date:   Fri,  6 Oct 2023 17:43:46 -0300
Message-Id: <20231006204347.2594-1-jorgem.linux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

uvesafb_exec() is a static function defined and called only in
drivers/video/fbdev/uvesafb.c, remove the prototype from
include/video/uvesafb.h.

Fixes the warning:
./include/video/uvesafb.h:112:12: warning: 'uvesafb_exec' declared 'static' but never defined [-Wunused-function]
when including '<video/uvesafb.h>' in an external program.

Signed-off-by: Jorge Maidana <jorgem.linux@gmail.com>
---
 include/video/uvesafb.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/uvesafb.h b/include/video/uvesafb.h
index 8d2a3bfc8..47d96e75e 100644
--- a/include/video/uvesafb.h
+++ b/include/video/uvesafb.h
@@ -109,8 +109,6 @@ struct uvesafb_ktask {
 	u32 ack;
 };
 
-static int uvesafb_exec(struct uvesafb_ktask *tsk);
-
 #define UVESAFB_EXACT_RES	1
 #define UVESAFB_EXACT_DEPTH	2
 
-- 
2.30.2

