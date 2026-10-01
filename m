Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBA4A498E
	for <linux-fbdev@vger.kernel.org>; Thu,  1 Oct 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863446; cv=pass; b=HJ0At4MQrdIQaUoEU7/eNvDdn5ZQeDYztMfN6zHQM18zBGsv9Psdcuyv7IyxCmLUUl+DK/qHqscyDWMjDmGAIHS/5mNkw7p9dBtoP3i5E/TtjrFCh++WPAjGtfFeZVXqSzUCcwjJe62bX8uifpjzwtCflRPAQtIT5V+I1C9jCZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863446; c=relaxed/simple;
	bh=U9jLK7/wc7B6mGa6+VCwGx4Ieg2jj91kEAwv06rg/rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKCzPPEStgBkv4XUxG026KQw5J2MOkTRKbAh1cGIEKUWFOhJGGnETuN5kKNBirLNfUIk208MI1JZY/vsbzVNzkZvRrgCXHY7lUsYDOtt2jxaa4FLFBzmEEGyYII+qb95BB9yIXeBCDzL8fAkvDWw6ABZSIz/pzP3AvNz98J0VpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxnS9U4M; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxnS9U4M"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a75ff20a6eso35005861fa.0
        for <linux-fbdev@vger.kernel.org>; Thu, 01 Oct 2026 07:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790863442; cv=none;
        d=google.com; s=arc-20260327;
        b=MdcX5shfoq0ziEHdDS7dNafE3jmfKWuFXyyxu0PeRLGm6xl4A360N/3Wq9TyYW/XFS
         w05taHJpCRrblNjg9zVks9i1sdhkcI11CqmrUCp1HCT00+dV5dqNElTQrPpaL213RdmG
         WAa3RRjRPlXYE52TZ7Zt2sooi4YirCaSpSeBJK2MN6WQJsbWbeMwGBNJrPOSqd2lEkHu
         qJSEa1RQmhmS2DS7eNaXnmstrTKk13b2ET2Fkzcjy/+dgZFzUoktbheovRZDu7yPrLN5
         gsYA1nEdkKtQEpFuwcP56bjmvEBMhjQ8RqP5rZNaIsvIOwM8KvAqtTXDe1TXTMivx6Au
         k7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U9jLK7/wc7B6mGa6+VCwGx4Ieg2jj91kEAwv06rg/rQ=;
        fh=cyXK4RqA1TxCFqm59N8ZD7M73mSKQSnjE4tMGo0eB1o=;
        b=IIYJRJIGvCnqnPjV0Pv5O/jw1RoNXSTh7hAQz3Nxk/c4WR51xifq1Xg4TEd6Wcm4Bv
         qXwsu7ECgtlPeq9zBxepQ1aPCU3E/Sbu17yVaoOWlODfQVBCxENXA1C0k4iLchCQHA/h
         9lD3a8TakA5SfrJEJU3NzVfFOKahOA0UqwbOhW5ve9eu9LDeRP5zgRhuTG+nreN1Ekwx
         weK4Hc1YqykVGrUtvcknG4UWbm2WroI9m6es899SOSf1anQvOIKdA6YO7i2IiBpL953W
         77z8d3A6PaYkuJPWLxa7zoMnDUkMCTpbU2CqChBlp7Q8m/IVz67/u9mRTbOwSHAfyk42
         5+8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790863442; x=1791468242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U9jLK7/wc7B6mGa6+VCwGx4Ieg2jj91kEAwv06rg/rQ=;
        b=mxnS9U4MAgMkcyZxXxOPp5bmZqUfNqW78r5C1CazNNYZAlO1HmyvOl6SR526BHZ78c
         zQC7l0Hbz7V3sqos12PwSoeVMFBfbZsJ6FpTXz2Ntr1imtKCsblpFIUMxAjHUjYM1MyQ
         ui0rG3MtrCLlL9MOO1KCilQ9PvCd81kP6vU8VkTkreZ0E/Kz07yLSVakR/vl4Khm5VRi
         OFi0M6lmV/hoaIN6SSSF1Rc+3DhGQoa0zgytVxxTFU5LZi0EH7CdxtPyeMc5WaBslGf3
         uu8tPs7on1//MD0XEMsYA15be4qE/RJYNDRSKgndp/1WR9gSaYxor5FqjUFBtmZwxfep
         io7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790863442; x=1791468242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9jLK7/wc7B6mGa6+VCwGx4Ieg2jj91kEAwv06rg/rQ=;
        b=sWoQNyT4ynbSegXkl0VT5zAfdRfHYdjWpOo1Uzgg/UYmoT1QI2xcpeK+ii7Ys/uEj0
         qyRYbGZtq/QV2lYLqzGaPd6ospJGpG0wwct6nC5LgNC/hyNX253M6GyZmK6n5YQ6fIA8
         rrLtW+MPD9i3eq5QUVhW4A0DsXwVV/IrLaiEoEsVSVMDkufAvT1plneJbo8rBtyG2I6P
         jrQlhlir7zZTNqTDV3yfV6UcO9EBl3AmqlxAq7t+bYIj0nvxfsx9vM+bPfaeZU/8EU5N
         NP3hJR5wtS9m5T1QIfvPXbYXa2w/iXYZwSy7qvgZcUu9vPnaQ/NwnNi5c1+U0bPmp3RE
         kNKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxs65Qc5ea4AvSUgCz1MBr4AE+QIOovJ0Et4igy47iInnrxim+cVfgNzRdhkFZxIoGxd1HQJYhKLCPd3A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJa0i2OsMJyOXyogUVdGokxfbL8Tin8Q1K42HjQ+EB4R9M5IVYZ
	IHRuyKbxBeITW5XoUDWn9P6kJ3EjvixT5LKzor2DHPkVSInPSyx2JwqjEzZ5w9XpzRhfdTb3ZMn
	Oz1MfUYMqvs0N2fZnIJ5M4tYdpOTbMzo=
