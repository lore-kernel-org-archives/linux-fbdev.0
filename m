Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597921917CD
	for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383437; cv=pass; b=bUcpk0Tzfa+v0ThQ/lfewt9+3q6/KCQXHSt0/WM+U2gtN7vAMUIyYFyUgC3mFhW/0TTt+N0vX5K9NPfW4UX5nxcC35E/b1Dkf+wsdTbZYTuXiX9yt3kVl8xIpG64rkxoPPFV9OT24sGzHOhKO0p1TqfUdgwEzwEk2C/t3feuvQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383437; c=relaxed/simple;
	bh=AvoQHghqbYYBynr9L28jSbgEoJOOe82Wl0qq9VqZVeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWC6rKtCM2rh7by5LyJ49WAJfQwv9Vxpj6S3QH+1rQ5k30veBRoxWzoGNzqGnxI1oJw4TCZSvC2290L9lGkD6oQcG7qPw1ssxKZjFq0aCuAW3fHOk4yrfKd1lt7ACn7DhJyOj0zk+xaTUZk+ANA5+ik+CcWPDMX7LMUY8GtcydE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcyGA+WT; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcyGA+WT"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c88b7c92577so846670a12.3
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 03:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782383436; cv=none;
        d=google.com; s=arc-20260327;
        b=Ljjk7YxsRPnKH5EbmSgDYgCu+OO6bYu6Sd9LNZ6bfpKF2eeA/UkvaHzaRPGlE/iykd
         rpuh77MD2uJfqa6j4iwdO+5OiM4aXpYkbaxkQMTDKGfMl7G520B2MYIFgZNOFTS2LHO7
         vLFTRGs65y8rYQ9Hrwsh2+b8yVOmqdlSmOVPtL4ABJqe9oa0yYpS5R+iF+v++B4bUuKG
         PteBKAm5tQIdtGi55nrsZgyVpQQ8qzPFlkpbDxmlym0/TR2rcmTa31OlZmTNVvtiA9eV
         a1RkuJ6gvwAalxEYxj6I2n8Zl6ZPLYjAqShXk6imSh8cUBjr8UcTFVaFurXn9PSoAno3
         LsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AvoQHghqbYYBynr9L28jSbgEoJOOe82Wl0qq9VqZVeE=;
        fh=OeF6eUMzKwRTDGDfrOXZTeLIY97zPKJLSaeIxIkG+i0=;
        b=QDUbHP8laZGHndH+1nddhQ7ryi9AUzW452MdMVH4UtC1HOai8JnQj6B3+DIQyf5KgP
         tFtc9olR0NctJIr9MnV9NIKO1mo2tfjTaWclWGXoJPMn4ItZkEbi8O2k/4LxxD+RdLTr
         v/lqSFre/V9blniivKGtophMNPo8OutRQoLojvb2njnod5zsneuz2ds+nVzqcXpP8IsG
         bqRoemawx65jALyYwxfExUqfz0hDOL9GBd8gj+IdX7k47AFJR5uTKfoPDck0urak961Z
         bc0kHbKfV6nG4E7qxZBtj4x/3s45g1RQ9zahOi0jAun7z91PoPcLKDzUegANtuQmp/SQ
         Rjmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782383436; x=1782988236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AvoQHghqbYYBynr9L28jSbgEoJOOe82Wl0qq9VqZVeE=;
        b=CcyGA+WTJLaSruGK+zUsMd+VbBKNl1Ra16R8c7HevnMBEqUqmUALhsyydhNgzBimu5
         gFCgd4wDqblZtq2D44AUGpf/K4cTo0Awg7I3Slvb6l8pXRChVMcLuYxf6H/+08lOt2nh
         t1jsPLdAddFOiazMruqcEOIRjYhnCZB27e0JmnKz+0DTcp+d3s6w/8+VgSS6pBjtjknH
         0ptcYHOWZtdYlKcolCUd70QyuF8zvobYyY0zByWmmEswYcETiB9dbHXjmJsKIuhWpogG
         Q+AVHinZRfWj8ZA09xIKWGuHTWE7lUNRO3I0EoP0qYyLylXn+Iio1iU+4UGSOi2qbOCP
         9ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782383436; x=1782988236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvoQHghqbYYBynr9L28jSbgEoJOOe82Wl0qq9VqZVeE=;
        b=R560Kd6Lz7WIdo9Z5n+K3BLqxfK/P4/Pj+lyFL4Sj2LIEV68WPce6KiGouusU58jKo
         U5veN//ZUukca9zUmMpEEsZbZrZ17OIXg7f28USUywYh91TIx855hy9YS2FultiCB1rl
         10vCWF/ojkYqf4JtOCYT2lMzdrOrzHtKHu0xRzoa9idR/uzU1dDnjexs2o4rXKfgf6uK
         k3Lx+/CIM3jbpKMvqUhU77eCJoTxFbdUGPUQ6Z0tnk2z3N0Rgj5qeBt0fKtAcLmEXOj4
         K1rprUQmexHuRcjKTb2kS9pfzCtOE1JH0qzzIk2nbN9omGul/qn3oTnKDoMYKstgpu+N
         kWIA==
