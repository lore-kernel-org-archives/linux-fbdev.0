Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C51FCCA483
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 14:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiFHOkI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241547AbiFHOkH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Jun 2022 10:40:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9E857B1A
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Jun 2022 07:40:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so3454655wmq.0
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jun 2022 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9EhidKpUM6if67sguCO5Og92a54Vj8KeIpSWVWhTgdQ=;
        b=SK47hwDm6FJP9FIEMaK3YXzJI6JodkcDhToAkvbJwJmqM5pD/7GP5YZrsdT68gYGis
         VdYLDTWh8NCL0udFANKYNpxzJD84W5sQo+ORJNNcRySyXgCcfcUYscuN6+uCpMbwYbJJ
         B8gbMjnXNgRbs6FWZikwqLhGasX7LLk1juNoDTKGD0xnKH0ima61XC3rMkoesOAwsCjS
         xqT0y6C/04VTou0Mxyv3PEEvvWDvUinef7zEQv+K/OVZHLyRMM18Q2ivUrsl7hjB1zc3
         YYUx0wkhazy+r6XfkyGyMJOZKXaHaIEqZvbrYLovgrO7EySIb/E4LGUm5gqmib35e1nE
         Ig8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EhidKpUM6if67sguCO5Og92a54Vj8KeIpSWVWhTgdQ=;
        b=tIjbkVFpucsH4A0swpsb9cvtOAY6+vyEbJtBXdk2ewHrSbWnDFxEn38IcOGSGhFGpL
         eaFx2wvPWYUzHqB3bmPet2BFpePGDL4lWdoe4jJq3LTFyQJuBApHx8TNUSnmMgz0zFAw
         SzQCIh8K53zVZvdxf4KqsJEyndDgtxDBxre2JdDJCz9dzxlgnaivdsY3oO4JQNGn4eYm
         rYnqL2bUQ07ScMWHt9mmtKik1PUc1RV6uHptyswG34fL7yxdvuv+Gg2toV4aX1ANIpO+
         3XxO4UoAIhBlv3qlXi/X1QX3TYOW6mQCslUxSZi0lO37xNcdm3UqFzirtgVZrTpbPuy/
         pV7Q==
X-Gm-Message-State: AOAM532FYbDqtx48cO0l5pTQ+0JwbOH5JjAwpX1Y1EkFZnqxtrbjHwio
        CL62liWp+Icv7M6lJy6f4HzBsw==
X-Google-Smtp-Source: ABdhPJwOho3vz1015JaPZPGvivUvkPzuD09czLzgw8tNib5JsVZWBogUj940HIu9+Qtyn0NNFZ80Bg==
X-Received: by 2002:a05:600c:154d:b0:394:880f:ae3a with SMTP id f13-20020a05600c154d00b00394880fae3amr63424097wmg.13.1654699203653;
        Wed, 08 Jun 2022 07:40:03 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b0039c5ab7167dsm5802344wmg.48.2022.06.08.07.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:40:02 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:40:01 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] fbdev: Use backlight helpers
Message-ID: <20220608144001.2gf6iaj3kvagowiw@maple.lan>
References: <20220607192335.1137249-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607192335.1137249-1-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jun 07, 2022 at 09:23:28PM +0200, Stephen Kitt wrote:
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h, even in cases where fb_blank isn't involved.
> 
> This will ultimately allow fb_blank to be removed.
> 
> Stephen Kitt (7):
>   fbdev: aty128fb: Use backlight helper
>   fbdev: atyfb: Use backlight helper
>   fbdev: radeon: Use backlight helper
>   fbdev: mx3fb: Use backlight helper
>   fbdev: nvidia: Use backlight helper
>   fbdev: omapfb: panel-dsi-cm: Use backlight helper
>   fbdev: riva: Use backlight helper
> 
>  drivers/video/fbdev/aty/aty128fb.c                       | 6 ++----
>  drivers/video/fbdev/aty/atyfb_base.c                     | 8 +-------
>  drivers/video/fbdev/aty/radeon_backlight.c               | 6 +-----
>  drivers/video/fbdev/mx3fb.c                              | 7 +------
>  drivers/video/fbdev/nvidia/nv_backlight.c                | 8 +-------
>  drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 8 +-------
>  drivers/video/fbdev/riva/fbdev.c                         | 8 +-------
>  7 files changed, 8 insertions(+), 43 deletions(-)

FWIW, from a backlight point-of-view, whole series is
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