X-Gm-Gg: AYBFou352w8XRhbC78xqRdMLUN1k8kEtQRyzRxb6VkE6lk55aoAFfVe8UPpod+QMCJX
	QNpIMtTeJLXy36ggsfk6sQLD6Ygg0Bpy0glAtEV+IJc0JHRchH4vZDvmL2NZ625g/ccwcHJO0aV
	JAaOSQAGY9GnNdaF8bu3Pj0CKyQ0IIrnshihbXcvNJDsk3rKCqlojFcAso9pxKEXORv3MxzxIjE
	ep/zQ5h1MM8gKjaI+wodIm2jApmbMpd0Msfke5leCUpXaEeE5TCHUn6K3AXrgyyCB1QOH0gCLHB
	EQ0RFYgTkSuQzj3Gn9Y33PzroXhX86IIgS+ziJFlU1/dl/d+wfH2iq3Ijh1PmA2VVCEce+1VWze
	z96udhC7d0qlSFXIgDZy0PCb3ucyW/fSQjQ+FmHtWyxE1Wr4CFEbO83tPblIOocGr7a1vSoP/Vm
	hicNjOodJYcG8ufUYoSlWptwMOO1m31HF3bDmSWuMX
X-Received: by 2002:a05:651c:2121:b0:3a6:27ba:be0b with SMTP id
 38308e7fff4ca-3a77928dc6cmr16119671fa.20.1790863442038; Thu, 01 Oct 2026
 07:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001133736.802604-1-tzimmermann@suse.de>
In-Reply-To: <20261001133736.802604-1-tzimmermann@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Oct 2026 17:03:25 +0300
X-Gm-Features: AclHuK-MGGGgGsa7XTJEX30X4AH0rHlA77AtOEFwmZmXzvdKsC2XJRDqSMsLZSA
Message-ID: <CAHp75Vf80MzmPvOK7Qpy99dxoKY1JSiJWM6KUVswoO12LgtuBw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: Remove simple-display pipe
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, decui@microsoft.com, longli@microsoft.com, 
	ssengar@linux.microsoft.com, andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 4:37=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> There are no drivers using struct drm_simple_display_pipe left. Remove
> the related helpers from DRM and clear any TODO items. Hyperv-drm needs
> a minor fix to include some additonal headers.

additional

...

Makes a lot of sense,
Reviewed-by: Andy Shevchenko <andy@kernel.org>
with the spelling fix in the patch 2/2.

--=20
With Best Regards,
Andy Shevchenko
