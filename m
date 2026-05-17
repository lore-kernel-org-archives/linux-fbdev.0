Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E62D8DC3
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779012678; cv=pass; b=B/bLx2ZPaYpbx7fZIMyIaGlNOOAVLW2PFaquxRwOJ767x7Sp3pRo709UrQWGTrnVH65GjglEzyoZ4lr1e7MBDZkN3SAjeJLSNYmreKsW/KxqFpiB+lRz/X4vfC0KgYqcs83WBV2850mfe/PJBp7gzA5FKMpjlipzkJayUVnyUmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779012678; c=relaxed/simple;
	bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfrkgFoCEQMvURff+J7lKXoH7zUcYd4CAsmW9KeJIcJpSQHjcJvjNTgvSlEXac4jz6waNoLRU/6GGw4c6UIwlMlhnUgt9QHfTKQPRIXPUjdxuiNVookTSHG328KtmlieLaIuRh6CNwbtkR2SQB9lpUiEVp4msDaYOzeliSsgEK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rciXCJPe; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rciXCJPe"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30246cfd41aso2956935eec.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 03:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779012676; cv=none;
        d=google.com; s=arc-20240605;
        b=QwnQQJOhjkh6wy0QD2y2P7yc2mGxpIU8rg9u1ayCRbvZyvAPIXdvdSQTcCqfcdFig4
         uMvK5OgimFpH2g52vN/8N5uAanT3Z0grv253FD6Se5ZmRWxesNAq/g7SPSIRhfyE1p/d
         qbfKtivJcPbolW3jdOSTTY13f23DZW8896/YavIM7fqNIs20mSD5sJO2Sr++8Do/KPpw
         1VZo0Qeq1ylRYxpmS3hMjvHRKRbfO0frMEKsusc/ZzyEftgbxzxlsTm1Tu9A58bds3h/
         trIg48TG5VhQ5MZri9EBZ8cCqNwwvyVYHh5d4mXb8LgaNso+KDS5xntikoQUE+N4M/sl
         u9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
        fh=upH5yxMMvgAho5fVz6LQvQBoCcjO08ZV0IxVyWj9W80=;
        b=jKfDiy0gaHZfC8DX49cPPXs1xwbIT0mC37vwzeLPyfQqPeiQLZ8I35tvAxBnHcGVlJ
         X2Wdzik+c+2ueA/nE4qyDDeaDYot/iV2NitglSxa/mOOuYD1TKv/+tYS6IZ+QMxjvtKg
         CnhaT2bUkd+sKJtS/cIFXS+ESmBNpX0u9iTbVqkeBPwQHcYKD5wbgl7/GBsWEUvQ9gcf
         FsepolUImUiq1hRiaLavb/YjDx0VypwL0s9lu39VBPjwKOxHIYzqnwgJxEfw9kbRyPdk
         TQdUtpac75vNYVeswi/rLbsW9AoaDrRKpYy4b9zGwIj5CPAsW+0UYm4LabT6+yAdBGsZ
         1Iuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779012676; x=1779617476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
        b=rciXCJPeT566uKV/w+At0X8Rs0RZV/FR/rji3r7v5LvvlzTyLylSU/Xzt91AF8VNNW
         XN8A0EauYbrgo4watG8Yts5hYBUsa709meo1B9CmObIghjF8H+BXZwjQt+yx2jMyDijH
         2iwsLse01gO9RFaghvIQuT7SbEbt2SVzdL7E+wFMBA3OoPrhnAENZnH/VClpeWB4dxyk
         oM3zMzSfboDWz8Vi28CYGvdqVRP3qZOWO5TjTgdfXKX1oNqoFXrB/XNvEegSWLQ3WnhM
         tEgJK2s49ifJyLvNL2YCaFkq1OK7DDMjfXTPd1Q5PGC2tKUQv7RQv04N1Qz/BWVn3U/+
         5DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779012676; x=1779617476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ifauxA5VPfHKLiYlXWLHFvyPEzmbAuAokN126eppTSk=;
        b=i4HZr2rqUSjIqwvGauU9jaOeT5aijuyHmqX8ptG2YwhNfFbxJYtz4bQNWubCXxidXC
         xtt42tCZMIRWRmHJ9iVr4kXfU4DHyUDS7Psgxp8j/komXrwvGVdi7MaMuyOFP9fvhO7n
         FeB5zYy1/kt8jF8a9NSOu124CTSpui1V0TflXzpWyX08a6lKZspdr8JrAokW7hxHyqzj
         8hoyB4srNHM5Ie9UlBXW+W5apCo6GFhm+oxrHhve6Zo/ElTJPVdHzgyIVfjGWdv252yJ
         gcMt0U8fJ2TTIAaR8DjoYFS55wxgbpSClAySs0YS7BskWYlsIWo6TB8Cus/fOpaz2GCY
         muYA==
X-Forwarded-Encrypted: i=1; AFNElJ8/LOwjlx+xYvG6F5+eO+0mZvjKvDqw2oQxuoq6/ge2gCZNRAMovCpCpo5CO6n63oLfwgbNjUvgFvraQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZEyJ6mw59hsiyVlkhjj83gYYaylv3f2GoSkni46jp3xx4r36h
	03+neXAH0dThWPLcorBUyhnIjAk/vnKFmOwpTmRll4Y0lNPpMFJmLg99CbyvGIxMgCvruDeYZJh
	T/vpuk1pWwIaA5DGuTHxdg27L/BFpu3Y=
X-Gm-Gg: Acq92OGSHkETJP07FLtc2aBMRCqTHzmFLa7Sbn4x+J8oC5PvJOIxZWlwl0gVBPUjaVo
	VfZNrKe2K6F16ezr02b17sLg8V/ZrfZbv/diuNOSujTz+PebSAKAgixDmo17we9BU8U7dVLIrly
	AHodhtRtnw3HKYGri57bhU+Yod33CDcOx9yb6b1rv0vmQjKvk4MNBEd496w3HC+0Ky3GLEIblC1
	5inZ5SSTxi/FR1DkwJJmxjx/r7OjVAwfNHZ9sZKyBpCwg8AIvCo+Uo3CcJLnYXIBuMTMHBcIIWP
	/t4zWx70
X-Received: by 2002:a05:7301:3d12:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-3039818a65bmr4929254eec.2.1779012676435; Sun, 17 May 2026
 03:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <20260517074306.30937-3-clamor95@gmail.com>
 <agl0Z_EGzX8X4No4@ashevche-desk.local>
In-Reply-To: <agl0Z_EGzX8X4No4@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 13:11:05 +0300
X-Gm-Features: AVHnY4L0_43-8RfJ6hM5f4ALu2Syvstfg64dnmlFGgfmiwaNMhHznD8dW2kFuMQ
Message-ID: <CAPVz0n2D7q5kEECPr+bo=W=5OU=w4eni-FccdMEUMupkzHhvLw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] mfd: lm3533: Convert to use OF bindings
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 10:5=
5 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, May 17, 2026 at 10:43:02AM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> > Additionally, optimize functions used only by platform data.
>
> This is a mixture of at least (!) three patches:

Maybe you can make a list of how to split it then. I have tried to
make it complete and remain readable. I am open to your suggestions.

> - devm conversion

This will be dropped.

> - the change of some constants

If you mean LM3533_ALS_RESISTOR_MIN and LM3533_ALS_RESISTOR_MAX they
are used explicitly in r_select value. Previously it was passed via
pdata as register value and now it is obtained from the device tree as
resistance in Ohms and register value is actually calculated.
Naturally ALS_RESISTOR boundaries changed.

> - the rest
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
