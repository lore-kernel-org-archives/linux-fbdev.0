Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456F2EAD1C
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665241; cv=pass; b=aeUdFAuy6WyaOw6GQs41thZRbKxIe68KsAYTGi23Yy4Em1Le49JCcHyAX/EV9n4WgtYDbF/Gi/hrVFxnecpxfedgGJQO7wHRp8cW1R4rbZ3HxkTVc0FQl4H/l1hhSjfoYJ+aRwAo6opEt/X8rU/w7um4VwX2y2d2W/6WiumClMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665241; c=relaxed/simple;
	bh=FzlNIwubDBvMWTsHAsdbkyAlcYjfTZvIU4NRqs0asyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enpfUE6ibYleLlVlg3UZ2PbyoyH5uc4UWWrJT7qVvz7y7th1NUQSzs0KSB12jU3m7BqXKSu/lU9icnlcMamj/kpeW+z5zAOvB6Vhc8uOyC2iKN7FzZw0jmT6f9CqSIFaEuyCoVsHdSaVlo9XWRlhvT6niZbtt4FmSKaQPWCxZC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPFv3VHJ; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPFv3VHJ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-becfa735b9aso655891166b.1
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Jun 2026 20:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781665238; cv=none;
        d=google.com; s=arc-20240605;
        b=Ct3SYlzTr1wxu8EJpOG1Chwu9+SNNQ9GBBAPlk3xvwa38at5X0unOrwesyqwU8kveb
         9/PVZiMUPuRZ9wrQBNg0/ucHOmbUr8tieB5QvacGV/z4ZiGH5La9FF2jSHGRh+kckoV+
         Oj7vy+sn1iou2ajwwicjJOQcfLyAJCQ//yuMGo147cQJOdFR2giwDcH0s97WNb0fF7o4
         V3oA38BjT/8p8lpD99MSvO8X8EYTJmHsyt/r2rBSRoAmiRLFibMWe8kbodXsfZ+Imq/R
         DrejZ5d0m2zic/39+fA9OlsE8C3XmdvA8213I+D3a75srN9PY5HcQYGPTgky6r96QI3a
         Oqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AVxcb6MPW/0aaJ/FVE44HUUHQfK736ne8YqYi6+JyTo=;
        fh=4tCXMmkw3MH0U3TaGlfHSqDQod+VdceWtuAUTR9KVSw=;
        b=Ke3eDy9LrdfjJaNFs2g77guBkojTIXfmwIinJSAN7fcAfhiZVgR7ExMaS3aG6HiejR
         HK3e2kLT6FGii7SKGQFqsVs/9TgbIqmBI//PeXzEQWbh7l43xkoyeuzA7ybsbWchIztu
         qMCMEY/+9X7wAcIxnsc78xmBkYRHDOAWx2dgVZ5XF1LldicR9ffAOlL++tDaGazgpXzN
         fOxWXqbkTGWOpJ0tisW1fYZ0qexCKNhD6g+DHUJgqnTwQ+Suj8EQlixmKh+o1xEF+sS7
         Twrbsu4T4qUVAOUgMkFW20nVNuiojoYYTRhluBYGsVQVPw2Dx01PXjsTv/SA3Q3g8p8T
         YqEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781665238; x=1782270038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVxcb6MPW/0aaJ/FVE44HUUHQfK736ne8YqYi6+JyTo=;
        b=WPFv3VHJ1lZH2NasjQ3QX1oBjh3iATAwkXhDeeH6+zcka+Yntjys1VitxvrUXxRcwL
         lW8ral2vwCw4DlO7Fr6iAlfy++U8bwSoKKCC6FZRyxvx+vghrdV/7LF98Hj0EeGbVVDh
         Twljjto176nqcK2XAB1fniqM3s0o6f0Z2uXHt5O+dNXp3Wh3AWAXwKpdtv+mTkWrjGg3
         CiGuybwia5IZUoxLJmmelnjjU1Jic6Mn2vHKM7I8QsjrEK1vCw32ehFvExKxBj2Cftea
         TbaEK6s96peKUDBYwM2S6NwJfB9m6vJAwnjGN5vBYbyYVVSdYaVQJ5/f21JDrnEz5ziz
         yxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781665238; x=1782270038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AVxcb6MPW/0aaJ/FVE44HUUHQfK736ne8YqYi6+JyTo=;
        b=QohpsAx5VCvE4LD3yI2c9hkqWpU0MVJyp1fGJINnmZPV2hGr1sRRQoUnAJ13dtHd1r
         VM33D6y7TlLhtsUn77Tkh4VnK9Bowzbno585oltuEOBbf7tZH15YVkew+CNd8xmup/Ib
         hZap3J3q8mk1K0R3xfp1Pzg86CpuER4XWGxLb/MsPDyt+RON+d5AVUbu1Kg2mENzhypI
         KJHabQZp5mTBbZm4JXujfL00lreBBitH8Voo3frb2VSnhVY3MQN1KolgCHkGuFQuOOxC
         f39VwlJimZDZJmSpyd/gLD5xdLNrbJm40tyHemA7UepTHZezW/V61nEgPQzPAiIRXW6x
         4/Rg==
