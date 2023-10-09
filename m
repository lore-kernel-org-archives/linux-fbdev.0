Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F3BE95A97
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Oct 2023 09:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjJIJ32 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Oct 2023 05:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbjJIJ31 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Oct 2023 05:29:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C997
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Oct 2023 02:29:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3247d69ed2cso4142662f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Oct 2023 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696843764; x=1697448564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8m4m0ieEJ2SA5cCHHqMfizD1ZJJDz/TnRHcokgUvn4=;
        b=XI0PPwQ06rDSlCLpr68nDNoKTMKv98UsyZR0SJc5Uxvs91vts0ykziX76nILvSEMGq
         Od3PB+10EvCoLvW+vH4fCK8KEoitd5VlnZoN0GZj9Lf3372M0X3nY1+BQ5HEOp+kQXCb
         vatxSuhws1ELs9EoaL+Jn4ZIGsX6XFpbHM9U2UvtghswsDBZf4xXFMLzyr3NLFgGrdhA
         4UoNjEVgCUBHpN0hJffMPYGWGjtEoGuiWb880Z5MSsTLqLYNYM7zXqvGnWPaUzveeljv
         7i/rcMPEb0Cv/R7QVE7VsFICRSBkg2HH9Keon06p/rjncWtZkvz4X4TZDZZRGsLoJS6q
         jXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696843764; x=1697448564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8m4m0ieEJ2SA5cCHHqMfizD1ZJJDz/TnRHcokgUvn4=;
        b=unkWO+k1f5zgPHl2/0CAgLmIPXyGVMoXfbgXq33LOpbbSdyfjwWTBV3+/i9ldPEGmL
         elRHejRKuBqIfT8oHZJ8JO3R8VrPhjI/Z2WZAQzcboQL9Iex4K7jhB22bVBvAvCMSEzv
         VU/Qe6TW1bJ1klSyYNV2z6MFBKu+3jzoTjvp9lYrw0sPuU42ljx0AZVFfXWnRJtj6iMJ
         KdwzVcq8muujqyKww6mlVrTdnGULrLv2ennmhsjM2KNq/90fonzb6JkeDJsxIwtGjW3X
         Y2vNsR8Ob41zskrKIeX55ZHmpq7jnRc1VuG/yecl3lIXoiOgLY3oU5aflS46gjH6rUH/
         7umQ==
X-Gm-Message-State: AOJu0Yy4lsOR6rySXZvYHrAtRlIHhPM1jkNDy9jPqFFycBE6Ac857e/K
        u3QU7HlWBzeGAoQ4+Y2RJgby2Q==
X-Google-Smtp-Source: AGHT+IEXeYstdXT6TbrSO2yEei8azH2660L8AX7ojU3STjxM7Q8gohifEoelTb8KAy2MvYiMxGH00g==
X-Received: by 2002:a05:6000:38b:b0:329:6bd7:470c with SMTP id u11-20020a056000038b00b003296bd7470cmr9256860wrf.58.1696843764410;
        Mon, 09 Oct 2023 02:29:24 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id r18-20020adfe692000000b0031912c0ffebsm9059425wrm.23.2023.10.09.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 02:29:24 -0700 (PDT)
Date:   Mon, 9 Oct 2023 10:29:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Helge Deller <deller@gmx.de>, Karel Balej <balejk@matfyz.cz>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] dt-bindings: backlight: add Kinetic KTD2801 binding
Message-ID: <20231009092922.GA223751@aspen.lan>
References: <20231005-ktd2801-v1-0-43cd85b0629a@skole.hr>
 <20231005-ktd2801-v1-1-43cd85b0629a@skole.hr>
 <20231006123014.GA96854@aspen.lan>
 <5984411.lOV4Wx5bFT@radijator>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5984411.lOV4Wx5bFT@radijator>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Oct 06, 2023 at 03:08:42PM +0200, Duje Mihanović wrote:
> On Friday, October 6, 2023 2:30:14 PM CEST Daniel Thompson wrote:
> > On Thu, Oct 05, 2023 at 08:49:08PM +0200, Duje Mihanović wrote:
> > > +  enable-gpios:
> > > +    maxItems: 1
> >
> > Why "enable"? This is the line we are going to us to bitbang the
> > ExpressWire protocol. Doesn't that make it a control or data pin?
>
> I named it "enable" because the KTD253 driver does so too, but also because
> that pin is also used to power down the IC. If "enable" isn't right
> regardless, is just "gpios" fine for this?

KTD2692 implements ExpressWire and calls this signal ctrl-gpios. I'd
suggest copying that prior art for now.


Daniel.
