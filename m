Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE5AC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 15:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADEB60F3A
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 15:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhI0Pqs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:46:48 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55150
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235152AbhI0Pqr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Sep 2021 11:46:47 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CCD4340198
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Sep 2021 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632757508;
        bh=QblA15uiwZ7l+Ibk9gNFwOO+GmQVJrKRAtlqWocjIZ8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=N92Z5vyx4awUm1LnPpyRFAgETxSD2VepiMB0Va3uvTyDZZX2IzI+9um3kdby4ke+G
         rEr34TsV5y5p2Eu1rusKVk4fPsoJbDAbFgYphNuKT5nVqznO4F8hN6mWvnhhxJdcwo
         +xmL9DW4Xgdz1wa18rRGw3dKKfhV5YPpI5H1i6OYtb71RZwMozb3udL+SPHYlybhSF
         lL+NbKXuJGl5YyFxDUgg7EAyzzJbtoMe4wcC4YVfdPLIV+pv4R3e8xvBWIOQecwphA
         8eS2hsFktIwQ8sW7DoiD7TRqMyxLZ4CBNQeOUkiE5ICJu5LjCJmsuUNayV9aUjzdXs
         f78PkfQwNWmrg==
Received: by mail-pg1-f197.google.com with SMTP id p19-20020a634f53000000b002877a03b293so5146925pgl.10
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Sep 2021 08:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QblA15uiwZ7l+Ibk9gNFwOO+GmQVJrKRAtlqWocjIZ8=;
        b=DsctgbIorpTxrf2ypftuXu/RipbgJNizVqXyN/lbo4hq310+EsLXa8NTsaoIuaqE5U
         0OCQBNg0cdVeyxFcE6mWuO4BwZTpZUHUCZnGg/Je1ZZ16vfIi1ufBTgfOgak2iFGxuM6
         hnRUTNpLa7ENiRr9tUOoGX4szvZNNHHKaGW/8ATSXEEdkIpbSeJfMVAJ7slJxX+B4p0V
         zgVYRpK3jxiW/JoKKaTxIzKMyRC5DRCgIKNUYQoyv0kK6CnXF0CIgjmcYgMvmvihwiWP
         jgpVCBZfmVmpWYiWXayYeA5d34s07gMHqK/X8NrlNcMWm+UfuFhdSC+svEILWz/4EtKT
         JhQQ==
X-Gm-Message-State: AOAM532xG5HXnjfw13oi6uqgjMG+fo47RFJODpZK3qPWWIklp1yotcAi
        fxHytfxbE2UMhJ3/fKHzru+obpCSeF49oWNrCGNro1e+Smy2kNYRob8LkblNpbHALpc1aZVLFDI
        IKVs06m4y1QY2Cds5da+SSwc3DTd1ibJqCw4VQcwn
X-Received: by 2002:a62:7e55:0:b0:441:c7a6:fcd2 with SMTP id z82-20020a627e55000000b00441c7a6fcd2mr383213pfc.6.1632757507044;
        Mon, 27 Sep 2021 08:45:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIcXtn44DVJ7kkF5B6wBQHYvxY4BnpmGkvMYNq6WMkWLzHV8KuCCeAXC9apx+oB2TD0uA2Gw==
X-Received: by 2002:a62:7e55:0:b0:441:c7a6:fcd2 with SMTP id z82-20020a627e55000000b00441c7a6fcd2mr383191pfc.6.1632757506705;
        Mon, 27 Sep 2021 08:45:06 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id y2sm15987228pjl.6.2021.09.27.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 08:45:06 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-fbdev@vger.kernel.org
Cc:     tim.gardner@canonical.com, Antonino Daplas <adaplas@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] nvidiafb: Use strscpy() to prevent buffer overflow.
Date:   Mon, 27 Sep 2021 09:45:02 -0600
Message-Id: <20210927154502.21026-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Coverity complains of a possible buffer overflow. However,
given the 'static' scope of nvidia_setup_i2c_bus() it looks
like that can't happen after examiniing the call sites.

CID 19036 (#1 of 1): Copy into fixed size buffer (STRING_OVERFLOW)
1. fixed_size_dest: You might overrun the 48-character fixed-size string
  chan->adapter.name by copying name without checking the length.
2. parameter_as_source: Note: This defect has an elevated risk because the
  source argument is a parameter of the current function.
 89        strcpy(chan->adapter.name, name);

Fix this warning by using strscpy() which will silence the warning and
prevent any future buffer overflows should the names used to identify the
channel become much longer.

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/video/fbdev/nvidia/nv_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/nvidia/nv_i2c.c b/drivers/video/fbdev/nvidia/nv_i2c.c
index d7994a173245..0b48965a6420 100644
--- a/drivers/video/fbdev/nvidia/nv_i2c.c
+++ b/drivers/video/fbdev/nvidia/nv_i2c.c
@@ -86,7 +86,7 @@ static int nvidia_setup_i2c_bus(struct nvidia_i2c_chan *chan, const char *name,
 {
 	int rc;
 
-	strcpy(chan->adapter.name, name);
+	strscpy(chan->adapter.name, name, sizeof(chan->adapter.name));
 	chan->adapter.owner = THIS_MODULE;
 	chan->adapter.class = i2c_class;
 	chan->adapter.algo_data = &chan->algo;
-- 
2.33.0

