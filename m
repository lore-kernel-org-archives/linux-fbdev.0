Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591D1F4186
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Mar 2025 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948098; cv=none; b=Hc3pNhnZro1+nt+Ey85HHmFbDLP3olx3y8R/zjd3amsOBVn6Ja7c56gEBY7bRT/zHqMS9d80Ul3cr297wmgFoMw+Dwxq50HpCpejhNcasJNYHGr6InVnb4yB8c04RBWjezaYdqgACWdwm0sbbGZ/P49ahiFs6LeivxszShAlIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948098; c=relaxed/simple;
	bh=7lhUJ6eiiWP9IJ/FYhzjbXh+LAJRJWyTLSUXs2Uq9+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgpR2VibCnXYRI678X827BktMxsJGspsc6jiiprQait1E/1G4dqA/aOqGkZumYuSAjq2C4PpJzMFq/qIT2TDMFpfJJ+vR9GF6wmehgP1Stem8S4AJROwQLatKezfmBDYCQ9PC11t+PDm5oAzfgFm6WSjtlNrXclP7F3BnH8J2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jq0KWvbC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jq0KWvbC"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so2120615e87.1
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Mar 2025 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948093; x=1742552893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lhUJ6eiiWP9IJ/FYhzjbXh+LAJRJWyTLSUXs2Uq9+Y=;
        b=Jq0KWvbC+RGapBxE/79RV0BIeD9VvGdw1Fpe1TB3FQiE3Mx7M1ug74I43skmk/ysed
         pW0eyKCVeuPLLFbAr8/7rZaVq+ypvWIqqp98ONbAm/K0er06k802QP0sKmwApc01jN5E
         LJkRPCM7GjMxbAZVdkkbB+WFpnQ3yeovdkzSGgBhRM8hxbnIqo7S1fIfuHXiO9Srwm6f
         0krXnLDsipucb1cr4hOpq8EflJ5+JkQWavCGVohox/GL31nKFJGEb3tY1JskSboySuXw
         evvwW11mE8FMNJVAwglnLWQuelsD1w2tLYtm1nHAHAZQlQ3gbq3yJ1khhhuBRD+qlb/f
         Bh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948093; x=1742552893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lhUJ6eiiWP9IJ/FYhzjbXh+LAJRJWyTLSUXs2Uq9+Y=;
        b=ouzXGd1yv4VI8vUGtRcRc/KBhEfT4QkaWXghCpBfYYQvy7NQPnM5bzt50y33ha+3UD
         RsGfJgMq/VkIRkdkReQDbGTzQFfJRNjf1kk6OSTFNFQ+IhaAO+AnfuwwvRbiF0IdcXpD
         ES7eQuLl8twevvzgS8eyG/Mpgv41D9PDYmdHNeHBoR9vw+mZGLhipuhpxhUAlMyB8ntb
         5VzL86pYIuenOoFNUIoRdlO8bsI+OmoerXtOLJp1Kdiy+JSTa/vFfw9GI/vPjtxnCckJ
         nHIVoIUJjncKfFf4O6BxuLuPmSPBdozjnnRHVSE96978zNRlHiGzCnDVIlX2fDCCOPw7
         c1fA==
X-Forwarded-Encrypted: i=1; AJvYcCV5YQjREVQ3P8PqQuaR+wI6oq6gUzFRTAnr0I8iexT6/EpBLF3FHHaacdu0CCbNKBmaWk8EncY5y9k50g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8PGMvLiAqpa/0PGSELlBtNbAryYheFpX+5DENR6LQ5wFFGdy
	3ZoQo0AEE8jv9JUL7/iJC5nGP4pKVcJsZDTgnR4zqLTu+n1PtGMH1CfyU+EAeypM8fdMrdL/eG3
	DI1m6t/O+Vm8j9ION4QMf8exFj6wqFlgZmm0atw==
X-Gm-Gg: ASbGncvao15osxC5gh29mJ2QcrZWPpdlzanjWhNRIwF9xbzamPxO//MqKOpS3IHktZ9
	vUUuRTaiO/9wHqnZEUHlDm+6iPo0AXXhXQ4T2nOadUaQ9Z9Z8MCvCSjn8xcn+fhb/AaNFcClhVV
	ZIrrO8XGvhR3rnUhGkxBiv6GY=
X-Google-Smtp-Source: AGHT+IEn/Zc2evX7ABWKYXK/Rs9IfMZdPR9tSjfOKy1a8kRLZcgdXcqx09hfLow4+l9JiJIqttYJQGRGb5b/H78iKJ8=
X-Received: by 2002:a05:6512:3087:b0:549:7330:6a5a with SMTP id
 2adb3069b0e04-549c3913d63mr621103e87.23.1741948093287; Fri, 14 Mar 2025
 03:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309193612.251929-1-linux@treblig.org> <20250309193612.251929-5-linux@treblig.org>
In-Reply-To: <20250309193612.251929-5-linux@treblig.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:28:02 +0100
X-Gm-Features: AQ5f1Jo6nSq2AFqXUDepXvu8J8Xduf-drgRoP8FzPPUsiMaA2xVOQZlsv65trtc
Message-ID: <CACRpkdY2oZtu4vtTwHRMFxaoYWu3B5bfPN==thz=BT2F6BHQQw@mail.gmail.com>
Subject: Re: [PATCH 4/9] mfd: pcF50633-gpio: Remove
To: linux@treblig.org
Cc: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, alexandre.belloni@bootlin.com, 
	danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de, brgl@bgdev.pl, 
	tsbogend@alpha.franken.de, linux-mips@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 8:36=E2=80=AFPM <linux@treblig.org> wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
>
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
