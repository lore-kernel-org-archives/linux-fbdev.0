Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793007176;
	b=JSFqtWLC+/k6bwDeA//temx/Jt+QqVuojYR/ySVMCPBpwwLElXw9HkKC8s3EWuummB4t
	 vZ56H9nfwtUYmECa7dc+7p2mEqgVADqhf7EfGgw+jrWML3Jn0mQZaWWrfGfcwywGg0Euv
	 PWvChjt3v2CFm4s+fDZ4Ec0FDsyVmjY3DnCdPb/X+sBw2jIuXR3Vm/yz1pY8zwfWYuT3B
	 cPL0XZjcWcFNS3tsdMAUPk0rPSdfgiyCR5jtjc4UUVFDnrlo5Fn3oIQX8EadvVIWruk7F
	 PWgyvafCI+v3ijB8neL4c0GSFo/FG+xYmQoIHZzhhkK7KoUbV3V3m4xr30ZguoMn7yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Q6uMsTxs9DnFToK/y/1eGhUA0bzycwdopukAlnns2fM=;
	b=nzT/r5l0IvFryUlI0k4Hba/GqGO7KpPicdPvC2up3trJtYpEi9JQWwQ5zZISQpNZj4Qi
	 EW9AuXI+3L0kveKT2P4y2We/dFQi80jEGKSkC3M9494531xKSjRx2AeFceEXYiylgg0gB
	 IdSsLnpTVTy/hHHvgd91BETSio/4mCqA82UNTbv6/XbmTRN9Zzpo8oVE9orWriwnXJKBS
	 Tqi7wvua53Pb5aVAxx0DdfdcGuLfDFKhIyRvMUwSvecRYEeMtYL1cv9y2ngGeCBmx5KnR
	 WwwKdOWezsLYz5g+Dqvf1M1elwOhnk4zxOCBLI/Fw7YSo8/ajPLzUzH1QcbhDehlY9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=axzs74Wg;
	arc=fail smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B36606A325
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 09:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B36606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=axzs74Wg
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6aa9606ddadso1924371eaf.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 02:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007175; cv=none;
        d=google.com; s=arc-20260327;
        b=l6+YBkMXIYhHr1Qz3rNi0DR8+fzxzgsf719x83P7miB27ZUSSgyZzl7f2hw66vsJJO
         wORX9KjcD8JuPsax4Pfv+pd0KyBlalsaGp0q5KaBJZb9jjvyN3FJnPKf3Hlb/EIv9Dxr
         tD1w8VC1pVhrU3JxktM6jFArx0/KiskXq2WtrK91NYU1LW8EOZ9eK11OkFonguNRSlfH
         qZzWtDqZIbtavxlUFKW9BPutoQstjHJGxdozH0QLjJleR12PytN1Lu9mPcil/UyvK63Y
         jF8kbpHi/gm4Fj2BMkRMpjA8U3ePm+CXNz3Q6cI64Tzs8fvbqtvOuofEVPFNNNwJdQR3
         arDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q6uMsTxs9DnFToK/y/1eGhUA0bzycwdopukAlnns2fM=;
        fh=dPXFlnCA0GyfKfwEw02vHQ6C7S6wE7aHXug8vDcfnJ8=;
        b=QXDqZ0/ezIGZ6Ad9igquzEHl+2vc46qh7eKjVb632CmMSm2hf5ht/EZ6+KBh3F+Amh
         oyFQQNefAeqb81vNlzpaHMBeuhV7wvynKp7WSBQWiNd5qPNS+45iJrgUU2vmElP1kLM9
         fPLSlfw0gbYbLqBRjWP3G4uzk4gqLDtf/a2Rte7UdJtGhOvqd0Hcq/RA/1IsPmBBgW7h
         7WW/3hNcMgA1Erix0g2Hzt4op57sCxZieNYwdauq9Y0GfA60ViKItFvhBJcCrxHFWOIr
         gMOVIplFOmLi+GkE+8DEcB81VzVJYoXeOzKU94M3j16JpI+hqahZINaGiCSBj5A/ZUi1
         L7pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793007175; x=1793611975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q6uMsTxs9DnFToK/y/1eGhUA0bzycwdopukAlnns2fM=;
        b=axzs74WgATN7HBSH7xkmswDiDnyz2G9wP+K4kFPOIokR6D/ILNhrhyydPLv+EyrnyF
         MPCM8EAceQ3/wjSyBQP91B7lU3RsCzVaqldJLL1eEEj8dfakXpOsWGXYvTdNxMveKmuR
         PstCf0bPnDFPuJOJHnnbe7UxSd7sgYPSDrky0p477ZIB0AyLEzYq8Gb6WYyfzwz0unes
         We1NDOzGoafdGglp3x96/Rpwr02JAtdc9B0wDHtXnZg1tuHEXWTAyjAnxwEfST6IW44e
         f7ktgVC0n69HNu2nV5fGkEfBku9c7fDUnYXuwq2qwltHEFAUNzAJ8lzBRe68+BY1AvoZ
         Y9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007175; x=1793611975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6uMsTxs9DnFToK/y/1eGhUA0bzycwdopukAlnns2fM=;
        b=rJEE7QYx8GCKr1392nC+4lqGRA03F9FqJMFTrod1KI7+1yVGnAvOsIN7+yWZq/JlxO
         W5m8aaotumOyJXnC6eC9MqyWz5dRiO2VHfMLAk9qxtFT6Xl8UFhn8M6W6hjOA72uO2eW
         OoWy+KY+7oPFhC+Jt40FqcYaMGwYtaoa92ua4S9LPJClh+8KjNfmrgnhdWZE/dhjpnGS
         fRuzVLDp/2/wBGD3IwRT8mFcIeEJqF79thVtd0GDcqIG10+ySfxkyjFpbqT9uKNNQPeW
         r9vmvrMIaWncxDxcdGGrWNyN6Sx4ImtuvDikggbEHz4BtfIVkXLpF8QOcSyRaDdOT6nw
         iZpg==
