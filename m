Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE4C63777
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Nov 2020 18:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DD322D0A
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Nov 2020 18:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dop1Dk46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgKTSmd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731600AbgKTSk3 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:29 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CFD8246A5;
        Fri, 20 Nov 2020 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897626;
        bh=Y8kh4owvTk63yVbmvl7KFgSqNLo2VS4SK56SXLF+fBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dop1Dk46ltomSe9RnVeh+F4JQdthkLRZGJkGbcpFRXggLCnBfNjtF6Qh30G6n3yh6
         jPfF/2qAWBAInawMufgN75RsUlg+KGdHY64wLZXOCwlNlFzof9nhzTcoZjD2RxQIQ/
         8uf1yq40dFK9D7Ue5Q/Wr4bohI0P/XZLWdzxFBlY=
Date:   Fri, 20 Nov 2020 12:40:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andres Salomon <dilinger@queued.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-geode@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 134/141] video: fbdev: lxfb_ops: Fix fall-through warnings
 for Clang
Message-ID: <9c1dcb12aae7c7ff0907ffb99ffd227656cbe444.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/video/fbdev/geode/lxfb_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/geode/lxfb_ops.c b/drivers/video/fbdev/geode/lxfb_ops.c
index b3a041fce570..32baaf59fcf7 100644
--- a/drivers/video/fbdev/geode/lxfb_ops.c
+++ b/drivers/video/fbdev/geode/lxfb_ops.c
@@ -682,6 +682,7 @@ static void lx_restore_display_ctlr(struct lxfb_par *par)
 		case DC_DV_CTL:
 			/* set all ram to dirty */
 			write_dc(par, i, par->dc[i] | DC_DV_CTL_CLEAR_DV_RAM);
+			break;
 
 		case DC_RSVD_1:
 		case DC_RSVD_2:
-- 
2.27.0

