Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4716F0F0
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Apr 2024 23:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002586; cv=none; b=Pd3vQA7x34AFRc8dY6ebQG9f9sO+uU+MnJu4R0Bc4CwRCZ7fiWDtbtdD9GUTpQQLKQQkClYsjTbY71D04vjdTryqzTkSXH2Ag7eBSsCnyapSNfOw7Cntlj84OIJuMa+WFmr6lIFK5e2Lrr3MVJMlf3lJTzozs0sVh/OEu9hTA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002586; c=relaxed/simple;
	bh=3TMMHB8yCzPTh/CRK0mHUYStaXtqMrUWVeSzdA+ZFTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtJ0PeZ0xHPx8hG2ov0aA6ykO1odMcwJo8+eayu1+RT5LlsFgSqnjEFZqlhDiT0/rW6KTebIgD0Ct0k2liMsbJd7sRL5ahU/z0xhXuy+YSACL+IBN733uOykgAMSt8OkH2Fdwa3hd6R4W0ryxPqKpgFY41WRzzL9Je7tFBGwtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nWr2005j; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nWr2005j"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso295085a12.3
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Apr 2024 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714002583; x=1714607383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Ln4ozbltMQ1gS/VWFP66dxI6mY0+jL0XYSMnzOQX84=;
        b=nWr2005jax/MnjKdDJwFPeefrTf1MUBf2gYlWic/oYc26vdybgBIaRepxo6mHVA1k/
         XYDNZSvuLHWeZqXARnURRvY+b/7FbMjdjHDZFvsrl1M9VQIGpSqEO/e6AN1gr0S0ErRf
         cAGmK0hE8YidPXWbpicRATA2V7/hlYqzg2Z3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002583; x=1714607383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ln4ozbltMQ1gS/VWFP66dxI6mY0+jL0XYSMnzOQX84=;
        b=myMXtUit/ZNrSIuQHk6q4wA6cuuVT6mI2KkmJ3En+9GzKfR+LDFDm1w5//8T+VHEDx
         dPaRUQwMb+8AbcQ8o25bnYr9o1DIc9agMhoWPdATUzyue7SlwRQKs89G1Om8uoZwXX4o
         DeWDEvJmr5JOpmaSP6bvO7T/kChsiPnNiq00zf0q+L1nSx7+jsUgizAq2zXijQVwkn/S
         xmnEfmyfUGvN/PkvhliNqPwWdI5ENfYI1Q9aVqitNX1zPnSUX/AV/3XaMWhaYNxLx3Xx
         ml5zMsofZu/+QGBARzcgbKDJYkKgIrcOok9zJfLJa4nQbRJSPnRypc1eJhzsSAKah8Nm
         P9uA==
X-Forwarded-Encrypted: i=1; AJvYcCVxxYjSy2url2U0I3P9V1/NJfNQKcVM+lCJT2T+LPJLBnldIUsWmuLy+5UMkV3e7S+y3slGz6a5SgVwDe8c7RpvZ8Z1lGk5Iw9tMSw=
X-Gm-Message-State: AOJu0Yz5iz35hy614IoKr+e4y7um8pJLRMVtrBpPGk/1WNHZRgNEWnOK
	NvaYI1LnHpP4vCfDP/R0UmAy2YNW+y8I76Lju9Lu04fu5ONXgKTDsqojHM4PtBH10YD1r1d+dS4
	=
X-Google-Smtp-Source: AGHT+IFO8Ea4GR9fA+qYZG0KzcyI34jDzQm839FmGziVMLbFiO7Z04WwSyAKCKIv8DYuS0frG1SRdw==
X-Received: by 2002:a05:6a21:4982:b0:1a7:4b40:96db with SMTP id ax2-20020a056a21498200b001a74b4096dbmr4391151pzc.10.1714002583218;
        Wed, 24 Apr 2024 16:49:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001e1071cf0bbsm12498516plg.302.2024.04.24.16.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:49:42 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:49:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Helge Deller <deller@gmx.de>
