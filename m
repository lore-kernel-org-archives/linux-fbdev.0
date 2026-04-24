Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA554763
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777012996; cv=none; b=nkImh3pm7TBimC7Z0dT685h7EpTeKuaUYYdwhxJyubB2/gJBb5lvo2ZatGylwIZBC92994PYwKHX2NDx+N+ODvALHz1YSmr0APpmXuN2xbrvZb/Z1Njxp7FDKCygznwbM6i+W4AjQ4Eh5c5geVHBE/COF8u8ynuC0bsWSFhFQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777012996; c=relaxed/simple;
	bh=2dk0QJyccXUMaQGKKRVANye26evV8lSR82dJNOYqSXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZJp4lk2Qbtosm0q4kNGxPSQPZ2qMzTdMIDFma4zWd+cArt7kGT0YvbWeSxrmVtj8KdfkoXnuwRBOIbr15lJDq+Y0iNi5LpTHz3i2ECtSuar3/MyTzpJFpLGaaA8wT0pxiYP94UT5OUxqhvRvcYLyMy+43VtPRGCPh2YWNBO/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-60591ade110so5134506137.1
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Apr 2026 23:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777012994; x=1777617794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oJXSFX8PKzcLFcm7xTXFNvyUHwCzfrNVzAXd7R67sg=;
        b=USHa4pn4Licgf3N9myYhPX963WoDVJR+ayT2Ln2RDR/AkQQJXRKfiQW1v+A1tERMQQ
         4SrmFlK1mMgSFNvQbjLXwF4ivliwchrzh2zI+iHRBYkLUFSQ1I1DpKGMEVlpE7C11khG
         PmA1dYirj4zDtU9MYUsFpn5G06zlN2xDCoSMU2rUsJnsDBSbEeIZxDyyJlIpLRnq3xxQ
         c4PofX9OO92lD/rJbYDUp8oIXFeHvWwnNJDwFjmdV44geLS0T+ilXfchMizykh21mXu5
         IW6xtSEDELzmq00PymnmT8qgiquXQPW7BEk9Pd2xp3XcZoA3Faw9An2F1+4Z36ueK37z
         nfYw==
X-Gm-Message-State: AOJu0Yx7ulJbHXM3DD+VYUCoMDI5KOYUUyBb4D+kWL//te8GhnW1ogOK
	1nn5XArpR+i2ua4wNi7/gI+a1F95UWGjPOGdq0Yi/HZzllPMde8JNqQQF2K1drJ2rPE=
X-Gm-Gg: AeBDievm1WdJ8ALOy+GOh7MaUidkAQg6RBoWN1bljWJSOpCeKxlORIQ9JqqZttFkTGd
	1j7HrrW9yZktAKlP8RcGvfpbz+LXdLZWWop/dkmEKET3e6MxuRi1JS88GpF/gHEwJR5JIJHeim8
	mhCDd3JgesJzsHfIKHya/cE47ZPFE+QkR4P+AkTk7rLlRc0mTVT6+pLbzsomYW2q6nZwu5/J6/a
	8nZN+MKt/Kma4Y0dTM9miuAutY3wtMTenjPEDXXPRlDqHXEN8bERwK/0i8gVcgMo3+Jiqk9xB3H
	GW8txNEABuQJKr5+BXe2DepKudzA22mRSOdzpSHS3ndcw/7zFQiDjkevARRO8ZIZUH7TMo3p7k7
	yZ30JQ3mfz0xMZL2Ew+Vv6KK9dW+CcZ1y2fnlgfJISpY1REx9V2pm3NaNYCc50uEZoqmPiSV/0q
	I0rRssqqWWEHN+Auni8FdL6gkugGeYMIZWp0D5I8Bul7QEIKeCcYBEZ7PzS8psZM1a1qxOBtg=
X-Received: by 2002:a05:6102:160d:b0:607:a3cb:4573 with SMTP id ada2fe7eead31-616f7d6405dmr15112450137.26.1777012993691;
        Thu, 23 Apr 2026 23:43:13 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-958909c5642sm10672756241.7.2026.04.23.23.43.12
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 23:43:12 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-60fa13bde2dso4744966137.3
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Apr 2026 23:43:12 -0700 (PDT)
X-Received: by 2002:a05:6102:3e26:b0:60c:bca6:8198 with SMTP id
 ada2fe7eead31-616f54a0df1mr16521159137.10.1777012992325; Thu, 23 Apr 2026
 23:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423205531.49971-1-deller@gmx.de>
In-Reply-To: <20260423205531.49971-1-deller@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 08:43:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOk3ejrM5EkOBRjc0rQsSGU7TP+Kgd4=DzYuiF8m8Mzw@mail.gmail.com>
X-Gm-Features: AQROBzD-bUctc5D-Bc0eMK2oVZmhH3jTRhq2Qclb0vv_xr_vyYpPVe9rCYI5UQ0
Message-ID: <CAMuHMdVOk3ejrM5EkOBRjc0rQsSGU7TP+Kgd4=DzYuiF8m8Mzw@mail.gmail.com>
Subject: Re: [PATCH] drm/todo: Drop todo item to request memory regions in all
 fbdev drivers
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"

Hi Helge,

On Thu, 23 Apr 2026 at 23:04, Helge Deller <deller@gmx.de> wrote:
> This item is tagged for beginners, so often people not familiar with
> the fbdev drivers think this is an easy task, start up their AI tools
> and blindly send in the generated code as patches.
>
> The problem:
> - Those patches often introduce bugs, so
> - ideally want the code tested, since ressource misconfigurations

resource

>   often lead to failing drivers
> - The patches are often unnecessary, since in the old machines with the
>   old graphic cards resource conflicts usually don't happen as only one
>   graphic card can be used at a time anyway.
> - and today most relevant drivers have necessary patches already
>   implemented.
>
> So, let's get rid of this todo item and silence the steady stream of
> stupid patches.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

Thanks for your patch!

> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -448,22 +448,6 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
>
>  Level: Intermediate
>
> -Request memory regions in all fbdev drivers
> ---------------------------------------------
> -
> -Old/ancient fbdev drivers do not request their memory properly.
> -Go through these drivers and add code to request the memory regions
> -that the driver uses. This requires adding calls to request_mem_region(),
> -pci_request_region() or similar functions. Use helpers for managed cleanup
> -where possible. Problematic areas include hardware that has exclusive ranges
> -like VGA. VGA16fb does not request the range as it is expected.
> -Drivers are pretty bad at doing this and there used to be conflicts among
> -DRM and fbdev drivers. Still, it's the correct thing to do.
> -
> -Contact: Thomas Zimmermann <tzimmermann@suse.de>
> -
> -Level: Starter

I am not really against keeping this item. But as the related changes
are not pure refactorings, and cause a change in behavior, they _must_
be tested on actual hardware.  I guess making that explicit would be a
bit silly (heck, all changes should be tested).  And bumping the level
to intermediate might send the wrong message, too (starters don't need
to test? Doh...)

Thomas: do we still any hardware for which there exist both DRM and
fbdev drivers, and the resource management is missing in the fbdev
drivers?

> -
>  Remove driver dependencies on FB_DEVICE
>  ---------------------------------------
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
