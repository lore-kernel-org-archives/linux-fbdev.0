Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A215FA81
	for <linux-fbdev@vger.kernel.org>; Sun,  6 Sep 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715752; cv=pass; b=HnEASFmnNK6g9uYZrQ22cxCg/zHaEl2dLLBXwTxNKjTSRvXDv36/2lxonFOLwDz+1tZzgBieqQOPYPK42dT/sUtrVvQoMaEv9PoFG2+ilppTGdVi/x4/M7olRgR5zDvd4gA948umXjypMzQhtHZDqmmrr9NwlW3JjtkGh7DY2Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715752; c=relaxed/simple;
	bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCFp7j5iuN3plHOjDh8A4zUuH7ay6P4G8LDgiKdLYPGj9T0PYICoIg9yn08t4ddyd1dXuDWW0kSIXvHKU09pg0+b9afr83y3pApqqn7VOs8UlMWZH+nHBKapVLvx1pr6RNUOW5gM/xKmzwhaTxIl2X/Ylcib6wASF1cEjqG0SRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF8j2/e9; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF8j2/e9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6f9e2f681so30443675ad.3
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Sep 2026 10:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788715750; cv=none;
        d=google.com; s=arc-20260327;
        b=XvxqyjeZNK7RljgQiNgVOx3U36IU/YwfTcFmd141L0/GTyw1ccaMEGWw90Hohd8iaj
         4kMHKc/WRMbpmAxsvNUeEZbyHYxMpJFhbbZkOGhHHy8qgC+icWeYOwZUIq9WbWGItphc
         MRVTmDy4Y2v0s3E+0gVV4Qoftl4kyHXQD3FDrRl9gYpds+OL21mBIxAqRig0vGRt6voN
         dQnBoaGl5Tx4Ri49RdDIAFADR6tnwd7tGW//mBJYgeNiKHdB5KtfuRvu4N5DtnJExFbz
         teEF30FLtOx5Zs43Fl5AXbXKI8uYo+L6dbLbsR03wDQQlb7MY2Um6/IKIVydOOH+WHzu
         JjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
        fh=jeop+Q5rlAlK+vKDIzdKvbKUZQaSSfF/R2KoeAIXM8g=;
        b=d+AMV6eMrDpUmVdsll+8GAWBsz1CgwUlE/G93lFbhcTumY5HNomchp2k4b3E3njQYJ
         9XB5ACb8DWZW23ZHHysyEO35A9V7UiMlVN9WevjHmNeuZtTANkdFZpCy3UNmE+q6jxJ7
         HFnme52WX87E/qKcFaRUL/4ddTAgJ+SiGg5gqfr6x114ThnJrpMfUDbrSU/BzM55oQjg
         9MIxIhzBzDgPaVIm4SC1RkxUmvWaEdkk/miH3kcoJnuRD5vAhjT+wJoc6ou4yd6SaDiJ
         9+v28if3wKbhjfWc8nZg7XznvpvHexFKtcc1N9M/RkgN8nxpjr+80RTl5mrIL4EVXJIa
         JfQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788715750; x=1789320550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
        b=OF8j2/e9XaMRw5ga8VMjNKTjcE7mR8jmZcAz5h3CAi+h5rCxFnYnEfwtjWc3daAtRK
         wWR3rt+PNnSrR1dFm+5ceUKKbPr4kqSvRyCTz/LEFdlh9sh8dDoqIPNAsqZystl9Cnav
         h/mCpA3lAUX61QIRfNqgQASSNlTzGgBGgTW7NJkBEbG7kLNVL7WTiYZVgCutRYCZqfmg
         fon2Fm5XPPuRiy6UXv9I2qR0SiNCt/QmbKjqeCqDDbm/ZwXZP15ige2qp3w9gsZ561Qi
         bZ9IXQ9hJe0u3MpgmjeCLTpgaXSNYVxnC4DC2pc10S1zGMdMJ+4zTlsFdSmNuItXxe5+
         Hjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788715750; x=1789320550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DEiI0XOfcZ/AmMcsore77sSwCupcFULPw2OZjhCwgo=;
        b=HhxcvVMyQOU+mNJFTPL/mSIfCfYgX2DeV4hiy1N2qWzpmdtb651HmzDMgx5Zvtl2XH
         O5sBAcyjsCOlGOjldOk4gVO537E117LyqUA5UsxGvtYDkT2h725FM4sPco6BupI5k1Qp
         m0atQ+MpLwIDWoCAYl3kzk0xnUeFLKJmVIpnbkxI8qogS5q9eZ7yocmL6xlqWOJWBA+k
         qeyogiE1rPM2y8zPlvk3oqO67oZPwLEGRobQ0EmTM9k+qmu8iVnHnZ9mbo+mo4oLrXX0
         mnHA22+ad3BNIYVb3EvAz+NLaKc0fUKCw/OZufxCMjbnzJvInwBSjsGnOwZOxjvq5vh9
         EfSg==
