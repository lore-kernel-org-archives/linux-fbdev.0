Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934E8C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 11:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7120E61215
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 11:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhKKLmU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 Nov 2021 06:42:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhKKLmU (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 Nov 2021 06:42:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E3F36124C;
        Thu, 11 Nov 2021 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636630771;
        bh=2xTzG56gxhhXwiS95ih42dEn74qDB8279alohU9qlZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vUcqJOU5W38ALz3lDjdbG/DdJhLZ3gujNbRImBlGflvjYe0GBBpvVnrgF3p9Xs4L5
         v28EJY4P4bYReLU2siXGRc4BjsM+26u90QTmMzeqAyDfMCUg8qZHlKsiwpg2kTS4uv
         R8ogjLcrEx0QOAuG1RfK7Na50FtQKTB07Tcq8VmM=
Date:   Thu, 11 Nov 2021 12:39:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Peter Jones <pjones@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] fbdev: Prevent probing generic drivers if a FB is
 already registered
Message-ID: <YY0A8LOVhs5JbMXW@kroah.com>
References: <20211111111120.1344613-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111111120.1344613-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 11, 2021 at 12:11:20PM +0100, Javier Martinez Canillas wrote:
> The efifb and simplefb drivers just render to a pre-allocated frame buffer
> and rely on the display hardware being initialized before the kernel boots.
> 
> But if another driver already probed correctly and registered a fbdev, the
> generic drivers shouldn't be probed since an actual driver for the display
> hardware is already present.
> 
> This is more likely to occur after commit d391c5827107 ("drivers/firmware:
> move x86 Generic System Framebuffers support") since the "efi-framebuffer"
> and "simple-framebuffer" platform devices are registered at a later time.
> 
> Link: https://lore.kernel.org/r/20211110200253.rfudkt3edbd3nsyj@lahvuun/
> Fixes: d391c5827107 ("drivers/firmware: move x86 Generic System Framebuffers support")
> Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
> 
> Changes in v2:
> - Add a Link: tag with a reference to the bug report (Thorsten Leemhuis).
> - Add a comment explaining why the probe fails earlier (Daniel Vetter).
> - Add a Fixes: tag for stable to pick the fix (Daniel Vetter).

That does not mean that it will make it into the stable tree.  Please
read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h
