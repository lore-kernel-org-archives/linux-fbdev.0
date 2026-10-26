Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793010002;
	b=u9pyzPrRuUkNvwOeobSX9nrtOJY+OmW+OBT6gm9GOg90rrXwMxejQv7F/yi3zOlOmEux
	 NXarq5VW9omFgKwF/s7aUBmP9PoFVsGLRF6laMn2M/mvHJEH8MIQcAEuDVqEXvRrSKojW
	 Vu6bVzvxyU7ca96Uq9skc4Hk56ikJkHZJy0iCNJH8auwEVv4iDHHboa0SZXiIbILK8Fbm
	 QVgpzDjPP1kXqkdmWY04qW+XIf85Zi0ZkbxTiMMDaKxf4/n1erargYG6EHorEsCi2VOk6
	 yCJHSZS0qzLaJdecO7QW48PWLvj8n3n8iEr3fuB1Cv2zVn4HM0kik5VrzAQ/pg+TYxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fbJOoGCOLIQzP8MPpKpAlj4vz5dI1YiHPW1SWmOARzw=;
	b=1VctppMDll4FeAD7Zk4NfeAWwIr2I/3emiQL2zIbBjc5vypU4KVcXAPbHeofxFqjkVCU
	 WwbOPdiyKqQ/mbbyDo7MuBzmEQ87KIQOOMRWyw3zwos7sQE93mjlJK/IXyF4K1CFSMGMi
	 ecpHrQiW33wRoMWb+8mm/jtHbSnCFlf0Kqcb/TPwBqc6cFV0/R38VaHu7q9hKx2tl0RmX
	 bLy6n2nEE4UkyzRi13EuKVxVnTiu4KCr5RgJK0H6IGOv4k+LlgNjQkhiBIoXbXD8EJPJA
	 czXX3+iYSBq1WFO8gy8N8DV1z4QdYyD8RGvhoyA7AvU/iDYUePB1eyMNQ9t1q6WUVmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V9SApA0h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B7606A31D
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 10:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B98B7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V9SApA0h
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6de2f213b7aso1213319eaf.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 03:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793010001; cv=none;
        d=google.com; s=arc-20260327;
        b=jcJH62G4qBDxFly9eN4SuAMhheZFHlvZ9njoeASRTgWx+/YSqYWxsqv14ThLlkS4dk
         iH6rQUwXlhtOPjaFD3wf50xVLRHD+eYLaSpS6cYYTAq9H5Ej+uZPrnH2lk0qzKaomdgS
         aDzw3KQ8zASpx5QTsN7qSNVdXGZBnr4dgoEt6YA8DjmakNfCCVAuz4CTAumzALtTjiIB
         1r+228I5ZbfiCZWdNKq2ZJDD5xBH0dkyB2HHSuxNfk34hofgJVBjOVDlRis8f8fTWkg9
         E2DqxunjzNUm7Pnt8MVkCK7i6x21h5GvxrSYWFXUJ1DI9BApdLcW5olZApgn1V/nDy5w
         gmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fbJOoGCOLIQzP8MPpKpAlj4vz5dI1YiHPW1SWmOARzw=;
        fh=PV85mXUx5hFD72HoZSC3WI9McrS1wf2mN4jMokSsKuU=;
        b=f+5DiE6NrVvBLOlREPnZdErIZpOICDQM26B3sP6VPEtDp+GoJxrDGb8hm7cgdqWFZQ
         DFH57bG3GTUZA5b2yuLx83G8wnXlbVzu5XS28kO07cgyCS9xDE2jXMStq2d8tgSxYwCO
         Bdj1goLV2oVcqi8SRV9qp6h2/K16eife7pQ8z5eW1+98lRuJWHiGAoaYu9U2EQLDw67W
         egoTqMRwAR7RTcRoTrJDpVPSXhMc6oi+06IW+ngc96YTZ5MmMzq8xqdXKTu6Ojdy9fmB
         ei33S7kaKC+Pe+Fg6dawvdY+/n6S8PqmXQ4B+cl3KCPmsZcZ/FF87xp99k1mh54OE/9j
         dm+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010001; x=1793614801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fbJOoGCOLIQzP8MPpKpAlj4vz5dI1YiHPW1SWmOARzw=;
        b=V9SApA0hxLuGymIPjHbh/F6yBV5wkSC8Fh/HIvW6yAhF1SboP48OLlob8Oyh1qqvdz
         hVJc6UX3LMQGz0fEROv1fGbqBDR4mdx+Mn/7qlJG3iORZn7r2eYymEc1iZBvn/K6ZD08
         lCeOxisCfCBXSk1b0UYdR8Jz9/9rf5lv1vAZMvMQ+jMtc1rvewyxDgRyEgpV/D2/N5/r
         r52OxvKJavCVDorFJPo62f+EjpbgBYO3+iZ0Z08Hppk7meCmmJOMOkrVMP6GxtAB0kPJ
         cUjB1Zor2p1Gb19DUm6MI2et2U1HI6xEZkH8j5+GS4r7It5vH1c5WO3BoUIVSHGxmG+I
         jQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010001; x=1793614801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fbJOoGCOLIQzP8MPpKpAlj4vz5dI1YiHPW1SWmOARzw=;
        b=vCFYSUFWRk9TOWcSY4sEapHyaG1TDYdIXnrrUmiP2dTT/Ur5GeMk915IedSYRmzWz+
         mDE9mVvO/EXCHsDZ/S8jHlmKTJUDIQ8X2hgTDvyI3L87NLG7R9sCXsXoVvh2CKir1wPK
         lDnYcGc17GvD6BTFB3wSLzNQHMhosOwiuaTlFXaFO0kQ4dJlIDM6lHJp5NDTFFCXEVAA
         3ECPJHS4FggPRhPkNuj0qJTPvFN1ZOpExTMG1mPa+dVY0+B6iEGG5PuELi9b1FQfetJf
         u70uuSFDSDeRIzEF/w38yV44f2vbStJVVQdOTntZRCB/4UPQleqIpQfJvwsrPHvZbWCJ
         gKpg==
