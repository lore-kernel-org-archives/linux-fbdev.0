Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E12BC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 13:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368F861058
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 13:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhI0NZ7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhI0NZ6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Sep 2021 09:25:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B27C061575
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Sep 2021 06:24:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u18so51988799wrg.5
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Sep 2021 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OkkBF2SlX+njMQCGOaxP8J7y/Zo+1AhEwVAoMOgNgus=;
        b=X95qVHjaPG6lAZB2Tp+Aiz7+YYAoEJ3daxMAt9XtWYjWkL8qrArnnhwkMs4NV85tOR
         cSgMYAqsjqWZWii73hdROKw3T72lvLKktHTJQ6GMU3Riqvw6VQt+3sKodxLvVfBvj0Gg
         GCUUalNfH4YSvZPedoq0A4WBrKWI/fCjLcKVT9EbA4JxuzD0tiGdEjoOD/lpgZUGHPhQ
         AIoZdiZ89CWK5fd5+GmaVw5VNPgSwLzQBWw9VQUGE21b1p+jXO4335rpcMLhPUG19+U5
         jtGvLStoCNW+gWlViA9rUyBxRnYaX6otQd9QkhI2ASo6BEzdZ4eNd/VhM0+SpRJx3gQS
         PaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkkBF2SlX+njMQCGOaxP8J7y/Zo+1AhEwVAoMOgNgus=;
        b=Ou2Ef8fKGvSAbLmh8KOnxVp1eecCIE6lXt2+uCzHEJcm4RaLSonYjHxfBrLbo8Wgv1
         4Z+WqOmoxvgrEJZ+XsWONBWN1301SlAtVgCFbuyc0YpVlDk82F+YKpyA109Sj/XEjTZC
         1YfWgMraPR51A6qGcZLiCAofnhfmF0hZqSDmeo1xK1HFQjQa7hFe+mkatpPVejes1d3L
         U4c99MCVNKePFrqWEch7/UDLGEhhs/RqecTOOiNc7sdKrOwIu30TrzzAWHEZ0x6KnYJo
         1dczCiwYcNI1wHepsm9gKSidYw9XptFGvaQDWE5sr6hMtfNOuaHHMJXdL05MuMnuSAiL
         1I7w==
X-Gm-Message-State: AOAM5306LlabubTA3jAbjYV+SZYjyCOJbrkFO8qCqTnjf38btXGYmW/a
        jtBJp9zmAsAuaGQ/T+yHtYr8PrN+xIyjv7pT
X-Google-Smtp-Source: ABdhPJwLQrVP4WcPhnxQL3ff/ESGiz5vY/YpE8RavLA8oOM8oKiwVP1Gg3FXEPY+lFhh3FIo3vX20A==
X-Received: by 2002:a5d:510b:: with SMTP id s11mr27352481wrt.79.1632749059438;
        Mon, 27 Sep 2021 06:24:19 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id y7sm1680146wmj.37.2021.09.27.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 06:24:19 -0700 (PDT)
Date:   Mon, 27 Sep 2021 14:24:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: hx8357: Add SPI device ID table
Message-ID: <20210927132417.lixg3ojhnwlleht3@maple.lan>
References: <20210922151014.49719-1-broonie@kernel.org>
 <20210927094200.a7d73sl2k4x5xjch@maple.lan>
 <20210927114727.GB4199@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927114727.GB4199@sirena.org.uk>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Sep 27, 2021 at 12:47:27PM +0100, Mark Brown wrote:
> On Mon, Sep 27, 2021 at 10:42:00AM +0100, Daniel Thompson wrote:
> 
> > Based on this I had expected to find spi_get_device_id() and a ->driver_data
> > somewhere in this patch.
> 
> > Where will this .driver_data be consumed? 
> 
> It will never be consumed unless someone writes a board file - the
> runtime match will still happen based on the DT compatible, this is only
> there for the modalias.

Ok... so I'm not going mad.

In that case what is the point of including unconsumed driver data? Most
DT centric drivers that included this for modalias reasons leave it
NULL.

I reviewed quite a few drivers this morning and I haven't seen a single
one that includes unreachable driver data in this manner. Unless there's
a good reason I'd prefer backlight to follow the prior art!


Daniel.
