Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D636404E
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Aug 2026 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665050; cv=pass; b=rnl3jPt/38SqJ+dMpyf3NNS94mYBbSaqiw+jyAcqP3JufZvU5WV6o4c9I8SZ8o58jxIczcbfxoFR/uKkgNB+aIYkMnVMXdEuIJePme779qcbpVbacpbZv10f1/ZW+TGD+I7BVa4QUmwglQ29+JEoaCOpNrEYH1PR632a3XJ4RwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665050; c=relaxed/simple;
	bh=T/dfQBLHu5s8TsHAIwVzyPX7PzgkH5dDnFw2MKqwf0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sl9Bt/Q3ut+3Y2zLYxXa2EzqdynkiUB24USWptcvBbY/TXxls9Wi8xSYC+MP5d0RvUNiaktt4ZmSQuTHakoKtW1aIAe3gbO4LBrJUr1b+dGVyuKMHY295jfRmYTm1LIO5uPrx1Ed7FW5QY+4jQi6m1E71UcYa93TrhRmtQVq4FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHwwSk2y; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHwwSk2y"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so628938a12.2
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Aug 2026 16:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786665047; cv=none;
        d=google.com; s=arc-20260327;
        b=ZVj+5C9iNpJxOdlJVBTM9pSD21CpaviDqo2ktN44xRjS/TDoohfo+I0Z6vxQJ4shpz
         GIh9515ujXo6sdzCnh5/3d031DuTneXNixSwpI8Xpl0sVy2BdBOQUhTk0VBmLJOlruOT
         jwS/rZ7/e2fQttfgyd291NrobyANVAVSxoJGA6/fvP4yblDOX3DjVQVgb1t3g/zfFVur
         nUOtz+yTAOqlsZqpJqjsFu72DsTysyH6o3hl0HLw16podgA4O/py/3ozP8ksQ1LpexZa
         6oyC3iAni0bBKvbtUpdgMxefysiqzZCfgxd7pMus8n7leOfKPZ2TMQ4bWt1+QzmxkC6Y
         KjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T/dfQBLHu5s8TsHAIwVzyPX7PzgkH5dDnFw2MKqwf0g=;
        fh=GKn5JI1EoABBAlO9OIgKdNoMLbMGNDuvUzIIKsezvZI=;
        b=lziLnlMCXjB++CglG6uQT7VsTrCqWktDLL2m0OrHJQGfkepb47CxRtC7pP30ibTNfI
         MfL3rNEvApz11h+u9h1AWVy3b3/OJkTWDDLCUkSRvyruqDeqwTmZElK/IN4XcLtrdZPc
         mvr26TaJfCbLjE+JiyhHfBMpSIPJzuN6n4w4UfRoo7MZuSiShXrGdQ5+XBtaAGvjRWJp
         +FzLuLKUGFlXhGpB9//8ifhKqwyvuMWILpXskBEeencqrCKpzYmGjetx3czzM7Yh12Rp
         qQtAiUB5zd7XDF2x8lhVDEAC5ESS5QEVeX9Zjlt5PH/ED6OtCYXrPKllI1Ue4p+/CICO
         ol5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786665047; x=1787269847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T/dfQBLHu5s8TsHAIwVzyPX7PzgkH5dDnFw2MKqwf0g=;
        b=UHwwSk2yJD0iZQ4o/5JsmmYt6i/+LdGM1X5ymPM7+4cmg3oh6Ka0CjwaxxouEicWeg
         XaD6VGnj7l+CMzm6sBiVXsMCq+D3z9N9gGvBBNQMxiuZdfenA0BGiw86ir57xvSt+zTc
         Fcdz4q7eClGtKLF+hmFu/9V4RM12Sd4ObsnWQss6DtqgytCYLqRD51wkvr890fg5FOci
         UdPrni6lsE4fDDnqtT3VACWLNMAviuC5G1Bn3OAMZflKzk0GWPZ7mzmGy3ZutLwu8CMV
         4O6Dp4TzMkGx66vQ81AM1r5psvm8/2hIVhoGX9mthWeF8cB6Z0p6SwLLgk+pMx3rOkWp
         P7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786665047; x=1787269847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/dfQBLHu5s8TsHAIwVzyPX7PzgkH5dDnFw2MKqwf0g=;
        b=iHBrhq5I5qCLBdSxXRTEHitUth2wl2pSG3oeroSjVVJTBs4kr6RccFEfCSOhwXcZ02
         Kpz2oZcSTJVYLT0RTj301xSirobPPu0Do0j+4/pBmI4jHJPVXDlb5C60hJGBdzYUY1CD
         w3tr3I5UtwBrrQi0UJDk2r7FkQvaSOTJFwzpkDBm2uq2FuNKzORhyTyLL/flnbq0Jfp3
         9o9bZYfwZVabK2ckcPEMKTWtcQ7viWUCFhDCexU9TTF/47k3bWUiHrsstcaGXq9Haru0
         meUn0iZsPpjuGV68dcgBT8QMYgnZHLwFVSgmS2LI+jtqEww3FO04BpOyFdpTRqoSxmGx
         gW9w==
