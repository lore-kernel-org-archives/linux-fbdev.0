Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AB22D4FF;
	Thu, 12 Jun 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720564; cv=none; b=gGhrLVy/zwX8Ns09IA7OaQUC5TwZfFRZFSYaSv3Fo5xybObNdqby5+gF2OZliHh2/j4YUKm4TPf2us2pTtHdx3Gk/CkXQasiG5di7HVJK4T/Bkv+KlcH7U+FWNqqkL67G6PseyH6xCBEZd3yQ97sJ6KoCe/DmSHvBjm2AYOpZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720564; c=relaxed/simple;
	bh=xncBKzmzCQLk7mSsHxy95YNmxWkHWoPa46bnKz9eXBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCxlpyiwbhsFiWwRA3+/EaVxxYYwC1MY0oiX6CpxAEgmB4qzPTeISp0BDhbJs5+2MyLg/9iEvBNFNCc2eBGVF9DRUF5DQ0sQDCuxBuaERbez1DeZdigf7gLAac4yE4yv2bQhIVs2TRyiQwL4rMaQrqLmzEw95pWNB6vp1B8ZWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e7c4ab7ff6so207326137.3;
        Thu, 12 Jun 2025 02:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749720560; x=1750325360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NERsyttcJtkIczzHslePzMNvEb9gRLTeDCgd7sAMOcQ=;
        b=lzBSCyfrx7aT3lle/dCHURUuSOmDa0ZnX6z5LzHI+kM3FqwR0F7jrSUqArmldshIBI
         PWYh03H7Wdkqo/JMkA8jejnSVfQ/zp9d+hq6rcFEqlgDTLj6G7DIBOUwp4WlFZsb/N82
         0bjKp9L3leHkjcrIpcOd21B4AK5ZCHLJNCry+UUHTBpCN7A9Ls841ALeCmUV2YFBv0iV
         7Cir01X0FpEY2T3aWMHUJGcEdz76oLBkjogKsdbVZ+L/iTgUi5cQIu4xrSh+S1uPSz9s
         ilq1BeFIovdvd3fBKmnLzBIY76GRU/ZizBfGo/YKyAQFhHsKCXTyfaVdL3Y2JAXpf1BP
         hrOw==
X-Forwarded-Encrypted: i=1; AJvYcCVmP/sUAKhC7lLBK2lxiJ213tD1XkPk+2fnWIfI6fRp3vAqAwmDw/bbItUHq8yO+RQ2GS/Qs9tjPnC786Js@vger.kernel.org, AJvYcCXqlOAICHwtf4SDV3H6op5kxVp81+ItfxjzCgqaUT1ZI14h9phhzAJmlmldm/e6nd5m2tIDa66h9iUztA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBucCco2bzs/KP1xnqx1nkpgqPZr0X9xrBCnHyo/ezFJg4Glda
	5xCaGoyve07nITl4BPgrik3imiswIPl8p8P6jmkb8axdpgcWDxEo2D8NVlx/mrdS
X-Gm-Gg: ASbGncvgtV7cZtgmY3XQNBDwiUIqknPfJdG11nY1DRciB6zg37N2a1/mlT41u2wq1Z8
	vP74uTxQ681C/ZTlUz3INNx+k/yKk+eMyOyfsD6tWrFwSenPYZ5BaiVfVCjtlP1aSMYzc6TAPGX
	auqvSSvMtQqcWSRUnzN2uj7uhjBhmKilMzl/5lX5ULrWBCzVJ0vvFT1qUwruWqJ/4PatSJxpide
	tj71ZZhN+V7lZcoajkc8d3+lHLqbr70jpDjEqEjMsXsexjzGpBRVq6Aml7i7DUvnpooxflnYFBK
	3irz6/f9mOEUxljsIewAlnzWBWAY/aGoqjvLVGlXCek6lwYN1Rj/W8ixXoaYh1tcADJwAzyy4B2
	hk1Np+XXRzAtloF5EzFHf+fpogeW8RoHV4u4=
