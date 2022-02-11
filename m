Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD23EC433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 09:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348697AbiBKJqp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:46:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242819AbiBKJqo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 04:46:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEBF10A1
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:46:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 736981F38B;
        Fri, 11 Feb 2022 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644572802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hWkSlUqmvqatphDrQbtqrs0TOgMUCOXaEkFWSy0KgDk=;
        b=h/kVSTb3vhQtZK+zgStLmNwTpJ57fiDU+/rp+KR9SNzkLAEVNrYlmgIQlSbZ5FSGKMsqqk
        CYolu8WU7Tn1n300He3nrzmyhwgC0p6xMrw/r0b0wtwboP0/oGLI29iLaOZqlGZxOWdqp+
        CwELrMZr+AJom+1bHtV4GHHpR6S+9DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644572802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hWkSlUqmvqatphDrQbtqrs0TOgMUCOXaEkFWSy0KgDk=;
        b=VazQaEGt2MZRxX9i4HqAvveVE+YoXNHkeuAsaO6UlK3QZqbIsi04Imv/kNGkD/q5WQGKqW
        3oZ9BxTFHNkow6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CC9213BC3;
        Fri, 11 Feb 2022 09:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zJbzCYIwBmKMHQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 11 Feb 2022 09:46:42 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, javierm@redhat.com, noralf@tronnes.org,
        andriy.shevchenko@linux.intel.com, deller@gmx.de,
        bernie@plugable.com, jayalk@intworks.biz
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/2] fbdev: Significantly improve performance of fbdefio mmap
Date:   Fri, 11 Feb 2022 10:46:38 +0100
Message-Id: <20220211094640.21632-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove the bubble sort from fbdev defered-I/O page tracking. Most
drivers only want to know which pages have been written to. The exact
order is not important.

Tested on simpledrm.

v2:
	* make sorted page lists the special case (Sam)
	* improve several comments (Sam)

Thomas Zimmermann (2):
  fbdev/defio: Early-out if page is already enlisted
  fbdev: Don't sorting deferred-I/O pages by default

 drivers/staging/fbtft/fbtft-core.c  |  1 +
 drivers/video/fbdev/broadsheetfb.c  |  1 +
 drivers/video/fbdev/core/fb_defio.c | 48 ++++++++++++++++++++---------
 drivers/video/fbdev/metronomefb.c   |  1 +
 drivers/video/fbdev/udlfb.c         |  1 +
 include/linux/fb.h                  |  1 +
 6 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.34.1

