Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0BA5FB9E
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421233; cv=none; b=rohzk1JYY6NwQztuHqfEd3OYv4gBXzqKnTPs5+bM8VU8w0KC8/XvgL4jwyj6SJfXUe9+O1z5yp80F7ZRM0+8RfScxqzl6ViPFEKQby9LE4WPHGp6q/IL6madmC2nAarAaoUtil1C6+o341PuAmv2qHmtiyrZ5XYHP7LWZvE0qmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421233; c=relaxed/simple;
	bh=Cr049JDQLVE6h9YwU+hPc42YZw3O5KaA0156euo/6HU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jr2NHT0RC5ELqE7cL5RcY0G+wM3WNvfhk2fGK3ZNjzbRunfSQ7eHweVE7/xU5vlFDshkTEWZ61aeR47OhlyM50K1bOIHQZVCPQeLq/DMTQ4twAsiZzN4HOpm6AwBWatAvleJWE6nAl9tracUqYMULbSysElrxGsJzCQraYgH9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFROOUWE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFROOUWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cr049JDQLVE6h9YwU+hPc42YZw3O5KaA0156euo/6HU=;
	b=jFROOUWEIOprRmqYt/pSA6T7eCfWQS5o4cI0FsSPIaXSBwASyBHxH+K1WioXBsTU7Uz6Ec
	db8TZVHRLXmdD9O4zW2+QJB4uMNgWHymwqxGjOWVM5ikY3pZ4s+I98gbvvPqoFiSDMR00f
	xVy1bxReVGha2jsdDnL5yPFatJKn1us=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-BlSz_jXLOvegDpxP9UBtEg-1; Tue, 20 Feb 2024 04:27:09 -0500
X-MC-Unique: BlSz_jXLOvegDpxP9UBtEg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d24b0b52a3so2230701fa.1
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 01:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421228; x=1709026028;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr049JDQLVE6h9YwU+hPc42YZw3O5KaA0156euo/6HU=;
        b=GrFTIj1yHwX5Z7/4LHgSsJrhWRxmEU80Sy2nW7s/VERH1A8lPXWzh/8nNVgG+UnJHp
         kcnO+CyOM9b92Vc6OCNsXM0OOXSbv5RJtgMjv/fl3uQnActxgza+y+aJaFFJjdt3t6Pu
         dXJ1+jfI3odqSjHGuLMNBUa764fhHzuYPCOpU6QRQPOdlPMSPx+Wmgwo85IAzdJjk6GW
         Q5UC4VvYNcQGMyTYB8ZXqPu26bbQPXGAHr/D3oPoYRbBGUZ5U3niTbdIzvRpimzn5MPY
         4zMEs+enUwKlHOUhzmDexHC7lKvDUgmcwfGTqV+/IDEO/P0bqbSOHMM6Yk1+u/38Ffsa
         CiIw==
X-Forwarded-Encrypted: i=1; AJvYcCVuUzwQvQzCTcI+XBjFhNuQQqbETuC5et+rD2i+HYlMhZXZSSG+kxANyhwQYiTjJSbd3aAqsUmQfJFZUYf2o571ud2AI6HzXbOaLwA=
X-Gm-Message-State: AOJu0Yw77zxI9/J/MVmPVmkzFZT5l7bFORduUmtqTVEVghzDMFHRRsfI
	63S4HzEwJV2clUsVP15j9Ww6FRkvVa/MvW8APFsXdifL8eWVQ+2ewn9bWnWXQihV71UaGebp4eT
	cnVGyXtJcfANI0nvGbxNmcqClC4B+Zd+jq2pOW0aRwuB2HHWQXR7IdIRDSF5J
X-Received: by 2002:a2e:8895:0:b0:2d2:3707:485c with SMTP id k21-20020a2e8895000000b002d23707485cmr4468704lji.20.1708421227878;
        Tue, 20 Feb 2024 01:27:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIOUqTz15wX4tpCLDU3x6oh41ZPQVlb/WZWHFmGcfp/tIINmvltfgmSrW/DyUZvNLfveew0g==
X-Received: by 2002:a2e:8895:0:b0:2d2:3707:485c with SMTP id k21-20020a2e8895000000b002d23707485cmr4468689lji.20.1708421227590;
        Tue, 20 Feb 2024 01:27:07 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b0033b198efbedsm12732585wrw.15.2024.02.20.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:07 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 06/10] backlight/pwm-backlight: Remove struct
 backlight_ops.check_fb
In-Reply-To: <20240212162645.5661-7-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-7-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:27:06 +0100
Message-ID: <87wmqziiz9.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The internal check_fb callback from struct pwm_bl_data is never
> implemented. thus the driver's implementation of check_fb always
> returns true, which is the backlight core's default if no
> implementation has been set. So remove the code from the driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

