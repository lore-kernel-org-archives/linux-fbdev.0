Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35114EB64D9
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 Jul 2023 15:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGFPOh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGFPOg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 6 Jul 2023 11:14:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4958F0
        for <linux-fbdev@vger.kernel.org>; Thu,  6 Jul 2023 08:14:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1A051F88F;
        Thu,  6 Jul 2023 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688656474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=As4kMc/EQnv4x1h6UjH+L2M3C7Pzlg8Iav1SSMTHjVw=;
        b=QIMhXzhClSiikuk/LZH4oABB0QaA5Fds3DfZbyEIA5yJr73GoaCRNr+TxlQNkZ/GSIm0I2
        zHYVURdn5YFhIEQEqUrqu3l+tWlC1tXr6Mck03TTREQIzUS5LyXw2fiyNnkTN2cIgJgca7
        RZlho96Jc8yOlb5aML6xe5ZtotebjMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688656474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=As4kMc/EQnv4x1h6UjH+L2M3C7Pzlg8Iav1SSMTHjVw=;
        b=9VKBDQvAKc+L33Uc/mrU0UwlzC2geGx6JUeo516Cdjz9tldhMLvLyFYLdwbDTZT9QNUEvg
        yJeLLaXPfQ1iLTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8087B138FC;
        Thu,  6 Jul 2023 15:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pRlcHlrapmRvDgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Jul 2023 15:14:34 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/10] fbdev: Generate deferred-I/O helpers
Date:   Thu,  6 Jul 2023 17:08:43 +0200
Message-ID: <20230706151432.20674-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Generate the I/O callbacks for drivers with deferred I/O. As in
the old, opencoded functions, the generated functions operate on
system memory and trigger damage handling if necessary. Also bring
the drivers' Kconfig options up to date.

Generating and initializing via helpers macros will later allow for
a fine-grained setup, depending on Kconfig options. For example, it
will be possible to leave out file I/O if FB_DEVICE has not been set.

Thomas Zimmermann (10):
  fbdev/broadsheetfb: Select FB_SYS_HELPERS_DEFERRED
  fbdev/broadsheetfb: Generate deferred I/O ops
  fbdev/hecubafb: Select FB_SYS_HELPERS_DEFERRED
  fbdev/hecubafb: Generate deferred I/O ops
  fbdev/metronomefb: Select FB_SYS_HELPERS_DEFERRED
  fbdev/metronomefb: Generate deferred I/O ops
  fbdev/ssd1307fb: Select FB_SYS_HELPERS_DEFERRED
  fbdev/ssd1307fb: Generate deferred I/O ops
  fbdev/xen-fbfront: Select FB_SYS_HELPERS_DEFERRED
  fbdev/xen-fbfront: Generate deferred I/O ops

 drivers/video/fbdev/Kconfig        | 31 ++----------
 drivers/video/fbdev/broadsheetfb.c | 78 +++---------------------------
 drivers/video/fbdev/hecubafb.c     | 78 +++---------------------------
 drivers/video/fbdev/metronomefb.c  | 74 +++-------------------------
 drivers/video/fbdev/ssd1307fb.c    | 69 +++++---------------------
 drivers/video/fbdev/xen-fbfront.c  | 61 ++++++++---------------
 6 files changed, 60 insertions(+), 331 deletions(-)

-- 
2.41.0

