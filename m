Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08317597
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Oct 2025 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760579137; cv=none; b=uunL3D3oetn58JBKCN048dDnn4rG3AO49yUv+XfceGT0Juvlks/FEG6HEqwgirQxfLyT4EDApq8ahK7mEYQNhmNysVcLmzduGGF1yUSwr/t6L1A/FFTMHPdvgAyYp727ppvnlkjCccDuZE6rFdic5L7zQQSIUJEc4I7BhnhcvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760579137; c=relaxed/simple;
	bh=BmO9QvsJixoNrPHTLBb7ox8ODljvqV5zZ13V/ZDyQ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD4pQxvKx07RwQpZX4ifgbBTJKG7ZvmfNlIgvG2pBuxK0nE24NgEZMuZvr2cShaLDie9al+/yaF/w6vdHz2TGiHEw+TajlrTzcoJLsfnNfTBLnBLej5BEDijuLbfhx919myDmbxQkTu3BHa3Wx19ULO0XlGHtBVn1BtBjtX16Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/DCLpCX; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/DCLpCX"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so8426639f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 15 Oct 2025 18:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760579134; x=1761183934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9rwUSd8nuRKW1ZndheoOnbtiXymXGXCv7wri7PtzlnM=;
        b=b/DCLpCXZe5+5Q8BKTkDyuv+dL3M095rdN3cw8MBCV2AmaDe/5/i941c7jApxzrcZ6
         as1t4S03m+nzYlK8RpKVUdgQq4yucmRBf6Odb5HG4eXkvCwrNuhAxzTIjR9jKK/nuW4B
         iRk92yiMPfNjxLWR+X9Z/86kvbHQ7wyq/XOZHP61W3aDBalAuNe8lLHeeOIVh5G+oOD8
         paJLTdOokatQ211VqnYF/rqopoARnZz/h/s+jXOobcRl7dOmKkdhneB6T8kHuWbO78TR
         bCg1WuiQvLtwaiSJ+KWJ1DFuQuk1289I7M0fmyaAa/0lMPL1DS/jYDJ99LCluudirncd
         j2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760579134; x=1761183934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rwUSd8nuRKW1ZndheoOnbtiXymXGXCv7wri7PtzlnM=;
        b=Mo5qCQICeW629QyBllkChtY/4tNhpw3gYN9TDo5nu5JQ84uigZjqlfqSxJY0uCQEJY
         BYrGde9lFf9XXM4TKwTBFW6iBXTzlKJDGk9JKw0lN83TL9fTInTzQ57Ejz+aLs+wfsAt
         hvskYbJIHaUHLv70GK2mXMRoQfFZxe12K8Okr8Y1GHYgqXckmpLnf5qLXw28dskybEHi
         ISPZoJZZReTFp1DvbjdWEkQV7jm4BU0t/9IgYcBYLAykcWBeQAMSdnc/+Y0u9pQju7kR
         mcvl7RbPes+Jqm8BdHf9Xgfma1dMsHGsEzSL+4ovxErWU3hiL7ASrH5aGMz34ZTJ1e02
         T5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxKL/5kVSr9MFR1A44JuL407J/N3eKjMR00sNRQShq7P441muOJXiemYLVY5OZY/E0vKwzN4SXijSIkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6SMopcD1X7wpURYEtqUCNa3GdwAk/59gJXOKrj9/qUim+yB3V
	x72uSVbfjRL4fZUHBz97JLZL9KV5BMdc/vZqw6wbggWyHkr/0U5MMyd6
X-Gm-Gg: ASbGncsZBJ6kJWgvUXuQR/Mp/W1pusQO2hDhNW9ROKePwWsPoOk3pnfAo6c38OSRTVx
	OP7p6wZypZfp/Jbqvbvde0OgUTzIbAQpVN1lPsLUVN8LlDjlJrtsuYtU3Q/T9DAsEaXDh+FvU/C
	wi9HYKKnFA1RTl/DracGPu+/8a18gSDB36jzy03PrI81n1utImpvo809CGg1H+H3ly0HLAM5YEA
	n7gH1HR46fUQGe0AQfjeKTEMsq/qGd6N6vOptsWWEWuogABKHzBSvY3Z3WRSgtUBK98uValubhN
	yvx1n6/8pg1dH53ET8GsaVKGFa5/zYxoDtOSkwiKZiEzD4gDfhW0dOwZ3RNGCwNM41w1my18GRI
	b1/xrDlOMPO/FVK2ZcZYxB+DSgkPSGum+r5UADHzCrezxb+7zFhxX6/DsRNARwtOgTe8dPg==