X-Forwarded-Encrypted: i=1; AFNElJ83CIWP0wxAYJkSlw76Z6wVWrsJZFKuB2GITfcLpduEYWntzNgySOeOwzE5xu4IKoVAexoO+yoRrnLDLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wPQ6VqG8neWy20nD0QWRCfEgbiRzJPlwIZINdIPdI/NSMJ9i
	3GTCf9KvUUKU7OtU1b+JjJBiaJY0tf3zeJLBbe4mzdMoCU/eLS/FYJ+PfBWetYKyWqEg36HiPHM
	6QFlJPjHEckeZfDkVrYZEohN4gidG2jQ=
X-Gm-Gg: Acq92OEQ8EAYzsL1qo2cJHNvYRUoIYLxxszWtAaCbS03+5RmSitoCal+B2zABOIPXy7
	CvA0+LNRM0H0pHpDRE760NHWYCtSSuqt4CTBZvcRyP1sZp59vJvKuvPsQRNBDKh5W7N2L8k5uVN
	SeiyftOJRbgbInvIZJdCZbjbBkjsNTC07FUVwHxNhPqYIJFiYHmicEizlio84UIyL6kewqiZKJG
	rIgyuEyYpneZm3KP88dmJdIJb5kj9R++VRiwwj0TyDCA3UdQfDw1TwxC5TzJg+0/rqGCOCzOtIT
	KmqGKiXgT0CgBILl/VkYm+alJVM=
X-Received: by 2002:a17:907:844:b0:bfe:ed06:5a20 with SMTP id
 a640c23a62f3a-c05a83a5be6mr120171466b.53.1781665237966; Tue, 16 Jun 2026
 20:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529111927.14138-1-neharora23587@gmail.com>
 <CAOWJOptv1JcOGcEt39HVy7LkpAsvzbw9yj64kJG+X5J=VbWrMA@mail.gmail.com>
 <CAOWJOps9RBNAGsPFsBCbzFkEUN1=75YvwmqJX6RdQBbt1C6W-Q@mail.gmail.com> <ai-j96dVwtPMERVM@stanley.mountain>
In-Reply-To: <ai-j96dVwtPMERVM@stanley.mountain>
From: neha arora <neharora23587@gmail.com>
Date: Wed, 17 Jun 2026 08:30:25 +0530
X-Gm-Features: AVVi8Cc5Aqz6IEU_psJpBjlzSR1xH6pEKu7o2DlkOJhvJA9uetWjimuvkY4Vpkw
Message-ID: <CAOWJOpt2CW=-zybOrPr2pwfPVQFcd+j3YoNP+rMyAar_2kJtbw@mail.gmail.com>
Subject: Re: [PATCH v3] staging: sm750fb: rename pv_reg to io_base
To: Dan Carpenter <error27@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Please disregard my previous patch submission.

I am currently working on a complete rewrite of the sm750fb staging
driver into a modern, KMS-based DRM driver (sm750drm). Because this
is a complete architectural overhaul, I am building it outside the
staging tree structure.

Once the sm750drm driver framework is stable and ready for a RFC
(Request for Comments), I will submit the entire new subsystem patch series
directly to the dri-devel mailing list and CC you.

Thank you for your review and your time!

Regards,
Onish


On Mon, Jun 15, 2026 at 12:34=E2=80=AFPM Dan Carpenter <error27@gmail.com> =
wrote:
>
> On Sun, Jun 14, 2026 at 12:45:05AM +0530, neha arora wrote:
> > Hi everyone,
> >
> > Just following up on this patch to ensure it didn't get lost in the que=
ue.
> > Please let me know if any changes or a V4 are needed.
> >
>
> It doesn't apply to linux-next.  Did you work against the lastest
> devel-next tree?
>
> regards,
> dan carpenter
>
