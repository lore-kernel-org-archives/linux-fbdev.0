Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF432C76188
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Apr 2023 11:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbjDEL2o (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjDEL2j (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Apr 2023 07:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E61410D5
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Apr 2023 04:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680694068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQAzVcvbALN+4zchowqIgolmdBCfNGbq9PZTSMW02q4=;
        b=Wpg2x95F/tb2ztPVU8vyZqQXsZJCza21u/nTsLBlxhOh5LoY+rdhqemG7+HtCYip9F/xJh
        EIB9Q46IAyCVTDJIVgKaCq4pQoy+GVP4nY2/S4hOSbvYUfjGP6fG9lYTVe+8sr734DIlK+
        nsZy9EjUrNJ/awhKWXEDtnuGi0AXguI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-X4_8ItpbMKe1v4hEps57DQ-1; Wed, 05 Apr 2023 07:27:47 -0400
X-MC-Unique: X4_8ItpbMKe1v4hEps57DQ-1
Received: by mail-wr1-f72.google.com with SMTP id m4-20020adfa3c4000000b002e75158e632so1712396wrb.17
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Apr 2023 04:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694066;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQAzVcvbALN+4zchowqIgolmdBCfNGbq9PZTSMW02q4=;
        b=r2d6NA9tv+j+I15BvyWCjzpMR2dbe1ZXc5sjOYm/8R7XOkXoiYX6Nhicuk6cyk/2iE
         wM73qKmrlJT39Ir/x8fWhzn0GDHpzbSmeneZCUSobkvRtRq/3dEM2zMC/fqkaFHk0Lr4
         pz1+1AS+n9X6cw12jbwUTDsfFIjNFg39D5Ky4HDLnaGPfRlxd9QMSmGIZapkDge6jJrQ
         VAk/CzhdFuuIhhf5Jl8FaBLvSfGmtRbDmeHF9KqSo1dQFr5Is8FeKFc+7uOl20ZFtshW
         chYW6DBcIxVTtK3FtUHOhoCA9uQSr2FLoWTONVV11AydlKkRFJUy66xi9T4YcVW833Re
         EPNw==
X-Gm-Message-State: AAQBX9eqX8yz0/Bl6Gu8CNjj8F5c7ijoN0p6NzIXXMA5lNF4E9D9xkY4
        mk2hJkzWQ8R03pnOCI7AyCq033KKMYS37E0aGreiSJFaBwo3zNhg1rO+rc3aewxtHud1id+Wayi
        0EMNHQuba9+JO2yjJ/O518jU=
X-Received: by 2002:a05:600c:21a:b0:3f0:46cd:c9d2 with SMTP id 26-20020a05600c021a00b003f046cdc9d2mr4444092wmi.16.1680694066172;
        Wed, 05 Apr 2023 04:27:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZzTSpH0dlIR9VSJkSVxYJXQwsT62p5V7VWpSKXwUL+Qge1Vw8p6lDnbGeqjb+SWtxtq6KLIw==
X-Received: by 2002:a05:600c:21a:b0:3f0:46cd:c9d2 with SMTP id 26-20020a05600c021a00b003f046cdc9d2mr4444082wmi.16.1680694065839;
        Wed, 05 Apr 2023 04:27:45 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b003ef7058ea02sm1929216wmq.29.2023.04.05.04.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:27:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/8] video/aperture: use generic code to figure out the
 vga default device
In-Reply-To: <20230404201842.567344-2-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
 <20230404201842.567344-2-daniel.vetter@ffwll.ch>
Date:   Wed, 05 Apr 2023 13:27:44 +0200
Message-ID: <874jpud0wf.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> Since vgaarb has been promoted to be a core piece of the pci subsystem
> we don't have to open code random guesses anymore, we actually know
> this in a platform agnostic way, and there's no need for an x86
> specific hack. See also 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to
> drivers/pci")
>
> This should not result in any functional change, and the non-x86
> multi-gpu pci systems are probably rare enough to not matter (I don't
> know of any tbh). But it's a nice cleanup, so let's do it.
>
> There's been a few questions on previous iterations on dri-devel and
> irc:
>
> - fb_is_primary_device() seems to be yet another implementation of
>   this theme, and at least on x86 it checks for both
>   vga_default_device OR rom shadowing. There shouldn't ever be a case
>   where rom shadowing gives any additional hints about the boot vga
>   device, but if there is then the default vga selection in vgaarb
>   should probably be fixed. And not special-case checks replicated all
>   over.
>

Agreed and if there are regressions reported then could be added there.

> - Thomas also brought up that on most !x86 systems
>   fb_is_primary_device() returns 0, except on sparc/parisc. But these
>   2 special cases are about platform specific devices and not pci, so
>   shouldn't have any interactions.
>
> - Furthermore fb_is_primary_device() is a bit a red herring since it's
>   only used to select the right fbdev driver for fbcon, and not for
>   the fw handover dance which the aperture helpers handle. At least
>   for x86 we might want to look into unifying them, but that's a
>   separate thing.
>
> v2: Extend commit message trying to summarize various discussions.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/video/aperture.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
> index b009468ffdff..8835d3bc39bf 100644
> --- a/drivers/video/aperture.c
> +++ b/drivers/video/aperture.c
> @@ -324,13 +324,11 @@ EXPORT_SYMBOL(aperture_remove_conflicting_devices);
>   */
>  int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name)
>  {
> -	bool primary = false;
> +	bool primary;
>  	resource_size_t base, size;
>  	int bar, ret;
>  
> -#ifdef CONFIG_X86
> -	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
> -#endif
> +	primary = pdev == vga_default_device();
>

Maybe enclose the check in parenthesis to make it easier to read ?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

