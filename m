Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B553B8413
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098179; cv=none; b=g0kb/r1ghZbCgcZt1dLjRwAdvwCh8lyBC42x1m6DPl6e0QO8QvEachbZ460sEJGpNTMA9ilf5cy4GBfs0ZzPBpsVCOp2J7joLyaeSABJmkERguNr9ypkOYVhcIZxaNtenlf5th/We0U3pCkCIjaEF5QL7eC/9uWOl+tduGQERXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098179; c=relaxed/simple;
	bh=ezl60jnsGlY2DjuW5u8Hxt4e27j5KruM4etJ6V9C2uE=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fAXicTuvSdNI6z3N1SO6VJws8zHlHlNx8eOMBeGwfcUhPzZqlWoTfQUcQxOCXKVXfxbLsEN4kcUcOq8knQt5PswSGgoewBbhiUrZq5zScte4XZK+r/VLmuoMZc17KUFeewdfvXrbJi2PjIAAAU37RR1buOkdrvaAFfW8TmouLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwQnKggr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwQnKggr"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so517574a12.1
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Sep 2026 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098178; x=1789702978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cS7AJAyUrXw4OKsQuXto2NRThO/NQ7LZ4I3G8/x/j7Y=;
        b=NwQnKggrZbdvmf8bEqW4QqxsnvrLHhEXABy6/YHz6jTuLwCMrv/zYPJ2V9k8zpYCiG
         y/usF2SCWA0aw+nLN3KUjxF7z12j4a2PNprmYeZqNKQUdwHLrQ7gD8T3XTF/eXlbSZlg
         HFKRT7rjb+JOu8pxqQNCDWCn75ghzEQWOXwOPIIy0h2PThRyIpB5GBEHqGOXfjzsmXLy
         0bZE14y/dSHw0ROWYmCgZAB0J58fOAGAHeQQAEpmxhRwfTPuklYT0vItw91idWy/8mtL
         Nuc2722H715Cb0nFsFZGTzNqw0/8hsVz2XVbo4lZS0sNPyi2i9oWPzzaTNCYDGyc3lz+
         XxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098178; x=1789702978;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cS7AJAyUrXw4OKsQuXto2NRThO/NQ7LZ4I3G8/x/j7Y=;
        b=dx1lCAZPkLphVP9p1pd9CgwjdUAjgC8/N18lhS7ZcVWFm3OrxRyXMPe9PSqt16Kqki
         7S+8phLp0NgxKvxT8fR1e3SZKLkkCLzHQgwKc7W2tih3XrFPvrA7njkBWVf4aoTng3ed
         T5pMVuNaA4YwsnYxz7N5YWSP385b+WAQTRT7j+z8HsSzutrwu0z8JV7+k+0MNXO1b7LY
         jLaxr5q5vYsS5Q0f5v1QH9rA4ASHIG7v6y2Y1G90oxtSpsZAKp2pUYONuH1TK/E3adXA
         lTWB8GEexpOoiKuLFEmVu2uPXAql3/9I29cyE/8gHWXMMU4kB8iYTKmuLmJL//2/bR7X
         PFBA==
X-Forwarded-Encrypted: i=1; AKwUvBz+cRdJrfg5suKP5Kt4s+hOnRaJMIsGbwGxzODN5htw0xdiXN/+uANzAjqdo5yvIbgBIHvLvM7ZIbc4jg==@vger.kernel.org
X-Gm-Message-State: AFuF++lk9SAimGSxiWrJDV+gsxpSWlSvx2zBoxk4Tdgyy4bLM/TSIh20
	JbWB/9VEV/DFkzJh4DClRTcZZrFxoDca9VEcgOhbzTuqo41igO+EL/UG
X-Gm-Gg: AYBFou2ABWczZwsfGW3sB2edmtZRdcFKZJ1fmIq5wiwIPaaphRFI/Br2ZwAHbA1n0Jw
	8AkPKnf/a36C2ffKx93PQuNjPkl/htGWwYkA5DCaqOJ8fFJoCsARegEjj0vGDmdOvtbO5BtP//6
	/7VgiNRCV+L6aGvJV/9EyEdDvpAGJqi3sALFaFv/O0dxwznchp6GDZWAtiUX21oMNvGNsgu/422
	cTyk9vJHcXSgnmyKWbk4v5rbxxndaNf/dG6S/8KPvJf2Hq059IXX3WBjLwhzZhji6oLT26QdQDQ
	fIZrfza/UfrwcROTCd4FxKnbVmSrcqX+6F1yAHfmkFlZdVog0RKilOfLz44mlHtTc4sP/K4mTGy
	SYNpf1gwzK5Y+LlA2QoVnj4QPIk+874jdK3G+7PS99HmFYMSyUNir88UWn7t+eVysWmSo1dGHow
	Y0tZQj6/9EsJB9mFQNLjjeFuOIFV9kZAkJSBrZqZhbP/iDaNLU21vfhtTlP6GH6TAEMMrbBlVX0
	4nv2zrFL23WibXZk1jdxJsFXQRB2A==
X-Received: by 2002:a17:90b:1d45:b0:398:9be9:ab8f with SMTP id 98e67ed59e1d1-39d9c21cf40mr3366244a91.20.1789098177800;
        Thu, 10 Sep 2026 20:42:57 -0700 (PDT)
Received: from [10.1.1.24] (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9d9ebeb1sm408602a91.4.2026.09.10.20.42.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2026 20:42:57 -0700 (PDT)
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Helge Deller <deller@gmx.de>, =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?=
 <miro.kropacek@gmail.com>
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
 <a8cb0e4f-a2fd-4478-99d6-fdb043a9d15c@gmx.de>
Cc: Linmao Li <lilinmao@kylinos.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6197fda7-889c-7f26-98ad-e0c56da66efa@gmail.com>
Date: Fri, 11 Sep 2026 15:42:49 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a8cb0e4f-a2fd-4478-99d6-fdb043a9d15c@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks Helge,

Am 11.09.2026 um 08:39 schrieb Helge Deller:
>> All good then - do you need my Acked-by for Linmao's patch, Helge?
>
> No, I think your Reviewed-by is sufficient.
>
> But I added a
> Tested-by: Miro Kropáček <miro.kropacek@gmail.com>
> tag, if that's Ok for you, Miro?
> It's always good to know if a patch has been tested.
>
> With that, I just added the patch to the fbdev git tree.

All good then, much appreciated!

Cheers,

	Michael

>
> Thanks!
> Helge
