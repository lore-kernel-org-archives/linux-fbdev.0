Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F585C04A68
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jul 2022 11:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiG1Lbl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jul 2022 07:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiG1Lbk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jul 2022 07:31:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361F95007B
        for <linux-fbdev@vger.kernel.org>; Thu, 28 Jul 2022 04:31:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B1CFA22D9F;
        Thu, 28 Jul 2022 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659007896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T4hQ/srl6ezx6qKxwYZFZoIzdHVMVGWAztMtWSsODRU=;
        b=WKraLZd3Nx1mQi2HCCD6z59bZmbtSTHs2bmXmI6OQ3rVhAwOgBSCRZcdwvb/ikns0uqwrt
        tGIgXCIY+4dbUN7I273qjDjRWtuA1q/1Q6xTHivSXnpJM955uXQltYYcY2zKust3TXg6Tq
        k12UHAjsTAUsAVY4q3YoTsrsDmWuUuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659007896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T4hQ/srl6ezx6qKxwYZFZoIzdHVMVGWAztMtWSsODRU=;
        b=Gh/HNYvu/lj5tV+p2GbSX4mtEPX6FWpozm40/6neq0aYbAiVlEACdEK6b4/xPj4MiFIioX
        TBy2Jz+a0EBUxCCA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 626C42C141;
        Thu, 28 Jul 2022 11:31:32 +0000 (UTC)
Date:   Thu, 28 Jul 2022 13:31:31 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        maxime@cerno.tech, sam@ravnborg.org, benh@kernel.crashing.org,
        paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 00/10] drm: Add driver for PowerPC OF displays
Message-ID: <20220728113131.GS17705@kitsune.suse.cz>
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <871qu5cww8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qu5cww8.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

On Thu, Jul 28, 2022 at 09:13:59PM +1000, Michael Ellerman wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
> > (was: drm: Add driverof PowerPC OF displays)
> >
> > PowerPC's Open Firmware offers a simple display buffer for graphics
> > output. Add ofdrm, a DRM driver for the device. As with the existing
> > simpledrm driver, the graphics hardware is pre-initialized by the
> > firmware. The driver only provides blitting, no actual DRM modesetting
> > is possible.
> 
> Hi Thomas,
> 
> I tried to test this on a 32-bit ppc Mac Mini but didn't have much luck.
> But I'm probably doing something wrong because I'm a graphics noob.
> 
> The machine normally uses CONFIG_DRM_RADEON, so I turned that off, and
> turned DRM_OFDRM on.
> 
> When I boot I get boot messages but only one screen worth, the messages
> don't scroll at all, which is unusual. But I'm not sure if that's
> related to ofdrm or something else.

A somewhat interesting datapoint might be how this works with offb.

> The machine does come up, I can login via SSH. Is there some way to
> start X to exercise the driver from an SSH login?

The startx script provided by distribution usually works.

It's basically a very convoluted way to do something like

X :0&
DISPLAY=:0 xterm&

Thanks

Michal
