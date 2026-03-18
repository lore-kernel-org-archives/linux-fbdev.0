Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FAC3E9595
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860244; cv=pass; b=MWa1MFb/KM/+tLzSD55IFGUv59LYoZTlPD6nbP/Z4pTdJwWLfHWJgfQwOvY9G/C5TH5O979BmRc+6GTj4xedTwJNJhTDlTJh3DnQZN4t/f72xARfAvxS26AnFln9aah+M+29z0id67CmrSaUt5BXTDtsBzt5nMb0UP7lR86s9dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860244; c=relaxed/simple;
	bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpIItQwo+NBU501GAgyVIpzAx2Ix2z60DJBvDCvE2YIWLv0A6pcLRJPxtVXKZsIOXnEso5RjMGJpGqb2qiC14Ay1eltxC/PAv/aMX+o7hlYGoasNhB6ywYeWyXN/6PAP8SbQyZCtoyH0xtNTFA+ntWFjcJKWAmhIYg7oC/MHjl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2A17xX8; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2A17xX8"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12714f01940so25262c88.0
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 11:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773860243; cv=none;
        d=google.com; s=arc-20240605;
        b=I2LRT1CI+bupzyqutS/uxLnxPK4QVd0dN8GAOzggBqZ71zX8Ry3nIJyhHZdQaKGRjy
         vXuFwpcp2ztq8olmYN7N8hPd5TatS3NwsiCP7mxblM2WaevSc4D6wNjLs7LTseN5QjNd
         RHnAf1BgrCkpapmpp0TYvy068nYr6E8IWF5nlPGjJxc/SpXKbMCns/2qD5KuNYx45/sF
         rgccNqmJfs7PWASG+83x5DNB7ouuk/OSTotvOA0p46PKaukBk+ghe4xZv8qBT0TOrrIc
         boW1bBDeIjKblfGuSkuQXf3VFy5YQK/SQ2GTsug+AL6FFkrX+8yam5R/FRTIDCbSa3Es
         IFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
        fh=5bxJkoAZyqtudrjFzNbzz2kCvqdP+KDsUVAMuX3l10o=;
        b=X0sAF3ove4kVVYq6r0RztlbyGT4hsp85mWdAFt0gzJDBT5b5esnQKksKVV5RxD3a79
         +JTeFNh2Hmwh6VEcEdOIkDzwgKMTy3q7JVLKXQx1PSzCetWOZQqiEqId3KDHMBRzT2e3
         S6QOOG9QLdMm+8vovEr7yoNA+Qr3sDmejdTLFUrQuXsioqhSUjPnslKSdiFtH/6duG/1
         32KmcptUwntwTz9sGafK0S1fuFth9oXyKV6FFO3uPV/T99Wlo+uvRRIoRyHS/MMNKCPy
         W9MWQibWAAUVBGv72xsxOww01Q2JUoMvye4YIqioj50y7sXvZNnikYg13fdnSu+5sDVX
         +lIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773860243; x=1774465043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
        b=G2A17xX87xyMH1dzp54YJNtLJNegkpLBUxOAo72HevAParB3VTcSAk17TM7ahF/sQQ
         RlASRGT5/tLdBDwlHuKdv0RDc0YEbMaHnY+iCyjIAt1bxctLJkwznYUD06ySntITHGej
         MXTGYpVqcbz0OTnhiJtE7JycWw277IP/39FR8t33hlDa6DPWvONh2l2vPM2QwLE20bvW
         V4R01ZRc2O3VL5rBJ6jKLo+BsUOz8zrOacH969U7mZGu9vafScCwEwm+E/AODHvzD9ZL
         goCnsb8gWjW/jWA1uguNdvs+j0/11pGX1rjdOlamsxZo1D0fGnP5r9vWYEHn3qCew8KE
         UhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860243; x=1774465043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
        b=YPMvYwONohXC9QCTCoH+qiqZ5ByWQNq9ryt8GnV0u1YVz8hTnp9bn5zxuAqXUaEQOk
         neWg1LJ6Fs69IJdK8eJzKXF+5KR1+ozEIjNGZ/9Sf8qQIFa0oKM3tZU22TVvgxbwi/9x
         zWrmDqVEZ3X4rxFmY+uBnxFgb/LG2lu6xOQYF+DavWWPUGTkueRUvWAyG35Jm6i4RYr1
         z4eAQwUzE4ENlhbUy07QYauOIayTxLKEK8LEvCxaMcHUxy9v4msaVmjuoWdfipFSdmwb
         kul4XxIqfxuieGKoT7hpFTINYozHnd5FYFGSG1qkFguySwWHWdm7KA4kE2pgTb13ikS2
         k4pg==
