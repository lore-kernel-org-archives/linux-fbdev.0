Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F1C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 03:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiFHD02 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Jun 2022 23:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbiFHD0R (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Jun 2022 23:26:17 -0400
X-Greylist: delayed 1818 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 13:03:22 PDT
Received: from 12.mo581.mail-out.ovh.net (12.mo581.mail-out.ovh.net [178.33.107.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163E832A8DB
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 13:03:22 -0700 (PDT)
Received: from player698.ha.ovh.net (unknown [10.109.146.143])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 0687E24074
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 19:24:20 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player698.ha.ovh.net (Postfix) with ESMTPSA id D80BF2B48047A;
        Tue,  7 Jun 2022 19:24:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-110S004c12dac52-d115-480d-84c5-32e704857230,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Helge Deller <deller@gmx.de>, Paul Mackerras <paulus@samba.org>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>, dri-devel@lists.freedesktop.org
Subject: [PATCH 3/7] fbdev: radeon: Use backlight helper
Date:   Tue,  7 Jun 2022 21:23:31 +0200
Message-Id: <20220607192335.1137249-4-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607192335.1137249-1-steve@sk2.org>
References: <20220607192335.1137249-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11953397840202401513
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeghffhleeigffhteeiffelveefhfeiudehkedtgefhgedvleffgfejgfdtveeigeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheileekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhfsgguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedu
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Instead of retrieving the backlight brightness in struct
backlight_properties manually, and then checking whether the backlight
should be on at all, use backlight_get_brightness() which does all
this and insulates this from future changes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/aty/radeon_backlight.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/video/fbdev/aty/radeon_backlight.c
index d2c1263ad260..427adc838f77 100644
--- a/drivers/video/fbdev/aty/radeon_backlight.c
+++ b/drivers/video/fbdev/aty/radeon_backlight.c
@@ -57,11 +57,7 @@ static int radeon_bl_update_status(struct backlight_device *bd)
 	 * backlight. This provides some greater power saving and the display
 	 * is useless without backlight anyway.
 	 */
-        if (bd->props.power != FB_BLANK_UNBLANK ||
-	    bd->props.fb_blank != FB_BLANK_UNBLANK)
-		level = 0;
-	else
-		level = bd->props.brightness;
+	level = backlight_get_brightness(bd);
 
 	del_timer_sync(&rinfo->lvds_timer);
 	radeon_engine_idle();
-- 
2.30.2

