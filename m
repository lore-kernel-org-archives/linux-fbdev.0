Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14553CCA47C
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 00:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382176AbiFHAOm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837632AbiFHAAR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Jun 2022 20:00:17 -0400
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 12:39:12 PDT
Received: from 16.mo550.mail-out.ovh.net (16.mo550.mail-out.ovh.net [178.33.104.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC02AC571
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 12:39:11 -0700 (PDT)
Received: from player698.ha.ovh.net (unknown [10.111.172.211])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 5078C246CE
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 19:23:52 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player698.ha.ovh.net (Postfix) with ESMTPSA id 6FA302B48041C;
        Tue,  7 Jun 2022 19:23:45 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-110S00469d172a2-4b38-4c8e-95e7-ea9a2b73ce1c,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Helge Deller <deller@gmx.de>, Paul Mackerras <paulus@samba.org>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 0/7] fbdev: Use backlight helpers
Date:   Tue,  7 Jun 2022 21:23:28 +0200
Message-Id: <20220607192335.1137249-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11945798012241282694
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedgudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheileekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhfsgguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedt
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

backlight_properties.fb_blank is deprecated. The states it represents
are handled by other properties; but instead of accessing those
properties directly, drivers should use the helpers provided by
backlight.h, even in cases where fb_blank isn't involved.

This will ultimately allow fb_blank to be removed.

Stephen Kitt (7):
  fbdev: aty128fb: Use backlight helper
  fbdev: atyfb: Use backlight helper
  fbdev: radeon: Use backlight helper
  fbdev: mx3fb: Use backlight helper
  fbdev: nvidia: Use backlight helper
  fbdev: omapfb: panel-dsi-cm: Use backlight helper
  fbdev: riva: Use backlight helper

 drivers/video/fbdev/aty/aty128fb.c                       | 6 ++----
 drivers/video/fbdev/aty/atyfb_base.c                     | 8 +-------
 drivers/video/fbdev/aty/radeon_backlight.c               | 6 +-----
 drivers/video/fbdev/mx3fb.c                              | 7 +------
 drivers/video/fbdev/nvidia/nv_backlight.c                | 8 +-------
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 8 +-------
 drivers/video/fbdev/riva/fbdev.c                         | 8 +-------
 7 files changed, 8 insertions(+), 43 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.30.2

