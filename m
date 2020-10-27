Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A88CC55178
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200F3206F7
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1vwXINy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811794AbgJ0Qmg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:42:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40068 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1811194AbgJ0QiF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Oct 2020 12:38:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id w21so1224327pfc.7;
        Tue, 27 Oct 2020 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0NQC8q5PZfZ/nsIJ5qKnoN7K1varb2/TGSSOiRrezY=;
        b=M1vwXINyKCI2zbkqZyjRXzOz+OiTTjv5+YsMO5WomPxQ3OpKFOn7449dzir9pXj29D
         N5LsWZQuc+CpSU0G6fApBL8OSc3ryHX6s4+fH7/jMVFh8f3/aTe3/XJ1Ptp/jgX7r+t9
         9xZFjZp26qxDvFk9dfn92Za9iIbief2hH5kZJ6lYpp2Ug7hYAdAIIbpVGHbquuB8px5+
         LJQUV0NFSXrXOEc1N2TBFJmfeEId/wIGYG3QrPBOWi9ebke753T1av3HH461g4YDBEmp
         Rt6Abuk4cHAhe3quvhm7Y+ucPdDhEs7s8FvMm4Xd2uPJGWC7E+Bo6tSPsXJgl9VVG1XI
         FABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0NQC8q5PZfZ/nsIJ5qKnoN7K1varb2/TGSSOiRrezY=;
        b=T0KovKs6r2x/Qgd6mTlUitQ+6wDSJ7ET11exBu2ksQOdzZJ5QmDpTryBeYUhfZJamf
         0gMjmfl6xdBvQTEXZkk1GituI/nIa1pfWPpug+ppnkoEBdVinqUzoAnMOT/zdCYGRQtL
         BqU/V3SFGh6x9XLbT8aTcJxd/lZzCkZTglaqUwtuJyT59/1kItg0LZdoo36N03SzscXt
         4cjdr+p4duk67u5nwGxRu2DDh5t6ijnYdtZRWUX6G+hrJN4faDTT5wwbOm5/AyCXTQaM
         KK467OBhZEJT2Gjd3f58BdUEoXchw46aQF4fhu8xWJyp4O53JKFTp8/eIvtKOxz7A6pm
         7XvQ==
X-Gm-Message-State: AOAM532/wGcsnnyTkbX/YHwt061OJlfLKu5l3XWbWI44rE3muq5d2s2w
        2YOEKJCIbZPkB13WZO3+7w==
X-Google-Smtp-Source: ABdhPJxBV7fdXTggzQ998E92lWxE1sdD8P1AgGgCr6mresHIg18LPfPSKo6TccWBfKl7Hovza/PVDw==
X-Received: by 2002:a63:5d61:: with SMTP id o33mr2564224pgm.295.1603816685018;
        Tue, 27 Oct 2020 09:38:05 -0700 (PDT)
Received: from localhost.localdomain (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id b7sm3139676pfr.171.2020.10.27.09.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:38:04 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 4/5] fbcon: Avoid hard-coding built-in font charcount
Date:   Tue, 27 Oct 2020 12:37:29 -0400
Message-Id: <a3b1b3cdc160fb9aef389c366f387fb27f0aef38.1603788512.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6c28279a10dbe7a7e5ac3e3a8dd7c67f8d63a9f2.1603788512.git.yepeilin.cs@gmail.com>
References: <cover.1603788511.git.yepeilin.cs@gmail.com> <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com> <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com> <6c28279a10dbe7a7e5ac3e3a8dd7c67f8d63a9f2.1603788512.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

fbcon_startup() and fbcon_init() are hard-coding the number of characters
of our built-in fonts as 256. Recently, we included that information in
our kernel font descriptor `struct font_desc`, so use `font->charcount`
instead of a hard-coded value.

This patch depends on patch "Fonts: Add charcount field to font_desc".

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cef437817b0d..e563847991b7 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1004,7 +1004,7 @@ static const char *fbcon_startup(void)
 		vc->vc_font.width = font->width;
 		vc->vc_font.height = font->height;
 		vc->vc_font.data = (void *)(p->fontdata = font->data);
-		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
+		vc->vc_font.charcount = font->charcount;
 	} else {
 		p->fontdata = vc->vc_font.data;
 	}
@@ -1083,8 +1083,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 			vc->vc_font.width = font->width;
 			vc->vc_font.height = font->height;
 			vc->vc_font.data = (void *)(p->fontdata = font->data);
-			vc->vc_font.charcount = 256; /* FIXME  Need to
-							support more fonts */
+			vc->vc_font.charcount = font->charcount;
 		}
 	}
 
-- 
2.25.1

