Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36EE370D45
	for <linux-fbdev@vger.kernel.org>; Wed,  6 May 2026 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051673; cv=pass; b=TGZpetykuTW3Y1Vu7pmxK5mFisQOW6InsrO4U10erRJFgKieIvaK2srgQdVBC+u/QIH7w8PbNd2gpjrKZNHtaKJ5pF0TeFw08KIH8x26hcY5JARFsfRwZdoDKLp8GdI3xTKtbx0a6sq2caf7PTW2yDUwahEmXfGMO2BMKWLGWRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051673; c=relaxed/simple;
	bh=nrTVzwqcUX1ETTzxzJwbehjLh4y/BraAV+VE4EHDEWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjZZ3R/8xbyrJha71qTIi/msjFdymlaVqvAWlIemOmEfNV+jG++6P9x3QP9qGEh3Yut8shewIZcYLfDdeWSacaGQVNU3TU3kjyJ2649zkFUh8MlXSNq8GjiGdZk4beN0f0FVi5I9aah21smJBe6zFjB8rJJJIA+2mQOmq8StLNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3o5fhKm; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3o5fhKm"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c2cd216c9so5011550d50.3
        for <linux-fbdev@vger.kernel.org>; Wed, 06 May 2026 00:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051671; cv=none;
        d=google.com; s=arc-20240605;
        b=b/FQxQOBihJ+yEda0pW8k8s8oeBNcu90QRKqfqVSBi3FxFbAxg6Dg/ZcDsuwOL7YoW
         C6p1ukYEiDxKEHrTLeE5klOOpjGSwXTFXRw0iu5Y1ZUOdxE2GtrR3vqymYc7iifJWjAD
         qRnPQXBvNo4/8fB/R9j2d7B4gxdYQhFRMoG6xJisA2CuLqYVJRJPBPRKEsdKeIm1/aZC
         dhxyjpONfbxCH3FaWLhVl1ePSRLJEfhNI6Nb6HG2xxLrCEs/Ob/06/b7uoshdt0QbfrL
         sOigrAtzvruha6+VE51yT3sPtdNQ9mqdADo6qqP9sLPLuyn9oiT+xXHBJ7xeAbBtvKaa
         BdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nrTVzwqcUX1ETTzxzJwbehjLh4y/BraAV+VE4EHDEWM=;
        fh=ieQdX1itYapC085SN7Qws9vkG2My0hzOwaD4jRJSTxc=;
        b=P4Hg1DWNo5pi+VJZEqQrOX0rD4yAyzrBcvkj0eIy0YMsNjtEI2XmSCqwrOdMeZKV/H
         5urJuNccNPYtNQkg5ERkNkmmLv3w1BflNMXcSJ5sh8SAchW/ByfQz16AIYS10F8pmufn
         ZCJWFW1d+V60cDTm0JgLaVdWGuaz0spSvr2v6eXdTPSB64mZMXt9w/AUhaO4pwOEwc9e
         DTbwIrY0aVwr3I03vFOHTbWIo5KJa6ByfyvdvTyYEaY0Vg627G35sLcPR1/9lOYAgKeG
         qbgzkKRA/bHIhc9b9/X1rPsloABSVNyb2YYjFeROMY3eAbwO2PFYNTWMWxLTUidC0cwa
         owWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778051671; x=1778656471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrTVzwqcUX1ETTzxzJwbehjLh4y/BraAV+VE4EHDEWM=;
        b=E3o5fhKmkgQOsDQZpJpt4GoCfIMH5CuT86fEhliXRNip/IQ6UW3iUAqryARFRzP2K6
         TdI3J115tqQoIDAm15GjfR1Ye2Lv51wSpdkv+FnJ6/FQCYnO4ocjkD/XY/fGDLEI10gw
         VFktgTsSfPzNkRAc2F9wjFNLd39S4/nR0TteVRREovNr3ISsoymSxxWRumX7HtrsqnWu
         haTJqCJTCFobq28Bjme41t5jaoO8huFxo91Dh1riJ+OkQB0oDhYc89pPLirWxkyEPQsF
         myDK0vmg1TsBUpTtRfdX2KVymU5rv0kCQs/J6QAleJNrk9V+cieJi4aTu1ZUM1xoLmj3
         F/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051671; x=1778656471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nrTVzwqcUX1ETTzxzJwbehjLh4y/BraAV+VE4EHDEWM=;
        b=VgOlAsrs8m2A2yEyj4ViLeZHb827hmTd02vJ44hTTbbzj5ptbYO7wSO/8OJ4K9IQHJ
         uMzgUBYL6NH1+CcYyEC+Xj3rCOQzFkFYXOOvCI3jDtnt55Ztm2fmKv/vAkX4mDQAaSwU
         O3dkCXVPOzHGI6PtFvNx6F8HWZzEoNqayZSGaoNML3KpDm1/gqbR3PxZWeUPuWGLmFi9
         GYqucd3TxPwNuLtnH8ibMj+kUGu2rnTtmotA6ACKk0jc/8xc1vyur35kFJaIelXoU7jg
         eP5B3tmm208CrHUTmiI/6tGSsAkLHeN3us7lMeTQn2+zR7TXP7EZAqxUPUjqSMCefhKq
         5dPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fc4irPB3Uu5VYVMOnCT6uWtgbQM53UYU35epRHHiE3mAMk4wmN4QTM8eEF9oGaxsvLD+1Gr2m/2gClA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LKvC1fLGeivyGimGwpDbqJZdFADYvWAUjY5tHENA/JhaY26F
	n2tWbtE2ZXV4u428QW0v4tnMiqsR35gCzVCIqkUs1ky3AZNm6IDnTGV1TETpf7k6V4gE8mKQWst
	O9SKXXsCmUsk1FnH3sPClw02KmBkRHjo=
