Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D45C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 19 Oct 2021 12:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B02460FF2
	for <linux-fbdev@archiver.kernel.org>; Tue, 19 Oct 2021 12:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhJSMLs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbhJSMLr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 19 Oct 2021 08:11:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0105AC06161C
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Oct 2021 05:09:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mcnvw-0007lu-PW; Tue, 19 Oct 2021 14:09:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mcnvv-0002tE-9K; Tue, 19 Oct 2021 14:09:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mcnvv-0005Ih-8N; Tue, 19 Oct 2021 14:09:31 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] video: backlight: ili9320: Make ili9320_remove() return void
Date:   Tue, 19 Oct 2021 14:09:27 +0200
Message-Id: <20211019120927.3822792-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=RZYESF66hZfDyWU+b5WASFcMA9DmtfHkhRF6XoE8Ojw=; m=WhH+Bx1/1uVSZ44lHZDVbyJMFOU/mieXkcDGUQhQnns=; p=ykZu7sGpRLez8bbIDcs78swRkDoY3LVlT+edbNOTLqk=; g=ba7faedb192066ac6a8eb382323501df27e7b664
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFutXQACgkQwfwUeK3K7AmoJQgAlhL HLb1VdkVnmqgoodI4R83bacFEbj0EFLMJaUqYBSx46p9c+uwJdioF4GfSyy6uXPZmhBWlc4x4oT6x +F8Prfeu8FMDN9HJctnb7OoQiOY2oUGBJp9r1uVpWHbFeKJFz9lpPPy73YZV7znGMAajD2EIqRmsh 05CvRapwuVzpjACzrQgmxI7WNF6/qyWJ9mmEFR9rFrv4u0elBhvsZfRcm5d2mlYTq9bIpj3JGTPng pUHtFhCP9VxsKuPeni6JXxbZr/vG4uNz73lXIzJKMDW2CSt2wNYlwDjIg3GnoVNDN8iaYEadby7nm EUESjEFRCt3AO3EYF8a2OHBRbLm9rHA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Up to now ili9320_remove() returns zero unconditionally. Make it return
void instead which makes it easier to see in the callers that there is
no error to handle.

Also the return value of spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/backlight/ili9320.c   | 3 +--
 drivers/video/backlight/ili9320.h   | 2 +-
 drivers/video/backlight/vgg2432a4.c | 4 +++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/ili9320.c b/drivers/video/backlight/ili9320.c
index 168ac79523d7..2acd2708f8ca 100644
--- a/drivers/video/backlight/ili9320.c
+++ b/drivers/video/backlight/ili9320.c
@@ -251,10 +251,9 @@ int ili9320_probe_spi(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(ili9320_probe_spi);
 
-int ili9320_remove(struct ili9320 *ili)
+void ili9320_remove(struct ili9320 *ili)
 {
 	ili9320_power(ili, FB_BLANK_POWERDOWN);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(ili9320_remove);
 
diff --git a/drivers/video/backlight/ili9320.h b/drivers/video/backlight/ili9320.h
index fc59e389d59a..8213cc6e9184 100644
--- a/drivers/video/backlight/ili9320.h
+++ b/drivers/video/backlight/ili9320.h
@@ -68,7 +68,7 @@ extern int ili9320_write_regs(struct ili9320 *ili,
 extern int ili9320_probe_spi(struct spi_device *spi,
 			     struct ili9320_client *cli);
 
-extern int ili9320_remove(struct ili9320 *lcd);
+extern void ili9320_remove(struct ili9320 *lcd);
 extern void ili9320_shutdown(struct ili9320 *lcd);
 
 /* PM */
diff --git a/drivers/video/backlight/vgg2432a4.c b/drivers/video/backlight/vgg2432a4.c
index 9bf277ca4ae9..3567b45f9ba9 100644
--- a/drivers/video/backlight/vgg2432a4.c
+++ b/drivers/video/backlight/vgg2432a4.c
@@ -235,7 +235,9 @@ static int vgg2432a4_probe(struct spi_device *spi)
 
 static int vgg2432a4_remove(struct spi_device *spi)
 {
-	return ili9320_remove(spi_get_drvdata(spi));
+	ili9320_remove(spi_get_drvdata(spi));
+
+	return 0;
 }
 
 static void vgg2432a4_shutdown(struct spi_device *spi)
-- 
2.30.2

