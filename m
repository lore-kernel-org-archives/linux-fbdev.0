Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FDAC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Feb 2022 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiBUTyh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:54:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiBUTyh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Feb 2022 14:54:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC6E22535
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Feb 2022 11:54:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A248210E3;
        Mon, 21 Feb 2022 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645473252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vb/yYMmkZswk47laAMZe0Vl5CGOJib45/nPrTHVVtdU=;
        b=xtX9buHOjNNIl4FOPDYlWld60Ubfh+a4W76/3msmEBYkGWDTWGaDtOZE9ejzz3XQo1Zz9D
        yaa5cOf8D4+r7CK7kz4Xq+vdw921SVLOjBAxwsa5Q69/gtv36A6MNjYd+zM2h0sV4LIGDa
        ZqZuxV6RBEm9yGNQBeqwjSLCAnwzKCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645473252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vb/yYMmkZswk47laAMZe0Vl5CGOJib45/nPrTHVVtdU=;
        b=yR8ZSMCYBgVaU5WQ6Hiu4vhIAZBoN+K+DiDbNRBtt1T9yA1E8u5XF2Cmwjj4gYJSrTgc9N
        xPmk3CLPnsbqxRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0970013B78;
        Mon, 21 Feb 2022 19:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V9ddAeTtE2KVPwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 21 Feb 2022 19:54:12 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, sam@ravnborg.org, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/5] fbdev: Improve performance of fbdev console
Date:   Mon, 21 Feb 2022 20:54:05 +0100
Message-Id: <20220221195410.9172-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Optimize performance of the fbdev console for the common case of
software-based clearing and image blitting.

The commit descripton of each patch contains resuls os a simple
microbenchmark. I also tested the full patchset's effect on the
console output by printing directory listings (i7-4790, FullHD,
simpledrm, kernel with debugging).

  > time find /usr/share/doc -type f

In the unoptimized case:

  real    0m6.173s
  user    0m0.044s
  sys     0m6.107s

With optimizations applied:

  real    0m4.754s
  user    0m0.044s
  sys     0m4.698s

In the optimized case, printing the directory listing is ~25% faster
than before.

In v2 of the patchset, after implementing Sam's suggestion to update
cfb_imageblit() as well, it turns out that the compiled code in
sys_imageblit() is still significantly slower than the CFB version. A
fix is probably a larger task and would include architecture-specific
changes. A new TODO item suggests to investigate the performance of the
various helpers and format-conversion functions in DRM and fbdev.

v2:
	* improve readability for sys_imageblit() (Gerd, Sam)
	* new TODO item for further optimization

Thomas Zimmermann (5):
  fbdev: Improve performance of sys_fillrect()
  fbdev: Improve performance of sys_imageblit()
  fbdev: Remove trailing whitespaces from cfbimgblt.c
  fbdev: Improve performance of cfb_imageblit()
  drm: Add TODO item for optimizing format helpers

 Documentation/gpu/todo.rst             |  22 +++++
 drivers/video/fbdev/core/cfbimgblt.c   | 107 ++++++++++++++++---------
 drivers/video/fbdev/core/sysfillrect.c |  16 +---
 drivers/video/fbdev/core/sysimgblt.c   |  49 ++++++++---
 4 files changed, 133 insertions(+), 61 deletions(-)

-- 
2.35.1

