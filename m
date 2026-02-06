Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292341F03D7
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Feb 2026 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770340045; cv=pass; b=qYznbJforGgV7077JBoiK2Gr7+FYPCZExMit/tloYIDQnmiwOQagz/sELcPlbgx9KNsq4U4YWev6sL3ZXaEjYc8XnYPV1ypuykrSQQmWKf10ck+Rt5u8iRO0NW9CNaB0CexLZD0ucnVqeqZIALknYDJK5UUm6/L5i+29HT84sbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770340045; c=relaxed/simple;
	bh=wDWVWFCQyt41m36By+1mg9Tz8HGxZTNBLIvQ/XOM2S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZD7/9qNJ6TkCHxiXDmjhdAia3swjPnkQiUpTQ3LiZKnVMDQgUDvy5y6mKF/9WhR+g6V1ZuOGg/3lbZD2go3CrIjei3+wnZZGgXpPkCf3bpy3FruZmtCHE7FvpjuaVWxRytRvRN/qCZ3LcZGYGueuDPyfyHoMbw99ZVMQEyxTNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBSUUK+p; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBSUUK+p"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso21544646d6.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Feb 2026 17:07:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770340044; cv=none;
        d=google.com; s=arc-20240605;
        b=RjBq/iZjfD9sRHZPZ2RYa8rjQgEtGXBKStrs1j+sB8HbyiDds2zwwT5xWJJuYUx8Lb
         G3rR7WVnv109XF+qnDpVchlngDc0hz9DfadLKjk0tj5H6TU/ow4YHQGpaMmhTaMo1wJK
         rEuLbTYOKej1JlgWQ2avNyHqgyezhIrAQc+vyB9PzNWjOWfrm2jUPk8K8OfBa0xcGXFA
         U5BzCkVdagMv0qyU4ZVoZpOWtvMOdtYkyR/PlcwrMBd8LSEzIInPraxNMJX1OT3jCrcY
         q8Bq5HI1ADjbU06M0NIBtAihzAj+mh+CwLHJEenA1aicSJCIzlp+O54G6IeAaN9d1yYm
         57Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wDWVWFCQyt41m36By+1mg9Tz8HGxZTNBLIvQ/XOM2S4=;
        fh=NaMDXLslKy59lW9CMOh9Qdtd/mHdD4o83i/Wy6G0UCY=;
        b=i09xbIsUCVcRptI+OpKs/twY26hWtzZI9+Cu1Gx9kt5Ve+W1WfMVcfFRIuNbdzBEk8
         o1X9aOOIU7UN13hgv9BxE35w2+nvHvRYYBCfn1SGh5P/7EgaGnkydYsOxq4WMWKBxlMq
         Hyrp0dd73obh2dJWv6Vq6Q9nDKXvWJ0+k8TSXPDsKq/ekEEmfGqBZ92O9tV1TYy8Ib4D
         GYNeqc2iHLlJlgajsd1EjNp0ZnrNdMuKRkkIux/Zg7f7y/Oz2dLmX6FGDCwmqIA2GhYA
         Yb2oej6Ae5J5JX+cM1Afn+ONPMiqq6kTIGe5f+Y9GbS6hgNUg/++DNSFnl+YeBmu+Mzf
         wEpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770340044; x=1770944844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wDWVWFCQyt41m36By+1mg9Tz8HGxZTNBLIvQ/XOM2S4=;
        b=QBSUUK+pHEQKVDWqU7aVtVvNN+Z5y3qfTInfv+o7/d+2U/Uh98z2l3j5dJzMDHo3Zp
         7KKRnsvL51LzOWN+hUhOeIfyuKXIdl1AsuQ+9ImzT10RJQrmJhcU/ERBypEEGwG3/5i8
         sny6S4hqC9OojiB3yjMI/4xI0HaVn/ERoMhuAmXv58idmsWrURwif8g/EEhH1jV6AfGQ
         jln7vpt5QNkBk8Q829AqmRYgQsGCqOzIKNZyRNh+XVEmsmC19nnmfcuVySZZZKgwA0EA
         aam044VkgskRdJrJcg3J5Fex8XYRGFJKrLcV5M0IwV4LGKHYlwhHmqs+v1frn9zxK6TE
         oTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770340044; x=1770944844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDWVWFCQyt41m36By+1mg9Tz8HGxZTNBLIvQ/XOM2S4=;
        b=MTIQxr9iyFiEkkvDbi6035RjaZX1aIqZ8ajEUtq5JjMke+RUhZbJ7TLYd4g4tXOiUT
         +DWp+KrTtmHd0MmSSAZH5Rxa4Ik7NJJJ0I8ajikMr157qJNoFlGc61yjQEW53S4ghH39
         mDnojJaVx2bBANiMeo4mnXfNs53rtomjaeY9IEo1MkIGf4BcbSB4sQStHKn4kBlt6Vmf
         Bounk508ume5XjG8ZmeUkSAwVnAHT7oi4kaoZpBvM6GkZKeztN6WBMEUy5aXZmTXxIGp
         Co7iGdip+FfiTQYYYqF9GntbfRS2FslBZPVJA6XID3+kS9MasF+nyaQytbU0w7eU3Ghx
         yqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSbQiNmTBC+Nh8fcl8YN1odONE8s1UuGjm7SXTHjes0xPZUU6VhyGsJRhh3EhS5aqGpDGwRnB19XH0GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn12iOarOwGu+ixH6vDp0tz079cGIUD+750Nzows6g0BC/5XXp
	j6OQeNN8am3S9wktmCXHii3IR9ZV4a8l08UEuQpqtme86AVfrBfwnYVd746qynAB2SqQ/6EF3Gz
	nYvqL1RG+PADa9bdcXM/4iNDhYkhM3zQ=
