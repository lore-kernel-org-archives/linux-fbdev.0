Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39F0C5479D
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Jan 2023 10:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjAIKS7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbjAIKRY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Jan 2023 05:17:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C7613DEC
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Jan 2023 02:17:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso3265355wmq.3
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Jan 2023 02:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDNF2nq4b9KxYEgBtOKFU9bGBLHmMD8mjcoecRR8JOo=;
        b=Egiyt8t8NeEPoldU+PsuMHoanqPPDdbLc5AyDm0+6oAWOFis5vdQtE5/FvQHaJJnhQ
         OuIfStlXNBRlfLFjDGfyTKUrPDuKQoyBgyHjErZyYUYct5mgqH9SeVXKMpbRF4KGIXWZ
         WwDyG99fgkUfBCwlWm8+yKbGSfbIbon+k6//kWKlqatplP0564wsAvcqa7e6HMxqG9ZV
         Prs+JDy8t6GKuek1QRak6deutcLpdTM+FsU1QoVwtl/yADesOj1EG7SvsswBTrbfWy/q
         3IUEcRv7PsptoNROWnj7mx9IFyBBRkjrgiLm05N0Kn4C2YhRrzDPTLHS3wuteHcs3se7
         i1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDNF2nq4b9KxYEgBtOKFU9bGBLHmMD8mjcoecRR8JOo=;
        b=rYY6APrngeUlAyP3o0usdB72AGvPf09441Bre4afC6WK5g+j1b5mpg+UezkiB8cF1T
         UlEKXYksTlngJggU5JZpwlet+3niiDLYKrJwkvpvxTcs955zm3o7I0pj9LPS2119eSLo
         +C2ONVpc/u0w/bKNiFBWR+ArSi38WRtCXa84Mvy4mduys20bjpM0qmFQ3vgSS5W0xdiO
         Z6Ds7ElRxa5Zr7QprYqIdgsEl9yz14J0vyBmn7cl7dBEJWDExWmLLxAHlA/fw/V2/7k9
         NmIRg0klDKIIERTrX54VtCgJP+9uaEYRpSNfd/T5ZdPPNycGaeh9EeA9fqR5VBDQhBDv
         xoVA==
X-Gm-Message-State: AFqh2kosM5v6pUIVzz//1OvDy7cWH82KkC9WIVIAVQh6E5u/f1obLPSQ
        9e5w7EtpHX99u8DB4GoO18G8Ew==
X-Google-Smtp-Source: AMrXdXtDVvn4E0/j7oBFUTIF1bLHNjmYSsToEWXF24uuZxYxJl7CkWIxhyClEjlcLBHh4/n9Ls5fBQ==
X-Received: by 2002:a05:600c:4854:b0:3d3:5a4a:90ff with SMTP id j20-20020a05600c485400b003d35a4a90ffmr48166011wmo.23.1673259428083;
        Mon, 09 Jan 2023 02:17:08 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c22d000b003b4a699ce8esm14604643wmg.6.2023.01.09.02.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:17:07 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:17:05 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] backlight: arcxcnn: Use backlight helper
Message-ID: <Y7vpof89LHgqdHvU@aspen.lan>
References: <20230106164856.1453819-3-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106164856.1453819-3-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:53PM +0100, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

For the tools:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


D.