X-Gm-Gg: AeBDieuLNMz9IGlwRo+zNPzLDBiF80YqqqeOF1XNmCJr3kS7AZUz+DLyha17JNpzBvg
	0rdDAaJvWdevFZn//jyGR4mXK3A+UU/7Hvi0PDncexzLx2gWovZk7vNYYhh8sLswtSezMVDjRsl
	raEUyIJgKF6Lw6fjzIdiYCCEzugXVnyqKAdSTrhv7q4IbapGZWw3OXHx16CV/WafqjFbXdaGDvn
	Mg50HaXo5yYElFgKCVtWbayLmDsku2NoXsOCL1cj5CKPDNy5V8SlCiQXFVmDyNKsidRcStJnThd
	CFbl226GvV1GkrF2GqWpmVQuvp+qBA==
X-Received: by 2002:a05:690e:590:b0:651:d6a2:f766 with SMTP id
 956f58d0204a3-65c7999cc38mr1970922d50.35.1778051670788; Wed, 06 May 2026
 00:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506035641.5060-1-chaitanya.msabnis@gmail.com> <fcfbdb1a-188a-4ab1-b7cc-b2c430d2cca4@sezginduran.net>
In-Reply-To: <fcfbdb1a-188a-4ab1-b7cc-b2c430d2cca4@sezginduran.net>
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Date: Wed, 6 May 2026 12:44:22 +0530
X-Gm-Features: AVHnY4JS8UipDKQTuKzY_iGmgL_vrVTq2ax3_OE91C3Hg5E2OxDxa1oOzXSXKkE
Message-ID: <CABjkosGtM-bju-gn9QtBfOMKMUsoYFb22noWjELnNi6B_ZBQ3Q@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: add const to g_fbmode array
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 11:57=E2=80=AFAM Ahmet Sezgin Duran ahmet@sezgindura=
n.net wrote:

Did you compile these changes?

Yes, I have verified the changes by compiling the driver with: make
M=3Ddrivers/staging/sm750fb/

The build completed successfully without errors.

Regards,
Chaitanya
