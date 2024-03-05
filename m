Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE98F7A
	for <linux-fbdev@vger.kernel.org>; Tue,  5 Mar 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663830; cv=none; b=aZVTTdNRYmtxyfCtShW49V132sqX5GxRehlvkSMGHYKRBescVuUibSO1mpjCIta4juNZfvZQD0sYIJVfX0EZBtO7TB2Ytp6AdIH3dYlw21/NUG1mcEtNMzwSwJWxvdNrXhXDq/rN/9I9UD9binpWrD73+k0oUxwqbEZ+AQaVDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663830; c=relaxed/simple;
	bh=kcInFMDuwGJ0Axr0QM+HodbDvTjHxk7/GQsBaDqghoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsFB13NSkDYRfCIv7tUNU7DsvJ914jvY/yn3ZonK4ErejwLQWQRTI2xoRPmSohtKB2Q83xutItZ7Xfg9MXtgbsJ/PjgZu90+Z9iY+JfgMmtfnfrQsqYTQoj95QpnC+8ybbzMdQQjlF1PbTXHlkrTH1NqLjpZ++Do/cDF90ExggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpB3hvRy; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpB3hvRy"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6087396e405so629927b3.0
        for <linux-fbdev@vger.kernel.org>; Tue, 05 Mar 2024 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709663826; x=1710268626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoNrumIdDmxRFKTd8oqeNhVL7nHIUTBgQcYMEPSY5hU=;
        b=vpB3hvRyUyca9vy0xhEGaSET96qY0lWucndTm8Ry+UwlMqvJDBp6MEZ2wrH0Ti0EQC
         7mgLOe9f81pWuWByvLQrB6GE2s8CKvjvLFc/EwTVSrspe43jnmlsOT/5reg7pGNlxqWN
         pKdMmbdMZDOXW+aSfgznkhwz1+Fbb6/PYu6xH90mMgXa4/5mGpvMQGuQZcLP///fuSrR
         x7cR26/M04D60DiaGkBc7nt3kZduUn1YJTH+UEccsf+cs0dm2mNvUCBkPC5fmADJuGaF
         XZJwbpGs+KhbqXRTswwXDl8jsgQEX6f4Nl7HtdhtjngtIvZU4FmWbZrNMzfH1GGui1ax
         BACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709663826; x=1710268626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoNrumIdDmxRFKTd8oqeNhVL7nHIUTBgQcYMEPSY5hU=;
        b=CeyiQMjQBNpCaYBIjfm8Y6mVrN13rNEPhcNhfZvn3+8u3MPkpKD4M1+i+VWEb9Iwhd
         CsTRtZmVRMLJlbyVnhAp55vsaADLM6JJq7MGZaNKxKuydqNigx0PlycliTXL1zrTP/io
         BMqQ1jOxxyHlR5YmcGebak40tyIyM/5L94WnlonCGnsA6mx3gTGPQLw14rQKRYpZlYaL
         5NExVuLQjPKnRvHTNi52PBHXS+9AcoviHYXuZrUuG+IwKyYhR4rqav3qyHzPxfcFovXz
         lMHAWSk72V5L66CCiesQiGfNQwSWiA3r3mGrFeMynEsSXxNyXkpeACvtc9iv8LOtaGyt
         zomA==
X-Forwarded-Encrypted: i=1; AJvYcCX/kQjFDRtl0PM9WZxXyxHvHB16hKMqbV3gPamt4crvwVPeNCX279zyCQwIm+RzBeqsZb5xNOAO9c4swPZOKRBZaxToX3HNxISUW14=
X-Gm-Message-State: AOJu0YzL7GziY0L0fkT8K+rbUS37+onF7BLkVO1DblvoiQiJCqmNalbL
	SyjMxTimzzloJ9hZ2YaqAYk/hDvxdMBnEoyLnawKmHiqVy3dWeJp4vNscCFZX8BzMU7vZw1DfgL
	HY1sWV+YgH8it4l71P6FXNrE58O2Tk1y0JZLA
X-Google-Smtp-Source: AGHT+IEoZFcKgWl/szXzeyOtASBiJA8GR+9pZvgd3lMN7BXMAj+p5AQ3HQCYYWPBUm119ytYheFglLY62BfeRkzUV08=
X-Received: by 2002:a25:870f:0:b0:dcf:9aeb:73af with SMTP id
 a15-20020a25870f000000b00dcf9aeb73afmr2705895ybl.2.1709663826235; Tue, 05 Mar
 2024 10:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-class_cleanup-drm-v1-0-94f82740525a@marliere.net>
 <20240305-class_cleanup-drm-v1-4-94f82740525a@marliere.net>
 <CABdmKX0VGyBdTo8gzEocyz2HFcqEtu_31PYVjWzioBdCbnXW6w@mail.gmail.com> <gdkioaqffaoiocsybn22qwfpkgz6cujy5oklrdicgdcbatlsan@v7qjtak5jacn>
In-Reply-To: <gdkioaqffaoiocsybn22qwfpkgz6cujy5oklrdicgdcbatlsan@v7qjtak5jacn>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 5 Mar 2024 10:36:54 -0800
Message-ID: <CABdmKX0PKer3PF49ypH-8XBMT8rsm3xi3ia1iJB7DVHfFS5fxQ@mail.gmail.com>
Subject: Re: [PATCH RESEND drm-misc 4/4] dma-buf: heaps: make dma_heap_class constant
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:02=E2=80=AFAM Ricardo B. Marliere
<ricardo@marliere.net> wrote:
>
> On  5 Mar 09:07, T.J. Mercier wrote:
> >
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> >
> > Is this really a resend? I don't see anything on lore and I can't
> > recall seeing this patch in my inbox before.
>
> Hi T.J. thanks for reviewing!
>
> I'm sorry about that, I sent the series only to Greg before but I
> thought it had Cc'ed the lists as well. Then I realized it was sent
> publicly only once. Double mistake :(
>
> Best regards,
> -       Ricardo.

Cheers, glad I don't have to try to rework my email filters. :)