X-Google-Smtp-Source: AGHT+IEqW9am1rIU6PjNRZahp0UG17xMzrFqbsH8aRHgct5PBS4FCtXU3ddOWc3LLw5WuzZ3oBzNJQ==
X-Received: by 2002:a05:6102:f08:b0:4e5:ac99:e466 with SMTP id ada2fe7eead31-4e7ce914bbemr1569285137.18.1749720559899;
        Thu, 12 Jun 2025 02:29:19 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87f0135026bsm219816241.20.2025.06.12.02.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 02:29:19 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-87ecba78750so245602241.1;
        Thu, 12 Jun 2025 02:29:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1aITzNTwv5DOg2FYyxstSmO5f7nUx5CftUSntLnb9riYdHjhGK+twoy3+C2NyxbqUjD8O/2TRvV2j9w==@vger.kernel.org, AJvYcCXzb860X3GTk4ogIWwIi8e4tIU1SA2rudlD6deTrpoeyjF4oB7EKSrKyMRoWVtQaRg/LIa1I3yDyAB7xmVg@vger.kernel.org
X-Received: by 2002:a05:6102:3e12:b0:4e7:7787:1cf8 with SMTP id
 ada2fe7eead31-4e7ce8308b4mr1675643137.7.1749720559317; Thu, 12 Jun 2025
 02:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdW5wU1ForGOGD-+HDUu7wcnBx3jx911nLEqbJ71t4MBsg@mail.gmail.com>
 <20250611161207.4031677-1-alexguo1023@gmail.com>
In-Reply-To: <20250611161207.4031677-1-alexguo1023@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Jun 2025 11:29:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=GyUHsfqtSD8iYaV_nRszEunaDMCoL6zWf5_bPS0T4Q@mail.gmail.com>
X-Gm-Features: AX0GCFsIv4ID6KhU6t-X5eNite_AO0HV8CCJC0-uReM8yNgsMZKrhCmvXGEXb8Y
Message-ID: <CAMuHMdW=GyUHsfqtSD8iYaV_nRszEunaDMCoL6zWf5_bPS0T4Q@mail.gmail.com>
Subject: Re: [PATCH] fbdev: pm3fb: Fix potential divide by zero
To: Alex Guo <alexguo1023@gmail.com>
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Wed, 11 Jun 2025 at 18:12, Alex Guo <alexguo1023@gmail.com> wrote:
> > On Sat, 7 Jun 2025 at 22:14, Alex Guo <alexguo1023@gmail.com> wrote:
> > > variable var->pixclock can be set by user. In case it equals to
> > >  zero, divide by zero would occur in pm3fb_check_var. Similar
> > > crashes have happened in other fbdev drivers. There is no check
> > > and modification on var->pixclock along the call chain to
> > > pm3fb_check_var. So we fix this by checking whether 'pixclock'
> > > is zero.
> > >
> > > Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
> > > Error out if 'pixclock' equals zero")
> > >
> > > Signed-off-by: Alex Guo <alexguo1023@gmail.com>
> >
> > Thanks for your patch, which is now commit 59d1fc7b3e1ae9d4
> > ("fbdev: pm3fb: fix potential divide by zero") in fbdev/for-next.
> >
> > > --- a/drivers/video/fbdev/pm3fb.c
> > > +++ b/drivers/video/fbdev/pm3fb.c
> > > @@ -998,6 +998,9 @@ static int pm3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
> > >                 return -EINVAL;
> > >         }
> > >
> > > +       if (!var->pixclock)
> > > +               return -EINVAL;
> >
> > While this fixes the crash, this is correct behavior for an fbdev driver.
> > When a value is invalid, it should be rounded up to a valid value instead,
> > if possible.
>
> Thanks for your confirmation and suggestions.
>
> I added this patch based on existing checks on var->pixclock in other drivers, such as savagefb_check_var, nvidiafb_check_var, etc.
> Are you suggesting that it is better to replace an invalid value (var->pixclock == 0) with a default valid value, instead of returning -EINVAL?

Indeed.

> If so, could you advise what a suitable default value would be for this case?

The answer is hidden in the existing check below:

> > > +
> > >         if (PICOS2KHZ(var->pixclock) > PM3_MAX_PIXCLOCK) {
> > >                 DPRINTK("pixclock too high (%ldKHz)\n",
> > >                         PICOS2KHZ(var->pixclock));
> > >                 return -EINVAL;
> > >         }

It can be replaced by:

    if (var->pixclock <= KHZ2PICOS(PM3_MAX_PIXCLOCK))
            var->pixclock = KHZ2PICOS(PM3_MAX_PIXCLOCK) + 1;

The "+ 1" is needed because of rounding.

> Actually, I have found a few similar issues in other functions as well. I would like to make sure I am addressing them in the correct way.

That would be great. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
