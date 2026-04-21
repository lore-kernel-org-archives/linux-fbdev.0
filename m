Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6753DD531
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Apr 2026 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801959; cv=pass; b=QyIB9UJzZphj5mQZwaDfDwv9Wt47V7wCGWbqlJPBwG8ZAV9EEV1Lcfwl6hv8E9IQ8TCguRO1Y40mj6U2r6WfROfC3NuUvROcweV0f0nVl95rJH9Ca9MgH0pjufvzw4NkvWzbXGV/oPg4AKmx2T9z1HnSvUKl+KrZyxL5QDl/naY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801959; c=relaxed/simple;
	bh=Y1PLoj4e8iOjKgpTO1Z2p5qecvDaS7epvI5R7dinmlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNy+1BcrgNVJWbLKvYGf/LJ1nH4hi3veoSSqCuQHqkicjyBXHk8idenWQrJV77ORSePhqQ92Himec3qVBmU9ywbSmUmzDfsNi66H20yhYruQzd7M+QkhllKLw0SWgAueKAZkwIwQ7vxHw+BtBO6SrgsBx8o5+H30cA/4QdSctRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bK70RxBA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=boWnkarr; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK70RxBA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="boWnkarr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776801956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeHr6DVVipYM8wZRZ3joTJjeppE08pl393d8VJrbaO8=;
	b=bK70RxBAjBkXkA/jCCxLxAxUcUlK/cU1o8zYiiDVRJwdYgSHOdBB96Ocpuz6fIFNNZBarG
	8Wd1MX+3Ecpqhp1HIOo/bosx8gq1yxxpoAGZ1jaXxQtxZ3GmbjMIAt3H25TgrmE3cn+kZg
	H8p/1DlVS00p20rrF/LCdIkww9ZeQbE=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-NWRuPf6QOgefLTKv00P4EA-1; Tue, 21 Apr 2026 16:05:55 -0400
X-MC-Unique: NWRuPf6QOgefLTKv00P4EA-1
X-Mimecast-MFC-AGG-ID: NWRuPf6QOgefLTKv00P4EA_1776801953
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12734af2ca4so2763045c88.0
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Apr 2026 13:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776801953; cv=none;
        d=google.com; s=arc-20240605;
        b=TY8XKIGqrmYnjWoH0AnaTtMAu7ZaFXk/tHTnem8B5Dbg7Y2OUESYlqV5e5aU0FsUVp
         o10Y6T4uFuqO/5/l1opZ2GpkUXBtSbWfXMSdH8aHzvmUi6TokWzbh1y7bB1SNPqZwg4g
         ZRpm9JpvWrylbc6RYw8AYZhKX6idRBv0/wM08xDXQVYjMGkppntQEiw3mk0JB7KYsZTw
         jQEt1nmIktQ3y0XM9r1M680zKXGP1g3GKoVj9tVfQNlzt8XKyvUJj8mp/AQ/Yj95Bgbd
         KFg5Xl5Ucy+ki6VUmpYBF2v3qmz8raDC8/2ZE8R3F2S0LZgZZEe+rePJ1SvxteIZQSRd
         AZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XeHr6DVVipYM8wZRZ3joTJjeppE08pl393d8VJrbaO8=;
        fh=D38LAfT+GlpIbpEjkE8Tf0QjIstr3WFzd3F5nCjWbzI=;
        b=gBScUVesOFexnRkygcvu+L8WYQrTaRq32HKLNip9i8KKFrtMQsvRFeOh8M6sZRPWVA
         wa3B8OdukepcmflEm6o0XWh6ArSGduUOIw6sZJNmSxaf1ElROOdcShquu7vhxL9QiKwm
         7f0f1NgZX3T1UmjF9uzVNXUXE+sHoFo3GFaaWYl5GvZyWt1YZiCC2TnXKJMNED+jbEZp
         d2fVa1uUDQyHXYLoVLthrLJacLZvPm1dRPd/C/h+NhDDhIClBr1fIjbw65IM41WD9H4g
         0hQeqEMH7mef4H/4jOK7/gJPKtZNYuUOZUYO7kPqRzuvRLwaGFyEAKmB7+r73O0MnWZ2
         hsbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776801953; x=1777406753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeHr6DVVipYM8wZRZ3joTJjeppE08pl393d8VJrbaO8=;
        b=boWnkarrESPOMUmMVm98ZwQtxNh3XEyMkTo4+uWXgH1b9pDbBhXhwryrKU9vJQOw83
         uYfSGYeHoKTehsV88BEidvfZ71tdHgjnCJhVQXRHSvn4oSQTOKO9iASj2v/RnnJ3Y35K
         YCPwccoLsjdEYMHOkrgm5ttEMDlXMmyBJ2Dv9EbJzfGKn6hZmy+S5won9tmHl7lq5wnP
         IVoSwaRiMxM4zNeqFbMRCxZqEmHp1QmJ6QRmmXC95tlBWtKPQGBZ+vQJhanFwXRIyC9w
         E6mrdgHVE2250+XKfvAwHJnrmhIXdc5WdM0UiLT0D8No8YlL7k/uFneXmXZL8FRXLeml
         +kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801953; x=1777406753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XeHr6DVVipYM8wZRZ3joTJjeppE08pl393d8VJrbaO8=;
        b=cQeANvUmskaAzE7MPIqTSTo0GaJjkWmzTsXDAow3y0ptpubUXyPXt4QKJGLj/brGCa
         CZpZMpjIssCSKD0jwpLJmIiLGL7f0uO2qYypyWcYMQBQWuiwkTON4JfyIcqSzMqQuTjh
         8As+1ddtw3M3LIcwwQwQJcmMFJLSuF+zKUKEdsphgq4XGHgdgoH8/omiL6irSQ8ZJpNX
         r4EKfT9h5B5qwFk49+Ay3q+ia0mPbrMDjwFIMR8pigt0WoKCNWkOwgjMNAnJztZAkKo1
         WNzRHiEYw9R6U/GXhq4BZ36v8cOwEhWWPVMqEkgQpjKlYgg4UPDLPnqjt4rSuIlKSIiN
         SBMA==
