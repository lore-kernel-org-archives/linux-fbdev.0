Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F212B153
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271009; cv=none; b=szSNeA3nrGnMUFQkHz3ZlbCW0C43dB4uPI/GbyWAAcGKl0P6LTejiI+KokqoMsGUAdD5JlNIzhXe6Pdp9/QnXx6BHa09aoxupT+BUH0Q8c4CmA41p/0wTP+uk6vHpxTABYjYa5T6TY/iBlgD7ojQDeGFKtWWJkvlRALPCblxb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271009; c=relaxed/simple;
	bh=fzdzmaQpsP6qFq57RDebOQTXPO8ko95PIygsDfOUjtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oe5mmuEZjlhWfw6c3atNYjJnWW3FeGg13ROConvyH1BTIEy7fsZvNOvajuJ+L/0YKmHIBZSGRtAZWbTHrNPoU1t36dHcalEGXT4mLa6r7PPu4UqwM/9xxtTWGIqBPYR1S9NUVq6iPLtwGrs1wX73kzbO6IniML4HHxYRRbC4a/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmcVaX9i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmcVaX9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713271006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzdzmaQpsP6qFq57RDebOQTXPO8ko95PIygsDfOUjtE=;
	b=NmcVaX9iElXZCR+/SyHYz2SO7KfLVhCXzSyYJRkBwfDUbdBBhDmMI2C/tHaA4yG7R6mJMX
	563ZmHRCgzcVFZ0tzM5Zd7+And4rGfLWxwhGhVJxfYAHhVMWPo8/nPt/eBEK/9guca4LWw
	5BSnzxO0PejsQ1S3+/hddVo36gTKG5k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-CznNflIMPui-QyIWxroq5w-1; Tue, 16 Apr 2024 08:36:45 -0400
X-MC-Unique: CznNflIMPui-QyIWxroq5w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4147de378b9so20391675e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271004; x=1713875804;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzdzmaQpsP6qFq57RDebOQTXPO8ko95PIygsDfOUjtE=;
        b=TcwB5cHMaI4cFdRzKn628YlCDFZ847hg9/Xrnwq8OwvFChkI9BXBPjFvnLJxPooybb
         4zwYaeIVMRHjBBnCEwL6+Hv2fa9JolbfNwxRrvOuIOf1Og0PbcDZVtGLPwors5PeOcmH
         hXD2PPCWqQReqUF9GMz2iuVmtSAuf48irQCt88AMDZZUei8lUv63B/tbc4KZcczsDc+O
         G4p9haYNTuxfiUxhXIUZ20jv0u3PiLkiNaGd5tbnwxUwHOyBQnGax5L4oH8E98nVGlFi
         BxtTqbN+UtoCBodBOxsLlUjMCRP/oLnieBrqffEYuS7pYj8UvVljQX5Xv9irIEW3RfRZ
         J5lA==
X-Forwarded-Encrypted: i=1; AJvYcCXVJyK1yfEB544eay89yvbU/f1dTvwFaSuDl5RmXHpKA2TeLfCFsEwk1y9rYvgdwnvyJdsK9dcYJh7IbgOylQzBv/ZWck+5LpjYExA=
X-Gm-Message-State: AOJu0YwNk252cCiSAhn4zDxGR3K5run6ll2G4vCE++kBwf3gAF73qItw
	Xs53Vz/ppOuNK4pQnFmozSJIAKDhIxPLfrKU2fkzeIJo80ah9HyvAXUy1AEw7M9dIxIQgQkJr4B
	0CLMk/MTvpPNcewhlIGEYa8LErPJLIBBpuXhRFzTqL08lnlyuASSYdUQgZw2M
X-Received: by 2002:a05:600c:35ca:b0:416:8091:a39e with SMTP id r10-20020a05600c35ca00b004168091a39emr10783140wmq.10.1713271003740;
        Tue, 16 Apr 2024 05:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaadVrQyFNMHCnMTbyWE2LjjeIhfUT4D+QboertmyRjaD6xw/Yym7WIMwNnFYiLJ2zSjeUyw==
X-Received: by 2002:a05:600c:35ca:b0:416:8091:a39e with SMTP id r10-20020a05600c35ca00b004168091a39emr10783127wmq.10.1713271003372;
        Tue, 16 Apr 2024 05:36:43 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id dl5-20020a0560000b8500b00345fb949c28sm14748889wrb.100.2024.04.16.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:36:43 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Sandy Huang <hjc@rock-chips.com>, Heiko
 =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 31/43] drm/rockchip: Use fbdev-dma
In-Reply-To: <20240410130557.31572-32-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-32-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:36:41 +0200
Message-ID: <87jzkx5vs6.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by rockchip. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St=C3=BCbner" <heiko@sntech.de>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

