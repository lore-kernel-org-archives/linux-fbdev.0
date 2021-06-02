Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1ECC47083
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Jun 2021 09:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB6E610CB
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Jun 2021 09:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhFBJdU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Jun 2021 05:33:20 -0400
Received: from w4.tutanota.de ([81.3.6.165]:52178 "EHLO w4.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhFBJdT (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 2 Jun 2021 05:33:19 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2021 05:33:19 EDT
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w4.tutanota.de (Postfix) with ESMTP id 53D8910601EF
        for <linux-fbdev@vger.kernel.org>; Wed,  2 Jun 2021 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1622625847;
        s=s1; d=tuta.io;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=UmAcICIaKq8y/cAiBMpq5puIHlCBXs37f+hc6mp26t8=;
        b=YqoOuLBeKlVRvamq/y70tAs6GJCw9ZwZ2Kk8FDgBw1sfERBMoofjcqxf8K6OWlPy
        axuUf9Ykc5H4igWvwlWgr4H0rHBvgsPGpakADM/QnyxaHiUAcL45Jm5wsDYzmvmkpRb
        4dJs70srXe74Q8hOAiWID4klecDIsu7ZNjyg4l7ucUnUTLkIy10/utZkDXHSRlBFPhS
        SpGxMK5s6qnSrskAieTWFeBaZWEDGJurvJVd8TBFr1NCgYlRvXk90kIIT+tl+tvHGCg
        4VUtJhQynobj4jA2FGivced8CnFQoPgcXjtoGpKm4yvr/OdZuLa3z8zIdc28YdE3yAr
        xLwA37Z+uw==
Date:   Wed, 2 Jun 2021 11:24:07 +0200 (CEST)
From:   Adam Kandur <rndd@tuta.io>
To:     linux-fbdev@vger.kernel.org
Message-ID: <MbB1N7h--3-2@tuta.io>
Subject: [PATCH] modify fbtft/fb_agm1264k-fl.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From b8bcaa200c97a6054efdb2c58acf5cf794c150d1 Mon Sep 17 00:00:00 2001
From: Adam Kandur <rndd@tuta.io>
Date: Wed, 2 Jun 2021 12:12:48 +0300
Subject: [PATCH] modify fbtft/fb_agm1264k-fl.c

---
drivers/staging/fbtft/fb_agm1264k-fl.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index eeeeec97a..2e58c9d1a 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -273,10 +273,10 @@ static void iterate_diffusion_matrix(u32 xres, u32 yres, int x,
continue;
write_pos = &convert_buf[(y + j) * xres + x + i];
coeff = diffusing_matrix[i][j];
-			if (-1 == coeff) {
+			if (-1 == coeff)
/* pixel itself */
*write_pos = pixel;
-			} else {
+			else {
signed short p = *write_pos + error * coeff;

if (p > WHITE)
--
2.31.1

