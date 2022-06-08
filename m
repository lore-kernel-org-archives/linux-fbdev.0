Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5720C43334
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 14:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbiFHOeT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiFHOeS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Jun 2022 10:34:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC043CA2C6
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Jun 2022 07:34:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q15so20592831wrc.11
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jun 2022 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smuYMl0mhH56tDeHdXWNQOJZvruGPXatNdGHlD7YYTs=;
        b=lh/wsibIUywoWWz5yLN1RVAdkgCCFrBp+/s6WpZdSKwBaZHa3wcoks5skuKZz30cfP
         nSZWTrzWnqLrVP1W2Wk7qG5pXrVup+/0Wwy1s6utotmkgIgACXZfPb+9Y79qoUfX+oJ9
         ExKOMgNgf/jN6HJ6ywgE+i/QHy5irCgS3+L230B7vEM9DAXccGChvXIK5jIi7Z+x71Cc
         b0iNAVnZ9lvEzXnIlIjF1NlS2vyBb2eyTgxDgDrBW9qowNQ0Zwq9SSLVLFmfM2NmFXQo
         UOvufvy+J2IzDSJrbR/BjQxjf1cfYIk5QRwc+J6D2AYq1DnctbL2XqJq/7cEZA+q/GF6
         73QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=smuYMl0mhH56tDeHdXWNQOJZvruGPXatNdGHlD7YYTs=;
        b=nQMD8o00wCRWNwVW0/s5DZHdSA/1nzN41X/CwLwDQjqnNoKAneh3Cw5XztHgIPnfNd
         5h0MfjwJgIwlgvZI9dD14VI9yi1NbkuimvJIzbMBabRahmvyYlAANt0gKt12BqucVhEI
         zkH1mrHfbJPD10able/oQL5dEmZRS9qBn+Q6E4nTtmteSCDYGer1vmuP/tPcFWmgZwEi
         VquwOKzAaTTMe5AhBwbUfiKMvjNlDoS109IzGqJQ9+j8QA+gnhJdOPlachW+ipwr9oi8
         M4yHgX7KO0rtj5xBU5afjlwcJqunA/OP084wqjLULAEMVK+2jXqbEPu+bf9rFOiiS83E
         MCsg==
X-Gm-Message-State: AOAM532WXROvqMR3691ikPZnd3PE/6fshQ0egL6pw+mO55azsFZzxyal
        K5PtpSUuHIJVvJ5bu2CM5Oq9og==
X-Google-Smtp-Source: ABdhPJzA4yH9/T+sa0NpsuRjmT5XXk943o+/qsHi0qHrpaB16l7/vjdk7u5BWNDdUZEneCaB74mdag==
X-Received: by 2002:adf:f390:0:b0:218:4de4:510c with SMTP id m16-20020adff390000000b002184de4510cmr10350628wro.475.1654698855460;
        Wed, 08 Jun 2022 07:34:15 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bp3-20020a5d5a83000000b0020cff559b1dsm21061219wrb.47.2022.06.08.07.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:34:14 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:34:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] backlight: ipaq_micro: Use backlight helper
Message-ID: <20220608143412.rbhk4ne7jwubzz6g@maple.lan>
References: <20220607190925.1134737-1-steve@sk2.org>
 <20220607190925.1134737-4-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190925.1134737-4-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jun 07, 2022 at 09:09:24PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
