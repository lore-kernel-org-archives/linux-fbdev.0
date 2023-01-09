Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EBFC5479D
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Jan 2023 20:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjAIUDR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Jan 2023 15:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjAIUDQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Jan 2023 15:03:16 -0500
X-Greylist: delayed 86925 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 12:03:15 PST
Received: from 6.mo584.mail-out.ovh.net (6.mo584.mail-out.ovh.net [188.165.36.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B0DC00
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Jan 2023 12:03:14 -0800 (PST)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.143.183])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 5A33224A1F
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Jan 2023 20:03:13 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-5hsr9 (unknown [10.110.103.232])
        by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 37A121FD0F;
        Mon,  9 Jan 2023 20:03:12 +0000 (UTC)
Received: from sk2.org ([37.59.142.103])
        by ghost-submission-6684bf9d7b-5hsr9 with ESMTPSA
        id IRLoAgBzvGOtowEAwhAMxg
        (envelope-from <steve@sk2.org>); Mon, 09 Jan 2023 20:03:12 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-103G0058ad932df-d07d-4a40-b278-686b7b8d2d10,
                    796317D5D98EA53ED2B7ABF3FE0FDD27B7A2AA3D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Stephen Kitt <steve@sk2.org>, Sam Ravnborg <sam@ravnborg.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] fbdev: atmel_lcdfb: Rework backlight status updates
Date:   Mon,  9 Jan 2023 21:02:38 +0100
Message-Id: <20230109200239.1850611-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8286904792286267099
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeigdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleegteeujeffjeefjeevhfdtudefjefgteelgedtudekleeiledvvdetudevjedtnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfhgsuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekgedpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Instead of checking the state of various backlight_properties fields
against the memorised state in atmel_lcdfb_info.bl_power,
atmel_bl_update_status() should retrieve the desired state using
backlight_get_brightness (which takes into account the power state,
blanking etc.). This means the explicit checks using props.fb_blank
and props.power can be dropped.

The backlight framework ensures that backlight is never negative, so
the test before reading the brightness from the hardware always ends
up false and the whole block can be removed. The framework retrieves
the brightness from the hardware through atmel_bl_get_brightness()
when necessary.

As a result, bl_power in struct atmel_lcdfb_info is no longer
necessary, so remove that while we're at it. Since we only ever care
about reading the current state in backlight_properties, drop the
updates at the end of the function.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/atmel_lcdfb.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 1fc8de4ecbeb..8187a7c4f910 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -49,7 +49,6 @@ struct atmel_lcdfb_info {
 	struct clk		*lcdc_clk;
 
 	struct backlight_device	*backlight;
-	u8			bl_power;
 	u8			saved_lcdcon;
 
 	u32			pseudo_palette[16];
@@ -109,22 +108,7 @@ static u32 contrast_ctr = ATMEL_LCDC_PS_DIV8
 static int atmel_bl_update_status(struct backlight_device *bl)
 {
 	struct atmel_lcdfb_info *sinfo = bl_get_data(bl);
-	int			power = sinfo->bl_power;
-	int			brightness = bl->props.brightness;
-
-	/* REVISIT there may be a meaningful difference between
-	 * fb_blank and power ... there seem to be some cases
-	 * this doesn't handle correctly.
-	 */
-	if (bl->props.fb_blank != sinfo->bl_power)
-		power = bl->props.fb_blank;
-	else if (bl->props.power != sinfo->bl_power)
-		power = bl->props.power;
-
-	if (brightness < 0 && power == FB_BLANK_UNBLANK)
-		brightness = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
-	else if (power != FB_BLANK_UNBLANK)
-		brightness = 0;
+	int			brightness = backlight_get_brightness(bl);
 
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, brightness);
 	if (contrast_ctr & ATMEL_LCDC_POL_POSITIVE)
@@ -133,8 +117,6 @@ static int atmel_bl_update_status(struct backlight_device *bl)
 	else
 		lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
 
-	bl->props.fb_blank = bl->props.power = sinfo->bl_power = power;
-
 	return 0;
 }
 
@@ -155,8 +137,6 @@ static void init_backlight(struct atmel_lcdfb_info *sinfo)
 	struct backlight_properties props;
 	struct backlight_device	*bl;
 
-	sinfo->bl_power = FB_BLANK_UNBLANK;
-
 	if (sinfo->backlight)
 		return;
 
-- 
2.30.2

