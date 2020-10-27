Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9D9C55178
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 00:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BFD21D42
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603758024;
	bh=WDIy5NAMUgKJed38rTklTj5huLIPmnjqzgrejSlkD80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LSBqWpzG26PGx/Y1FMQ5jrTbtcdxF03Xnpxz9SEdnMqM0OUttVgXNZVMWwX0T3UEf
	 Yi8zYvHjSbGmNyvSh2dn6yACRHXBAVtArte+L+ovgLYZWel7W35tc4rN4apayXUifK
	 YJ9WM2Br3w+Zlu2n1lJq7WmNdcNDxBPql/gsF+aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438824AbgJ0AGp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437668AbgJ0AEb (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Oct 2020 20:04:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF80121707;
        Tue, 27 Oct 2020 00:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603757070;
        bh=WDIy5NAMUgKJed38rTklTj5huLIPmnjqzgrejSlkD80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQHqMgh9HuAsJGUfz/7Rp1ld2oB64cxrtZO+ci1C4iNadvM/+POMruTXgfLMeag3U
         bHiE4Qr9jpO3ZdX85txuwuUYoT+Q1MCUI1Kj5YHf4Mg1rIpFItjHUpNA/CIrVKHPjY
         OqxlGSh7Ul1o3nBESmjUPmeNKNfQnPQ7Ozc2xLnE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 12/60] video: fbdev: pvr2fb: initialize variables
Date:   Mon, 26 Oct 2020 20:03:27 -0400
Message-Id: <20201027000415.1026364-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027000415.1026364-1-sashal@kernel.org>
References: <20201027000415.1026364-1-sashal@kernel.org>
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
index 8a53d1de611d5..3fd2cb4cdfa90 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -1027,6 +1027,8 @@ static int __init pvr2fb_setup(char *options)
 	if (!options || !*options)
 		return 0;
 
+	cable_arg[0] = output_arg[0] = 0;
+
 	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt)
 			continue;
-- 
2.25.1

