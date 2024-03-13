Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3007A141
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349902; cv=none; b=g6ryEVJOR71XTiRr/LAY0+hCWFnIB+Zo6KOIXRXZ3tjys4ii1IfS/ZXdZQ4wnDl2NJdl438Q+guS8yIfj86LpYMAQSL3snexAO3C5o5RMjlPYYBN4YoE8SVC95jMnEd1XDOO6WxvH17m0Wp99jmd5gegcxkWYUXOo/MS/Y8KkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349902; c=relaxed/simple;
	bh=/avyauc5PSAA6YqZTk10zgDYesk4c2DrAB2My5MLAgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY0JQiADq5j40v/JfxCHwboOYSFq/7Trk1SMM/Vz6jtaO0gMh1IQ/TPXjdXqhvmicDTlEo6Q9HfsSTXBL6nbr6i60n6SJfN0TwurfoeRhpvFze4HY6TiHok+g9UymcOBNCsSwegWUs70nX1OQIGAR2P73gEksMiLiQpjkMim7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BA0aBE7E; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BA0aBE7E"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a450615d1c4so21946966b.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710349899; x=1710954699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4989NFoTQ07zq5PnHdZf2zLYVP+OOsZrZkI627DoQM=;
        b=BA0aBE7EpXyNj96XGgcBEbU4ke8kvAIgbvvl8eDAMWhnuJdmttAefL+30PP1FzDp4e
         Yw0xw3OfvC1Zo0Eq9ezFGOrU8fbEAMXiRV9NrjhyFWCW07GnAyGy5kHNY61DJdj+q+c6
         Gwe4Y0IgHx9dVZygEV05VssHMq0hz22JaWKw5R3bi1te2c5A7l4ESUA/JehpOqLFw0iX
         FS5rhHJXM2LCnzbLQck29AlAmFl1n9Bvw0/A7fpW+3XejBeO6/EvBxfLBMc3gpGOELBi
         uB2kdEc3lfHrfa/NA7MfWcvPV1BHca0nAojXNXCmM80Qg8RNfAykb3nHDQxcXNw6mxRt
         X7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349899; x=1710954699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4989NFoTQ07zq5PnHdZf2zLYVP+OOsZrZkI627DoQM=;
        b=rVE7AboZISnQZskRputILEZOCyRiOrXd18E+l/LiumC4F3stoTagdPItU5Jcpi/rG4
         YmXrpIfAEB1eNVZi/dFyGXdHc4FFY/q+GsFG3ni9tkVIS5SoMBh/JkTU/1WODie4gyuZ
         qZVLM3ReUxsCXSyiu3n03BGbEvLmgkpImkkKRQtPGxW+OABygXurDu2vIDT0SOmeEcbv
         2yhF6W0B+2lMk7VoKX79Wztlvq6gf24TVm16+IZiDyTzQ2/qfTRt8zm0QW4o7eJKlAb4
         uE/jo2dU4Izb/buxgyu18nXWGm0rQz8zcpA19XsdOmKCOTxzNbQFvvVo6rf/JR6on7yw
         jhcg==
X-Forwarded-Encrypted: i=1; AJvYcCUcdOmfexMtIw7Wyg90geNrVfhkFAGyarQ8POmqSCUimdz4CT5X44aTdyvNqfO6gqR+Su1WG7PxdyLLrw4kRlKG9rugJMO1s0EOrYo=
X-Gm-Message-State: AOJu0Yz17En+TdtoyIUQxHjPftwzgNS0UFxr24bSzUnQyq/3R4PGC5AX
	itje+C5MP15xdZnQNkntACMfnxKxuad/rOJ0X5VeCYp5FQHhNC4DSES9bdOgjB4=
X-Google-Smtp-Source: AGHT+IE+IqeM0K8AvqOGHDpdNt4JlH9jV1CrUlPPX5RdEaGIo5go5N8DZ6CKG209IIMOIcNXF7bviA==
X-Received: by 2002:a17:906:c7d0:b0:a46:1f91:7078 with SMTP id dc16-20020a170906c7d000b00a461f917078mr2730655ejb.20.1710349898986;
        Wed, 13 Mar 2024 10:11:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b00a4600ca3098sm4809644ejc.43.2024.03.13.10.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:11:38 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:11:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, lee@kernel.org,
	daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Robin van der Gracht <robin@protonic.nl>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
Message-ID: <03ea1afa-e54b-4f31-bf07-03d9cdbacaea@moroto.mountain>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-2-tzimmermann@suse.de>
 <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com>

On Wed, Mar 13, 2024 at 05:08:08PM +0100, Miguel Ojeda wrote:
> > -       int brightness = bl->props.brightness;
> > +       int brightness = backlight_get_brightness(bl);
> 
> This can be `const` now (or even removed and have the call embedded below).
> 

Is there an advantage to making this const?

regards,
dan carpenter