X-Gm-Gg: AZuq6aJSzulPI4pHm7ZPyrqj8S0WBa4OIl0LSVxs2IDw4vqETfy/t5ELXLiBrdguvdV
	AxvoMNd+WGx1y6hTCb2rT1SWC8QAiJTv46npfyp35QLllKmo6cS61o5SMQPPXA/kxA6Ay49lsFx
	H8ugkGHt739ZS6gDRpm6L2najWkwx8Pfz/a1FmFUEmhGNJEMOCcHFEduiGlw6oFrqhgTgjcvEg5
	3TkWYbBieVYMmpzAFftIghmemi/JxkjCKL2LnjL2gcd2P82aA7ejnTgG5Rsx2KY7tmlabp/T+jn
	Gfqj3dy5W8J41XUZ8qCRSH8sdOE9/E/Ut8+QXbw9m6naBW4sk4C6kX8=
X-Received: by 2002:a05:6214:c29:b0:88a:44c8:fe30 with SMTP id
 6a1803df08f44-8953000350fmr75404466d6.10.1770340043910; Thu, 05 Feb 2026
 17:07:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
 <20260120204303.3229303-3-joelagnelf@nvidia.com> <CAPM=9tz5iXoFQ3+4hPFW+tZCL2zWe0WJ07-oFkP8TNVL_J_SSg@mail.gmail.com>
 <44542f0b-be3d-4e82-aacf-0bf19ab69954@nvidia.com>
In-Reply-To: <44542f0b-be3d-4e82-aacf-0bf19ab69954@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 6 Feb 2026 11:07:12 +1000
X-Gm-Features: AZwV_QjEIAozPEFJ7NdCW81HEOLtXZUhxCZzFmSJOZbp-SMcdPX-QLYah3tkGzE
Message-ID: <CAPM=9tzafj_-L+ia8q=tL5DBWZU9PdSq9vaCAD7ituoMR+CaQg@mail.gmail.com>
Subject: Re: [PATCH RFC v6 02/26] gpu: Move DRM buddy allocator one level up
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Helge Deller <deller@gmx.de>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>, 
	Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Alexey Ivanov <alexeyi@nvidia.com>, 
	Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	joel@joelfernandes.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 at 11:04, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>
>
>
> On 2/5/2026 3:55 PM, Dave Airlie wrote:
> > On Wed, 21 Jan 2026 at 06:44, Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >>
> >> Move the DRM buddy allocator one level up so that it can be used by GPU
> >> drivers (example, nova-core) that have usecases other than DRM (such as
> >> VFIO vGPU support). Modify the API, structures and Kconfigs to use
> >> "gpu_buddy" terminology. Adapt the drivers and tests to use the new API.
> >>
> >> The commit cannot be split due to bisectability, however no functional
> >> change is intended. Verified by running K-UNIT tests and build tested
> >> various configurations.
> >>
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >
> > I suggested this and think it's a good idea.
> >
> > Reviewed-by: Dave Airlie <airlied@redhat.com>
> Thanks, Dave!

I'm going to apply this to drm-misc-next today but I'll move some of it around.

Dave.
