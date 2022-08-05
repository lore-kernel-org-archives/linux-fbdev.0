Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B1CC25B06
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Aug 2022 00:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiHEAjm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 4 Aug 2022 20:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiHEAjl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 4 Aug 2022 20:39:41 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3240E03C
        for <linux-fbdev@vger.kernel.org>; Thu,  4 Aug 2022 17:39:38 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2750T200009896;
        Thu, 4 Aug 2022 19:29:02 -0500
Message-ID: <e92ea74fefd5110d2c1dbcea454d5ec8d2cadcf8.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 10/10] drm/ofdrm: Support color management
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        maxime@cerno.tech, sam@ravnborg.org, msuchanek@suse.de,
        mpe@ellerman.id.au, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 05 Aug 2022 10:29:01 +1000
In-Reply-To: <05511c35-da46-aefd-3e03-364b7311284c@suse.de>
References: <20220720142732.32041-1-tzimmermann@suse.de>
         <20220720142732.32041-11-tzimmermann@suse.de>
         <abe3fa95-942b-6d2f-7167-83d0cea59444@redhat.com>
         <05511c35-da46-aefd-3e03-364b7311284c@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 2022-07-27 at 10:41 +0200, Thomas Zimmermann wrote:
> 
> > > +static void __iomem *ofdrm_mach64_cmap_ioremap(struct ofdrm_device *odev,
> > > +					       struct device_node *of_node,
> > > +					       u64 fb_base)
> > > +{
> > > +	struct drm_device *dev = &odev->dev;
> > > +	u64 address;
> > > +	void __iomem *cmap_base;
> > > +
> > > +	address = fb_base & 0xff000000ul;
> > > +	address += 0x7ff000;
> > > +
> > 
> > It would be good to know where these addresses are coming from. Maybe some
> > constant macros or a comment ? Same for the other places where addresses
> > and offsets are used.
> 
> I have no idea where these values come from. I took them from offb. And 
> I suspect that some of these CMAP helpers could be further merged if 
> only it was clear where the numbers come from.  But as i don't have the 
> equipment for testing, I took most of this literally as-is from offb.

Ancient black magic :-) Old ATI mach64 chips had the registers sitting
at the end of the framebuffer. You can find an equivalent in
drivers/video/aty/atyfb_base.c:atyfb_setup_generic():

	raddr = addr + 0x7ff000UL;

Cheers,
Ben.

