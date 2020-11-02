Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DC5C00A89
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 09:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D3322272
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 09:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8iOFOWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgKBJi5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgKBJi4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 04:38:56 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9354C0617A6;
        Mon,  2 Nov 2020 01:38:56 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i7so8368979pgh.6;
        Mon, 02 Nov 2020 01:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIkUS/F/h0cPY8zoQYXrrVqLmu2PvOEJdmO7uBtIRmA=;
        b=e8iOFOWnoSM+T3VgJIdvUIoDbCbNf3KV95reaRCqBmp2FvsCbL4CFcbuUYPkHqxmkc
         YhdotRfTN81ubPChT7zXGTUsqyNxgeFKNBMCf3SzBPvO9TaXdr+qN9rINCzpASxuYsnj
         N3ZothOUEwZsCsqVm4UXP/NadPUfKNBFMjM6A6dMU7y2wX98kCALGuMEOy3CIoZiAcDP
         kIvitL06u2RajJIyUxt65QaCyZDajX7Gqg1UkiyD+jmHwo8W88hGTfXBUmFaJ3gAMlcI
         cEe5O++yDuXwJtyM44W+wXdYOtwJ4mj5w4oXpjaqcWkEeq9B6ecjw1avm597BfmDlIBi
         xD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIkUS/F/h0cPY8zoQYXrrVqLmu2PvOEJdmO7uBtIRmA=;
        b=Weks0An4NgMi75b4j1Wx6LKQ6xkB9ryVPQ5wDNYuRYoejQDNXnxuj2KYFcMEMS4HXH
         /zW4nu+8xA30xKsEhiH6I2tbW7M9JnzJgt+vd52Z7NxFnDEXuZotbutiH1duX8UdSCKp
         AZP6FfQ8+N7fIXunmlKVTChVe8d+Urh03S475Ssm493eSX9FGAY6hI5Aw8pcILSEd7Tw
         HwnzZxRBJ0MAyaQfX5n83M+EbZhJfG4sytQHjg6TtT1+gTnDKJMF1Bf7rcXNGSzq1W1X
         EOrAs8/dAvb4qUrYrPsdKz6+C0ZMnpPWpBylHrYuQ4RqHvEhR9kB2o2byMVdiaoSHx5x
         68qQ==
X-Gm-Message-State: AOAM531zCnVH5qKQsoBiNwn8HTyxrTlLFpe9wl7rwR8+0Ial3reE1nm4
        X5Io2W0g2SdKodXFKxOwnA==
X-Google-Smtp-Source: ABdhPJzCgNIMLBogFRg0xQa7AqfDjpwCrCxnaBYR0EmavPxwn1TrqXYVqyom19qz7drAlhjDOwtHSg==
X-Received: by 2002:a05:6a00:c8:b029:18b:b0e:e51 with SMTP id e8-20020a056a0000c8b029018b0b0e0e51mr1972116pfj.37.1604309936301;
        Mon, 02 Nov 2020 01:38:56 -0800 (PST)
Received: from localhost.localdomain (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id u11sm12574877pfk.164.2020.11.02.01.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:38:55 -0800 (PST)
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
Subject: [PATCH v2 2/2] tty/vt: Avoid passing struct console_font_op to con_font_copy()
Date:   Mon,  2 Nov 2020 04:37:55 -0500
Message-Id: <72c954371ed9b1d050901b2d498a979017de8a3c.1604306433.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com>
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

con_font_op() is passing an entire `struct console_font_op *` to
con_font_copy(), but con_font_copy() only uses `op->height`. Additionally,
con_font_copy() is silently assigning the unsigned `op->height` to the
signed `con`, then pass it to fbcon_copy_font().

Let con_font_copy() and fbcon_copy_font() pass an unsigned int directly.
Also, add a comment in con_font_op() for less confusion, since ideally
`op->height` should not be used as a console index, as the field name
suggests.

This patch depends on patch "console: Remove dummy con_font_op() callback
implementations".

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
con_font_set(), con_font_get() and con_font_default() also pass an entire
`console_font_op`.

con_font_get() and con_font_default() actually update the structure (later
copied to userspace), so let them be.

con_font_set() does not update the structure, but it uses all fields of it
except `op`. Avoiding passing `console_font_op` to con_font_set() will
thus make its signature pretty long (6 parameters).

Changes in v2:
  - Remove redundant `con < 0` check in con_font_copy() (kernel test robot
    <lkp@intel.com>)
  - Remove unnecessary range check in fbcon_copy_font(). con_font_copy()
    calls vc_cons_allocated(), which does the check
  - Do not Cc: stable
  - Rewrite the title and commit message accordingly

 drivers/tty/vt/vt.c              | 8 ++++----
 drivers/video/fbdev/core/fbcon.c | 2 +-
 include/linux/console.h          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9506a76f3ab6..27821ef97b13 100644
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
 
 
@@ -4715,7 +4714,7 @@ static int con_font_copy(struct vc_data *vc, struct console_font_op *op)
 		rc = -EINVAL;
 	else if (!vc->vc_sw->con_font_copy)
 		rc = -ENOSYS;
-	else if (con < 0 || !vc_cons_allocated(con))
+	else if (!vc_cons_allocated(con))
 		rc = -ENOTTY;
 	else if (con == vc->vc_num)	/* nothing to do */
 		rc = 0;
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
index cef437817b0d..cb5b5705ea71 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2451,7 +2451,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 	return 0;
 }
 
-static int fbcon_copy_font(struct vc_data *vc, int con)
+static int fbcon_copy_font(struct vc_data *vc, unsigned int con)
 {
 	struct fbcon_display *od = &fb_display[con];
 	struct console_font *f = &vc->vc_font;
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

