Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCCD2D322E
	for <linux-fbdev@vger.kernel.org>; Sat, 10 Oct 2026 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620036; cv=pass; b=Jx0Y6K1JXJgkRX/NulK0Pof5bVA+gL5r1WdSqZe4jRo4UZyhB7Nj1QpS26VbwZ9FGJMEbNKFlPswXnZz2jNKdT6/GzKggHrlpzh4uE9cVB0RwTrlRUUzj78bCNFxT3tZIu+Q0RyoklkJSyyCIREegaSUf1Bt/R+qPIpLMz001ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620036; c=relaxed/simple;
	bh=v95mXYZS8OV/hddK/8aCeP00yH/oKndJ4AKBv1pvm/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4QW1wYN3GeMADV+rC279kVeC0yBfvHyxrdEv07cMav3E9Zva1U/F22byZ/8+/dZrTD6hgSA3ZnwGfZHvTR1JSxhhWr4zdsEAKdDelAtaMwHUgVY0sCVdyUh6FeUJmqo78lA/DRe0FpwHfF+VnpeaERgUlRkSXFYTcAhtFYtHJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDPxHFpB; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDPxHFpB"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso248506e87.3
        for <linux-fbdev@vger.kernel.org>; Sat, 10 Oct 2026 01:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791620033; cv=none;
        d=google.com; s=arc-20260327;
        b=aUqzlCUcdVDVUfXSVHlWTuB1Z6AWzVkbcAL7Z8pPSZN6vwqM8g59zq1sKlQN8Hq3HC
         +hlSZePZpDCRXck1JgSmOojMDw05XPMeScaUAmWbN7EDn2RUf8+2/w7OSPE/gpED0Zdl
         eldE2pL9CL3JbQF0NPS7dLrppjm8Rrl0aQBbiB8/VviQfHryLTiEql/9mv2LPPlVcSMV
         Q6F8UeBaU7bJHFLfJRqcohujsTXRmChB3qniSOMm56AqMyiVocbF/7u+Q44yAlHX+9vx
         eAQ/RlpybCA8TbuGRfLV9tvaxSzstJ03yzHeTYdo4dYgyZDXP+bd4WIzD6FGqLxQxQPz
         uCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v95mXYZS8OV/hddK/8aCeP00yH/oKndJ4AKBv1pvm/U=;
        fh=AqckTmT01gWYAS7BVOkDtJU/o6dykpYn+HXyPsqiW6M=;
        b=gLxohR0xaSZ+vPzfujHehAx/yW16RaM2ZWSPxuWODkA5Bd8SwQgCXo95pYKtWx/7m1
         EdyRKdBTfm4T9p1bx78mVhLJvn2e2CuWMeZDWKrm+ib+L60gExcgMFUAbgEOiAZfsgS6
         h/GvDHZMI5E9AarQWek6YArsFKRAH0486EW2t8OtmvbdqUEWDEtZQrCyDuebszwz4X9k
         0vPvrFlhP7U9zEaUAVSLl2cI6nsfMHMObeoKOYySYk0Fyp7WrzzBRjDafhVZCUb2AjFW
         eiZOF0XeOphIBnLr7YW+bXWy4vhBgQ5tn8sd2bbeVGiRY3WyXhpRWF4yOv97uYgn4SZL
         IQnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791620033; x=1792224833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v95mXYZS8OV/hddK/8aCeP00yH/oKndJ4AKBv1pvm/U=;
        b=cDPxHFpBELcnjvKXwPUyrO/hGqo7t1TKxGKuXajuq9+IyMeUGX5eMdp8UwUQR+aYEs
         UHPFIfHz+q0JDufwle51VI+ov7K8NLJT68WGna6PItKu3/TkQ8Bdli9E1Av3bvEGd0nY
         KOrbdisGlEfbODk61LDXwSdkmqR5T5WPwARdn3Ifnn6JEgTRwcV5SwtlJy2OLA+gTU77
         ztmwUeH4Bm3o67CsbpXUMPxgCJJGRFO+KsnP1h7L6SQwk/X0D0v7JtMqTpnz5hvn5qk6
         Ond1i+nYxi070k/r4V81XHACQ0aCAifFliavmGSCm4oTyQa0lmAVaYiQzDmmVsZDJEr6
         402Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791620033; x=1792224833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v95mXYZS8OV/hddK/8aCeP00yH/oKndJ4AKBv1pvm/U=;
        b=PHI3a7adlRsGg9WLZW+6SkzjgeSGq5NE/E6gm3KqAu0kN9aoj5hR+ABeFOS9XCgr5v
         ZAxuq+u6OHqiN6V6/2VHH7SM0+Aa3eh4pE1ic59/cvwZRsNxVl4x4YdVCkh+ZCyM5d53
         uuxlwnVQRAeI/bFs3JjmSF6/7hKxJmAV3SDUcWpvh7RIykDVLvYi7pBHN2Vaan1mUJLQ
         ySLtIQnt2p+IJcNbOmh9252+gjAhEllZr6SYs8a9lZteAck0mC/L/lhQEf2tQB/zANCJ
         Y75b8OVnkfYWwq+O0AG80wWf8KWIT14OQAlBaDzSJsmL37hbiNiX2fnXBUHg97Dn8pgX
         vuJw==
