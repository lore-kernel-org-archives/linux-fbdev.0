Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC4283142
	for <linux-fbdev@vger.kernel.org>; Sun, 19 Jul 2026 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784448075; cv=pass; b=k4qkvZfZpTppbWtBfENW+UKaRkkWO8niZAZxUlsru8YgzJ5GYB1L5kgMJiB5IIA/IHy67ibq1a1/qJa/46QGjEu/3/9o3CwTNMfejS36oFq/KIHv4bh0QtsIKX3MLkkln36jLMw3ZZvrQqN1ItQOpGAjAYp7aYipxya0VOQRJU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784448075; c=relaxed/simple;
	bh=mRqH6Ek3y43nF1Dmwi5BJEBjG5UGgqF7TA0tuT0IpUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVtSVqNKXqL5shffOi9JQ1RbY6FI5pPuTNRZsJ/S4LybCU97y8+G4Lht/jRA2HjVoFjD4yf1hlLnZUTMK3xVeBOF0CoFuKS9lFZ5dVinejLtuZI4mh6yut5FO4lEeUMa3yki2cmZoKdEts+EaPnYzYAgS1vzjunNuizKRIg5Y/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFccKHlm; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFccKHlm"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15c7d22070so1205893366b.2
        for <linux-fbdev@vger.kernel.org>; Sun, 19 Jul 2026 01:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784448072; cv=none;
        d=google.com; s=arc-20260327;
        b=gOHNblJjqnJhoiUDcj7z+I2xSfWlLmRu4UUAJ6e0VF4d5ci5ubyHvFd3X7pjn5HFbD
         +VSOcSA/WJId0EnqEgoN8FOrlgHgTzi+aMLKjZJEa81NPDhZBqceOEXV7rdo2Wvtg9iE
         joemrvJKBl87X+lbef60UgEt+X99CPwDaSVZFCITnSCE2w2ytP1rZFr6LVkDSHCwoyHm
         T/xzULY5oKRpuSI7QZMuhaUbjPJv2J4kChXThKpi9Y0bSjLqMMg6kOEiD4xP5YVY3gOe
         uNzEp4BQ7sXpkWeAmu31ybHDj/wRsoQN8SmQcADeIOSlkdMBS/1pn+neWXBmGXUwM0cF
         lMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mRqH6Ek3y43nF1Dmwi5BJEBjG5UGgqF7TA0tuT0IpUI=;
        fh=DY6j+EcCvnPYFSLrYxFF6dM/JYc8kWvQu73KKNsb5m8=;
        b=fn/A2RAf8JisVyaH+hm+aMfBKcq4z6R5kAyK02iPt/WSwDwBqypRAeFGI0Yiw0LM9f
         iHXp0P8Kph9rGy2ekULzIy4S95SS5e7dmcASVXAQSZ8eid2+VLDOY0bY15pPoriF4HBK
         4HtS/yslxsDTn5YSP+UD411b7JOSYY6l5uNHzzxZbwHoHiSMVesm4apjCi0nu0sBzchb
         EAsdEsCTHErDr6DssgUor0H7M7JoZGUoJwPXDtZLuATT7sCQOKJNmHdsc0Fn9PzjZeiN
         sS2uziTIh9LNoY37/T6kGkXjLpuVNQ40KT6n8A7682F43gmJQwbng7sJBCHhH7JrGihi
         zTCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784448072; x=1785052872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mRqH6Ek3y43nF1Dmwi5BJEBjG5UGgqF7TA0tuT0IpUI=;
        b=mFccKHlm5A+oZpL0U8OmzsOybyBXsFrCEm8L+FHi4bhkrnfvS1DbBgJ+tek6BKm7f7
         Ey+AtahslYuHHc0RyE3X1uEaw7tBtdypbulE8riLy/wOXpCzqiAwHHyuVEUE1Jw844UW
         p70/I1xCXMHZEj1Yrk4h43RLqdOMUIVgvA4OlYLLhMLVmaSSDvrcyH5Uo8A3tyhrNVWf
         /ZJqDEoNBlZskEJGhcbdmFElhQDF+4Ej+gr4kCsoWwz3ufcapSFioOJbWLf3GWsglPcT
         xy1NuVWDR4V2sJlp/eTYQOd2+OBZIpDu9XgZ9rffOXIfP+3O9qZjeJjWdkl3v/zVP+iP
         DF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784448072; x=1785052872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRqH6Ek3y43nF1Dmwi5BJEBjG5UGgqF7TA0tuT0IpUI=;
        b=rjsMvbdcNIC3vlOzScy+GzM2VVRtoIhvak1OZifBc6WxQUfZrn7luaTMzjIN2IsvSI
         758KYC19mY7shWfmRJuIlHHyJhjEWEm4704/W1LpOHJy6HoVOd6GY8lPwFENrP7kYa2O
         hi5EDVAg+dvUL/p3Bqm9tKDfGVndoTuUPkcKW/zxOS6U1kU4/16CK+5r6PUSh4oYSzA1
         QNcWnhlqjNufLvMFcLQySU8LJCopOWkJY3JIAWr0IHpOGh2lQyYIFLjQpSdx4d09cg8I
         0ydt+9JA/fJ8CpccZM/g4zvLmknx/7OFQXc9aGh1kyffPjKbaK+P3NCnBfaPT7/qxM/D
         jcWg==
