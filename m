Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792990120;
	b=QIf3I1sqRop5SJk6BhiBSX/ipHKxY6z+Mz06eQ3bQL1So3iGoCONtB7mZOxKVygkPcrK
	 CubbjvBe/cB6r0FfgXwiWBrU/ChBug3Su7ddb6+5yqa1osIOskgU2wkCr8Oaro/gSjMTs
	 Te+0/iP82ctfs7rKSM+zj1F7MOuFsWz1DRVEarUZUuWddaE1zWb93DtrttAFEuUDLrdq7
	 GFwkq/i7KTnLl9b+TvQ7nEISJ599vfFP6ZJFw42ayOWqxXOqJwIpm+jyzQyp07TVKUkWh
	 izTrVLwvByvaDQOkmO8t12Pi9Y88kAfZArL4fXibb6sB3HoPzP0nZkrM75zCM6Yf2Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=56Y4H+QOpsErxz20UwuJ3uqXiwvb5kpke2jcTVoosVI=;
	b=FD9JeaiSjyO7pOc1C640oaFQlx5Rh3q0iltWkmIn5wff2jstDfrs5vOieRbx36D2BRYj
	 D/URbxk9jFSBzlaPTBPMzk7P8umj3LnB1c1b+wUggc5oQgpJzG72DgBBYm1ZBrA4Me6eC
	 TLYkSsG2kpVliPzzHLmQS7ZSYrZ+X10B+PCt2ndFvIaTxyPCn8R65lbi9fwnDHx5mHmDQ
	 N5u3GHq1kEUPXgkFFvh8leCsk+It2IHFDSffN4szn560M+yoBYcrmcpuOP6cF9DP64a3r
	 XXo3K8daVT9TE2n57Ng5yITINBMwCadHflaSTwfWNk3Nu6K1DEs9O4spncgxwymVhUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="WcRmM9L/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6AE606A31D
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 04:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA6AE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WcRmM9L/
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-70b875f6f13so1497373eaf.0
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 21:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792990119; cv=none;
        d=google.com; s=arc-20260327;
        b=EgIJM1XxL1qq6bDhJvX6qcNUgZqj3M8hZIc/EspUCKgYkoX6kRlcgPYKNLPIqLBUot
         xkx4dq459QLfjziKZpxqyzwgofHB5zsTVQ8ZSQSsz9QM3qW/WzHxUO1yUGV8SGS5d1Re
         Eeqlsdw15JNEPyMJ6i2rm+SFIyioLs65ZeR1+5oWsbKtV7IZK/hmd8YTa0xWdSdMmAAO
         g7PtsJHr44Kv5B021BZkn6lSYS0mMtYvV7yevNw9Ht6De28+lYkSZXtR0N/VVJKa/8/5
         wljliOiv76t8Ju10fewEbFAokGnhp71Kn3dnrIr0LeUFdec6BaTLfuUTJp+FbecwhAwd
         Omiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=56Y4H+QOpsErxz20UwuJ3uqXiwvb5kpke2jcTVoosVI=;
        fh=5Ztqdb48NcUHKuSWAUaLcG9rqGcazZ0bu/i7gCQQclQ=;
        b=KoC3x8QQuc8Rvnyqpnck+rSCfJFTNpHwzLgtX10sqZVWvHkUHcnwuuSyeeVmHK0AWx
         MhvR7XClqhIPZppQqEhTqFecAryyLYKxwXoihJFl/91p6c10N9Nj0u+JdkWMRk3LldHM
         KoLZBKMgpRk4KtZRgHI0ooP0F11Ur4XzOSX3dLu4DLbYgCo4PWDmFyAY4o/1qC4hUhiM
         j576iT3l5ESBXzRvS6BR6Mp0gDmhvqPJfrRTCtHm4IfPEyj9t7skOiVv9izppwfKkpBb
         FyrrSFgUM1B1TymANtWBoQztZxRvlM6ytpIM8X6fFTVT0/X343Pu59vB67u5CfWiJdqJ
         0LpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792990119; x=1793594919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=56Y4H+QOpsErxz20UwuJ3uqXiwvb5kpke2jcTVoosVI=;
        b=WcRmM9L/sz/H8KG2lOQoxvJL91bbD1aAc6eXQLxZ0S1g4ijInjZdX/ODV8kbStiyLy
         vdycIwd8tpi+4JUedHMMMDoPSCXrGNGFK0j/qKp3oWTukFMMWEZk9yseU3c5dVSXmP58
         EI9K9dr21qIkcAmJKyoh+wGN4fK0f/mpfO+AAZSriOCLjPphGkFwm5OyVxI/+a/hMnUu
         iGh3JYRA/rO8hd9FBczh3DUAF3pf4Ad3OaxYdGxaY7ucUNLAknv3qeopjkyGSGVwIAHt
         x9acQVIjCWfV/KQ9XEU7yPhzV1lnvGn2knV2ArxKjBQsKyEA67gxSRMWeqOa6lq2w9At
         nmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792990119; x=1793594919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56Y4H+QOpsErxz20UwuJ3uqXiwvb5kpke2jcTVoosVI=;
        b=PjtWiBkGduFgiacObiibUqM7qeSK/qHKYSrwPMJhG7TjxlppKeJQ3rWZJB1yOUnfmB
         kTTNffbOlJN7E42CS5lfEEwq+Undj4HLSSG4FZa+so7o+elp6UAjjnJx9VXIB3hBGpnh
         UZE0GEkZx6ssO9LHr/543ky02CcVba7y6Z6vhTl7j9WcaXvHK+Fj412nmRN8A8GaLCOj
         TJsZFdXG5by3Mkz4ce3fG9fOOebW1b0aoI439/TwGr6Px1z1Xe4uXmJL/qY9A/Bha25j
         hjbVEDAbGcwmaEt7Lkx6FDg/dL9WHryJ1qpE83Z0PxIaFGOKQuBY1F5ecAQUGwvHrsV4
         ccQw==
