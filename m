Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7374C83F2F
	for <linux-fbdev@archiver.kernel.org>; Thu, 31 Aug 2023 19:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbjHaTEF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 31 Aug 2023 15:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbjHaTEE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 31 Aug 2023 15:04:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D90E67
        for <linux-fbdev@vger.kernel.org>; Thu, 31 Aug 2023 12:04:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a4b62c2f5so1514504a12.1
        for <linux-fbdev@vger.kernel.org>; Thu, 31 Aug 2023 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693508640; x=1694113440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MxGEoM6NvMI83xhY8G/ImCWZyFVY8xF2ffN+doaTRi0=;
        b=KhgLzpCYjpxbyaSXMPtJJDXy56CWpI0HSMYo01C/wsL2jw4Avp+/shatNnyP4VpgZv
         +ksX9D3wMbi8/zubUzc4GgSdgOD5o5CZoWYcaMiyYd4aaz9INhizWFrRzdE8XzMPxJTV
         Ki9RrwQWkG9xC6r7DAXHb3uvljeflKXT1kUY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693508640; x=1694113440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxGEoM6NvMI83xhY8G/ImCWZyFVY8xF2ffN+doaTRi0=;
        b=OY+Z2K4P7BOisioCjjDkrfJE1q4IPy6LVdH01NCo49xl4crBiK8chmMO+zpFtdOH9o
         KWegOwh0W6zgJC6JE1As9KzA/P55WsFYyjjjPdhJd7s9Mre/G6S9cjEqtAVYSqsZ6qZd
         dovV6E90hVzBAUv/ueswYIagkKjKhylAH8Wud3joR7zD8bYahrPABFQS1uAG3uw5Y8Gf
         L8al6AZbOBd4oemO5nTe3q4uV9u+FkjM3l3Vk6GKS4cvvL3qXih84nKjt2pwXwy3PTtb
         ESFewYdziirQ3y1jhrKbtewAKBoXBYhmXozLg75ZMTopk+Go/3YewFl7QHBk7wJNxYdK
         0+gg==
X-Gm-Message-State: AOJu0YweXpg7VTiK0ijFVB4uzXvrlfWoeIoPzjcyBT+RlHpLyGAhNjUP
        jzxCRwpT4rV+M7r3a1zNv/F8l8EgdYU+iEKKIS7lgJh2
X-Google-Smtp-Source: AGHT+IEe59UJ7Op6uT8rJdht262zDwCMbrTeD0eF/X3QZT2ZfBDGzaLjYakLfDkaWCtLs3T9Fz8MJg==
X-Received: by 2002:aa7:c389:0:b0:525:d95b:cd46 with SMTP id k9-20020aa7c389000000b00525d95bcd46mr368021edq.2.1693508639852;
        Thu, 31 Aug 2023 12:03:59 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id l6-20020aa7c306000000b00528dc95ad4bsm1090310edq.95.2023.08.31.12.03.58
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 12:03:58 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1013478f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 31 Aug 2023 12:03:58 -0700 (PDT)
X-Received: by 2002:a5d:5242:0:b0:315:8a13:ef17 with SMTP id
 k2-20020a5d5242000000b003158a13ef17mr269497wrc.65.1693508638437; Thu, 31 Aug
 2023 12:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <ZPDgdGBbxrTl+m2s@debian>
In-Reply-To: <ZPDgdGBbxrTl+m2s@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Aug 2023 12:03:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4vpuourbbUPn19yFx2cNj93O6t0PhiARLLL6z22yV4Q@mail.gmail.com>
Message-ID: <CAHk-=wg4vpuourbbUPn19yFx2cNj93O6t0PhiARLLL6z22yV4Q@mail.gmail.com>
Subject: Re: mainline build failure due to 501126083855 ("fbdev/g364fb: Use
 fbdev I/O helpers")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 31 Aug 2023 at 11:48, Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
> The latest mainline kernel branch fails to build mips jazz_defconfig with
> the error:
>
> drivers/video/fbdev/g364fb.c:115:9: error: 'FB_DEFAULT_IOMEM_HELPERS' undeclared here (not in a function); did you mean 'FB_DEFAULT_IOMEM_OPS'?
>   115 |         FB_DEFAULT_IOMEM_HELPERS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
>       |         FB_DEFAULT_IOMEM_OPS
>
>
> git bisect pointed to 501126083855 ("fbdev/g364fb: Use fbdev I/O helpers").
>
> Reverting the commit has fixed the build failure.
>
> I will be happy to test any patch or provide any extra log if needed.

Would you mind testing the exact thing that the compiler suggested?

So instead of the revert, just replace FB_DEFAULT_IOMEM_HELPERS with
FB_DEFAULT_IOMEM_OPS.

I think it's just a typo / confusion with the config variable (which
is called FB_IOMEM_HELPERS).

               Linus