Cc: Justin Stitt <justinstitt@google.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: au1200fb: replace deprecated strncpy with
 strscpy
Message-ID: <202404241647.E1DE1D9@keescook>
References: <20240318-strncpy-drivers-video-fbdev-au1200fb-c-v1-1-680802a9f10a@google.com>
 <53670007-edbc-4762-9e57-0b3c29220d9e@gmx.de>
 <CAFhGd8ppVq9aGbfFLeL30jQ15KHS=FoLh0c1udXo=Z+pCfXL1g@mail.gmail.com>
 <49ba1e7d-d256-4644-beb9-c84b9feb0052@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49ba1e7d-d256-4644-beb9-c84b9feb0052@gmx.de>

On Wed, Mar 20, 2024 at 11:48:52PM +0100, Helge Deller wrote:
> On 3/20/24 23:35, Justin Stitt wrote:
> > Hi,
> > 
> > On Wed, Mar 20, 2024 at 12:56 AM Helge Deller <deller@gmx.de> wrote:
> > > 
> > > On 3/19/24 00:46, Justin Stitt wrote:
> > > > strncpy() is deprecated for use on NUL-terminated destination strings
> > > > [1] and as such we should prefer more robust and less ambiguous string
> > > > interfaces.
> > > > 
> > > > Let's use the new 2-argument strscpy() which guarantees NUL-termination
> > > > on the destination buffer while also simplifying the syntax. Note that
> > > > strscpy() will not NUL-pad the destination buffer like strncpy() does.
> > > > 
> > > > However, the NUL-padding behavior of strncpy() is not required since
> > > > fbdev is already NUL-allocated from au1200fb_drv_probe() ->
> > > > frameuffer_alloc(), rendering any additional NUL-padding redundant.
> > > > |     p = kzalloc(fb_info_size + size, GFP_KERNEL);
> > > > 
> > > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > > > Link: https://github.com/KSPP/linux/issues/90
> > > > Cc: linux-hardening@vger.kernel.org
> > > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > > ---
> > > > Note: build-tested only.
> > > > 
> > > > Found with: $ rg "strncpy\("
> > > > ---
> > > >    drivers/video/fbdev/au1200fb.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
> > > > index 6f20efc663d7..e718fea63662 100644
> > > > --- a/drivers/video/fbdev/au1200fb.c
> > > > +++ b/drivers/video/fbdev/au1200fb.c
> > > > @@ -1557,7 +1557,7 @@ static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
> > > >                return ret;
> > > >        }
> > > > 
> > > > -     strncpy(fbi->fix.id, "AU1200", sizeof(fbi->fix.id));
> > > > +     strscpy(fbi->fix.id, "AU1200");
> > > 
> > > I wonder if you really build-tested this, as this driver is for the mips architecture...
> > > And I don't see a strscpy() function which takes just 2 arguments.
> > > But I might be wrong....
> > 
> > I did build successfully :thumbs_up:
> > 
> > Commit e6584c3964f2f ("string: Allow 2-argument strscpy()") introduced
> > this new strscpy() form; it is present in string.h on Linus' tree.
> 
> Interesting patch.
> Might give compile problems if patches like yours gets automatically
> picked up to stable series as long as Kees patch hasn't been backported yet...
> Anyway, thanks for the pointer!
> I'll apply your patch in the next round for fbdev.

Hi! I haven't seen this show up in -next yet. Have you had a chance to
pick it up?

There are also these too:

https://lore.kernel.org/all/20240320-strncpy-drivers-video-fbdev-fsl-diu-fb-c-v1-1-3cd3c012fa8c@google.com/
https://patchwork.kernel.org/project/linux-hardening/patch/20240320-strncpy-drivers-video-fbdev-uvesafb-c-v1-1-fd6af3766c80@google.com/
https://patchwork.kernel.org/project/linux-hardening/patch/20240320-strncpy-drivers-video-hdmi-c-v1-1-f9a08168cdaf@google.com/

I can toss all of these into the hardening tree if that makes it easier
for you?

Thanks!

-Kees

-- 
Kees Cook
