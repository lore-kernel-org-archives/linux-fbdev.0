Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9AF2D060E
	for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101860; cv=none; b=ZzUZEyVw818/cENbpaiqEDCOmJTJXKvII/gp1Aqpr6s3nAE1smP93PD5WdYrmeST+DTtAjFGQO/qudmSOEER6NG3D8huzxTFbAHcPLA/gTmfCrtn3555RClXQ6e+ckhdFjWseUTC8QD1rIbhdSDnfwPLmG7fTFlFAVLz9aWi288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101860; c=relaxed/simple;
	bh=i5xbOi/JRw9fbDfoOPiueWSD+D+pBvn2T4pJf+V+WQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmLKB4DrjRYuiz+44GhCf+2NRd1EMXp24ygAY10daEfoVCsHNzPRT515ADntuMwM6dtF6QEsu/MlppAGatOYFexDssVIRmz++z/kMLihI2x979Sgw1DNnl1EyJDO85N/P5YglhYh7gmTxl5bix2U4oJvsex+r2xSsfg/Hq3Va/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFEMI/97; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFEMI/97"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2da83f721so23482885a.1
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Nov 2025 12:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764101857; x=1764706657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5xbOi/JRw9fbDfoOPiueWSD+D+pBvn2T4pJf+V+WQY=;
        b=GFEMI/97lghW7B/kfcQgSWkvgECAhe8ZSkG/hudGCEFB2dxyOuEOVQCtEG5eo9ZMvV
         sxwaYSwBgUMMESMBi501BXh5aXeJJtNwu51n7jbzkijiRJ83skIOGmBuhvjf+cBfNaF8
         97tkb+tG83v5CoxmHtOH5kEK2HwWpVW+VmqeE+cOdNwO7hO/8hJ/kHWzb97cSz/0uCq9
         Mo+b0d8A5zZ34N8tUs7Qh4ei0AIL1TQ/98wzGzMWX9SU4GyTuB9okNhNVWhFncRvAlOw
         xNlXP65cBVGo1Ep7nQitTT113cf2xKqcQrZ2cVOFveao2q+4/aLUDqF4ClXSPxPYKErg
         s/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764101857; x=1764706657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i5xbOi/JRw9fbDfoOPiueWSD+D+pBvn2T4pJf+V+WQY=;
        b=ZAfS5djvbogbRPv4B+pxNUKCuNnK/ZNLGiYyDsn2G4l4ebA9tI4MZ7BAOMeBaoo6CM
         4ItZaDf5nczAlTZv/u2/kdpAzky5MRjKyJt4k07OSPwUAvaDPfiYvnXorCRn9YaAoCIf
         aB3LX18LuB8UkYtntNCxHy4RF08fO8cA8cga2VVtzO98Wmv4Aypu5rbKTmeEqhinOBLO
         +oXlY0d80dChtem5RiLSPnOMYglp9dba4MNAv/QQ8Sv4W5BPd3maOfeqNjX4iVgY2lW4
         QNgmsTDMu6y9z6dZIsqoYtiCOTJA0G05J0Bbn78+c00ES/MWOqR3ZghHz24u2ZXA8Rie
         5yoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+7wwox7J4MS0ww2fgSV874g6UOT+Xut8u56aslbV5rWw9pd18qZuj1cXKmVZhoR/IJtiThcZGzmycoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeYuLcodTYISjjTy9ceXeoyX5jUpkl/XOygwz0g/pV7lOR1/Jh
	3VPp8vwlcFlVcHpr6mfji1cnLqN/HmhBlhD1naAGSg7XLMqZi5rgUj4vqWdZG0yLSojixN0gGSE
	2NC1cgC04FKh48Cg9gEdPsGY2u3+LBuQ=
X-Gm-Gg: ASbGncv7Thk1nTe7UX5MhTXYYnft18fW+JkFHxIk/8vZbCxvwVvPkVi4KfOXjItxVGj
	zjLLxA37wNjHMOm00/jaj8FxkaQLIMjEOkm3x7W8T3bhqvSl1EtiRQuQ9qers60/XgQ28JJZQ/W
	meaUNRa08TU8WdaiVGsuxl0b9O9+s08bsfh+1h8iENoY6gTCUaUEgHMPSQSNHi8I0kbcF2JyFv/
	318RYe3dfNucEIuu04WxaFw9fkGLv2SouVOuXeIhb2AqqfXWS4kBjbTk7eK7mmk/3paDwigw0ok
	Zd11
