Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D8C25B06
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Aug 2022 00:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiHEAaQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 4 Aug 2022 20:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiHEAaP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 4 Aug 2022 20:30:15 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 946EB26E6
        for <linux-fbdev@vger.kernel.org>; Thu,  4 Aug 2022 17:30:14 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2750JNpl009247;
        Thu, 4 Aug 2022 19:19:24 -0500
Message-ID: <4715518d0a6ec60349c76414815ae3f6e4ed977e.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 10/10] drm/ofdrm: Support color management
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        maxime@cerno.tech, sam@ravnborg.org, msuchanek@suse.de,
        mpe@ellerman.id.au, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 05 Aug 2022 10:19:22 +1000
In-Reply-To: <20220720142732.32041-11-tzimmermann@suse.de>
References: <20220720142732.32041-1-tzimmermann@suse.de>
         <20220720142732.32041-11-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 2022-07-20 at 16:27 +0200, Thomas Zimmermann wrote:
> +#if !defined(CONFIG_PPC)
> +static inline void out_8(void __iomem *addr, int val)
> +{ }
> +static inline void out_le32(void __iomem *addr, int val)
> +{ }
> +static inline unsigned int in_le32(const void __iomem *addr)
> +{
> +       return 0;
> +}
> +#endif

These guys could just be replaced with readb/writel/readl respectively
(beware of the argument swap).

Cheers,
Ben.

