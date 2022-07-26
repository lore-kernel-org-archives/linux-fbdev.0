Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85C1C04A68
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jul 2022 14:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiGZOka (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jul 2022 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239346AbiGZOk3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jul 2022 10:40:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9556423
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 07:40:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ED8121FEAA;
        Tue, 26 Jul 2022 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658846426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eTmDdk3BCJXU66FNIOyDwXn3D4Z4E7It/BpD50zR37c=;
        b=slnjENGecyoF9cdEgc3AdMM/bgS3ZaMTCjuJhT/ATqsSIq8r2k+z9jerENWV2+GKZiz019
        IydVJQpgTKEvbsa17clvsvC2q/L4NvNOwqgQQMgtpcrTLiiusoTKu3CofLq1DdztGY4bLt
        dpm80iIgIcQHtQLXGDZzjssGyaBIWPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658846426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eTmDdk3BCJXU66FNIOyDwXn3D4Z4E7It/BpD50zR37c=;
        b=+9jOMyM9GYJd8e7hl0Ul/rnbsYdkLNTVLbIlMof86f5aY6/bt7N77Vxg7HIHi07pzV74et
        uKa9ispc+GfyPZDA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 45C7B2C141;
        Tue, 26 Jul 2022 14:40:25 +0000 (UTC)
Date:   Tue, 26 Jul 2022 16:40:24 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 09/10] drm/ofdrm: Add per-model device function
Message-ID: <20220726144024.GP17705@kitsune.suse.cz>
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-10-tzimmermann@suse.de>
 <7b1a2807-59c7-d524-af8e-1ec634c740a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b1a2807-59c7-d524-af8e-1ec634c740a7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

On Tue, Jul 26, 2022 at 03:38:37PM +0200, Javier Martinez Canillas wrote:
> On 7/20/22 16:27, Thomas Zimmermann wrote:
> > Add a per-model device-function structure in preparation of adding
> > color-management support. Detection of the individual models has been
> > taken from fbdev's offb.
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > ---
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> [...]
> 
> > +static bool is_avivo(__be32 vendor, __be32 device)
> > +{
> > +	/* This will match most R5xx */
> > +	return (vendor == 0x1002) &&
> > +	       ((device >= 0x7100 && device < 0x7800) || (device >= 0x9400));
> > +}
> 
> Maybe add some constant macros to not have these magic numbers ?

This is based on the existing fbdev implementation's magic numbers:

drivers/video/fbdev/offb.c:                 ((*did >= 0x7100 && *did < 0x7800) ||

Of course, it would be great if somebody knowledgeable could clarify
those.

Thanks

Michal
