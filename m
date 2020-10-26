Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F88C56201
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 00:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE75920780
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 00:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603758180;
	bh=hW8oAgtPCSp1/+yVU3mvQFbxtOKPmK/KoxuZzgXE32A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ol83Q+TkwkwcP2MtcM6MpGdA5mpFyQRWFo0MyV6ITQXXar1+QSAvOSleXBShHeHec
	 ifdPntviUNHduNGlgzyte5qCg1Rlugt0ngTxZ2fgEYn9frintqia+zfYRm1fkQbkaE
	 czClHk6ZNcDQw7TNLy/dHbaRLuKlVW6cZm3b3ZpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441368AbgJ0AXA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410312AbgJZXzh (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Oct 2020 19:55:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12B812222C;
        Mon, 26 Oct 2020 23:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756536;
        bh=hW8oAgtPCSp1/+yVU3mvQFbxtOKPmK/KoxuZzgXE32A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ER1bM0M9+Z8qDIsYP4UZnjvudybCaLg55AqUR7LlkoZnR8SSde5jHPKZsUcca+y/7
         wiRQ/Hofe+gjbHQ9K4dPpWf/LVBv9+Mw3bJQlaZq8Un2V524UyuJZ04395kYCsOWYp
         rs0c8b7Rr2k3EYMpm/on9K8AYvlwp4XgSZ9vPOqc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.4 16/80] video: fbdev: pvr2fb: initialize variables
Date:   Mon, 26 Oct 2020 19:54:12 -0400
Message-Id: <20201026235516.1025100-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235516.1025100-1-sashal@kernel.org>
References: <20201026235516.1025100-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Tom Rix <trix@redhat.com>

[ Upstream commit 8e1ba47c60bcd325fdd097cd76054639155e5d2e ]

clang static analysis reports this repesentative error

pvr2fb.c:1049:2: warning: 1st function call argument
  is an uninitialized value [core.CallAndMessage]
        if (*cable_arg)
        ^~~~~~~~~~~~~~~

Problem is that cable_arg depends on the input loop to
set the cable_arg[0].  If it does not, then some random
value from the stack is used.

A similar problem exists for output_arg.

So initialize cable_arg and output_arg.

Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200720191845.20115-1-trix@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/pvr2fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 0a3b2b7c78912..c916e91614436 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -1016,6 +1016,8 @@ static int __init pvr2fb_setup(char *options)
 	if (!options || !*options)
 		return 0;
 
+	cable_arg[0] = output_arg[0] = 0;
+
 	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt)
 			continue;
-- 
2.25.1

