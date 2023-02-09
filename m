Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C354C05027
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Feb 2023 07:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBIHOL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Feb 2023 02:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBIHOK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Feb 2023 02:14:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF243126FC;
        Wed,  8 Feb 2023 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=psI5wI9gulg2hiH2+9DDGUZ4DRwxGGa5fsXKxdqh1Cg=; b=3g9U85Y+r0o2gcjA02swU4ypiz
        iVUnPVL+xafRfDyqlHYIWtMGbpDO73/ENly4Dc97gdVPgmQ4tJV7p7+0tBdc5hGuVT6o1Bj9pgq7r
        Yf1qD6lWYUriWzONRRZ0PlcLc0N5eTeKYVe4n5FZ0ykc1GxnOPZo4ICLRjAiMIGucQj3RigrIZTWx
        t09YmW8T3Ait/CCp7066nS/wLLO/POduLE7k9hBw/CKp0VAfiMJngpVLa9pXzkjMgFkVWaoKluNw/
        kJTOd/YySTDitIMIIQDbRtZMM86o7BMmZA8MzezCg1TjTfV29W9coEafQT5+Uq1QSV/HLLRUIBPqP
        lRqoO+Zw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18B-000LPt-08; Thu, 09 Feb 2023 07:14:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 05/24] Documentation: fb: correct spelling
Date:   Wed,  8 Feb 2023 23:13:41 -0800
Message-Id: <20230209071400.31476-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Correct spelling problems for Documentation/fb/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/fb/sm712fb.rst |    2 +-
 Documentation/fb/sstfb.rst   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/fb/sm712fb.rst b/Documentation/fb/sm712fb.rst
--- a/Documentation/fb/sm712fb.rst
+++ b/Documentation/fb/sm712fb.rst
@@ -31,5 +31,5 @@ Missing Features
 ================
 (alias TODO list)
 
-	* 2D acceleratrion
+	* 2D acceleration
 	* dual-head support
diff -- a/Documentation/fb/sstfb.rst b/Documentation/fb/sstfb.rst
--- a/Documentation/fb/sstfb.rst
+++ b/Documentation/fb/sstfb.rst
@@ -73,7 +73,7 @@ Module insertion
 	  the device will be /dev/fb0. You can check this by doing a
 	  cat /proc/fb. You can find a copy of con2fb in tools/ directory.
 	  if you don't have another fb device, this step is superfluous,
-	  as the console subsystem automagicaly binds ttys to the fb.
+	  as the console subsystem automagically binds ttys to the fb.
        #. switch to the virtual console you just mapped. "tadaaa" ...
 
 Module removal
