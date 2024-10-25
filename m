Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046720C33B
	for <linux-fbdev@vger.kernel.org>; Fri, 25 Oct 2024 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881140; cv=none; b=lBoJh78Nic6jvroAMAi+VLKVCUnLxIKQgGBDkvzcd6RrSALERtUmqyFkBgCja6wqT1W3b8KFbmXxCWEGRD9KXge75aKQc8x6o18pP4e7eJXuKl0JqKIVg5xNzoZmK1waD1aGW5GKFvqU+nNoxHR5riW8sKtR+laZlETr/2u5As8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881140; c=relaxed/simple;
	bh=0NRe5Z9bYszwew2si7F+kgrSb5MS03WEEqD+uCRELYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ru4+OBZz+b0kIlMt4+JXljpdTQWrAtGN+lm0s2wOXY16atOZxDy9/JPRGIfKB6kSEXfcy1NTa8Ix67YtmN/q2MFkHJRlEg/46UT8jQIjqnnhPE4+9OS0ohaLJw+hZz5VMCNpFc5W/BxaKtPFH8NYMH10NfjdGkdJk1dvJ+79uNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bgj2ch7d; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bgj2ch7d"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a156513a1so344749966b.0
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Oct 2024 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729881136; x=1730485936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bzuNw67+MpGyTXn9LaJ+2b1si0MHMNXbchvz8Oa27fU=;
        b=bgj2ch7dEjhgcIs3YmIp/751ah9nPWI1tkk8JUm6EZBmaA47/RYJ9Kmmzb/jI181CU
         OljxpyhnEPY5czRkyE1Us5NgrTcDd7QrHW4dhxQGTQ93gqYhnx5fXzq+IifrkayKGniE
         cAFpPEuKvO/DodZDmL9Vj7tH3gUGTDUFj1iJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881136; x=1730485936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzuNw67+MpGyTXn9LaJ+2b1si0MHMNXbchvz8Oa27fU=;
        b=GOerU+6Mx34gGlMK7TzgdXVI0Z26E+AqvUtveYQDHZfk9XEZ7t6DY/K4bq359lo1ni
         pYcQxgSRW2n7ZkvS5QyLtI5Cf0LtWGZk/4/6fXchNgIJae6TshWfQEfx++X5omXhnyLt
         EZaaKamXGQv/B/EdrWNsEhDVZR/uHdZdDzPmTsKumuEZwpH83KgCSjM5WrkBC9usVJZO
         NHy9XhGl8nRr9itfl1leCI/tiG1OEFbZrwzVM2428wIll6E1ayXm3uHJJXM7l7hrgf7A
         g2/lrxkdCv1R+/OSmTMQPgqHic2fmfeIH7mcvrE5aa2PNjIcc/LHpNf4oxIsiR/SRbFb
         WK4A==
X-Forwarded-Encrypted: i=1; AJvYcCWglxudNdIqLjdS07ZmOaYC2P8xQsz276Dd9Sh04ong9zPC601Ook4X72S36nFw+k7V6bbe7UXVfp0mKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzslTcGwt1utUC04C6z+t3YjeV0Q8nzcdPun9Oq62Dw0XxviEC3
	FlMCrDP30OvY+CmC+LlNxtOdNaLXju2UjeVx1DaXSw6x+qYYO8zXqYk+KoE1+gz9aBwIc1/CTOd
	XOvM=
X-Google-Smtp-Source: AGHT+IHRLl1PrE9HCzAP4dUUWMh1k410A++FVxb5lqg5G8HJ4NRuGklk596i/aCLnDDmnyvOK0eTUg==
X-Received: by 2002:a17:907:78c:b0:a8d:3d36:3169 with SMTP id a640c23a62f3a-a9de6451243mr3087966b.63.1729881135978;
        Fri, 25 Oct 2024 11:32:15 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b2f965d90sm95875666b.154.2024.10.25.11.32.15
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:32:15 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99eb8b607aso265696966b.2
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Oct 2024 11:32:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzBtNl7TSPnQ7gteGeI8y0d95ASZVt9YA4J32bTLMKPbCv7Mrkq43CgFvzdkJWooAq+Smy2HcnaesGWg==@vger.kernel.org
X-Received: by 2002:a17:907:2d89:b0:a99:33dd:d8a0 with SMTP id
 a640c23a62f3a-a9de5ff9ad3mr4825866b.38.1729881135176; Fri, 25 Oct 2024
 11:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxvBfDuqSC_TEM78@carbonx1>
In-Reply-To: <ZxvBfDuqSC_TEM78@carbonx1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Oct 2024 11:31:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKouRizUF97ZABtCmijjKR+sAOmWA4uiYhhSOwhxCT3w@mail.gmail.com>
Message-ID: <CAHk-=wjKouRizUF97ZABtCmijjKR+sAOmWA4uiYhhSOwhxCT3w@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev late fixes for v6.12-rc5
To: Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 09:04, Helge Deller <deller@kernel.org> wrote:
>
> It's mostly about build warning fixes with cornercase CONFIG settings
> and one big patch which removes the now unused da8xx fbdev driver.

So I pulled this, but only later noticed that some of the Kconfig
"fixes" are anything but.

At least commit 447794e44744 ("fbdev: sstfb: Make CONFIG_FB_DEVICE
optional") is not fixing anything, and very questionable.

For no reason at all does it seem to enable 30-year old hardware in a
new configuration.

There were no build issues before, the build issues that existed were
*introduced* by broken early versions of this patch.

Does anybody even *have* that hardware? Why were those pointless changes made?

Sure, the Voodoo1 was the bomb back in 1996 if you wanted to run
hw-accelerated Quake, but in 2024, this change should have had more
explanation for why anybody would care about the CONFIG_FB_DEVICE
dependency.

And in no case should it have been marked as a "fix".

                 Linus
