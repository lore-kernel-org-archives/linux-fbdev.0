Return-Path: <SRS0=P75A=EG=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B109C55179
	for <linux-fbdev@archiver.kernel.org>; Sat, 31 Oct 2020 07:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E6F20756
	for <linux-fbdev@archiver.kernel.org>; Sat, 31 Oct 2020 07:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIwfpdRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgJaH2V (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 31 Oct 2020 03:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJaH2V (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 31 Oct 2020 03:28:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33AEC0613D5;
        Sat, 31 Oct 2020 00:28:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f21so4135597plr.5;
        Sat, 31 Oct 2020 00:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZxHTpIUuYgNndqXicmDLiO1m0V+5tn5buT9cLfB+9g=;
        b=YIwfpdRpUfnBUn8ZhV34T6cgdKpAXXJ7obKnN1EQWRpkZZQKkbbpdpiYSAAM97xXi/
         ZLTOd10tIBffO/9Lyvf8uUxypxNUO/HCXfblHWq/kMfJMJozExNih4MfwDDpPSXIrAej
         6jWp0gJNmJcEpLIgRRW39ET3UIFBMpmPj+deK2P7NtFIel5Xl7wo8ArWhhXtiVFLgaTD
         HswhO2mCRy/ABF/eQ20D04Ks7kSHPg0TbxaTn9hiVIQEsdUav21Jn/xKuUJSgNZzxnPp
         7voi2K1WU6VECoAhBDamYpZ4y2BecgTw8X4IHoyAKMr7IUxGTbaADH621aDoreOI5R79
         VdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZxHTpIUuYgNndqXicmDLiO1m0V+5tn5buT9cLfB+9g=;
        b=fKTRbA7SkGnXlZ8bFL3iokDnteGErvUxEvJN7ON0Hi6g+94bEGwApeLMsVTr1HtxF5
         7G9psSnlCsmNm8Mm9mpXCTPNtiw9wLcKP7HtA8IS3BakzEphsaRkPhQvazaT4moGRhSH
         0WJf+uzfDQFUo9wEIOtB39II0pBoz/SpaqEVvZx01xhViUuTRp7WGFAGTE7plrUdnZ2q
         NPNpmHR6S5TrrPBeheOhbB9W7Whtsx6kWrTurrXs3UM3lYvEkjQJrp0LoFBWWNgTUg7U
         iXDbuZjejCliQUrlmM4KdhiryIOGbkBKZ/vJcDPGrsAVisdBmqCOIfGFl36aZpRI78kh
         ahOA==
X-Gm-Message-State: AOAM532b2a3e1nnp3BjxU5wwYe8jPkTjI4JFRJ2jB3xkKPE4SvddzGE0
        4FgI4WHuptrBh/Kr7FmWlQ==
X-Google-Smtp-Source: ABdhPJztMHxNfWf3xsujrHApl5xwOCW+fbxMgEuv4wshNZPyBEJrBtKtrxhbOqgnAJCUsQbk4qML8A==
X-Received: by 2002:a17:902:b582:b029:d6:6008:264d with SMTP id a2-20020a170902b582b02900d66008264dmr12179232pls.80.1604129301244;
        Sat, 31 Oct 2020 00:28:21 -0700 (PDT)
Received: from localhost.localdomain (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id z21sm688157pfa.158.2020.10.31.00.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 00:28:20 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Winischhofer <thomas@winischhofer.net>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 2/2] fbcon: Prevent global-out-of-bounds read in fbcon_copy_font()
Date:   Sat, 31 Oct 2020 03:27:23 -0400
Message-Id: <64b792b83119b0ec6caed9cb62087453b675c690.1604128640.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

fbcon_copy_font() is using a signed int, `con`, as an index into
`fb_display[MAX_NR_CONSOLES]`, without bounds checking. In
con_font_copy(), `con` is being silently casted from the unsigned
`op->height`.

Let con_font_copy() and fbcon_copy_font() pass `op->height` directly, and
add a range check in fbcon_copy_font(). Also, add a comment in
con_font_op() for less confusion, since ideally `op->height` should not be
used as a console index, as the field name suggests.

This patch depends on patch "console: Remove dummy con_font_op callback
implementations".

Cc: stable@vger.kernel.org
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/tty/vt/vt.c              | 6 +++---
 drivers/video/fbdev/core/fbcon.c | 8 ++++++--
 include/linux/console.h          | 2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9506a76f3ab6..ff8ea1654a69 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4704,9 +4704,8 @@ static int con_font_default(struct vc_data *vc, struct console_font_op *op)
 	return rc;
 }
 
-static int con_font_copy(struct vc_data *vc, struct console_font_op *op)
+static int con_font_copy(struct vc_data *vc, unsigned int con)
 {
-	int con = op->height;
 	int rc;
 
 
@@ -4735,7 +4734,8 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
 	case KD_FONT_OP_SET_DEFAULT:
 		return con_font_default(vc, op);
 	case KD_FONT_OP_COPY:
-		return con_font_copy(vc, op);
+		/* uses op->height as a console index */
+		return con_font_copy(vc, op->height);
 	}
 	return -ENOSYS;
 }
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cef437817b0d..1caa98146712 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2451,11 +2451,15 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 	return 0;
 }
 
-static int fbcon_copy_font(struct vc_data *vc, int con)
+static int fbcon_copy_font(struct vc_data *vc, unsigned int con)
 {
-	struct fbcon_display *od = &fb_display[con];
+	struct fbcon_display *od;
 	struct console_font *f = &vc->vc_font;
 
+	if (con >= MAX_NR_CONSOLES)
+		return -EINVAL;
+
+	od = &fb_display[con];
 	if (od->fontdata == f->data)
 		return 0;	/* already the same font... */
 	return fbcon_do_set_font(vc, f->width, f->height, od->fontdata, od->userfont);
diff --git a/include/linux/console.h b/include/linux/console.h
index 4b1e26c4cb42..34855d3f2afd 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -62,7 +62,7 @@ struct consw {
 	int	(*con_font_get)(struct vc_data *vc, struct console_font *font);
 	int	(*con_font_default)(struct vc_data *vc,
 			struct console_font *font, char *name);
-	int	(*con_font_copy)(struct vc_data *vc, int con);
+	int	(*con_font_copy)(struct vc_data *vc, unsigned int con);
 	int     (*con_resize)(struct vc_data *vc, unsigned int width,
 			unsigned int height, unsigned int user);
 	void	(*con_set_palette)(struct vc_data *vc,
-- 
2.25.1

