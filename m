Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B264AB3
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351296; cv=none; b=pao++rOPUn5Vamm5dfWgB/3XQgJ9jLdI6hfQKyH8aQuBKjWWoJkYLbbR5pqreBTrgA7/Ta3WU//BAunzl+EEGAYQn62j+/ruVA1wc+pYpVraDWtECWguNqroDmqEiq/VOD/E3k1i2EU4v6UXRx1FsugWnk4Zci/7MrOIlolQbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351296; c=relaxed/simple;
	bh=wDVYaiWTHLKSiNQF6TvsedVi1h66ePmZbiVPozc8hJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKNgM/g/o04yjkoH6eewyChzUeWzs8XLb1GjPhKpillGqvWO5hguZ2lo836mOiSChPJOD3uYfCGfAnxOtEuS9PRAFvr66UO5uqsQPFmBPv4SbFjGnimPOLldGR2vxffh5agLwdKVMZOxBKGg3rafsZKpmBSp/+iCCyfMhXY6A+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wo9x2r4v; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wo9x2r4v"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56838e00367so128587a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710351293; x=1710956093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDVYaiWTHLKSiNQF6TvsedVi1h66ePmZbiVPozc8hJw=;
        b=wo9x2r4vO7ts6UZZFzAgctrFpdFw6njaiZbCaVH6lAJ1mTkB6jwpFV05lpg6F1IHwA
         1Rf4YvVoPe4LBGRhfAccMCtO+TAapaxIglEJgCbwECs4pA9QI/DZ7/ECZFOhtpzm2Xcr
         jBHG5SSgR9VHimwZZzPL8M9KgkCCJAM07OfCMyk96sdriwEurj4UGcYaP625UBkfXdgA
         fdHshBowGfaO+cKYBlIQEnJ4NGPdSDVCldWrs09dZ7Jx5fjajDrnAjduqgAl7mQiGLTj
         +H6TRiHqZqvxZWCxQn7z+ywbnD/VvY/jhjl1a1/ngrvFcxmXHHBmCJoYxXfhoqHltrMQ
         79dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351293; x=1710956093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDVYaiWTHLKSiNQF6TvsedVi1h66ePmZbiVPozc8hJw=;
        b=Bs+hbgBIChhxxGRKgmpAsXydFwY04XfWD/DHqAp1FbUSMr9Lt4pg1CuGc3V35bdlHQ
         Xd+wx+dSwiXzSmsxPed4UkVisMHTjEAtYPZwxZ1h60GHa2ValFf59m2J1/CPx3oBRMbI
         4S600A+09G63yrRkOmj/n9RBV1AzVd8zOx3ZzYCxuQhFMfTjpcMJgp3DgE90Q0rGV8LO
         /JDmy+snTt/01FcMJYfAzVGE1qWrWnXIkyGBVasZccVqvTvGcgvgSH96Zfqx5eg7r5EW
         Epneivg7DnTEKADj42V54/95Lf5ABdNNCMQwdV+/6BOnwvhUO0m0uGfkEzO4Ig5UHgx9
         3PJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN8KU+LSm/jFHpiiP8veyG7ou8sdB0Umoc3FkjLFvUbOEoWkxtQfVSfD9jPgFXqIz0IWs6BhcTI89WQqcj7cyDhPvC6M7sA3T0gWA=
X-Gm-Message-State: AOJu0YxQLZ0Q4+ybcccGTyuGOkoTAI3lC25/Hwx6AwcBAi4kGbgwHY0U
	WjuRDEf9INw/dITf2jS7+lK7TDXzAZq0sl5pFFrTqfvOtnhuGZPBWq3cp1z11+w=
X-Google-Smtp-Source: AGHT+IF0uw6I6idQAb4xv3M/WoLxMq8rIEcSu/qwR7wMCtqeIzkvl56KxAb3RLUFTKsxfBzsJerNtQ==
X-Received: by 2002:a17:907:c209:b0:a46:4469:6ef7 with SMTP id ti9-20020a170907c20900b00a4644696ef7mr4148744ejc.52.1710351292978;
        Wed, 13 Mar 2024 10:34:52 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm3441069ejb.126.2024.03.13.10.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:34:52 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:34:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	Robin van der Gracht <robin@protonic.nl>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
Message-ID: <ece2ddfe-a996-4622-8c46-abfd84c79809@moroto.mountain>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313154857.12949-2-tzimmermann@suse.de>

On Wed, Mar 13, 2024 at 04:45:00PM +0100, Thomas Zimmermann wrote:
> Replace the use of struct backlight_properties.fb_blank with a
> call to backlight_get_brightness(). The helper implement the same
> logic as the driver's function.

If you end up resending there is a typo s/implement/implements/.

regards,
dan carpenter
