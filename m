Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21C438A714
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Jun 2026 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507554; cv=pass; b=c6zIWpJ74cL6DNgETOumJZPdhyNLuSd3pqxRPQq9tXmVIzzbmKWLWFlh4sMxEqyUHExFNfymFAY5/d7UAtGhhZr/M40HFCWCrP8vR0gyEQi/y1TMr54KhDtcBfnR1AXdYfSbnZE8x7Ew3uqVih5ngItxV9A+XKr5QuY/BCvTu20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507554; c=relaxed/simple;
	bh=FzhraAC351YoE/9WyaNWJaPNFlY7jKFOVa/EdskiQPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNDueaZlTitlfu9UfV44E9xN6H+p4OkpDiEYCz9YySx7ij0+3DpZBDow8x9SM9nDPpP8ShAK5ZxWp6GG/NFa0Bfs4/rrLj17L08GysM1xJg35yxRurZHRUhND5J2p3TiJd/1eYcR+/QUQsnh4Nou/1OMrlmCx80AbYdRZ6n3IJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfvmMjYU; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfvmMjYU"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bef1e6423e7so297475266b.1
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Jun 2026 00:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781507551; cv=none;
        d=google.com; s=arc-20240605;
        b=GXOtXmDez1YWGK11Rp9muKeoTzswOF5TvA7vT4ThIHbsxAwft+XEK37+gRNpyVthBS
         68loesYEmSw5t1bWT8ImKgfv9UOAvTAzzarg8PXCfWTDYQdAkEuuD8Y9AyoeUZzZPhyF
         cmERxsjSNdDu4Vqqh3LU5Xn53QnKY+6E4GrpoC47wifwsq0OL1JfHyWL4fRAvQlrtTvR
         aTqfZSiC84eCh1MXVLKagwADKht1kfsZiKaQ2Brn1l+jLlPnrdSB29GtJv2HYFAdEyyH
         gjK4+ndeL89czyum/J/mGg8b7Nba07NyhwuoChklOHy5T9YJirw/fvbnSkfSrXMZuh9f
         +Ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FzhraAC351YoE/9WyaNWJaPNFlY7jKFOVa/EdskiQPI=;
        fh=75/YUcLBfEdGOsGU6MCCiEIK9ZSAwvDecw/45QZ+oTE=;
        b=eIzy0UQuwh4X4hIxWftLWVP11sJCHE10msa0GpTAiy0TWAPt62XaCnHRnl4L7W9Q8I
         BoFM7JSL/wehIEQ7Lnr3l6fNpEl7f/Pj07JbSZRRsflLY+NPXDh/7qZ6HuFIVs7jSMQk
         Qy+9uZJGwTeqjvOrIzneqXBXAw7qpSlIiew2SIuTNQ8cZeGXvi8OG6B2ubzYYcTqvP3B
         bl3xT5b2tdqCzkuv8aUosC6NUYYjT+oz4RgXSbKrtW2wJzkkdD4jGobV4qM4e7aPg1Xv
         6YIjLbwLkLIW51fDMkEAyE0Aoinin2NKQGTnMjYCiNXoUTZVgQIwzZoCLMe8mzeHx2lw
         cWFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781507551; x=1782112351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzhraAC351YoE/9WyaNWJaPNFlY7jKFOVa/EdskiQPI=;
        b=XfvmMjYUawhJlfFB4gRcDFCNY5HCm+5T0NcYeiQm4g04OmDC9jlOcrOLwxGdkfxeDD
         a3MxBif3A0LmYMS+EiFY9LQ1RVQr9McOxUu/dCGtLvXwv1R0YX9pJYE/VKjoleOLVQZM
         6nr1DXUFteFq0MToLqEpf6LRDUy4iQd7eoX/72DfrYyVnqIZrgXvLowC9yZhE2vQp7i/
         zcPAWW75q/14JB0+bzj5r1JKOPd/CCUaQCJE5dbFcWvo7f489VkOp5YrA5ac9Xlx8/UK
         Sr6KxibzAbxzicXqXUW9HVEHYM9pYxLVgoe3OVpK6fOuyUZv4FhoKRR+zbCiRWNPX3Cm
         SvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507551; x=1782112351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzhraAC351YoE/9WyaNWJaPNFlY7jKFOVa/EdskiQPI=;
        b=RAR1YbxaP50+/kOlgq7KulR/tgUzf8NNCtsazMeRZNmMhL1gK4ytu57WEh4Aj5xdQy
         Hwqa4PmZ9CyFpRwuM5BdNybYXTOZuUHxAoDtkmrj+ssm0dGXjbglFqvUG0SU+XwaGpXz
         1EVhYYLZpa+rCgr111jvZovBD4jhVrrwnMfHauTyiE4Lk4mP5PVMjEBONNuCAX0opO35
         nGJGAiOSpOH02qGFML3UYddWNAxS/y0nhDmg0X6ZH2LPUNeygWssxL5/0Mnf6aQhqlXS
         bmIvYN4hFzdCMzIlBBEEDpyG6v6eTREN7aIRTryZws7DGZHz0p6di1cyXjENiTgvt1fl
         +EuA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZBtp++1L6SrVFKoIQRL0QTrl8rRdreVUzBMjWq7Bh0itSDbKgJMp0tOudfmeorvdKS+b3eAx4QFu0Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzleOnSPOveodXUCNLEUH5Q+HV7afnk+xBoYUWkHGH9rTdhggEp
	M8t9mF0nzkx8e06IEY3sKq/T4m9O70oroT4Viyr6P9lTcgx4HJmAsNzbYa1pxK96qDOoqDrkfqv
	vz++fiYMSKfgY9ul/gfiYTiiRKi1N9TU=