X-Google-Smtp-Source: AGHT+IHkFdHWZaY4LOLQkKFmHBql2cXu9IqsP0TX4ELpOPpCajUvQgW7eqKX4cHfwlYxtJIqgi3EGKK4Y8sqki2XcH8=
X-Received: by 2002:a05:620a:6910:b0:8b2:faa3:5639 with SMTP id
 af79cd13be357-8b33bc68daamr2220226285a.11.1764101856982; Tue, 25 Nov 2025
 12:17:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124234432.1988476-1-joelagnelf@nvidia.com>
 <f73e4536-ec89-4625-96d4-6fa42018e4e4@amd.com> <CAPM=9twe3xcVBgrNCT+1_pGECPL-ry_aA2dxBwbKVeai4+S7AQ@mail.gmail.com>
 <24d4f02b-8ecd-4512-a1f0-ba41684ede1d@amd.com> <dfc50417-66ce-44ce-b607-917d678c5631@nvidia.com>
 <9f433dee-7ad9-4d0f-8ac1-e67deb409b70@amd.com> <CAPM=9tyN_A3oEyQZCOWaLO1orO6oKX0ZukJHR7cFy12Go+7d=A@mail.gmail.com>
 <cc0db376-6cff-45d7-b3a3-d13be664700f@amd.com>
In-Reply-To: <cc0db376-6cff-45d7-b3a3-d13be664700f@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 26 Nov 2025 06:17:25 +1000
X-Gm-Features: AWmQ_bl_uhqER-0YSILUF1BfRs5LdG2TEdIVo4_rhtDFefamEG9auPeZIzRmvoQ
Message-ID: <CAPM=9tx5neQ=TbmK+2eAO=O-XW_67VhOGO-791kqyVDJEpTA+w@mail.gmail.com>
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
	linux-fbdev@vger.kernel.org, Zhi Wang <zhiw@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2025 at 19:15, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 11/25/25 10:08, Dave Airlie wrote:
> > On Tue, 25 Nov 2025 at 18:11, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote:
> >>
> >> On 11/25/25 08:59, John Hubbard wrote:
> >>> On 11/24/25 11:54 PM, Christian K=C3=B6nig wrote:
> >>>> On 11/25/25 08:49, Dave Airlie wrote:
> >>>>> On Tue, 25 Nov 2025 at 17:45, Christian K=C3=B6nig <christian.koeni=
g@amd.com> wrote:
> >>> ...
> >>>> My question is why exactly is nova separated into nova-core and nova=
-drm? That doesn't seem to be necessary in the first place.
> >>>>
> >>> The idea is that nova-core allows building up a separate software sta=
ck for
> >>> VFIO, without pulling in any DRM-specific code that a hypervisor (for=
 example)
> >>> wouldn't need. That makes for a smaller, more security-auditable set =
of code
> >>> for that case.
> >>
> >> Well that is the same argument used by some AMD team to maintain a sep=
arate out of tree hypervisor for nearly a decade.
> >>
> >> Additional to that the same argument has also been used to justify the=
 KFD node as alternative API to DRM for compute.
> >>
> >> Both cases have proven to be extremely bad ideas.
> >>
> >> Background is that except for all the legacy stuff the DRM API is actu=
ally very well thought through and it is actually quite hard to come up wit=
h something similarly well.
> >>
> >
> > Well you just answered your own question, why is AMD maintaining GIM
> > instead of solving this upstream with a split model? the nova-core/drm
> > split would be perfect for GIM.
>
> No, it won't.
>
> We have the requirement to work with GEM objects and DMA-buf file descrip=
tors in the hypervisor as well.
>
> And my suspicion is that you end up with the same requirements in nova as=
 well in which case you end up interchanging handles with DRM as well.
>
> We have seen the same for KFD and it turned out to be an absolutely horri=
ble interaction.
>
> > kfd was a terrible idea, and we don't intend to offer userspace
> > multiple APIs with nova, nova-drm will be the primary userspace API
> > provider. nova-core will not provide userspace API, it will provide an
> > API to nova-drm and an API to the vgpu driver which will provide it's
> > own userspace API without graphics or compute, just enough to setup
> > VFs.
>
> Ok, then why do you need nova-core in the first place? E.g. where should =
be the vgpu driver and what interface does it provide?

The ask is for a driver for cloud providers to run on their
hypervisors that does just enough to manage the VFs through VFIO
without having a complete drm driver or any drm infrastructure loaded.

The nice pictures are here
https://lore.kernel.org/all/20250903221111.3866249-1-zhiw@nvidia.com/

You will only be loading one of nova-drm or the vfio driver at least
in supported systems, depending on the GPU configuration, whether we
allow users to do things like that isn't well decided.

So far I haven't heard anything about needing dma-buf interactions at
that level, and maybe Zhi has more insight into the future there.

Dave.