X-Google-Smtp-Source: AGHT+IFp34gerWyI/eqrZfZ7861Ql4TRlIasFqKa/zgiw4czVi2L9IWSlxhtzXGcGKWZ9dJtvmyXZw==
X-Received: by 2002:a05:6602:1645:b0:93b:da4b:d0a3 with SMTP id ca18e2360f4ac-93bda4bd174mr4031136539f.19.1760579134525;
        Wed, 15 Oct 2025 18:45:34 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::ffb])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-59043f842bfsm5965410173.62.2025.10.15.18.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 18:45:33 -0700 (PDT)
Date: Wed, 15 Oct 2025 21:45:31 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Simona Vetter <simona@ffwll.ch>,
	syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
Message-ID: <aPBOOyrV3ihF_Bpq@arch-box>
References: <20251003073210.48501-1-albinbabuvarghese20@gmail.com>
 <b4af6e84-6555-4629-8291-fc4c2c99390b@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4af6e84-6555-4629-8291-fc4c2c99390b@gmx.de>

On Sat, Oct 04, 2025 at 02:43:33AM +0200, Helge Deller wrote:
> On 10/3/25 09:32, Albin Babu Varghese wrote:
> > Add bounds checking to prevent writes past framebuffer boundaries when
> > rendering text near screen edges. Return early if the Y position is off-screen
> > and clip image height to screen boundary. Break from the rendering loop if the
> > X position is off-screen. When clipping image width to fit the screen, update
> > the character count to match the clipped width to prevent buffer size
> > mismatches.
> > 
> > Without the character count update, bit_putcs_aligned and bit_putcs_unaligned
> > receive mismatched parameters where the buffer is allocated for the clipped
> > width but cnt reflects the original larger count, causing out-of-bounds writes.
> > 
> > Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
> > Suggested-by: Helge Deller <deller@gmx.de>
> > Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
> > Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> > ---
> > Changes in v2:
> > - Partially render when height exceeding screen boundaries instead of skipping
> > - Update character count when width is clipped to prevent buffer mismatch
> > 
> > Link to v1:
> > https://lore.kernel.org/all/20250927075010.119671-1-albinbabuvarghese20@gmail.com/
> > ---
> >   drivers/video/fbdev/core/bitblit.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> 
> applied.
> 
> Thanks!
> Helge
Thank you for merging the patch.

After the patch appeared in mainline, I observed that syzbot continues
to find the same bug through different execution paths. My fix addressed
bit_putcs, but the crashes now occur through bit_cursor and cw_putcs,
which bypass bit_putcs entirely and go directly to sys_imageblit():

Crash 1 (cursor path):
https://syzkaller.appspot.com/text?tag=CrashReport&x=11fe95e2580000
Call trace: hide_cursor → bit_cursor → soft_cursor → sys_imageblit

Crash 2 (rotation path):
https://syzkaller.appspot.com/text?tag=CrashReport&x=164f0b04580000
Call trace: fbcon_modechanged → cw_putcs → sys_imageblit

The original syzbot reproducer depended on character height going out of
bounds, so I focused on bit_putcs where character images are drawn. I
naively overlooked cursor drawing - apologies for that. That's why I
looked at the other crash reports after the merge, because it seemed odd
that it was still hitting the bug after the fix.

I believe adding the same clipping logic in sys_imageblit() would provide
comprehensive protection. Something like this:

void sys_imageblit(struct fb_info *p, const struct fb_image *image)
  {
 +       struct fb_image clipped;
 +       u32 width, height;
 +
         if (!(p->flags & FBINFO_VIRTFB))
                 fb_warn_once(p, "%s: framebuffer is not in virtual address space.\n", __func__);
 
 -       fb_imageblit(p, image);
 +       if (!image || image->dx >= p->var.xres || image->dy >= p->var.yres)
 +               return;
 +
 +       if (image->dx + image->width > p->var.xres || image->dy + image->height > p->var.yres) {
 +               clipped = *image;
 +
 +               height = clipped.height;
 +               if (clipped.dy + height > p->var.yres)
 +                       height = p->var.yres - clipped.dy;
 +
 +               clipped.height = height;
 +
 +               width = clipped.width;
 +               if (clipped.dx + width > p->var.xres)
 +                       width = p->var.xres - clipped.dx;
 +
 +               clipped.width = width;
 +
 +               if (clipped.width == 0 || clipped.height == 0)
 +                       return;
 +
 +               fb_imageblit(p, &clipped);
 +       } else {
 +               fb_imageblit(p, image);
 +       }
  }
 
I don't have any way to test this other than testing it with the existing
reproducers. I can prepare a patch if this approach sounds reasonable.

Thanks,
Albin
