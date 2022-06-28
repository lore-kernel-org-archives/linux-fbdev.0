Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DEEC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 28 Jun 2022 02:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbiF1C3w (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Jun 2022 22:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbiF1C2J (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Jun 2022 22:28:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D592612F;
        Mon, 27 Jun 2022 19:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECE4CB81C00;
        Tue, 28 Jun 2022 02:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89448C341CC;
        Tue, 28 Jun 2022 02:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656383194;
        bh=MUI0g+P5Tea9OVrYzqPo9ISB1lDMPbc+HFynI4qkWbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWjSja8WpWVWL3iWK82+md7xTtHJHXcMRGB1hvHOpsOkrkIHPPc5HbNFim/GxudlA
         Y+vhdlTaaFG6jvxfNVtpweKwVfg+5Y5sI/3SonWcGxmeZWmgsp4FMzKajKy/MYg8/2
         SYvzP4YZHen/kh42sCCDYcN3Xyi24qLmqWDXUfEAZNb4El5DgWQpDYn4oJ021Gbd8q
         hmXQLAjjtJV3Rf1LmW7Ob6XyAksBEn5bszuA0SQubF3XWuCbA0ddE1epWq/X0Fs6Ya
         Ev+gK/BePy2kA+rkRVKhfFveSgsbJT1/gTPQvXqzy8qtrnKVHYwAazB6B2TAB0Imms
         09ynBquIokGDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiang wangx <wangxiang@cdjrlc.com>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>, daniel.vetter@ffwll.ch,
        geert@linux-m68k.org, svens@stackframe.org, cssk@net-c.es,
        bhelgaas@google.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 07/17] video: fbdev: skeletonfb: Fix syntax errors in comments
Date:   Mon, 27 Jun 2022 22:26:05 -0400
Message-Id: <20220628022615.596977-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628022615.596977-1-sashal@kernel.org>
References: <20220628022615.596977-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Xiang wangx <wangxiang@cdjrlc.com>

[ Upstream commit fc378794a2f7a19cf26010dc33b89ba608d4c70f ]

Delete the redundant word 'its'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/skeletonfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
index 7f4e908330bf..b7d364673026 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -96,7 +96,7 @@ static const struct fb_fix_screeninfo xxxfb_fix = {
 
     /*
      * 	Modern graphical hardware not only supports pipelines but some 
-     *  also support multiple monitors where each display can have its  
+     *  also support multiple monitors where each display can have
      *  its own unique data. In this case each display could be  
      *  represented by a separate framebuffer device thus a separate 
      *  struct fb_info. Now the struct xxx_par represents the graphics
-- 
2.35.1

