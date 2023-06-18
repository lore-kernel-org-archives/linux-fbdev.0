Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39B5EB64D7
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Jun 2023 20:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFRUxz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Jun 2023 16:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFRUxy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Jun 2023 16:53:54 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E70E6A
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Jun 2023 13:53:29 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AzNvqYsw5LSaaAzNvqfd41; Sun, 18 Jun 2023 22:52:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687121552;
        bh=hfE30K9IK7rXEnDLZJeVX8ddHPQiVgEhsGvxibEOfaw=;
        h=From:To:Cc:Subject:Date;
        b=bwidpUFgI5FGBLro01LZRgpEap6F3W1IkW3seMmj5UxJFMSQriDW4ce4ecJekQVmE
         /F4Daw9LSApRqZlPO5WvJxYlH9/0OCOp+KmMSkuopDvXrII04NEDSYaexqdEjmxcya
         JNNe1Qb0dVIu21NrGyL6g5PQNlw+tnFIKL8Z3AjXAmCLK3Ellvdh0PT6B6uzB65ogz
         ciyULM4rnNFOD0fE4xlYctcSZxbtRFHSi9UO1AYIHGyxJvcLcxPxVVvhYdbQoa7hqb
         VALI6p0MFdPLrzmVcZvp176RdPifi5QqpHmevB5PM0UUPbeDdcqd+r4IFlbnWecMWm
         QiJfraQOT5gvA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Jun 2023 22:52:32 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] video/hdmi: Reorder fields in 'struct hdmi_avi_infoframe'
Date:   Sun, 18 Jun 2023 22:52:28 +0200
Message-Id: <f5745aeab896f8d4622ff4c3cd0475d9be6bafd8.1687121400.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct hdmi_avi_infoframe'
from 68 to 60 bytes.

It saves a few bytes of memory and is more cache-line friendly.

This also reduces the union hdmi_infoframe the same way.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct hdmi_avi_infoframe {
	enum hdmi_infoframe_type   type;                 /*     0     4 */
	unsigned char              version;              /*     4     1 */
	unsigned char              length;               /*     5     1 */

	/* XXX 2 bytes hole, try to pack */

	enum hdmi_colorspace       colorspace;           /*     8     4 */
	enum hdmi_scan_mode        scan_mode;            /*    12     4 */
	enum hdmi_colorimetry      colorimetry;          /*    16     4 */
	enum hdmi_picture_aspect   picture_aspect;       /*    20     4 */
	enum hdmi_active_aspect    active_aspect;        /*    24     4 */
	bool                       itc;                  /*    28     1 */

	/* XXX 3 bytes hole, try to pack */

	enum hdmi_extended_colorimetry extended_colorimetry; /*    32     4 */
	enum hdmi_quantization_range quantization_range; /*    36     4 */
	enum hdmi_nups             nups;                 /*    40     4 */
	unsigned char              video_code;           /*    44     1 */

	/* XXX 3 bytes hole, try to pack */

	enum hdmi_ycc_quantization_range ycc_quantization_range; /*    48     4 */
	enum hdmi_content_type     content_type;         /*    52     4 */
	unsigned char              pixel_repeat;         /*    56     1 */

	/* XXX 1 byte hole, try to pack */

	short unsigned int         top_bar;              /*    58     2 */
	short unsigned int         bottom_bar;           /*    60     2 */
	short unsigned int         left_bar;             /*    62     2 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	short unsigned int         right_bar;            /*    64     2 */

	/* size: 68, cachelines: 2, members: 20 */
	/* sum members: 57, holes: 4, sum holes: 9 */
	/* padding: 2 */
	/* last cacheline: 4 bytes */
};


After:
=====
struct hdmi_avi_infoframe {
	enum hdmi_infoframe_type   type;                 /*     0     4 */
	unsigned char              version;              /*     4     1 */
	unsigned char              length;               /*     5     1 */
	bool                       itc;                  /*     6     1 */
	unsigned char              pixel_repeat;         /*     7     1 */
	enum hdmi_colorspace       colorspace;           /*     8     4 */
	enum hdmi_scan_mode        scan_mode;            /*    12     4 */
	enum hdmi_colorimetry      colorimetry;          /*    16     4 */
	enum hdmi_picture_aspect   picture_aspect;       /*    20     4 */
	enum hdmi_active_aspect    active_aspect;        /*    24     4 */
	enum hdmi_extended_colorimetry extended_colorimetry; /*    28     4 */
	enum hdmi_quantization_range quantization_range; /*    32     4 */
	enum hdmi_nups             nups;                 /*    36     4 */
	unsigned char              video_code;           /*    40     1 */

	/* XXX 3 bytes hole, try to pack */

	enum hdmi_ycc_quantization_range ycc_quantization_range; /*    44     4 */
	enum hdmi_content_type     content_type;         /*    48     4 */
	short unsigned int         top_bar;              /*    52     2 */
	short unsigned int         bottom_bar;           /*    54     2 */
	short unsigned int         left_bar;             /*    56     2 */
	short unsigned int         right_bar;            /*    58     2 */

	/* size: 60, cachelines: 1, members: 20 */
	/* sum members: 57, holes: 1, sum holes: 3 */
	/* last cacheline: 60 bytes */
};
---
 include/linux/hdmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 2f4dcc8d060e..3bb87bf6bc65 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -170,19 +170,19 @@ struct hdmi_avi_infoframe {
 	enum hdmi_infoframe_type type;
 	unsigned char version;
 	unsigned char length;
+	bool itc;
+	unsigned char pixel_repeat;
 	enum hdmi_colorspace colorspace;
 	enum hdmi_scan_mode scan_mode;
 	enum hdmi_colorimetry colorimetry;
 	enum hdmi_picture_aspect picture_aspect;
 	enum hdmi_active_aspect active_aspect;
-	bool itc;
 	enum hdmi_extended_colorimetry extended_colorimetry;
 	enum hdmi_quantization_range quantization_range;
 	enum hdmi_nups nups;
 	unsigned char video_code;
 	enum hdmi_ycc_quantization_range ycc_quantization_range;
 	enum hdmi_content_type content_type;
-	unsigned char pixel_repeat;
 	unsigned short top_bar;
 	unsigned short bottom_bar;
 	unsigned short left_bar;
-- 
2.34.1