X-Forwarded-Encrypted: i=1; AJvYcCW9cVT3y/BcrZFtKuxZBO4Ab0trhCOZbJYbWVioOU5TU3+BjEddr+KlW011TByiZb7K+A+Kr24P21gnUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1UkMDVO16h7A7wqriPVyXbUpsqi66oYWpgSSQFG0newg/6Pj
	3lDXEVc1x+dPJsnIoOZS0ej6sxPoPD9yNndScgCFZxU9DqUn4HQpH3iO5ow9Zpc6Im1lmXaBddH
	UtaNYz47PeMGTiwzZSAKy8YBv1tm14F4=
X-Gm-Gg: ATEYQzyW3LU/Z16PaKnCYxbZ4/8fmEwU18QuZRDaTAtnsQOUajQ1hw0srTF9zteHKnF
	jquoNk3qhEoYEaoqzYmYueHdJjKfR/vAlhcOeNF9iZTZW0aYjeYTQtNYYLSJNwqQ0Er7hR6TvI+
	xwVf0aBvS1x+nqWJKecwK7pCj2c0wM3ToWiRkWANwdlKLJPCXpi3nJUvzNmWMCPgf45C5+IUnTT
	GTNIhBQAG7kXyPhHRPrJ2tbihF1hCyZwqu0HXVe8vO2o6M5GVfM1Cs9C4cVR7MIYdtAgZUPYFS2
	K1zTN+yXVRlSR74x3QoaahJzIEqSEfTNdbgfNRnicPYSutbrLowBqNh2s1XprsL2NbQ29l5a3TZ
	j++Lf4Q6LSnEvRv3E9Z4rG3JE//V6f1/7TA==
X-Received: by 2002:a05:7301:658a:b0:2bd:a3fa:9bdc with SMTP id
 5a478bee46e88-2c0e51afa4fmr1076751eec.5.1773860242532; Wed, 18 Mar 2026
 11:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
 <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
 <CANiq72nad-60tOJeAfkvHTFrWXQS_wbG4JUGQNnkjm_NvhhaYw@mail.gmail.com> <DH5ZP3IUEWMD.TOOZSEUTLV85@kernel.org>
In-Reply-To: <DH5ZP3IUEWMD.TOOZSEUTLV85@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 19:57:08 +0100
X-Gm-Features: AaiRm53Z-cAG5mIpOPhPdv8BAXPHEZ1FbMlHxMtUEupEIZpM9NVL3ZvZ5w4-nno
Message-ID: <CANiq72ndoX123PKYr4DbJpvQaM=1YjYoYhoTq7wMoY51X7PuNw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list interface
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Koen Koning <koen.koning@linux.intel.com>, 
	Nikola Djukic <ndjukic@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Helge Deller <deller@gmx.de>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, 
	Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	Balbir Singh <balbirs@nvidia.com>, alexeyi@nvidia.com, 
	Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 3:49=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> What do you mean with extra file?

Right, sorry -- I was probably overfocused on the `mod.rs` symlink for
some reason. We may have talked about generating them on the fly in
the past too, I don't recall anymore.

Let's assume "s/an extra file/extra lines" on my message... If folks
are OK writing manually them, or that we generate them on the fly,
then I am happy I can get the option I always liked! :P

We can chat about it in one of the calls.

Cheers,
Miguel