X-Forwarded-Encrypted: i=1; AKwUvBwXnZTqXxulCbRZ/3Q4T1GO0ZGr1ZGj0czzbcXbu8+ytDMdUUYyOibZpdvN9zCuBeUpkjNdxO0uFhAVtA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLPJ29CZND9pwzx6pWPqbkao7xicewa7hVVB1RsjUHYURMTTEXc
	IsMNleHzQ2Gf37V3Jrv7pmosXImH3v+6iNMS3RVjKaB2jgGyE85LFAa9IL9rDkB2kr8s7pvHMhb
	k+WEMElraDlp5RJ5ObftItK7rLkBbYiUDsvFd2BU=
X-Gm-Gg: AYBFou3UI1SHbQuH11zr/RQhFXdi1OwFdRB+zv7kpvpLe9plgN3aiv3h9LdtHsUeIVc
	BNuYTvUlTnJyOyIuCjcK+ws9u9MoYoirZiAR4xGgJGlKikJqVxcX5bY0ZF9PELJpGd7HKiYiSnH
	sW0nqHvbn3FEwx5F8ntqm+1/zD5FjlnMGZrIqf0Eu1Kh1QY81bg9YeEzw3siZB6lAr2fSW3vcJP
	PuF8527bn9yIpgRvuHPwvjHX2/+FTyS11sMvDsPG94+nzJdyI/LSQZSLmzamP6TeQEbddD67NYF
	/A5Cn95UiQoptPPFJ3afMqR8RRWkyfNe827WWkXDVMVgae1D4J8GKZmxKQiA2b8HHBPm2vqfUEb
	I46uAEovdaY+vMRH8lGmdzz9fV1XAteGTifqH10XXrSWGpBslqkecIhB+7eNfkE2re5te/aM=
X-Received: by 2002:a05:6820:7184:b0:70d:a53e:845 with SMTP id
 006d021491bc7-70da53e26e4mr1017756eaf.17.1792990118754; Sun, 25 Oct 2026
 21:48:38 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024180803.108872-1-himanshu.bakshi478@gmail.com> <at4Zyt9QP3Yo-ZTC@ashevche-desk.local>
In-Reply-To: <at4Zyt9QP3Yo-ZTC@ashevche-desk.local>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 10:18:27 +0530
X-Gm-Features: AclHuK-hrVr9XIOU9ZgMN2G04tr1CEuz2jBrJcJQCkK3Fq75oom0ajhxJqnjf-0
Message-ID: <CAGLmz9+B4bcp4WKfBzpS1nO019J3yZppeGKx-ZgZjncik5e4Hw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Fix line length warning
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

I have sent over the revised patch (v2) over the mail, and will be glad if
you go through it.

I have made sure that the \ (backslash) is properly aligned to the same
column as the rest of the macro. I have also taken into account your
advice and hence added a local variable for platform data.

After some thorough searching through the respective directory, I have
not found any calls for fbtft_init_dbg. This might be because it's a
helper macro that might be useful as the driver progresses.

I have also noticed that some other macros around this one have simple
style issues and if you would like, I can send another different patch
cleaning up those too.

I have also done minimal testing by using the macro once to make sure it
compiles and has no errors, if you would like, I can also run any
standalone tests for this macro.

Thanks and Regards,
        Himanshu Bakshi

On Sun, Oct 25, 2026 at 8:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, Oct 24, 2026 at 11:38:03PM +0530, himanshu bakshi wrote:
> >
> > Split the line in fbtft_init_dbg macro to keep it within the limit of 1=
00
> > columns and address the check-patch warning.
>
> checkpatch
> (in one word)
>
> ...
>
> >  #define fbtft_init_dbg(dev, format, arg...)                  \
> >  do {                                                         \
> >       if (unlikely((dev)->platform_data &&                 \
> > -         (((struct fbtft_platform_data *)(dev)->platform_data)->displa=
y.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
> > +         (((struct fbtft_platform_data *)(dev)->platform_data)-> \
> > +         display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
> >               dev_info(dev, format, ##arg);                \
> >  } while (0)
>
> First of all, make sure that \ (backslashes) occupy the same column on ea=
ch
> line of this macro. Next one, it's better to add a temporary variable to
> hold the platform data pointer. Something like
>
>         struct fbtft_platform_data *__pd =3D dev_get_platdata(dev);      =
     \
>                                                                          =
   \
>         if (unlikely(pd && pd->display.debug & DEBUG_DRIVER_INIT_FUNCTION=
S) \
>                 dev_info(dev, format, ##arg);                            =
   \
>
> And last, but not least, have you checked with `git grep` how it's being =
used?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
