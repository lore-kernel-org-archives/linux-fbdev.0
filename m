Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C2C77B61
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Apr 2023 08:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjDXI6a (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Apr 2023 04:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXI63 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Apr 2023 04:58:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC5E55
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Apr 2023 01:58:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7513121A14;
        Mon, 24 Apr 2023 08:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682326707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+XJKKs849sQThStkQBOzc9zUGVmnw3q29MM/bZVqjno=;
        b=sTHEbv0Qsj31NwYUZzEROdQpCSS5LV/X6EuZYOl8EJ/bnEQLJc2J8oV6QktbiKtYcaJuuu
        bBnHLvNYCglfbu5XkDrmY/YYnMwCjos6qAXMMu6vvsD24subW2YeAo3U/UBSrLftjgjYjW
        711In0IAbrsSC3ikIF9+94JqNbFPsPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682326707;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+XJKKs849sQThStkQBOzc9zUGVmnw3q29MM/bZVqjno=;
        b=v8+j+2rycJN/3aArKwUvpMuDbTcryq8BQGXsbwDQWcVhH5EDTbrMI2eMMxAJgCq6OQwUBV
        jxp5mg9z0y66loDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39AB513780;
        Mon, 24 Apr 2023 08:58:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t0TQDLNERmQneQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 24 Apr 2023 08:58:27 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, geert@linux-m68k.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/3] fbdev: Set missing owner fields in fb_ops
Date:   Mon, 24 Apr 2023 10:58:22 +0200
Message-Id: <20230424085825.18287-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Set the owner field of various drivers' fb_ops instance. The
setting is required by fbcon, which acquires a reference on the
fbdev driver's module. Otherwise, users could attempt to unload
the module while it's still in use.

Thomas Zimmermann (3):
  fbdev/68328fb: Init owner field of struct fb_ops
  fbdev/ps3fb: Init owner field of struct fb_ops
  fbdev/vfb: Init owner field of struct fb_ops

 drivers/video/fbdev/68328fb.c | 1 +
 drivers/video/fbdev/ps3fb.c   | 1 +
 drivers/video/fbdev/vfb.c     | 1 +
 3 files changed, 3 insertions(+)

-- 
2.40.0

