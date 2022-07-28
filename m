Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6021C04A68
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jul 2022 11:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiG1LOM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jul 2022 07:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiG1LOM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jul 2022 07:14:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F70266AD2
        for <linux-fbdev@vger.kernel.org>; Thu, 28 Jul 2022 04:14:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ltp1h3XKzz4x1N;
        Thu, 28 Jul 2022 21:14:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659006843;
        bh=wZItW5ZtKMHAK45zLNIh7lLY/k1xgG/tdE8BGbTrDhk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EvOuNhleqMSiHu7f5rYL6A7uO+J/Jiy3M00zpvoXyk2JKm3DFUp7iDR+lS3Y9doXt
         pHsrS1Wz9/I3Uhn/+zUXi7njnfawpMliYynInvWYu+h3cRSobhCqiNjLfj98vAUu13
         OAET0Ecz/FZdocX905JEmh3hY2QnI2QALYADJkoBMgcnXPnuetJ04OnWIQA38KHUVF
         JyTcR+Ls9ax70KHCbAEFm6PkHhRglRzjm91nlbRtn/ChitPlpY3kvf2Q5z93oS/hms
         LRbGTIFzRvZCrKGDbHZZHPzIdSEGe/2DlCWH3y26Q+dfV4jv0uKob/aCKd4HB0x7Y+
         K4stznoQSRTyQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        maxime@cerno.tech, sam@ravnborg.org, msuchanek@suse.de,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 00/10] drm: Add driver for PowerPC OF displays
In-Reply-To: <20220720142732.32041-1-tzimmermann@suse.de>
References: <20220720142732.32041-1-tzimmermann@suse.de>
Date:   Thu, 28 Jul 2022 21:13:59 +1000
Message-ID: <871qu5cww8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:
> (was: drm: Add driverof PowerPC OF displays)
>
> PowerPC's Open Firmware offers a simple display buffer for graphics
> output. Add ofdrm, a DRM driver for the device. As with the existing
> simpledrm driver, the graphics hardware is pre-initialized by the
> firmware. The driver only provides blitting, no actual DRM modesetting
> is possible.

Hi Thomas,

I tried to test this on a 32-bit ppc Mac Mini but didn't have much luck.
But I'm probably doing something wrong because I'm a graphics noob.

The machine normally uses CONFIG_DRM_RADEON, so I turned that off, and
turned DRM_OFDRM on.

When I boot I get boot messages but only one screen worth, the messages
don't scroll at all, which is unusual. But I'm not sure if that's
related to ofdrm or something else.

The machine does come up, I can login via SSH. Is there some way to
start X to exercise the driver from an SSH login?

cheers
