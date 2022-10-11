Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3088C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 11 Oct 2022 21:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJKViv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJKViq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 11 Oct 2022 17:38:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6211B9DDAB
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Oct 2022 14:38:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AF61F1FCF3;
        Tue, 11 Oct 2022 21:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665524323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HT6Li+iF0Huei/eJnoHamNCOr9aOW9HkL2tj0lBESgY=;
        b=wC/hF1Ny/hJY1jVHKsfExaX1+zfDSb84W4lZvBkL+iDBhyznquBZjNxSyD9cZMmCysJGlG
        eLJjFboUoFgxjA53maP3cgAQ9cgMM7URWuOtal12f5VFZwGgu34cVl07FXWdLCdgGsFrpf
        56vveVxG5mDY9Q/vF3X46n70Jj1HjtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665524323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HT6Li+iF0Huei/eJnoHamNCOr9aOW9HkL2tj0lBESgY=;
        b=TuFbMswDOmZrTi3o8o5XH75BlGDCDWOHBFECy7skP9CenomkVYx40wAF/SE46A1oZgE16J
        oRs90C7DUPM6StAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 979B32C141;
        Tue, 11 Oct 2022 21:38:42 +0000 (UTC)
Date:   Tue, 11 Oct 2022 23:38:41 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        maxime@cerno.tech, sam@ravnborg.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        mark.cave-ayland@ilande.co.uk, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 5/5] drm/ofdrm: Support big-endian scanout buffers
Message-ID: <20221011213841.GA28810@kitsune.suse.cz>
References: <20220928105010.18880-1-tzimmermann@suse.de>
 <20220928105010.18880-6-tzimmermann@suse.de>
 <23333ff7-3ae1-494f-7abe-62da6698fd00@redhat.com>
 <83071743-a7f2-f761-baa3-da688f26b5e3@suse.de>
 <9162f41f-28c3-493c-ab54-b1c4a2fdf494@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9162f41f-28c3-493c-ab54-b1c4a2fdf494@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 11, 2022 at 10:06:59PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 11, 2022, at 1:30 PM, Thomas Zimmermann wrote:
> > Am 11.10.22 um 09:46 schrieb Javier Martinez Canillas:
> >>> +static bool display_get_big_endian_of(struct drm_device *dev, struct device_node *of_node)
> >>> +{
> >>> +	bool big_endian;
> >>> +
> >>> +#ifdef __BIG_ENDIAN
> >>> +	big_endian = true;
> >>> +	if (of_get_property(of_node, "little-endian", NULL))
> >>> +		big_endian = false;
> >>> +#else
> >>> +	big_endian = false;
> >>> +	if (of_get_property(of_node, "big-endian", NULL))
> >>> +		big_endian = true;
> >>> +#endif
> >>> +
> >>> +	return big_endian;
> >>> +}
> >>> +
> >> 
> >> Ah, I see. The heuristic then is whether the build is BE or LE or if the Device
> >> Tree has an explicit node defining the endianess. The patch looks good to me:
> >
> > Yes. I took this test from offb.
> 
> Has the driver been tested with little-endian kernels though? While
> ppc32 kernels are always BE, you can build kernels as either big-endian
> or little-endian for most (modern) powerpc64 and arm/arm64 hardware,
> and I don't see why that should change the defaults of the driver
> when describing the same framebuffer hardware.

The original code was added with
commit 7f29b87a7779 ("powerpc: offb: add support for foreign endianness")

The hardware is either big-endian or runtime-switchable-endian. It makes
sense to assume big-endian when runnig big-endian and the DT does not
specify endian which is likely on a historical system.

It also makes sense to assume that on system with
runtime-switchable-endian the DT specifies the framebuffer endian.

If systems that only do little-endian exist or emerge later then it also
makes sense to assume that the framebuffer matches the host if not
specified.

I don't really see a problem here.

BTW is this used on arm and on what platform?

I do not see any bindings in dts.

Thanks

Michal
