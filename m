Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792842655;
	b=aYc2n9fGFdm7fE/QBwNo/3Z7btiZWJDoFM7OYYFjY6KwxouV94mlNdtOQiTjpSghLusg
	 j+EjYuH4CLgi0xcCyLANeRBjH6EuxB6Y6/8e3OEod7RImAzYioiZW6SNFzf418IlUq/TF
	 BJvUE15zT7ZburLwfQygLvB5UOZMDcqSGCHLkCBJyFRTHQ3/uvd2uS24zfYK+C1Tl3gRN
	 KDJUuQoPt24esxtLSRZCpfp3yT4w8BDZ3XkBC5SRefMo43gjCiAY1Ga5VgXMN+m9z27x/
	 uM2BVra9TeLJAVlD1CCdSSXWpvHqVn4znPi8fk9z/wGrAUP7fMeM38NL9TPWd7sTImg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792842655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5Fk1gBgZ4AUPxIMy56kMymtAhp/DJX3lqyPJTQrRewM=;
	b=2acjZFnrCfjR1MWDAjc1cLSrF/V8zCKvNboMhk1PXZUraU4uIzZaXx77azaaz6X0ZXjy
	 oSFHrjtEG2o3LdzDsdwAPiJpKzo/4I9so1+mvLgpJl2tf43lk5RjNn3xRKPUgRNf/FsJq
	 rtDFnpCDjWNMTEEpkT1SqZ3YhjauyjkrT4TznQ2/P1wvMfzdPeh/EGrXEjw0msqNFsM6o
	 BIFchRJAlQTsI4Ojh9Df7cNn5kl86Q8RPPLSFnfnGLSnugwIbs9NIcS2ebOnmfGJuj2Ns
	 VobQ4qfvgiG1aNLdG//lLetxTuB+AndCijAp5RXOTkDKlUzQUKPAQNFOb149wReY5qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C9KU+x7E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6EF606A31B
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 11:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E6EF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C9KU+x7E
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6f5a0893610so1099831eaf.1
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 04:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792842654; cv=none;
        d=google.com; s=arc-20260327;
        b=ef7Q3drSoxid9djEaEaq5195x8hrZln4x6yIabkncgf1W69lGG7lYOshicSDLaAJsH
         KVeBzdBcsYV1vPD5gYxZ1wVyZOnL4fA0RbVSuESZymQF8ia5N9h/q/owiCkKMZyNKh3I
         Pd7yJD8f4rP6lFU1NYrUeIUNfpu+tW3PsXDP1vtr65hwqqfPO+sNoJZAHjkH/x/PxLNO
         eaLaGKrYaaZpR+I8UlovI2trdEfirpwhGDjoEZ/cDOALhsOWiDzkDesHHYooTaJmJwTT
         iE+fJZnoEPN1RJJT1moRJG5NP3fzvRot5HC2lCJqVx0jdausGv0lYgkZ/dKH5Ylyp6QO
         Ojxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Fk1gBgZ4AUPxIMy56kMymtAhp/DJX3lqyPJTQrRewM=;
        fh=GoqimGn/swnvecPvpxFMwfgS18/Mo7HA/w0Sv7uBWDA=;
        b=q8ERhpNVDtPF/Mr9XGut48r97XwC/DX9OhZdxSx7rucL45LT/rBAs/2hVHq4aCjG9/
         GRMNZZgd4m8soUwRGRzedrA6AyFYEVP9L2FCVYj7WsilQEo7t/XJXaPFZ3VFF6jlIogD
         2iqTRy3M6tgcj+vPZ/uwvfrDA5GHXfV/2+kzP12QCa2CX2/HOg8JXmWiJxSqfBaLffFO
         jLpoD54vhUz3y0vsWeXj2Vsb3lsaSmzOIaY6zja3cwKyDPqtZjof5fQXnUpx/LDOwSWe
         tOfbL83F/glvwmUh5X9ixIWPasd9Oim5GAQi67MU/YUjrwKSW1WYmToQlfYmyV+UzWm0
         6Z+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792842654; x=1793447454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Fk1gBgZ4AUPxIMy56kMymtAhp/DJX3lqyPJTQrRewM=;
        b=C9KU+x7E/r7l4XM0r/IKrahEoW7jsBvONG31JXVMp6hwt9NcuobnMS/wWD3QfWlAxg
         DemGI8DBG4NYVcru5hH2BcgNfjWe2t8DTaUbkDvAKnhsc9SI+Pw+78p9ELpMAPgsXmYw
         FmVCg6AEa7D7K5Jx1XiT29sC/n+ut3/Kn/6Dt2vqmuScceK0xlsLnU2IAvBvfJWDmgTl
         VRdETeFTixNknbM7p0ezihe7a7Kyx94/AC12CYt5Yco0AQrNHATnE9tqiTU7rS2SNrYO
         E1yDgUaLOWgt9WrnT0h7H6mXfjFWjDbbFxH5QyIL8BccfnwcHc9PEPwi+eYGdQCHkMAg
         SdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792842654; x=1793447454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Fk1gBgZ4AUPxIMy56kMymtAhp/DJX3lqyPJTQrRewM=;
        b=brsELvrlPrq4t5DxQpmm76+zCRRitVrcMQKjozmuj0coRb21NrjMx2OU6mMWN3y9QI
         Yn0PVyn75acps5PePotAc6n+j6QPnkie1Ee9uED8LPjMIxRga4qfzWtYPayAucRfNg/e
         PC9H83k5CXzp4qhGYb9hgeAtObBOXeKIwp9TR9zYAahoueObbJdr9bKoIs3SXEFZvYBQ
         Xx+2TeFrO4+3BxZR0UiBFbyg/AiD0s+/YA9ljk+A0v/fbqn7n+9qEFFUjo7RozIPA3f5
         j6moGubBDYpgtIrBmxc+ytMsyxAoNZFJghoSc1xZ3nid7RAfElRW+ya6zM4dHj0ggnhY
         9eFw==