X-Forwarded-Encrypted: i=1; AKwUvBxR9ibEetMhk5jOBEPiOkkmvZqBXZ2T5VGER4DIKs0TnH0B+O9WjP19VZ8emaBlqTu8OEPczjUNgH5W3w==@vger.kernel.org
X-Gm-Message-State: AFq9FYI1Wf5B7pUdF89EJ7OSYoQlHdBFk+0PM1J1F3TUM9BCw9/52oXo
	5WHP62R6J8RDXZpWRoMvsBljy5knSUqH7/HCZU752IJoIBI6Ln2JH+TfcSnIfkQ3DjbFbqn5os3
	CcuLvS7EVpTsjyvU1wCIGyJUEd12YjV4=
X-Gm-Gg: AYBFou2RR2pBykRVyhRF2C1yaxPReDklpy+Qw7mvteLya+Ipw7xDN8cTJhOakw5q69q
	wsfzJQ5Krt8Q09hQtgCpkjX7d9tO0rRRbe8vVD4vNVmB0odL4JG979BFInbVGTAi3OG8lHxpNMC
	ua4zioCCMYmsAfv3YAPN3yEPZCyvScsv8QbemVaAyiymlt99Qi66ABj8Z11VS1jAY2jZSThvshp
	0UWH8vK4pEUNbCNHNtWpJJY0lyovgMGA7mYBvEQS6wcXvWR1Mcln+GZL/J/VT8zWxjSPEfJJJG2
	gyDSTtNEzKQivTXd6jWx85CYS0R+KnHmY0xESLACmBBKkZcUE7IfY75GLpWTZB6vxeeU60+YO6/
	bl9na7UFu95084pl+l25Bv0WctpBSN/GUbXTQMGOvicMRwHMiXj620TAiwKXQuxpNLQhnmJc=
X-Received: by 2002:a05:6820:1c84:b0:70e:d5d:8712 with SMTP id
 006d021491bc7-70e0d6cd311mr1154315eaf.70.1793007175058; Mon, 26 Oct 2026
 02:32:55 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026081832.60570-1-himanshu.bakshi478@gmail.com> <at8cAMm6psyWsqbe@ashevche-desk.local>
In-Reply-To: <at8cAMm6psyWsqbe@ashevche-desk.local>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 15:02:43 +0530
X-Gm-Features: AclHuK9WK4Yy6vI4OA679g4Ynf2HPB3VI2XldS6LVlec7p2KSdSehO3JF_dOaiM
Message-ID: <CAGLmz9+0DoWZtmLjUq-8X85p+DrCXKazsGtN-QOccK++d+YGrQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Remove unused macro
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com, 
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Oct 26, 2026 at 2:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:

> > removed. After compiling the driver, there are no undefined macro
> > issues.
>
> > Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> > ---
>
> It doesn't say how you tested this, though.

I believe there is no need for test since its a macro deletion and there is
no call for fbtft_init_dbg() which should be apparent from the kernel
and driver being compiled successfully...

Thanks and regards,
Himanshu Bakshi