X-Forwarded-Encrypted: i=1; AKwUvBwkebgEusbHcK9BO1eY4z6I6miicS1y2TpRGOX4m2j2+0EYZH0nOIx40Lh9ZXkMSZD7wAUhQnkyDY00RQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKH8wNgaHdrGlyFzzcVLtNXaJJyoZqw6RExukELmrkV2Dr9DYhj
	kqTFtbaepQxOECHepJgh2AzIx8Ax4FzDPXKK8gRNcbCAquOXBWPzOQnqfFCU/HzEp2/LDPhzqZ+
	SqVZFjdKfSNK8PiRZdsGuJJh4/TvABGw=
X-Gm-Gg: AYBFou1DtOOVPuUm7JGLQ6pqQZxyoigt6F710u+knHv6dQgCRecyjJRpS51COhw+rNF
	C1nTVpEsKxk93B4ZGPWPQaEoimghDUYVhhiw1bUf1Zj2PMIh1W1Pwq344d5kXsyo5wcEI3E3XJf
	oCjSdtERgDclkIFR0D2CykYLkxX0SK901TrifLqXkZyZoAnR1IhdzsqaSV/hWuOUk/w9/OU4c/j
	lvpUzs+XGP0nFSudV2m8/BvYW4ZFtGM98fLE2uLS5txZvjqHgaasZmd9PHiiyS6KAevYLuyIFgG
	paGoyQEDVfaejrrjSMlwu63vpEcN1ev7BsbTDKJHfGe9xyUfI5dEKlqVFDN8bs75+TA9AOMU2fR
	JPG4KUwYDnAEfLboNgIPw8xAgHORCKASEhvLT7FX882EycSaXx65h7jMMaQ5/D8FNN8pjltg=
X-Received: by 2002:a05:6820:1391:b0:6dd:25a3:94dd with SMTP id
 006d021491bc7-70ba0e5707fmr3311431eaf.41.1793010000474; Mon, 26 Oct 2026
 03:20:00 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com> <at8h0ignZd8srvBi@ashevche-desk.local>
In-Reply-To: <at8h0ignZd8srvBi@ashevche-desk.local>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 15:49:49 +0530
X-Gm-Features: AclHuK_R5q_T7vpDB0YLNH0Ux2MdD6xxwDnqBRfktX82gSMvkXVTnMhZtHYzD28
Message-ID: <CAGLmz9+y5fXCf2-XFrFHfqAws5eODP4pSSro96R8vmt_aUQGMg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com, 
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, error27@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> You must learn to provide a changelog!
> What has been changed? Why (whose request was that)?

Hi Andy,

Thanks for clarifying. I have sent the v3 patch and
added what you requested.

Thanks and regards,
Himanshu Bakshi
