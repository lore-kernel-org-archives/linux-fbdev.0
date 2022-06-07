Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F530C43334
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 00:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383326AbiFHAOF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389474AbiFGWx2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Jun 2022 18:53:28 -0400
Received: from 4.mo582.mail-out.ovh.net (4.mo582.mail-out.ovh.net [87.98.184.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7632DF115
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 12:48:32 -0700 (PDT)
Received: from player797.ha.ovh.net (unknown [10.108.20.204])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 5FACD244E5
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 19:09:48 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player797.ha.ovh.net (Postfix) with ESMTPSA id 21EE9273DCA85;
        Tue,  7 Jun 2022 19:09:40 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R004703d033f-7500-4aba-a619-332a081ea3f9,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH 0/4] video/backlight: Use backlight helpers
Date:   Tue,  7 Jun 2022 21:09:21 +0200
Message-Id: <20220607190925.1134737-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11708233135120418438
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhfsgguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedv
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This started with work on the removal of backlight_properties'
deprecated fb_blank field, much of which can be taken care of by using
helper functions provided by backlight.h instead of directly accessing
fields in backlight_properties. This patch series doesn't involve
fb_blank, but it still seems useful to use helper functions where
appropriate.

Stephen Kitt (4):
  backlight: aat2870: Use backlight helper
  backlight: arcxcnn: Use backlight helper
  backlight: ipaq_micro: Use backlight helper
  backlight: tosa: Use backlight helper

 drivers/video/backlight/aat2870_bl.c    | 7 +------
 drivers/video/backlight/arcxcnn_bl.c    | 5 +----
 drivers/video/backlight/ipaq_micro_bl.c | 7 +------
 drivers/video/backlight/tosa_bl.c       | 7 +------
 4 files changed, 4 insertions(+), 22 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.30.2

