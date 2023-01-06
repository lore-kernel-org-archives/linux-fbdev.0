Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B608C3DA7A
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Jan 2023 19:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjAFTTY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 Jan 2023 14:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjAFTTO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 Jan 2023 14:19:14 -0500
X-Greylist: delayed 8966 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 11:19:12 PST
Received: from 6.mo561.mail-out.ovh.net (6.mo561.mail-out.ovh.net [188.165.43.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D173E2D
        for <linux-fbdev@vger.kernel.org>; Fri,  6 Jan 2023 11:19:12 -0800 (PST)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.1.161])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4165A23A55
        for <linux-fbdev@vger.kernel.org>; Fri,  6 Jan 2023 16:49:45 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-dkv5l (unknown [10.110.171.46])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 774621FEFA;
        Fri,  6 Jan 2023 16:49:44 +0000 (UTC)
Received: from sk2.org ([37.59.142.107])
        by ghost-submission-6684bf9d7b-dkv5l with ESMTPSA
        id qEZ3EChRuGOnAQEAwhnnFg
        (envelope-from <steve@sk2.org>); Fri, 06 Jan 2023 16:49:44 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-107S0016c7c8180-8638-4f18-99c1-2227c532a771,
                    9FE29456621203A27B372E1E0503D45BE0167874) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, Stephen Kitt <steve@sk2.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/4] video/backlight: Use backlight helpers
Date:   Fri,  6 Jan 2023 17:48:51 +0100
Message-Id: <20230106164856.1453819-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5848205592908039899
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsthgvvhgvsehskhdvrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhfsgguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth
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

-- 
2.30.2

