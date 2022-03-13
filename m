Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABA5C433FE
	for <linux-fbdev@archiver.kernel.org>; Sun, 13 Mar 2022 19:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiCMTbE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiCMTbD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 13 Mar 2022 15:31:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE54D613
        for <linux-fbdev@vger.kernel.org>; Sun, 13 Mar 2022 12:29:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BAF81F37C;
        Sun, 13 Mar 2022 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647199794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wP5LDXBP8J8DKjPs9l1L4LYI82zELO9ebHaKl/RR6a4=;
        b=sgqPuu4nG/qzClhY9AMBt2wmAkjskOOJUk/IUprSAKRH7gLQQ30If2HGBw42nh6vs7JujW
        m64+6b5W+ORdRjIktbbbiTNLvnxnPgEg7o9xbLh/X5vDi2iBqhhfSWRupRs7lht18H4Jmg
        hqMuQktpGM9qqrkFnAyRxa1EtSUwWFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647199794;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wP5LDXBP8J8DKjPs9l1L4LYI82zELO9ebHaKl/RR6a4=;
        b=3G930hpDFXktRi/1G6Eiv/bgwQv4u3aeXJk9RFkcvYdNZLnHk/OIEJZfgQt4ZbpcgBn6Y2
        FzL+IqqlRFxEvcCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFA7413AFE;
        Sun, 13 Mar 2022 19:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mYWTNTFGLmIiFQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Sun, 13 Mar 2022 19:29:53 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, deller@gmx.de, m.szyprowski@samsung.com,
        geert@linux-m68k.org, javierm@redhat.com, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] fbdev: Fix image blitting for arbitrary image widths
Date:   Sun, 13 Mar 2022 20:29:50 +0100
Message-Id: <20220313192952.12058-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Recent optimization of the fbdev image-bitting helpers broke the code for
image width that do not align with multiples of 8. Both, sys and cfb, are
affected. Fix this problem by handling the trailing pixels on each line
separately.

Tested with simpledrm and the 7x14 font.

Thomas Zimmermann (2):
  fbdev: Fix sys_imageblit() for arbitrary image widths
  fbdev: Fix cfb_imageblit() for arbitrary image widths

 drivers/video/fbdev/core/cfbimgblt.c | 28 +++++++++++++++++++++++----
 drivers/video/fbdev/core/sysimgblt.c | 29 ++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.35.1