X-Forwarded-Encrypted: i=1; AKwUvBwvCDor5lQxQ2DfOu3oPqjw51QDglNPSimpYvRdz1HYEKnG0gdx2kJ0KI50AaNCaK8PZE6hIWdNXsUbVw==@vger.kernel.org
X-Gm-Message-State: AFuF++lFrd0oeYA5LZ9sUiWN3r6AakJUWfg4fCoHD7f18vuRj0pNzfWV
	Xe5df5xrN4CG02VVHTXEQtQMdNZdo4nDmhpycqRbPUB1ZtEjFGkSqhlVHc/S+yDbpk2R6yaMQxf
	nmMwvQWenT41MWRMNEVypS9mG16j7NOI=
X-Gm-Gg: AYBFou1rbpoNw8ozEXuGt3pyam+gmEUUyxTNgl7gl8iJiiSdv9u4RkPPjAajPNKccmO
	M08vcK5fvt9PdZrLdnGJcGNcV27QfWUFl0ifkxzYdJsmfDvUYabcf5Dabxg1tpgRWCx+ZYgzmUa
	0+g6TgTzgt/+epqfce5Fbgl7Oh4NvHOdUwZHWliMCj9fQtsVMzAw9CWULD/2vzu+UgkBe79071/
	9E5MD5T3xCLwu3NCaK8cB7wEJmmAB6SNsgMXHEyJ36ojc4WJzHT2HIVxoy0m6fo8kktD++YVtGB
	EEu0eEtVo3kjM7NpPBjcVlUL4EfmOzfdWLZD7TiH0QSLGih80W5Yhy0L7nUuhL2PkKZsdgFmQXx
	f1Q==
X-Received: by 2002:a17:902:8a8d:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2db122edd50mr199148445ad.5.1788715750074; Sun, 06 Sep 2026
 10:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260702161828.GB2108533@google.com>
In-Reply-To: <20260702161828.GB2108533@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 6 Sep 2026 20:28:58 +0300
X-Gm-Features: AcwNN1XWisbz2ascChHcLatRKYQPwdXAhH_U7ChBKnQiXROAqpt9L2vnmsacgR4
Message-ID: <CAPVz0n2fRs=q-1dAEt2k1FJpQVK9+PMSY0BSMB7Rs3F2xDyFvw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] mfd: lm3533: convert to OF bindings, improve support
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 2 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 19:18 Lee J=
ones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 17 Jun 2026, Svyatoslav Ryhel wrote:
>
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
> >
> > ---
> > Changes in v2:
> >
> > schema
> > - maximum led sources for leds set to 4
> > - anyOf > oneOf in ALS
> > - improved ALS descriptions
> > - adjusted example
> > drivers
> > - dropped devm convertion of irq and mfd helpers
> > - all als configuration moved into lm3533_als_setup
> > - added regulator/consumer.h
> > - lm3533_bl_setup set before sysfs_create_group in backlight
> > - added check if LVLED is valid
> > - LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLE=
D5
>
> This set looks good to me now.
>
> Let me know when you have all of the Acks and I'll merge it via MFD.
>

Hello Lee! Is there any unresolved blockers for picking this patch set?

> --
> Lee Jones