X-Forwarded-Encrypted: i=1; AKwUvByKDwI/A6QI1j6+gsiJZN3I9BkGmLvr2Zz6VXdIfZWLXG/ErzX65P+3wW253DGyZ7smWLZNxGjP4VrTFw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLqZNSYTaD91zP/t1GiiJHgz48ccsC3AgUnVcSCx7VRVt8WHeJt
	jvGmIvtbUr3OAfHlDTNtUYTgpRu7yqOH+DHgCHYcshR6w2xCajva/Rnbk2X6DMLJ4fv6LRHHJA6
	LV1ItSSHFfEfF2iDF3bg68D8FfrHAn+Y=
X-Gm-Gg: AYBFou0U9ALmeKJAoPpZ4oHwT3KjidX5c8nkzBTITCJCrmwzlOHOTTK3sjwR9R6flMT
	nfg/I9BqDjSLKq4gzEJa8jyTZr5H11IcQxuxVqtppme7hxVWaLd7Prlk/ajIkCZuCr70D0diS0R
	EZK5jhJHWrMZ5yXY7y8IPx4KjVNzD+EitGEte9N1onpSsb2OEPE71ml/k16d3AlQ+o3OWW72Vjo
	TXXJBhLHmB2FbaYV7H1OMzZn61QzcBHWPUmpwHKGq/FvqbL2rqPQelGyBrK9hyP8rYD832woq/U
	jZiE4lbusWJBHTFMY5AT5g26YsGu/A8TSWC50OlElq/bh8JLRtW5BMMi76EdudGIzj0ONO2/3HD
	LCc4qPyqUSCTNdA3oI6SdU1O6fB+nlrFhEE1W8IoWXrmUAU5nvXWzE5WH4uDhcWYhBtyA5Wo=
X-Received: by 2002:a05:6820:7041:b0:6ff:6b2f:a11b with SMTP id
 006d021491bc7-70ba0fb21ebmr627518eaf.67.1792842654085; Sat, 24 Oct 2026
 04:50:54 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024073549.29531-1-himanshu.bakshi478@gmail.com> <2026102448-tackle-footnote-9ca0@gregkh>
In-Reply-To: <2026102448-tackle-footnote-9ca0@gregkh>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Sat, 24 Oct 2026 17:20:41 +0530
X-Gm-Features: AclHuK9RPNdG4PwTXd2ZHIWGfUPuk3tIjaYeZzEYcbczOXET7r-HnUoxLVjvyWk
Message-ID: <CAGLmz9+J-s98cT_ZFHF5EU7t=beK8m82fjq20+n5dmncdrMSEQ@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: clean up PLL calculation code
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I found this while reviewing sm750_calc_pll_value() and looking for a
cleaner way to handle the PLL candidate calculation.

I tested the change as follows:

Built the sm750fb driver successfully using make -j2
M=3Ddrivers/staging/sm750fb W=3D1.

Ran a standalone C differential regression test comparing the original
and modified algorithms across 2,010,084 test cases, including
frequency sweeps, boundary values, and randomized requests.

Compared the return values and resulting PLL fields. All tested cases match=
ed.

The differential test uses standalone copies of the original and
modified algorithms rather than executing the function inside the
kernel, so it verifies that the two implementations behave identically
over the tested inputs. I have not tested this on physical SM750
hardware. If by any chance you would like to see the test c file, let
me know.

Thanks and Regards,
Himanshu Bakshi


On Sat, Oct 24, 2026 at 1:32=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Oct 24, 2026 at 01:05:49PM +0530, himanshu bakshi wrote:
> > From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> >
> > Improve the PLL calculation function's documentation and
> > readability.
> >
> > Simplify candidate selection by skipping candidates that do
> > not improve the frequency error, and defer updating the PLL
> > parameters until the best candidate has been selected.
>
> How was this found and tested?
>
> thanks,
>
> greg k-h