X-Forwarded-Encrypted: i=1; AHgh+Rqft2NH9PpH9npX6w/njjo2AgnaWfS83IrIT0g+1ZKMeaAsfTRtWs9cw+jzc7Ed2iMm9yxJ9HySsGCTHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDAvlnvSm4mevENHXovzDg9w3Zrd1zPg1mhoLUsyD9xF1x/oC2
	VEoXJzduSfRAm2gAWGnx0qVrVB8qJ/IMPhuqym5NlUAQGErmelkBgLz883uGwarKfjwPOURa2A5
	9GZLb+yH58PLw18B+1/LvdCLL3GEFmvg=
X-Gm-Gg: AR+sD11mkpUOBfjcr6RFHwq4fh8uVGFjz53Q0sjJhsKq2guqIWpv/O0Op7+PGlS4dQS
	cZ/Nhns7H00pXp6ldry4EX1lZ5QYn53uDrqsAztYpm7Km/g8sIHQzkNlCk61WPGAxXwtaLblE2p
	St0OPJifVOp300NKSLyb92t0LsmIiJqzUE/iaAkWWRJs74CbJMGaZozo1FI4S1d0fQAzWYZJcxX
	dqDR3cQzHSmWlGzih8I1YGcOAxJ38Q0/+KguOfN0u2gwlrW9GOd2xvg47VNI3DH+QFf+E/H4NeG
	0gD50uV4wMSNDjnS75SF4he+1WoMyWZFDki0JE5DQyVr
X-Received: by 2002:a05:6402:504a:b0:698:ad4b:abf4 with SMTP id
 4fb4d7f45d1cf-6a38a8d7c48mr896349a12.3.1786665046571; Thu, 13 Aug 2026
 16:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat> <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat> <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
 <20260813-ethereal-sawfish-of-downpour-c23da9@houat>
In-Reply-To: <20260813-ethereal-sawfish-of-downpour-c23da9@houat>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Fri, 14 Aug 2026 01:50:34 +0200
X-Gm-Features: AUfX_myW-QMGZXXJ8a5tVXZ3ZTxXNko9mUPevusA5ZZV81bVlEs6TTsn0To5954
Message-ID: <CAEUXW=GE1atEpG3=SHZhZR4cAXvyMBp-K2n967MVY0YS9AwcWA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're right, on essentially all of it, and I owe you a clearer account
than I gave.

The 3.4s I put up was our 4.19 product kernel: not an SPL/Falcon build,
and not one that has ever been optimized for boot time. I should have
said which system it was instead of holding it up as if it were the
floor. "Suboptimal" is fair.

Reaching for an initramfs purely to paint a splash early isn't free on
my side either: it pushes the start of the actual application out a
little, so it's a trade rather than a clean win. But that's a detail,
not a rebuttal.

The case I actually care about is simpler than the one I was making. As
someone building products on top of the kernel, I reach for the simplest
thing that works, and the kernel already draws a boot logo =E2=80=94 so tha=
t is
what I used, the built-in CLUT224 image, from day one. What pushed me
past it was not speed: it was one kernel image feeding four panel
variants (two sizes, two orientations), where a single compiled-in logo
no longer fits. Describing the logo per board rather than per build is
the whole of it.

I'm well aware that "convenient for the product engineer" and "worth
carrying in the kernel forever" are different questions, and that the
second one is yours and Helge's to answer, not mine. If the verdict is
that this belongs in userspace or the bootloader, I'll take it =E2=80=94 I =
would
just rather have it decided than keep guessing downstream.

Thanks for taking the time to push back. It was the useful kind.

Max
