Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFACC43460
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C566139C
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbhDGGqU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbhDGGqP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E767C061761;
        Tue,  6 Apr 2021 23:46:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i190so3926782pfc.12;
        Tue, 06 Apr 2021 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bzo2CT+YJY2F1z9OlT8tzpIHNon2mF4OUcXaigWQziI=;
        b=OEtvKnq84mcXwBBifO9jX76kOSHpziONcL5SKzP8vMLgmp7JMbP18Sms565rdCRbAg
         F74VNu3LB4OKj92SaXLahFRQPMsdBnVKp+pnWI56WwTHALeqkjyxqlHGOLDBvCVt6Ea4
         fPLdcaGvQHhrKQYPMu51quOb/Dka/kK7PksE5lPe2GQJbSLXgmKjQenbhCXDwvNH222W
         owOpH6N9/wPlMh6fp0isjuJx421rgai089408WskSCSJ9fs38RyhQSatoRVoB6/BadRU
         ZRY24NKce1Nb5TaeeCLY9dmCuvNIZE0h38G6ElF25/kOldIoCSx8i320p0Q8RqgGKmH7
         GC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bzo2CT+YJY2F1z9OlT8tzpIHNon2mF4OUcXaigWQziI=;
        b=FBVt/pkZuXMP16iOc6EnNpIKxjoP0kfXivhlTxPdGHGLSZ5ZSgLvGdyZVysU8K9DJS
         mZ20yc1bLOCUqjmOjzfvPAmgP3XxikPV4BDQP8BO4JeasGeLBW/Z11LyEZ3w909B51wY
         DEXJwUaYcp15tAswKBORJlONG7fKp1EBcOB3FvNMdSCv3Z6cHyhMBDO/orhDQhlv7Xvk
         qVF/SdneflD2Ed5EHZd25BMl6H5d3K07am9kbxB1U/iQmRAeZy7dmjFUWXDtszPoFVY9
         0vu0s1O67OVRh8/gy3QO9P+B7WV2kIgkKmklldfBcZbzSnyQBt4xCXY16D45JD+pugvF
         luoA==
X-Gm-Message-State: AOAM533Wb78lN33pcOxxBeKeOJpKm1DFjUnQF4ePucCt3OQ66f2a6BX5
        6+1Nkpjn9+BLuihdoJ+vxW0=
X-Google-Smtp-Source: ABdhPJz16x0AB9cEwqIJ3PiCLPa295Lf4wEyzta3KqGXJS2K67APQvuWlM4EKvxaAD65pfkEihHHOw==
X-Received: by 2002:a63:544e:: with SMTP id e14mr1978911pgm.288.1617777963878;
        Tue, 06 Apr 2021 23:46:03 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id g10sm19697726pfh.212.2021.04.06.23.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:03 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:01 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 40/49] staging: sm750fb: Rename function
 sm750_hw_cursor_setData2 to snake case
Message-ID: <89daa11a59211c35ddef3a88bf2937a0a3d6946e.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
sm750_hw_cursor_setData2.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 drivers/staging/sm750fb/sm750_cursor.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 98d294ac223c..3ee3bf78f7a5 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -132,7 +132,7 @@ void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 	}
 }
 
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
 			      const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index af0211242ae8..8a1e81b8248d 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -10,6 +10,6 @@ void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 			     const u8 *data, const u8 *mask);
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
 			      const u8 *data, const u8 *mask);
 #endif
-- 
2.30.2

