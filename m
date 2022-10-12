Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E72C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 12 Oct 2022 14:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJLO12 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 12 Oct 2022 10:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJLO1P (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 12 Oct 2022 10:27:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1312AC3
        for <linux-fbdev@vger.kernel.org>; Wed, 12 Oct 2022 07:27:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 936DF1F45F;
        Wed, 12 Oct 2022 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665584830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bUIoEZRTB9r1lwBbrkvBK28f0PkDXtp6GQxBtOrWsPI=;
        b=HyPb1yFQquCok37hotWVp1+Zij1t1706TKbh4gACWlWrc5llFVQAubq5qlfdM1tGfbLTgi
        ezhLbkMtSQWqUd9V6dSfc+LEIHIjxy69utiEs0a4E4IcG2c0XP3HSe0u88uFDnXHm0FlVq
        eIp4ihby3219zuNZU47kbkC73YglsD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665584830;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bUIoEZRTB9r1lwBbrkvBK28f0PkDXtp6GQxBtOrWsPI=;
        b=pRJzz5ayEEG0IBdG1KJosmLHta58ronj+wi2sA0HDRLfAlEyZonma7ygjpcxKNKwRVx+qE
        yKf4wDpmaaHxn/BQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8B2BA2C141;
        Wed, 12 Oct 2022 14:27:08 +0000 (UTC)
Date:   Wed, 12 Oct 2022 16:27:07 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Maxime Ripard <maxime@cerno.tech>, sam@ravnborg.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        mark.cave-ayland@ilande.co.uk, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 5/5] drm/ofdrm: Support big-endian scanout buffers
Message-ID: <20221012142707.GD28810@kitsune.suse.cz>
References: <83071743-a7f2-f761-baa3-da688f26b5e3@suse.de>
 <9162f41f-28c3-493c-ab54-b1c4a2fdf494@app.fastmail.com>
 <fda959d7-1bae-716f-f01b-66d9db9096e0@suse.de>
 <654e3cfe-80d7-46c9-8e5e-461846e4df35@app.fastmail.com>
 <866c7033-0d4e-7b5d-008c-8eb16f99498b@suse.de>
 <f26ca6a1-feb1-4822-ac96-bc484b22f8a0@app.fastmail.com>
 <c80a6e2d-a3b9-8186-cc95-97c4775171ed@suse.de>
 <fc33ebf7-ecb7-4686-ac31-0118a40595f6@app.fastmail.com>
 <0a15ecf5-939d-3b00-bcde-0fc7b449cfda@suse.de>
 <76d8a408-fc3e-4bd1-91c5-8278f7469979@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d8a408-fc3e-4bd1-91c5-8278f7469979@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

On Wed, Oct 12, 2022 at 03:12:35PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 12, 2022, at 2:00 PM, Thomas Zimmermann wrote:
> >
> > Could well be. But ofdrm intents to replace offb and this test has 
> > worked well in offb for almost 15 yrs. If there are bug reports, I'm 
> > happy to take patches, but until then I see no reason to change it.
> 
> I wouldn't change the code in offb unless a user reports a bug,
> but I don't see a point in adding the same mistake to ofdrm if we
> know it can't work on real hardware.
> 
> I tried to find out where this is configured in qemu, but it seems
> to depend on the framebuffer backend there: most are always little-endian,
> ati/bochs/vga-pci/virtio-vga are configurable from the guest through
> some register setting, but vga.c picks a default from the
> 'TARGET_WORDS_BIGENDIAN' macro, which I think is set differently
> between qemu-system-ppc64le and qemu-system-ppc64.
> 
> If you are using the framebuffer code from vga.c, I would guess that
> that you can run a big-endian kernel with qemu-system-ppc64,
> or a little-endian kernel with qemu-system-ppc64le and get the
> correct colors, while running a little-endian kernel with
> qemu-system-ppc64 and vga.c, or using a different framebuffer
> emulation on a big-endian kernel would give you the wrong colors.

Thanks for digging this up.

That makes one thing clear: qemu does not emulate this framebuffer
property correctly, and cannot be relied on for verification.

If you can provide test results from real hardware that show the current
logic as flawed it should be changed.

In absence of such test results I think the most reasonable thing is to
keep the logic that nobody complained about for 10+ years.

Thanks

Michal
