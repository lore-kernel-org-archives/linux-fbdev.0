Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4C5B5A1
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526280; cv=none; b=OgNRoANvWixh5OVYihjlEeqJym4RRUVNLcmI3jkps9ZiU1YZe5JnFjljsAhR5ba8X0TbSvLQ1X6x0QgeWTlJH3S1ItElP5RJhidJHUOIsD6F2xQJsAkhOK5VUlpmwASV0QCKWwXxGwBaSvTrLqNAmWiVetML3RKFoprvk0Q05Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526280; c=relaxed/simple;
	bh=aFnf7+oR6FCrLIfDXFDm0Eq1vVJaIzTXma1qhxHzqLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QKU8FkDQ6uK18pMOt3xd1aSYxpxFxRzFO+7v9ISMpcQdKXeRNBc2E988VVDNWmlTkN2BcvDanBu0d5bKzPhs3wwXc1uDPerI5JkDqcfP36SOWbB4tZX/BzAvzOt44ngyT3T/wp4Ikeqh1w3D4YJ6KLy7xevz3xkQhv3N7NWsPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmTD+OEc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmTD+OEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706526277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUxFR3bcXHTta+1PBg8XyG/gXzeG2AKh0T4pCbNWzhk=;
	b=bmTD+OEcWUf4OA/4Zu6zuhw3epjnQqs8bQefwIwRVSuyt7FcHSH6JYWT8tVNihyS4020Bi
	BVbmsFfKi/HvUiWi6Ml2Qoo6/uBD4Awjo8YKm/IhsBBpffNk+69314YNIYG9o7CPX8vR2L
	xCcJgmMra3CSe5V1B7wlUQEqLjx7dlY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-5sxkYfUPPBS7Rw9tMCtcFg-1; Mon, 29 Jan 2024 06:04:35 -0500
X-MC-Unique: 5sxkYfUPPBS7Rw9tMCtcFg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5102bbe883aso1369783e87.1
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 03:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526274; x=1707131074;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUxFR3bcXHTta+1PBg8XyG/gXzeG2AKh0T4pCbNWzhk=;
        b=jeJ+ozwYX1nuPkG9+ig4zXFduGNLor1b86bRiyMNqkIMeMGBH2n1p0x2IJZV8CHzUL
         zh3wUDb3JiS0tvl+UzBgUUbJuBgvYhPue5WRTwdk7sYqs/VbhIhqp7Rk6PEjzfJbBOX1
         tEhv73fiNirvefvgezPNGNakWKpklvBLBVe53myUYe3gEdG/puBpAn4LqpZ9PjAzuDVj
         Zme4X40I6d4aa6NljfyreRJFQT8msKJ4fbSVkQNKOPC1agUGs4qoHUMVZomWjphNafYR
         vy2mgA0v6T7JjNjxmz6qvvdX+MOqzOuxkU+nrBJzTWLgQHUejZ793SZSS3DO42E7ERoT
         liQA==
X-Gm-Message-State: AOJu0YyYjrixA3U1CA2Ej/1lnQ43j0fqBdOLpugvkZL2FstmplPkuXD2
	zvCesFSOG4ERyq0KXzJePQsjr2FC+P7caAr6Z4nfKbuGjRRa6/LNmYrjNRXq9OE2kkrBRwkdF9r
	jdqFkNOMgBuAhHMImi/FhEU0QFwdTk46FhF5CAp2x3m4ncraDw5LPg7Dl0vco
X-Received: by 2002:ac2:42c1:0:b0:50e:b8d3:143e with SMTP id n1-20020ac242c1000000b0050eb8d3143emr3378871lfl.51.1706526274504;
        Mon, 29 Jan 2024 03:04:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+YRm9cnARxFv2Yk7TeaTF10Mp/qci6lPx2SZJuQwn7WAL5ifGgR2MNzRpI9RYU7JyB4YVlA==
X-Received: by 2002:ac2:42c1:0:b0:50e:b8d3:143e with SMTP id n1-20020ac242c1000000b0050eb8d3143emr3378864lfl.51.1706526274194;
        Mon, 29 Jan 2024 03:04:34 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bw11-20020a0560001f8b00b00337af95c1d2sm710380wrb.14.2024.01.29.03.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:04:33 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/8] video: Provide screen_info_get_pci_dev() to find
 screen_info's PCI device
In-Reply-To: <20240117125527.23324-3-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-3-tzimmermann@suse.de>
Date: Mon, 29 Jan 2024 12:04:33 +0100
Message-ID: <87ttmwv1ry.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Add screen_info_get_pci_dev() to find the PCI device of an instance
> of screen_info. Does nothing on systems without PCI bus.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

> +struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
> +{
> +	struct resource res[SCREEN_INFO_MAX_RESOURCES];
> +	size_t i, numres;
> +	int ret;
> +
> +	ret = screen_info_resources(si, res, ARRAY_SIZE(res));
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +	numres = ret;
> +

I would just drop the ret variable and assign the screen_info_resources()
return value to numres. I think that makes the code easier to follow.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