X-Forwarded-Encrypted: i=1; AFNElJ9Kp8xXht1SfQbdV5p9pQo/0odoZ5qGdcmpmtKXTKPLLA8WIJg25oOtmz6q9aVb4sIjkl64EZKEIFLztw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPx0f9S4yWaNB0ncHoDmyCeu6WSzSyNgu56gBXIc9enxwn4hYp
	20LOOfmo0eUXqpMtV85KmCwb4vyG5jlKJ9YjOmVlHztCwmex4891IAgROVtX67Bm0XbshGnfPCZ
	6YEx+Nwx5pUraL4kUmoG8fHnuKTkuSz/NBeUEL+uTpcSmS8Br7nVnvlEJfQE1PIb8jjoabxolH1
	iev0AwlYWVD3uxv7l+w/6HgCPe99aHYDe+7B2uNcI=
X-Gm-Gg: AeBDiesyLRx43Vs/2eefWz/cb6V0efwQyqLJb2e2M1+gTDy9wpxOO86+YxrBXxpkDIx
	rU5WaJEKIYANg+LvdGk0I+/vNoUcdnoodMsA1XXmd66iqWs+/uTpq3xijTmUSzZtLa6HcIPTsrE
	kbRI1WWuptyX2VD0L+Xmh3tY2Pu31UWZ+hBD9UTm3A5kz4ARDy3IhpHadfURbGbyEzf//EED0wq
	Occujpxsvmvdku+poHFv39n4lgSbRiuRxBYJOHhKlnHg3o=
X-Received: by 2002:a05:7022:e985:b0:12d:b2ca:a9e9 with SMTP id a92af1059eb24-12db2caab80mr2009944c88.8.1776801952706;
        Tue, 21 Apr 2026 13:05:52 -0700 (PDT)
X-Received: by 2002:a05:7022:e985:b0:12d:b2ca:a9e9 with SMTP id
 a92af1059eb24-12db2caab80mr2009922c88.8.1776801952185; Tue, 21 Apr 2026
 13:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415210548.3776595-1-joelagnelf@nvidia.com>
 <20260415210548.3776595-2-joelagnelf@nvidia.com> <b0c5267d-ea77-41c5-94d4-39c651761b3c@nvidia.com>
 <20260421145521.GA51176@joelbox2>
In-Reply-To: <20260421145521.GA51176@joelbox2>
From: David Airlie <airlied@redhat.com>
Date: Wed, 22 Apr 2026 06:05:41 +1000
X-Gm-Features: AQROBzAsZiSzIuFbaTfYEhScUqQNnqcYEoqTT_Ur4O9PkcMB0Af7pJH5n1PBSF4
Message-ID: <CAMwc25o2qmaYnfsh-cW4M4PEbmpYb_1x4qg1_2155P0orzCnOQ@mail.gmail.com>
Subject: Re: [PATCH v11 02/20] gpu: nova-core: gsp: Extract usable FB region
 from GSP
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Koen Koning <koen.koning@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Nikola Djukic <ndjukic@nvidia.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Deucher <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, Helge Deller <deller@gmx.de>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>, 
	Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>, 
	Philipp Stanner <phasta@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, alexeyi@nvidia.com, 
	Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 12:55=E2=80=AFAM Joel Fernandes <joelagnelf@nvidia.=
com> wrote:
>
> On Thu, Apr 16, 2026 at 04:26:48PM -0700, John Hubbard wrote:
> > On 4/15/26 2:05 PM, Joel Fernandes wrote:
> > ...
> >
> > Apologies, I found one more minor thing, while looking at a
> > subsequent patch in this series:
> >
> > >  impl MessageFromGsp for GetGspStaticInfoReply {
> > >      const FUNCTION: MsgFunction =3D MsgFunction::GetGspStaticInfo;
> > >      type Message =3D GspStaticConfigInfo;
> > > -    type InitError =3D Infallible;
> > > +    type InitError =3D Error;
> > >
> > >      fn read(
> > >          msg: &Self::Message,
> > > @@ -205,6 +209,7 @@ fn read(
> > >      ) -> Result<Self, Self::InitError> {
> > >          Ok(GetGspStaticInfoReply {
> > >              gpu_name: msg.gpu_name_str(),
> > > +            usable_fb_region: msg.first_usable_fb_region().ok_or(ENO=
DEV)?,
> >
> > OK, failing out is correct here. But in addition, we should also
> > log this at dev_err!() level. This is rare, surprising, and actionable,
> > so perfect for that level of logging.
>
> Sure, that works for me. Will add it in for v12.

Just fyi when we get to spark later this will not matter, we will have
no usable_fb_region, though maybe it could just return 0s in that
case.

Dave.

