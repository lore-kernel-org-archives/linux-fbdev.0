Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E937BC6FD18
	for <linux-fbdev@archiver.kernel.org>; Fri, 31 Mar 2023 09:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjCaJXY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 31 Mar 2023 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCaJXX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 31 Mar 2023 05:23:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A101996
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Mar 2023 02:23:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91FAF219E2;
        Fri, 31 Mar 2023 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680254596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=THVDIzxfv+axPfaNnFDnYiZYOvM2JA4pGYw+Lk8Hr3k=;
        b=bcPbu9bRnFVQli9TYWvqZ1MpyzGGhN5lIk/59C5/FPxzO8UtsdgdEtHzZvuK6xqRhpRuZy
        Tw8MaOzvaF6ZLvede3kjvNWjIQkmCUFnXmZJkw03qGlJ/vf2LqoYM7FLdfZuIimYsC6kjn
        XTZesz71JKLuDXlDfpOucmDLSZ+rG4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680254596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=THVDIzxfv+axPfaNnFDnYiZYOvM2JA4pGYw+Lk8Hr3k=;
        b=iuQEkjaqS89C0ZKcvrR+UQBi6iKQr5XZNamdW+TvIHZbq+acdliD7x34ZGbCKX+9YahhmF
        RemTG79PRMeEGUAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EB49133B6;
        Fri, 31 Mar 2023 09:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lbHPGYSmJmTsOwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 31 Mar 2023 09:23:16 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/15] fbdev: Remove trailing whitespaces
Date:   Fri, 31 Mar 2023 11:22:59 +0200
Message-Id: <20230331092314.2209-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The trailing whitespaces are annoying. So remove them. No
functional changes. Some of the patches has already been
acked by Helge.

Thomas Zimmermann (15):
  fbdev/68328fb: Remove trailing whitespaces
  fbdev/atmel_lcdfb: Remove trailing whitespaces
  fbdev/cg14: Remove trailing whitespaces
  fbdev/controlfb: Remove trailing whitespaces
  fbdev/g364fb: Remove trailing whitespaces
  fbdev/hgafb: Remove trailing whitespaces
  fbdev/hpfb: Remove trailing whitespaces
  fbdev/macfb: Remove trailing whitespaces
  fbdev/maxinefb: Remove trailing whitespaces
  fbdev/p9100: Remove trailing whitespaces
  fbdev/platinumfb: Remove trailing whitespaces
  fbdev/sa1100fb: Remove trailing whitespaces
  fbdev/stifb: Remove trailing whitespaces
  fbdev/valkyriefb: Remove trailing whitespaces
  fbdev/vfb: Remove trailing whitespaces

 drivers/video/fbdev/68328fb.c     |  12 +--
 drivers/video/fbdev/atmel_lcdfb.c |   2 +-
 drivers/video/fbdev/cg14.c        |   2 +-
 drivers/video/fbdev/controlfb.c   |  34 +++----
 drivers/video/fbdev/g364fb.c      |   6 +-
 drivers/video/fbdev/hgafb.c       |  36 +++----
 drivers/video/fbdev/hpfb.c        |   8 +-
 drivers/video/fbdev/macfb.c       |  10 +-
 drivers/video/fbdev/maxinefb.c    |   2 +-
 drivers/video/fbdev/p9100.c       |   4 +-
 drivers/video/fbdev/platinumfb.c  |  30 +++---
 drivers/video/fbdev/sa1100fb.c    |  32 +++---
 drivers/video/fbdev/stifb.c       | 156 +++++++++++++++---------------
 drivers/video/fbdev/valkyriefb.c  |  14 +--
 drivers/video/fbdev/vfb.c         |  10 +-
 15 files changed, 179 insertions(+), 179 deletions(-)

-- 
2.40.0