X-Forwarded-Encrypted: i=1; AKwUvBzXDxrBXEdfnZreDrLwohjx+77IYaJZm1zKSEV4zmkibf4cBFbIRxMe5hWdr99YcY5gK1E0bhHspCDufg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLZgcNJQZ7htPlHEBzZzz/gqHRde8qGVRnKk+jAoqcCAs00ykuF
	Evg4ayjkOSk8bjqVTlfETcV0kCdUsYpDQyUE9I+XHae5DWY5OFuVzP9Qk8nSAMytAovUZ5tiMgR
	IEk6odoeJ4og37+RyZ6dIoobYhC4CR7o=
X-Gm-Gg: AYBFou0O2BtoyhvZLo9LtT00h44M5HixC4JgTGyamG/pj0zjB5k3oQU+5JniLv3mUql
	WomzNLQZkLo96bLDxeLqlUkNAOkgteq7okkjTV4UV0pzUZK9JkWBRXMP91MrbibVK4u01Q5ncyZ
	mbKnhaCG5YgyGhk0ljvltfva8SreBysz50/G4yGinL6v4FOt/Y3JsmD9ghVCKJ7uopqI6+ptGtO
	FP2X7dMXcdqgP3KMKXGURAyckRbP1vyfPBZ73meFzREG7z/IK/FYgrE5ZBZQK92FGutHuuOz+VM
	9nrHJGjFapegNnCbFoQOcNoqrOvUyRffiHwOcWk1NeSWj3xRIPAusD9zmlFClrohSA9MVAnx7Vu
	dyFiZpBzFjNMxjV8WlJEv9F48822IkXwa472F71M5e3WKjojXG5e84sPfD94WUjn2EkE1qGWaM2
	vtCHOu2FtxAlM92QqrZP32eP74hjGzY4O3fQs4HWE=
X-Received: by 2002:a05:651c:2221:b0:3a4:9e40:d7fb with SMTP id
 38308e7fff4ca-3a9c53985d2mr10277901fa.7.1791620033148; Sat, 10 Oct 2026
 01:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009154526.43528-1-cenzhang@linux.microsoft.com>
In-Reply-To: <20261009154526.43528-1-cenzhang@linux.microsoft.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Oct 2026 11:13:15 +0300
X-Gm-Features: AclHuK87hlToSKlaS86YJtsi34MGww0jdhpR8cjy__Mr0Dxl209enwY_IZs85Ms
Message-ID: <CAHp75Vebzu0XHN0h_ehpmNfipzcR_7xS+Lavyd2beHUmR7t_7w@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: update outdated struct fbtft_ops comment
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Hungyu Lin <dennylin0707@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 6:45=E2=80=AFPM Cen Zhang (Microsoft)
<cenzhang@linux.microsoft.com> wrote:
>
> Correct struct fbtft_ops outdated kernel-doc comment: 1) update
> field write_reg to write_register; 2) remove non-existing field
> free_gpios.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
