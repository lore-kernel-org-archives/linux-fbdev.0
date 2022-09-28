Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7990C6FA86
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Sep 2022 10:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiI1Kxx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Sep 2022 06:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiI1Kxa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Sep 2022 06:53:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED353894
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Sep 2022 03:50:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 213611F891;
        Wed, 28 Sep 2022 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664362212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rvKjXOZrj9Wkmgpg1gpT8gS7uKDIb9UkBqyu7OJAIyo=;
        b=eu2p8khAqGYaAgPD0U7yJFj05dU/KA0hqSYjHISQ6h82b6QO10/8mybWBFaJkjhKcpnAsC
        5VPZUXi/MlU9MpC39eftRRvTTLCl/D1/Zkd2SeGv1hnXyA0S+flR6IVJ8GkW4wKpFuu4B8
        iwrdepvHLOtOqDHk8wjpPAEEIClXEwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664362212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rvKjXOZrj9Wkmgpg1gpT8gS7uKDIb9UkBqyu7OJAIyo=;
        b=48QzWCvsuPUQgcTrjJ477vilsoAWv9GwxlMZtaUaZq1DDjQTky/6TNckQNK+oXXXtO2ffk
        ltpoqOWV2SCXhdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C898E13A84;
        Wed, 28 Sep 2022 10:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cpIpMOMmNGMUEwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 28 Sep 2022 10:50:11 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, maxime@cerno.tech, sam@ravnborg.org,
        msuchanek@suse.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 0/5] drm: Add driver for PowerPC OF displays
Date:   Wed, 28 Sep 2022 12:50:05 +0200
Message-Id: <20220928105010.18880-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.37.3
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

Patch 1 adds ofdrm, which has again been significantly reworked.
The FWFB library has been removed infavor of various functions in
existing DRM helper libraries. Ofdrm now supports damage iterators
and synchronization for imported GEM BOs.

Patches 2 to 4 add support for color management. The code has been
taken from fbdev's offb. I have no hardware available for testing the
functionality. Qemu's stdvga apparently does not support gamma tables
in RGB modes. I verified that the color management code is executed
by running Gnome's night-mode settings, but the display's color tone
does not change.

Patch 5, which is new in version 4 of this patchset, adds support for
big-endian scanout buffers. It works at least with qemu's ppc64
emulation. Fbdev emulation and pixman rendering works. GL rendering
produces incorrect colors.

Tested by running fbdev emulation, Wayland Gnome, and Weston on qemu's
ppc64le and ppc64 emulation. 

Thomas Zimmermann (5):
  drm/ofdrm: Add ofdrm for Open Firmware framebuffers
  drm/ofdrm: Add CRTC state
  drm/ofdrm: Add per-model device function
  drm/ofdrm: Support color management
  drm/ofdrm: Support big-endian scanout buffers

 MAINTAINERS                         |    1 +
 drivers/gpu/drm/drm_format_helper.c |   10 +
 drivers/gpu/drm/tiny/Kconfig        |   13 +
 drivers/gpu/drm/tiny/Makefile       |    1 +
 drivers/gpu/drm/tiny/ofdrm.c        | 1421 +++++++++++++++++++++++++++
 drivers/video/fbdev/Kconfig         |    1 +
 6 files changed, 1447 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/ofdrm.c


base-commit: eee1f4330f388247943e97b93008ef11ababfda0
-- 
2.37.3

