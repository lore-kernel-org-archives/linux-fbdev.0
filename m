Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B8CC25B06
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Aug 2022 00:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiHEAdQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 4 Aug 2022 20:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiHEAdP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 4 Aug 2022 20:33:15 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F0686D574
        for <linux-fbdev@vger.kernel.org>; Thu,  4 Aug 2022 17:33:14 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2750McTg009481;
        Thu, 4 Aug 2022 19:22:39 -0500
Message-ID: <a9822ef5fba5599ddcee5daa4dbd17d8aaca8390.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 09/10] drm/ofdrm: Add per-model device function
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, mpe@ellerman.id.au, paulus@samba.org,
        geert@linux-m68k.org, mark.cave-ayland@ilande.co.uk,
        linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 05 Aug 2022 10:22:38 +1000
In-Reply-To: <20220726144024.GP17705@kitsune.suse.cz>
References: <20220720142732.32041-1-tzimmermann@suse.de>
         <20220720142732.32041-10-tzimmermann@suse.de>
         <7b1a2807-59c7-d524-af8e-1ec634c740a7@redhat.com>
         <20220726144024.GP17705@kitsune.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 2022-07-26 at 16:40 +0200, Michal Suchánek wrote:
> Hello,
> 
> On Tue, Jul 26, 2022 at 03:38:37PM +0200, Javier Martinez Canillas wrote:
> > On 7/20/22 16:27, Thomas Zimmermann wrote:
> > > Add a per-model device-function structure in preparation of adding
> > > color-management support. Detection of the individual models has been
> > > taken from fbdev's offb.
> > > 
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > ---
> > 
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > 
> > [...]
> > 
> > > +static bool is_avivo(__be32 vendor, __be32 device)
> > > +{
> > > +	/* This will match most R5xx */
> > > +	return (vendor == 0x1002) &&
> > > +	       ((device >= 0x7100 && device < 0x7800) || (device >= 0x9400));
> > > +}
> > 
> > Maybe add some constant macros to not have these magic numbers ?
> 
> This is based on the existing fbdev implementation's magic numbers:
> 
> drivers/video/fbdev/offb.c:                 ((*did >= 0x7100 && *did < 0x7800) ||
> 
> Of course, it would be great if somebody knowledgeable could clarify
> those.

I don't think anybody remembers :-) Vendor 0x1002 is PCI_VENDOR_ID_ATI,
but the rest is basically ranges of PCI IDs for which we don't have
symbolic constants.

Cheers,
Ben.