X-Forwarded-Encrypted: i=1; AFNElJ/Fa2ZQHr/dQz5PsbDCGjGmiGzKbyniqWOCYmpP7xkWi2LJQPW/cEAayxba3ey2/QcaEtlwLRS3ey1HoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qtjaSdX3q1fSOQWVEqzs0jGjsyaF7rHg3nudAOfBH2L/o7Cv
	4ydL3MLiDWxjZ8zy5f/SFlO7RWnD+q9HdWw/geB165KE6iw56aRdA+t7xQ39hC++lW+hUGFZxic
	CFIRV51uYyyiMhMl+OHUJMdtvzwq/xpo=
X-Gm-Gg: AfdE7cllfYH8bVWBZNAUaYJ6JpbtvU7pJzuAxb07UNbltLOkOIqj3fFcNiuO5VZ5+/M
	84+00jIo59WiaU/VrwvXs9oUjrU8f8VPM/81kd0MumjHnQfsMIyjYCo9Zp2bbuBo2scmbnsZ7sb
	NrtLUGWTqJXvFO6nDvhAdcDXj8JrB8Y5TqAqm2hCFGqy/gF6ODDYsZQZ65NhcBwqOdSqaTykWRJ
	ID728CUbwBy9HM0daO1NkVYhW5VMlzNna0SAFducFHedAZrGzPRM1EQKiJf/HTGzF9YyQ9sgk0=
X-Received: by 2002:a05:6a20:914b:b0:3bd:187e:2d1 with SMTP id
 adf61e73a8af0-3bd4ae0f890mr2352631637.23.1782383435568; Thu, 25 Jun 2026
 03:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625092721.238366-1-suryasaimadhu369@gmail.com> <aj0Cv0Wzb3rieNqW@stanley.mountain>
In-Reply-To: <aj0Cv0Wzb3rieNqW@stanley.mountain>
From: Sai Madhu <suryasaimadhu369@gmail.com>
Date: Thu, 25 Jun 2026 16:00:24 +0530
X-Gm-Features: AVVi8CcdIPL3-1B_-CzFZpXWUulit7-jlDYUNVs_z6-h4OjuWGoke0kaVKBdZ64
Message-ID: <CAB0uMAeMOV4Xhq2cNVjxne89yqF8vdubM8-OpPYGK4f4yBLMNw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace empty modifier argument with
 no-op macro
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

Thank you for the feedback. I understand and will drop this patch.

I have also noticed two pre-existing bugs in the same file
(unaligned access and buffer size calculation when startbyte is used)
and have sent a separate patch to fix those.

Regards,
suryasaimadhu

On Thu, 25 Jun 2026 at 15:58, Dan Carpenter <error27@gmail.com> wrote:
>
> On Thu, Jun 25, 2026 at 05:27:21PM +0800, suryasaimadhu wrote:
> > Define fbtft_write_reg_no_modifier() as an identity function and
> > use it in place of empty modifier arguments in define_fbtft_write_reg()
> > calls to fix checkpatch errors.
> >
> > Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
> > ---
>
> I don't hate this patch, but I think we've decided to leave this
> as-is.
>
> regards,
> dan carpenter
>