X-Forwarded-Encrypted: i=1; AHgh+RoBWRe4QKurjyAo6mFhWeOcT5j1WNEh1GlikMj+J7rcJmx8v1viqtl04asXmjtaR9DZjw4uiGdnPL/Bwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrA6U0bfYBq3K17SGIU322Z/bCvRJxxixEsD6eQ7z6NK/figE6
	EWy6I6GzF1ahtWE+yO+6hUjB4yom6BZ34fKQ0QHFsiZXe4Muaop/db9nStXlWQsDnhZAplSlZpf
	gg5GlrMYj2qxuE6byBs+7a8IbwE175NkNbQS0my8=
X-Gm-Gg: AfdE7ckmAgN99iuBXECW0vpaJswo5xxF/qqemUyA/C1ZHF3IQRfdVH1oQxg3B1Jl4QK
	kcVF9jiSNb5r4dz+ymI9zndoAL7JbJy6kA4AbRsFtqLzepZU4M19EWz54V66fgpU0zY1HfeB1nS
	p25KCOOJW3YS5wx6uw3unbUlcWXlRNl7nJ0rB6nUzS/TscX+Iku/Wcfx4p6EunAkGchvYZidjeY
	Dr9B8pets45v5JsgylXOR94NT+CxoT91zleV3Tvf6CQ5XaPpIoQrfw3idtWumzw/cnYM/0Y7Sky
	EBD5DdEweEQsNk0URvICP2DvWVpL7wWGt2tydL+L6PpXICApIQ4ptI4p9Vb6syCQ5QKLLemJV98
	JUKHoEllDftA3cAb5nejmB0tC5Iex03d5nwc5GH7Rr2XhHs7AyX59OWS5jw==
X-Received: by 2002:a17:907:741:b0:c14:816a:156a with SMTP id
 a640c23a62f3a-c16b476855fmr384738266b.43.1784448072255; Sun, 19 Jul 2026
 01:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a5bc4a7.f1c1923d.2d2b59.05d9@mx.google.com>
In-Reply-To: <6a5bc4a7.f1c1923d.2d2b59.05d9@mx.google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 19 Jul 2026 11:00:36 +0300
X-Gm-Features: AUfX_myg58yoFCRBGSgVX-lgudzYthoirm_XN3vbryoytwu4PunHn8W5YCPfrL8
Message-ID: <CAHp75VczCz8_=g8-is=gq+fkzcGbtf5Co1J7wH=M3+nkKzqo9g@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c
To: Shivesh <chanelshivesh@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 9:23=E2=80=AFPM Shivesh <chanelshivesh@gmail.com> w=
rote:
>
> From 7e9684b26176644bc92c2285acc7444f3f7ddb4d Mon Sep 17 00:00:00 2001
> From: Shivesh <chanelshivesh@gmail.com>
> Date: Sat, 18 Jul 2026 18:08:04 +0000
> Subject: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c
>
> Fix space-related checkpatch errors in macro invocations. When the
> modifier argument is empty, remove the trailing comma to avoid
> 'space required after comma' and 'space prohibited before close
> parenthesis' conflicting errors.

Format of the sending the patch is wrong, and you even haven't
compiled the code. NAK.


--=20
With Best Regards,
Andy Shevchenko
