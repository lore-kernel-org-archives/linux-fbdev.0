Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F64BC4321E
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Jan 2022 12:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbiAXMhI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jan 2022 07:37:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241571AbiAXMhH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jan 2022 07:37:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F360B21993;
        Mon, 24 Jan 2022 12:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643027827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFsZAidzPnckRwG2ZrgeFcutvgWK0xqyN6mRgt0+1cY=;
        b=wIMYvn9QgvclsDVeWuprpzJM6RLs1EPYcfmJhGo2UmBlY9daF/pFllqaQU6AmxGjbSM6de
        3IYIM8wJMYUg/1dTc6JBKJwpP/0TWLjykEUzXMdBPQe02bVVyjKdZpePx+hq2mLxUgmohL
        C0Y+6NWycWp5jcEO7uHsZNwx6FPGggY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643027827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFsZAidzPnckRwG2ZrgeFcutvgWK0xqyN6mRgt0+1cY=;
        b=UAoLjPluNwuGfsmB9NimS8RSuU7zHxEg67/fA/Gn6qRlmH+9igPAjHoD4j92dNN6U/OPNu
        5ljBaAItlUIWR4AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9F7A13BA4;
        Mon, 24 Jan 2022 12:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4GN7LHKd7mFyNQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 24 Jan 2022 12:37:06 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     zackr@vmware.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        hdegoede@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/5] drm: Add TODO item for requesting memory regions
Date:   Mon, 24 Jan 2022 13:36:59 +0100
Message-Id: <20220124123659.4692-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124123659.4692-1-tzimmermann@suse.de>
References: <20220124123659.4692-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add a TODO item about requesting  memory regions for each driver. The
current DRM drivers don't do this consistently.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 Documentation/gpu/todo.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index da138dd39883..1b2372ef4131 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -467,6 +467,21 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
 
 Level: Intermediate
 
+Request memory regions in all drivers
+-------------------------------------
+
+Go through all drivers and add code to request the memory regions that the
+driver uses. This requires adding calls to request_mem_region(),
+pci_request_region() or similar functions. Use helpers for managed cleanup
+where possible.
+
+Drivers are pretty bad at doing this and there used to be conflicts among
+DRM and fbdev drivers. Still, it's the correct thing to do.
+
+Contact: Thomas Zimmermann <tzimmermann@suse.de>
+
+Level: Starter
+
 
 Core refactorings
 =================
-- 
2.34.1

