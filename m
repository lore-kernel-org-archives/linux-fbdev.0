Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DC6C4332F
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 16:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354736AbiEDRBq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354758AbiEDQ7F (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 12:59:05 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B22AC44
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 09:50:57 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s131so1763591oie.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvTXB6edqfwGb9f3bN3lxER+CZs3NZn7TH176hxBXpU=;
        b=GNkCyoM+2e4VqyMeqAc6XDOIxo0acxXYnk0dvAoJMPXyjP7p1m5zCyN90OcqJlXSck
         wZbTJkwymZHdtUYtwYPwYXitIPHJvI3+KKMBThvHXowotIJJqvUyLGlEtBQS6EGDJSqg
         akLvOapKIygSbXMhAxwWN8ElOWAEWKtApcYnD+shBZzZCNEsdWBeXJn4Mg8LPeJYb+Je
         pVC3qPogL7oI3b/LcXQPOW8LzKllbFkQf2j2qaXbnTQilekkCR1aZK1urQn0feg/X55F
         uCxWIRPFnuZqjyO3PENDCApQTQh2vQObTB2LpLb3Ky8bWZyZ3Z1j7XPph+hcBZ+4di6X
         NcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvTXB6edqfwGb9f3bN3lxER+CZs3NZn7TH176hxBXpU=;
        b=V3HD64CM4g+vCWcUQFyk9K/dR6L4wQLLx/t5G4fyszQ0HanfM5H3cbzOjIRWTn2SxK
         nebtjAb2vHXZnE9NYSis0CMmztq33CnuGSkZOZ8FxqVlwYt8Bced3Um8cb3/4lH6XMNI
         8YOGHjKk/LvRAlsbSnqUzHGgQoubYjlSuAm6D12fnjoKH9yeaIYconzreURfIvUR8G/B
         O7jeCCBZLlUshzvcZ60WgUhmm110EmrXX1bmsqgFYlAniNz7k+kXsG4Sr83HNVQ9A5gP
         8PNiDZmlcOnAbhs6dwH/6zA1nTWhjnTkMFbE9CqgYx5uoyEJ2slv9lbrNtzfdD/MbBCy
         SArQ==
X-Gm-Message-State: AOAM5310zR5u5o0zIwX6cT0F47kZYOFY/A5DJ99AvGiugT+ZyyZaVOW/
        HvRaQl4bw3PvJ4DFphkPPfW0K8obyZMg7zbl8vf/QqWz
X-Google-Smtp-Source: ABdhPJx4uwTlYsNe6HOusG/FP32seSoyAomH/gOW9LREI0kBv0/w+BK2TeJNhGUSvDhu8ccCCy8qixJrqoJxH06nAKo=
X-Received: by 2002:a05:6808:178d:b0:326:3fe9:7f03 with SMTP id
 bg13-20020a056808178d00b003263fe97f03mr175940oib.200.1651683056728; Wed, 04
 May 2022 09:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220504134833.1672728-1-alexander.deucher@amd.com> <f48a0482-7be9-29d5-b179-e572dfac11fa@redhat.com>
In-Reply-To: <f48a0482-7be9-29d5-b179-e572dfac11fa@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 4 May 2022 12:50:45 -0400
Message-ID: <CADnq5_Mp7EnBUgXaT=-5ndWMW9svpsDbTypj+DdehOXsEAw_4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: disable runpm if we are the
 primary adapter"
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, May 4, 2022 at 12:46 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Alex,
>
> On 5/4/22 15:48, Alex Deucher wrote:
> > This reverts commit b95dc06af3e683d6b7ddbbae178b2b2a21ee8b2b.
> >
> > This workaround is no longer necessary.  We have a better workaround
> > in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are displays attached (v3)").
> >
>
> I would write this line instead as:
>
> in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are
> displays attached (v3)").

When you do it that way checkpatch and some maintainers complain about
splitting up a commit line across multiple lines.

Alex


>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
>
> The patch looks good to me.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>
> --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>
