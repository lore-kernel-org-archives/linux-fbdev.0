Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8764BC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Mar 2022 14:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350697AbiCXO44 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbiCXO44 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Mar 2022 10:56:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73797A987
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Mar 2022 07:55:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso2727894wmr.1
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Mar 2022 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ugHrK80HET8DZ+f74WXVZ6NolmaYIO5eOQX+LhNJahg=;
        b=AJCj/zXjgICiAM6Sf8VVdd5x8Xm4KQgPnUhD7Eq/Kg/cYJh9gjSoxdFjIVApiwnMSn
         XyYmCURT4GW6P6ew6BgF2ylK/+uhwjIlgN6aaZ7Pzdp0bt2lPvKzFb+rX47jhI0XTlwB
         W3SaOfQHkaOHHCIpsqQqG57jkWC1Dl52pB5PGpcR0Sau6xYefwskTmXNuH8CXCX9MK+A
         41nITgNnzJ0xoAkWgatllGKlTgUZI9H6nd5dI5jxvSQfj56scXisDkBUeiwuxHXvhwrW
         MaNE0KrJEMS2P/09t2E/ng0jgLuV/TraAlOF2HIu96aGvw228Aylx+sMHjnXJ/lfOYHK
         mLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ugHrK80HET8DZ+f74WXVZ6NolmaYIO5eOQX+LhNJahg=;
        b=LR2nQ2sWCPeRLsdxip5InK0lAo8P+EsbNAD4HKIp7UEdSr4NLTZWefVsAohIRkz8U0
         lTo8T6n/nfvxM8Wmt/NmdYoVY8bdQ4RE+1wkzJZGfGlq0gxjPKJZ2F9rRIIA4TQRK7RW
         feCq5mdojOE3ujiAetoFmVIWZn24oz2iYyQIkT99+gTisKGkbc9YRTSFpj3NnUUEF0eT
         Lk7+UIboEz9hGdcThcAQEk5HtvPP0FxQ0xnqeUU7Ojv8D6ajaMp8Bxmlnsxdf+9RF+p7
         j3Uizl6dKiiXGhA0EEWZ2gDEEfZycspxwGJDGkb3abXI1bhLjAnTlEsFeMB4ECjOcz5D
         Huww==
X-Gm-Message-State: AOAM533rSLRicUctDtwYS4EKZLM88c/meq9/4R4CbcpNh6oNoCddPZxK
        5dvvy7mo/H8CT19HS6r038KBdQ==
X-Google-Smtp-Source: ABdhPJzlGM7+aVhd+ESPeY+mOcfoNjBXue9ITUmk62M2qek0XavekfwVYbwwMPo/YwS+kAvuUXPAqA==
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id s1-20020a7bc381000000b0037be01fc1c0mr15024216wmj.98.1648133722411;
        Thu, 24 Mar 2022 07:55:22 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f7-20020a1cc907000000b0038c756fe683sm6202357wmb.43.2022.03.24.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:55:21 -0700 (PDT)
Date:   Thu, 24 Mar 2022 14:55:19 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] backlight: replace usage of found with dedicated list
 iterator variable
Message-ID: <20220324145519.lcalgtmw3ih4y4li@maple.lan>
References: <20220324070608.57057-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324070608.57057-1-jakobkoschel@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Mar 24, 2022 at 08:06:08AM +0100, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
