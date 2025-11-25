Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B72BE047
	for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061732; cv=none; b=WMGUALfVvNMwrwAtedRumMOZHSZiZa7S0ll4WVJmvvXlsfxpZr/M2NYKjaBHsT1urMu8Ra3IUZT91rg8x4ud1sTEhvYj+qmOj06jZbxMtOaUrlzx8dnexzFbuePRJE0pqFM3/5xgmu7C4D39dtZPhLYw78jiCnmzAbK17z7ouJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061732; c=relaxed/simple;
	bh=jCdO90en+FjhKk4ix5gedxAx+9JnP8FYLniKGNGpn2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHlLEr3xZ+6dByJLxaQ5NyRRUKikW9pej7iouXg2vEufly419+oujObYlxvoKciHSQayOCspvStAWjln3+Tm6pY7A/Q3/hYlZUF/WGiDo3yxSrSrvlkUmuOzekaVWeWFzzPqRmh0bOh7seqdhKSRms9gquQYT0gsqRgDZKZyWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jxp7KNgQ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxp7KNgQ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-882475d8851so61625196d6.2
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 01:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764061730; x=1764666530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCdO90en+FjhKk4ix5gedxAx+9JnP8FYLniKGNGpn2c=;
        b=Jxp7KNgQM3Q9rE375JZ+a1EbcBaUFmyrwcZdXdQXr+YpvCB7hko+7KZMTBFLtzh+AN
         lt0bxTIqcUiF7QfmHc9SyllXwBj3RYVm31VYo4idtbSH8KAxbrtAoJgkbmhgSKbuLjO1
         xoPgbS+d9oYIz8EOL2kQ2pInSqKcHdCEcDiSzkKyW/M2QURYUKzHs6V/9PpuTJAG0pkB
         K2Cii8suWSM2MiDlL2UOYnbONT6BwOuQNUtpD3BMSUkbj3PGGT3udoSvfpq5EDA7VOLt
         M785hPEr/2mJ15ZgPB1993mSrnZir0OWwJMJWIrYxdfyq/d9WLc8KBdqxIbjDW26C6a8
         /hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764061730; x=1764666530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCdO90en+FjhKk4ix5gedxAx+9JnP8FYLniKGNGpn2c=;
        b=AZ0EyUjqf6G5lUMmBmW0AtDuXvHBciHQdqvSyKkQoCYwrbEQ06s5Ra5b9c3kghMn6b
         W2aq7lFJp4Kx2XoueDsM9Nz+KX27gfwsmjSDkJX3q4rCt9a1SXcMjPyeaesKpFc10eQ6
         thXB666LJj5le+G2uaqp0BSfbL+ZRUHU8zO19LExmLZ18luKx6/hIpjtq+7ZqBHwr1Dc
         7qPpa3K7oRWbeC2BBdNewIubo+waGBiZzf+6z0ZzSsrAGpIoPRfZ5Bbx+Uv0cAlhWRGO
         49s/1Jos0LwYs6tk7/y3JZLFqk4tiAuNbEVouBYMZmf1TdEifNWqJ/mZRDgX7ZmtpL0G
         clLw==
X-Forwarded-Encrypted: i=1; AJvYcCWVHrmywiAqzGAcoge/DOXIg08XvVqO+ZHqc68nf4b5hVONe/qG2q7HaXMebT79J62CtpXyXkfU12ENWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi/KX7sZ/r9GJVRfwDir1h1EOrBRyLcd33FPjUZA/b2Gmn5K3S
	MQLjKzqJe+kfRSkNM9tb6B4bsVu9AlarNPb+V9ZM9Ics+cwo+OdJDfLBfgcBes86qs9PWp3Mubc
	JmpUCdcjSgbs+n6A4+r3acDlS/djjPYs=
