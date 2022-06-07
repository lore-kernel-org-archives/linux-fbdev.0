Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DD4CCA47F
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Jun 2022 22:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353229AbiFGWcK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Jun 2022 18:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385239AbiFGWbS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Jun 2022 18:31:18 -0400
X-Greylist: delayed 655 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 12:24:40 PDT
Received: from 16.mo561.mail-out.ovh.net (16.mo561.mail-out.ovh.net [188.165.56.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B3E27934A
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 12:24:40 -0700 (PDT)
Received: from player698.ha.ovh.net (unknown [10.108.20.144])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 58AA524188
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 19:24:38 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player698.ha.ovh.net (Postfix) with ESMTPSA id 4F4D12B4804CC;
        Tue,  7 Jun 2022 19:24:29 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-110S0042cd40763-c023-4ca6-b106-f074094dbf1e,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Helge Deller <deller@gmx.de>, Paul Mackerras <paulus@samba.org>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>, dri-devel@lists.freedesktop.org
Subject: [PATCH 5/7] fbdev: nvidia: Use backlight helper
Date:   Tue,  7 Jun 2022 21:23:33 +0200
Message-Id: <20220607192335.1137249-6-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607192335.1137249-1-steve@sk2.org>
References: <20220607192335.1137249-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11958745864637351657
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeghffhleeigffhteeiffelveefhfeiudehkedtgefhgedvleffgfejgfdtveeigeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheileekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhfsgguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedu
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Instead of retrieving the backlight brightness in struct
backlight_properties manually, and then checking whether the backlight
should be on at all, use backlight_get_brightness() which does all
this and insulates this from future changes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/nvidia/nv_backlight.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_backlight.c b/drivers/video/fbdev/nvidia/nv_backlight.c
index 2ce53529f636..503a7a683855 100644
--- a/drivers/video/fbdev/nvidia/nv_backlight.c
+++ b/drivers/video/fbdev/nvidia/nv_backlight.c
@@ -49,17 +49,11 @@ static int nvidia_bl_update_status(struct backlight_device *bd)
 {
 	struct nvidia_par *par = bl_get_data(bd);
 	u32 tmp_pcrt, tmp_pmc, fpcontrol;
-	int level;
+	int level = backlight_get_brightness(bd);
 
 	if (!par->FlatPanel)
 		return 0;
 
-	if (bd->props.power != FB_BLANK_UNBLANK ||
-	    bd->props.fb_blank != FB_BLANK_UNBLANK)
-		level = 0;
-	else
-		level = bd->props.brightness;
-
 	tmp_pmc = NV_RD32(par->PMC, 0x10F0) & 0x0000FFFF;
 	tmp_pcrt = NV_RD32(par->PCRTC0, 0x081C) & 0xFFFFFFFC;
 	fpcontrol = NV_RD32(par->PRAMDAC, 0x0848) & 0xCFFFFFCC;
-- 
2.30.2