X-Gm-Gg: Acq92OGE6W5foJ6xf1uMD7k8Yx9T1HyBhqlJFXM2bdDpu2maTCOdnM+Q+yCZ/kXx1a2
	1u8+DWC6yZC25BdP3/PYxb34lmovXvg7gihMajxA/jT/8ZSTqPkvtt2ECvAV3lNLJW4qhHRhKhz
	kVp7UeabcICoLxhVe3rIgp0TMxQgYs4/75ELxE5P/JEJYULr5g9rnlwewp3tC8xkKVw8s6HMjYv
	7pFbb+dDEeJuU3hFUJ3qT8k1+5rG1+IRASuct3OK68rWdkJz8TIbd91jOQsredtl0HfV+4wKFbX
	NreSTfswqxJxK/hRJW4ldBcTENsjVSeySoUJbjp8zk2wBivXuNY1uS1mRMFEdAWnqsMEzWSkSJS
	QpAerxoArv0oQ6XlbdmlNdtsi3KSllTdVnC5p/NzQqR5Kzk4z03PKcvqjYvfH+mcQQeSs
X-Received: by 2002:a17:907:1c9f:b0:bee:426:87ec with SMTP id
 a640c23a62f3a-bfe2a21eb9dmr597482466b.23.1781507550955; Mon, 15 Jun 2026
 00:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614201551.20542-1-reeveskeefe@gmail.com>
In-Reply-To: <20260614201551.20542-1-reeveskeefe@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Jun 2026 10:11:54 +0300
X-Gm-Features: AVVi8CeSC29eIc4U_npHh4CvhBaUd3ShetIXEBLYi-0z2YrMYKXv9Qbr5BF-IPM
Message-ID: <CAHp75VfkVQ0JJd4+ceniNnij8t-PXsrNOfof4c6NDWf3KW2s=A@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: use %pe for backlight errors
To: Keefe Reeves <reeveskeefe@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, abdun.nihaal@gmail.com, 
	error27@gmail.com, chintanlike@gmail.com, namcao@linutronix.de, 
	niejianglei2021@163.com, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 11:16=E2=80=AFPM Keefe Reeves <reeveskeefe@gmail.co=
m> wrote:
>
> Coccinelle found two places where backlight registration errors are
> printed by passing PTR_ERR() to dev_err().
>
> Use %pe instead so the error pointer can be printed directly. This keeps
> the behavior the same and just makes the error printing cleaner.

Oh, nice! Now
Reviewed-by: Andy Shevchenko <andy@kernel.org>
(for curious ones: you can also see my comment against v1 of this patch).

--=20
With Best Regards,
Andy Shevchenko
