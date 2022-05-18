Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E14C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 18 May 2022 18:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbiERSaP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 18 May 2022 14:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbiERSaO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 18 May 2022 14:30:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527D2268A2
        for <linux-fbdev@vger.kernel.org>; Wed, 18 May 2022 11:30:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0AA221BB6;
        Wed, 18 May 2022 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652898609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LFhkKZCpJuuSRVngySn7Ria9bqnykwodBJ+TQBeWJWw=;
        b=ZlfIsU0teixeYsjuE71J9WhX7c+tZIinjK6xK27iqO3YsO9IuDVWLZH8mOVXo/yDWpjFZh
        H/7kHegqMjZyv75f2+HSO5QT8GMallPReoj98LESG/4G/yo8VLg5n0xJCAYbOHdSdi73zp
        7fRnF4dEu1ZJY+nTAi/BH0CE6rBqrBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652898609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LFhkKZCpJuuSRVngySn7Ria9bqnykwodBJ+TQBeWJWw=;
        b=Dlt6KKCtllACFZibNb6QiwXu2hr+rnAauJAKKmfx44rDm75gWp2baS4A1cROG/vhVd8luP
        /1iq4/j1/DTCfmDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 959A013A6D;
        Wed, 18 May 2022 18:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1oedIzE7hWLPGgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 18 May 2022 18:30:09 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, maxime@cerno.tech, sam@ravnborg.org,
        msuchanek@suse.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] drm: Add driverof PowerPC OF displays
Date:   Wed, 18 May 2022 20:30:04 +0200
Message-Id: <20220518183006.14548-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

PowerPC's Open Firmware offers a simple display buffer for graphics
output. Add ofdrm, a DRM driver for the device. As with the existing
simpledrm driver, the graphics hardware is pre-initialized by the
firmware. The driver only provides blitting, no actual DRM modesetting
is possible.

Thomas Zimmermann (2):
  MAINTAINERS: Broaden scope of simpledrm entry
  drm/tiny: Add ofdrm for Open Firmware framebuffers

 MAINTAINERS                   |   5 +-
 drivers/gpu/drm/tiny/Kconfig  |  12 +
 drivers/gpu/drm/tiny/Makefile |   1 +
 drivers/gpu/drm/tiny/ofdrm.c  | 748 ++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/Kconfig   |   1 +
 5 files changed, 766 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/tiny/ofdrm.c

-- 
2.36.1

