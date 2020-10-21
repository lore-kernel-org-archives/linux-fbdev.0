Return-Path: <SRS0=Io7n=D4=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F2BC2D0A3
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Oct 2020 23:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A0723A65
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Oct 2020 23:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+mPkrUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507355AbgJUX7L (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 21 Oct 2020 19:59:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56196 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507354AbgJUX7L (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 21 Oct 2020 19:59:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LNsmm4104771;
        Wed, 21 Oct 2020 23:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=ia1bvcLIGRlULe3HUUv1lS8YCwcY+Jyv65hKmvu1yYo=;
 b=T+mPkrULepGxEyQ+/ozMIxARHfBx1kgMxaNvSMGMmxaAPv19uO3pCsUhIFHIdaPQlJua
 Dz+efSUQ3HiZ2ExKj7c9rRko9VWVnYFu/UFUwqN23SoVSIFwyjCzciO5Qhql8VHhzFEU
 ol9ZFqhXQkokyJQ2D716Vbq6G+1u6bJmtHLDrWru8wBpL/ZYM1kIQR+eIN5SykFiP8//
 k1qNNQM9FY5hvRjy0Y8jZAozeRV7my956gX9Lei4ENt/zsPh5bxSqycZlMr51CIdHsPL
 jBrwZ0K2dgPYwqIW1ICC30GImMIO1EraDqQmBZga87GkOnmQpFrsFY0i5R0HYphniJKm hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34ak16kky0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 23:58:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LNtheh114258;
        Wed, 21 Oct 2020 23:58:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 348ah086yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 23:58:59 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09LNwwIj119041;
        Wed, 21 Oct 2020 23:58:58 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by aserp3020.oracle.com with ESMTP id 348ah086yg-1;
        Wed, 21 Oct 2020 23:58:58 +0000
From:   saeed.mirzamohammadi@oracle.com
To:     linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, akpm@linux-foundation.org,
        rppt@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        gustavoars@kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 1/1] video: fbdev: fix divide error in fbcon_switch
Date:   Wed, 21 Oct 2020 16:57:58 -0700
Message-Id: <20201021235758.59993-1-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210166
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>

This patch fixes the issue due to:

[   89.572883] divide_error: 0000 [#1] SMP KASAN PTI
[   89.572897] CPU: 3 PID: 16083 Comm: repro Not tainted 5.9.0-rc7.20200930.rc1.allarch-19-g3e32d0d.syzk #5
[   89.572902] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.5.1 01/01/2011
[   89.572934] RIP: 0010:cirrusfb_check_var+0x84/0x1260

The error happens when the pixels value is calculated before performing the sanity checks on bits_per_pixel.
A bits_per_pixel set to zero causes divide by zero error.

This patch moves the calculation after the sanity check.

Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Tested-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
---
 drivers/video/fbdev/cirrusfb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index 15a9ee7cd734..a7749101b094 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -531,7 +531,7 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 {
 	int yres;
 	/* memory size in pixels */
-	unsigned pixels = info->screen_size * 8 / var->bits_per_pixel;
+	unsigned int pixels;
 	struct cirrusfb_info *cinfo = info->par;
 
 	switch (var->bits_per_pixel) {
@@ -573,6 +573,7 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
+	pixels = info->screen_size * 8 / var->bits_per_pixel;
 	if (var->xres_virtual < var->xres)
 		var->xres_virtual = var->xres;
 	/* use highest possible virtual resolution */
-- 
2.27.0

