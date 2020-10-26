Return-Path: <SRS0=7VUZ=EB=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F4C2D0A3
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Oct 2020 19:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402CB20872
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Oct 2020 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603741223;
	bh=nGR/itPh0jz6AbVxRkpFGc/DrAZq4nbxrqWJE5Gzyb0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LX/hXfcu87JhnskvPrRlh1WS4NS14c3PVCIm0spppnqaNwxq76hnSJZ+AfIlT8zH5
	 ign5m+wCYw1p3m6bRaQXPYGF/NmgM+VM0uETfWLsvBx3WJU6DAVz4siH+M/Ak3CWkX
	 si40K7DRB++VXB/CgoOM7xfI/xL3MnRfggY35Wh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437999AbgJZTkX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437922AbgJZTkW (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Oct 2020 15:40:22 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D57220760;
        Mon, 26 Oct 2020 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603741222;
        bh=nGR/itPh0jz6AbVxRkpFGc/DrAZq4nbxrqWJE5Gzyb0=;
        h=From:To:Cc:Subject:Date:From;
        b=0IfrEwAww116p9n62jgFdrxDrcJfSr3FN0QwP3khTPqJkzGE3ME/FMtgQOPBQBS2T
         spYjXpTIVLHz1Em0QaHed7uYCzl8seSsArlUP18ei/XuCj1thrBV+1bKq+vodby961
         TMzcY/KXq/xW7pUD3f0WY5q6Mzb7D4NaoFK+T354=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb: avoid -Warray-bounds warning
Date:   Mon, 26 Oct 2020 20:39:55 +0100
Message-Id: <20201026194010.3817166-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The open-coded list_for_each_entry() causes a harmless warning:

drivers/video/fbdev/matrox/matroxfb_base.c: In function 'matroxfb_register_driver':
include/linux/kernel.h:856:3: warning: array subscript -98 is outside array bounds of 'struct list_head[1]' [-Warray-bounds]

Use the normal list_for_each_entry instead.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/matrox/matroxfb_base.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 570439b32655..a3853421b263 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -1970,9 +1970,7 @@ int matroxfb_register_driver(struct matroxfb_driver* drv) {
 	struct matrox_fb_info* minfo;
 
 	list_add(&drv->node, &matroxfb_driver_list);
-	for (minfo = matroxfb_l(matroxfb_list.next);
-	     minfo != matroxfb_l(&matroxfb_list);
-	     minfo = matroxfb_l(minfo->next_fb.next)) {
+	list_for_each_entry(minfo, &matroxfb_list, next_fb) {
 		void* p;
 
 		if (minfo->drivers_count == MATROXFB_MAX_FB_DRIVERS)
@@ -1990,9 +1988,7 @@ void matroxfb_unregister_driver(struct matroxfb_driver* drv) {
 	struct matrox_fb_info* minfo;
 
 	list_del(&drv->node);
-	for (minfo = matroxfb_l(matroxfb_list.next);
-	     minfo != matroxfb_l(&matroxfb_list);
-	     minfo = matroxfb_l(minfo->next_fb.next)) {
+	list_for_each_entry(minfo, &matroxfb_list, next_fb) {
 		int i;
 
 		for (i = 0; i < minfo->drivers_count; ) {
-- 
2.27.0

