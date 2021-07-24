Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A40C4338F
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6538E60E09
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 20:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhGXTlK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 15:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGXTlJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 15:41:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6552CC061575;
        Sat, 24 Jul 2021 13:21:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so8633029pjh.3;
        Sat, 24 Jul 2021 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaGEdpDA93dZP0T/+1LD+f5/OqGOURSdBO4AdBPyvbk=;
        b=AI4mpHFjoc+Y2m9BVS+3RhJtiRCm72bWPg5xeFX3yUwqR9Kdvzh37YFqhkJlkxPQt7
         kgl/LMUCRXv8Cpzf/xkr1Mk29l5n/cBKw8q/Pzzs17W0xS8iRR0G/dA4p2WktS3yTBD5
         vkvSfAvXlt7/VtugQrsqlNR7rSq+e/qVLW61GE+/jOBJCTfHwLRuuX6u0aRQ960n8uab
         2P+UTPnucB2iQqQRZ/IIdNbmc/T7yfMNUddULY9b7pa3CzHYN5sitUrElKRkuglqSVqd
         hD04yQtRjEzvbJneJ2RZwezrBm7zI8/YRhcxZRGfhuKJax+aTmEryBLZPU1NqIUQicG6
         qFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaGEdpDA93dZP0T/+1LD+f5/OqGOURSdBO4AdBPyvbk=;
        b=tqmDHnqlrPSLEE3+SD/cl4JHapR5UWAtJ947e6ieKlaug9ey0RxnStvZI3TneMquM8
         LugvTGv5vxbcV2uS31123v+6U12cvQ59PCNZO3RSfg6zu20Z08Kfam3ftxVWQeLJfi3a
         P82LglJgQKfquyEYHBOjuywr7ysm34JzivkYmoHznHEvl/CHZK8PNy6qjJNgZM54n2s/
         YppEIPNA11QYf6/nRIUgQ2yPEhPoVu/A3F2Dz/rS/TTIqVvstXYFGXlZpTNl6sVQ1xCO
         KMT+i4NImaSzAIkzlhVZrZn1PwrXSFWUaRUoBqb2Ugs1yXA+k6lBZ6Delh02VBQjeCYj
         pfxA==
X-Gm-Message-State: AOAM531zKUHzdDcZ5IG7nMB+pDdKsuDr6tl3Q0kBez5hTXnFszMe2J5P
        ejy+7w0H8QRAOOPBmXO7DG65jwoOiEGu+Ny5Oww=
X-Google-Smtp-Source: ABdhPJxIurtl+fyEVAfteEQTQRQm0hJYAmrkxEIc3ejHJa8Sxk7bXTxc+lF8kHpmsI9dOr0LIZjXQdwtFgfOfFRHTCw=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr11150254pgg.4.1627158100931;
 Sat, 24 Jul 2021 13:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210724151411.9531-1-len.baker@gmx.com> <20210724151411.9531-2-len.baker@gmx.com>
In-Reply-To: <20210724151411.9531-2-len.baker@gmx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 24 Jul 2021 23:21:04 +0300
Message-ID: <CAHp75Vd+ZM_yO6CU_6oJieePMt00Sp6oKEU2+QEyZxLDg5PN8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] staging/fbtft: Remove all strcpy() uses
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jul 24, 2021 at 7:05 PM Len Baker <len.baker@gmx.com> wrote:
>
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy() but in
> this case it is simpler to use the "%*ph" format specifier.

...

> -       char msg[128];

128 / 4 = 32. So, this buffer is enough to debug print only up to 32
bytes. Hence %*ph replacement won't cut output earlier than requested.

...

> +                       for (j = i + 1; par->init_sequence[j] >= 0; j++);

Why is i + 1 initial for the j? You may rather access the 'i + 1 +
j'th element in the array...

...

> +                                     par->init_sequence[i], j - i - 1,

...and get rid of the ' - i -1' part here.


-- 
With Best Regards,
Andy Shevchenko
