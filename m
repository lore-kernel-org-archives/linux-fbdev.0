Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C2DC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 14:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbiFHO6U (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbiFHO5w (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Jun 2022 10:57:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18D3EEE0E
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Jun 2022 07:54:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so1966534wms.5
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jun 2022 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/UVSlpPd3rsOTMDlQ1ZyeboYDpPQXRxEscJnVQE7aXc=;
        b=NOVyZ0ybVuagM0hyY5lUQmNY5Z6tlfSssVLuHrioj4pFXSStCE299BtFou21UZk/8m
         VepKg6OpRednAFUOH+DrFvmLI9yOlC/IAMdYiSfQ6UOc7UJzfTqtO3wrZhRQ6Y3PkLuY
         gqjs0vLD5jjUsL/mscM1fXT35tsnMSwcomlX6a9/g3w8TXZ3R497MNNJCeBYOYZ22HGL
         9l/NPiOWTrux+f9ruw4K5CJf1Cr/GWmk6hkYBSp06qahIqkm03PO9JisT+Q0fZgMrbut
         ZpW2yIjJYDnnTb1+8qLVNW55t1H1tePx44wBwq4uu593J2cdba146uVXx2JRI0sZqR7f
         x2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/UVSlpPd3rsOTMDlQ1ZyeboYDpPQXRxEscJnVQE7aXc=;
        b=O8C9IzUYRoDWRIt4ku8aa3c+457RcQbiB2Ev7q9jHc3yJg4Svowr5elk6ZcY3NXXuu
         enNOLif78yvx7R5ELJwJMpZs6uZgXkTOWu+MyYliNJrlUEHanL5+cIXqhU52yI7/gCQs
         w/yy05X2jR+JCDqRfO+41Q6Y4lENu6X3OmXqvHOmJgR404+k4gcKK7CYquJxltgEtnoO
         0fgsEBVSY1Fb8U9Gtep9Sd70xRm5aiw9KhS/J9XYP/Jd7K4HfGGF0+c2JlzX5CwcDKwR
         JaRaY/Qght8eKwINDv7alt9qS9Th0zI6XIBvsFS3MWm7Pwt9uIsPverXfYDJi9jx7qtN
         6mRw==
X-Gm-Message-State: AOAM531wJw0Rf4SvR12Z03Be/I1Qvky6Ci0Jlzs/insXvcFnRexOHe+q
        3XKwQU2z8Z27/ZPACDYwJmDYv0RyTb3CndRB
X-Google-Smtp-Source: ABdhPJyEA+RemPKIQuk742PCiLnKJ52To3H1lPVlBXw0lq0Iq7rdYqBME7INiy/5snTFyMG/KiRGTQ==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id l20-20020a7bc354000000b0039c675321f8mr707309wmj.113.1654700044185;
        Wed, 08 Jun 2022 07:54:04 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c4f5300b003942a244f2esm30757054wmq.7.2022.06.08.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:54:03 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:54:01 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Len Baker <len.baker@gmx.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: ftbft: Use backlight helper
Message-ID: <20220608145401.qaycvdfc7ks3bbx3@maple.lan>
References: <20220607185516.1129900-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607185516.1129900-1-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jun 07, 2022 at 08:55:16PM +0200, Stephen Kitt wrote:
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h.
> 
> Instead of manually checking the power state in struct
> backlight_properties, use backlight_is_blank().
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Len Baker <len.baker@gmx.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-staging@lists.linux.dev

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
