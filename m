Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D830E75443
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 Oct 2023 10:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjJCKVq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 Oct 2023 06:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjJCKVp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 Oct 2023 06:21:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609BEC6
        for <linux-fbdev@vger.kernel.org>; Tue,  3 Oct 2023 03:21:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-533df112914so1172091a12.0
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Oct 2023 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696328500; x=1696933300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jFoBRsAsX+9pzgvJlYVzP8D3RlTxpihzcYJJnubu1s=;
        b=pnC5wW+mvNOuLidS0IZ9BvGujwUiy4v9SEIjnMb8JfsHeDmD65tUg1t2GtDAnXZqBg
         +RKQsA9kLRA9MLRN5OaECQJNFVFE80zX5Wd+MM5F8O7auJ8pFD61ImNIik4f2qu3N7h3
         F8hHTce9kNM5ENXlf6hhOUXrLcsS2RxdRiihUsC5/U9PRSrX+vN4l32OzZOGmwCsJagk
         U/c7/KgilALgzyio2WkyFrI7SbO/YgQuKZFmnPsKGsqsJhzR1+h40E3JojHqRmTYyPep
         +OUhH7ZI4zqO7VlSCxLeDVuhE/kFz3HV384fccdEwc3LQsygUO9h8KFYJQHXDEWrbDbM
         bX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696328500; x=1696933300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jFoBRsAsX+9pzgvJlYVzP8D3RlTxpihzcYJJnubu1s=;
        b=po2GPrhH8REq7His0flQB33dijUwaJfX/rzmkLmWlH+HEDN3CugNFtdKFSrm3ADlc0
         UV7Uy/3xLVEIbZ4f5OSYdE8eshYkq5fe7Mi7AnIH4WYAYvfACFAdP+jUWjxVl1FLf28x
         dfvDKssDVpOJu+RVoXtlQ7/tvDzoBwfSg31m3bjGxh6ZsGL0dgLu/Ygui4A5Ib/+IUMu
         S5snMlb2t7Wz5PlcGBHVixKEB2J+4aicLCqYTyQM/FFEFykC7eXgKvndCGljq7wtdByR
         6FzCrCrI/W/WaYRldjKTFam5Uf+egyX8s7P3NzkfyY3d/MEl7d3sb253OEf+QKlbap9/
         uYfw==
X-Gm-Message-State: AOJu0YzTBJ3UqFQNKNNwlXwlllVI2IZZRp1WbQ1mHS5pKsXOgMpVYlWg
        TUJ6bTiA0PTUA0Y8kryzVFEZMw==
X-Google-Smtp-Source: AGHT+IHTcqJckHVsJbxnb9Sl3c/bR2cdIpee7R+c6MfswLdRVMjNSrqe763xeTUxfrRHOZM0HyjPqA==
X-Received: by 2002:a17:906:292a:b0:9a5:c9a8:1816 with SMTP id v10-20020a170906292a00b009a5c9a81816mr3541714ejd.58.1696328500554;
        Tue, 03 Oct 2023 03:21:40 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bv2-20020a170906b1c200b0098e78ff1a87sm802599ejb.120.2023.10.03.03.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:21:40 -0700 (PDT)
Date:   Tue, 3 Oct 2023 11:21:38 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: Add MPS MP3309C
Message-ID: <20231003102138.GB69443@aspen.lan>
References: <20230925122609.78849-1-f.suligoi@asem.it>
 <20230926130113.GB4356@aspen.lan>
 <DU2PR01MB8034F448F6E66BAC3823CDB1F9C4A@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR01MB8034F448F6E66BAC3823CDB1F9C4A@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 03, 2023 at 09:43:15AM +0000, Flavio Suligoi wrote:
> Hi Daniel,
>
> ...
>
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - max-brightness
> >
> > Why is this mandatory?
> >
> > There's no point in setting max-brightness when running in I2C mode (max-
> > brightness should default to 31 in that case).
> >
> >
> > > +  - default-brightness
> >
> > Again. I'm not clear why this needs to be mandatory.
> >
> >
>
> Ok, you are right, I'll remove max-brightness and default-brightness
> from required properties list. I think to change these properties,
> for the pwm dimming, into a clearer:
>
> - brightness-levels (uint32)
> - default-brightness-levels (uint32).
>
> For example:
>
>   brightness-levels:
>     description:
>       Number of brightness levels. The actual brightness
>       level (PWM duty cycle) will be interpolated from 0 to this value.
>       0 means a  0% duty cycle (darkest/off), while the brightness-levels represents
>       a 100% duty cycle (brightest).
>     $ref: /schemas/types.yaml#/definitions/uint32
>
>   default-brightness-level:
>     description:
>       The default brightness level (from 0 to brightness-levels)
>     $ref: /schemas/types.yaml#/definitions/uint32
>
> Example:
> brightness-levels = <10>;
> default-brightness-level = <6>;
>
> What do you think about this solution?

If you want to introduce a brightness-levels property then I would
expect it to be defined with the same meaning as pwm-backlight (it's not
relevant to the bindings but ideally it would be implemented by
refactoring and reusing the code from pwm_bl.c).

Same with default-brightness-level although I'm not sure why one
wouldn't just use default-brightness for new bindings (doesn't
default-brightness-level simply do exactly the same thing as
default-brightness).


Daniel.