X-Gm-Gg: ASbGnctmdsAWFVpyh8frVmYMvDk7x/t3Wl2GV826hiIT/xGn+6DPgU1tobyGM/91m+0
	7kJkcVtL2yBQDDnsvZLpzclwFIx2+vVNNkx+8BdiuoIhuUf4p5orLU+xoDnHeiDWCyfi5yX/SNU
	4Qxk/j2eZXR3WlM/KqC54/s11jK1/WWrks8bWFickLFOuA0wa0ZtGZP/Mz2TrJgov21upHsKUvz
	jPYJjmd+e06iRmBaGBQoaFSM4ITsCzPpZ319ahjxG5Mn0sfTKTBBA1J4j5Xs39KAod9iw==
X-Google-Smtp-Source: AGHT+IGTFbY486YnNQWkoWlEaQzvsvasZFyHoZ9KTpGkdm47RfNT3iuxVdTNRpkeEmLfhER+Qz0gUPpksmHAUXp+rAI=
X-Received: by 2002:a05:620a:4092:b0:8b2:4b6:22e0 with SMTP id
 af79cd13be357-8b33d468064mr1952580085a.60.1764061729682; Tue, 25 Nov 2025
 01:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124234432.1988476-1-joelagnelf@nvidia.com>
 <f73e4536-ec89-4625-96d4-6fa42018e4e4@amd.com> <CAPM=9twe3xcVBgrNCT+1_pGECPL-ry_aA2dxBwbKVeai4+S7AQ@mail.gmail.com>
 <24d4f02b-8ecd-4512-a1f0-ba41684ede1d@amd.com> <dfc50417-66ce-44ce-b607-917d678c5631@nvidia.com>
 <9f433dee-7ad9-4d0f-8ac1-e67deb409b70@amd.com>
In-Reply-To: <9f433dee-7ad9-4d0f-8ac1-e67deb409b70@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 25 Nov 2025 19:08:37 +1000
X-Gm-Features: AWmQ_bm6tlLng_0bNMM-_zVqLKGasd2tHLj_Nv0hY-yBLivUiNyEs9A42o3KV94
Message-ID: <CAPM=9tyN_A3oEyQZCOWaLO1orO6oKX0ZukJHR7cFy12Go+7d=A@mail.gmail.com>
Subject: Re: [PATCH] gpu: Move DRM buddy allocator one level up
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Deucher <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
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
	Trevor Gross <tmgross@umich.edu>, Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	Edwin Peer <epeer@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2025 at 18:11, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 11/25/25 08:59, John Hubbard wrote:
> > On 11/24/25 11:54 PM, Christian K=C3=B6nig wrote:
> >> On 11/25/25 08:49, Dave Airlie wrote:
> >>> On Tue, 25 Nov 2025 at 17:45, Christian K=C3=B6nig <christian.koenig@=
amd.com> wrote:
> > ...
> >> My question is why exactly is nova separated into nova-core and nova-d=
rm? That doesn't seem to be necessary in the first place.
> >>
> > The idea is that nova-core allows building up a separate software stack=
 for
> > VFIO, without pulling in any DRM-specific code that a hypervisor (for e=
xample)
> > wouldn't need. That makes for a smaller, more security-auditable set of=
 code
> > for that case.
>
> Well that is the same argument used by some AMD team to maintain a separa=
te out of tree hypervisor for nearly a decade.
>
> Additional to that the same argument has also been used to justify the KF=
D node as alternative API to DRM for compute.
>
> Both cases have proven to be extremely bad ideas.
>
> Background is that except for all the legacy stuff the DRM API is actuall=
y very well thought through and it is actually quite hard to come up with s=
omething similarly well.
>

Well you just answered your own question, why is AMD maintaining GIM
instead of solving this upstream with a split model? the nova-core/drm
split would be perfect for GIM.

kfd was a terrible idea, and we don't intend to offer userspace
multiple APIs with nova, nova-drm will be the primary userspace API
provider. nova-core will not provide userspace API, it will provide an
API to nova-drm and an API to the vgpu driver which will provide it's
own userspace API without graphics or compute, just enough to setup
VFs.

Dave.
