Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E062C4743C
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Jun 2021 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6820560E0B
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Jun 2021 12:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhFUMYG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Jun 2021 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUMYG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Jun 2021 08:24:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD5CC061574
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Jun 2021 05:21:52 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvIw2-0005r0-E7; Mon, 21 Jun 2021 14:21:50 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvIw1-0005IZ-H0; Mon, 21 Jun 2021 14:21:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH v3 0/2] backlight: lm3630a: convert to atomic PWM API
Date:   Mon, 21 Jun 2021 14:21:46 +0200
Message-Id: <20210621122148.116863-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Uwe Kleine-König <uwe@kleine-koenig.org>

Hello,

this is v3 of the series. In v1 and v2 I failed to notice that the
driver contains two (nearly identical) update_status callbacks. Daniel
pointed that out, so here comes v3.

Best regards
Uwe

Uwe Kleine-König (2):
  backlight: lm3630a: fix return code of .update_status() callback
  backlight: lm3630a: convert to atomic PWM API and check for errors

 drivers/video/backlight/lm3630a_bl.c | 50 +++++++++++++---------------
 1 file changed, 23 insertions(+), 27 deletions(-)

-- 
2.30.2

