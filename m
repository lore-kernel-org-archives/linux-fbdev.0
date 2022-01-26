Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01483C2BA4C
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 11:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiAZLYT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiAZLYS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 06:24:18 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA186C06161C
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 03:24:17 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so1763487oth.12
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 03:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCtOvzmb9/mx72Ui1G8gLBm5A9F1BJtElWdIDXeMmF0=;
        b=KN8ygqBrm2dd9m4JKpN0ivDz9vFAd4sM+Jo250JWFfS7Fb0jrfDxVtjeWag9YgMJzO
         Ai4COV/8AMUKGvKvgGkScYEDjMJiWVqqXKZyFyEl/tJxqAuJNa3cxzEaswKPlkWjpIGb
         F5u56sCs+46RCDVor9dn7G4nmOEvnFb1fLPmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCtOvzmb9/mx72Ui1G8gLBm5A9F1BJtElWdIDXeMmF0=;
        b=QOpbpGAqFzSZygIp+1NMuaXsh26GPuTm6JkmyvJIJnr9/6gSjf9FmwZkI7rAXAw3/6
         tmrfz1xs7rgp2qbZEbaNO6ooPXvGwIBaHZTOmGj1rLDOKGDm20kzd/e0fGONwMLXn6wz
         feVk1dAbHj5WqBXSTLlXOfmCHJk51Rcu8fVTthJ1/suZbj9Uh5OO0199gjMgKxnPTSI+
         trKyJt65TbGyTX5TF6sDuZqAYzq5/KuyFRT5vXzUYdrtQE6BCTIjTH8+j3XuTu7f1GZw
         vFaRh9cU4c3FikTXRg+s6tR3KwZ4yDYn5JwGrMGURAeDyzxB+VyeBDFuNWMCQJlWSuTX
         fZLA==
X-Gm-Message-State: AOAM531U5IIQ0TNOPmdL6x2Qyn8oXuRb3BKh2F8rnCNxvoN4m8hH3pkb
        g8f4Hy94hY4WTq/8P7PbyQCBZWpxsqEdu9roUzGgyA==
X-Google-Smtp-Source: ABdhPJyJ434k8CTtwA2xfNAfr6EGCCAY/54kbGMlKb50hwBQ2htN+9NdPN5HmH3wpOHEdJ2kuYTIeZNw6vajtaWaJbE=
X-Received: by 2002:a05:6830:2704:: with SMTP id j4mr17448609otu.323.1643196257387;
 Wed, 26 Jan 2022 03:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de> <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de> <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
In-Reply-To: <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 26 Jan 2022 12:24:06 +0100
Message-ID: <CAKMK7uEqwyZuVheqyNG33Un4WK1cd1B+WBYbCmi20fZi0qVG2w@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 26, 2022 at 12:18 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> On 1/26/22 11:59, Helge Deller wrote:
> > On 1/26/22 11:02, Andy Shevchenko wrote:
>
> [snip]
>
> >> P.S. For the record, I will personally NAK any attempts to remove that
> >> driver from the kernel. And this is another point why it's better not
> >> to be under the staging.
> >
> > I agree. Same as for me to NAK the disabling of fbcon's acceleration
> > features or even attempting to remove fbdev altogether (unless all
> > relevant drivers are ported to DRM).
> >
>
> But that will never happen if we keep moving the goal post.
>
> At some point new fbdev drivers should not be added anymore, otherwise
> the number of existing drivers that need conversion will keep growing.

And that point was about 5 years ago, and has been discussed at some
plumbers meanwhile, resulting in the staging TODO patches to make
these drm drivers to destage them.

Fixing bugs in fbdev is all fine, reopening it for merging new drivers is not.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
