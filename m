Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C43BED18
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831581; cv=pass; b=JbkWYpZsebCqHpUv0esn0b9LSoMLUL/+grOy8d/o5ETXmfYBXg9NHDGMNDFGuxeHA/0f2aeKUHk5vSjYAoyHyDLQbN6amVSJuCgHXxxPFf1yJhkh+gSBbSF4WNCDBlrDXM8vscMAxcm0Ez3Du15nXA/SLgdkSpeKb5unrUASUrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831581; c=relaxed/simple;
	bh=Pgoh1PKkU8EkNum5z9YJaIpEiyCNGWxAB1mlPafIbAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzyytJ48X0Kk7GHJnZeDpueFZWqXKSnXKUx08BkZtoAt/9iVd6OGaFxEL6hBDlnvzYQtw2KpS130FDDy4xgbRKG/D/BUTNnDlcgmDpA0gWxj7qZGhOxrPB0lkhf7rYhf0DUN1fCYKHtRTO7T3lnkodWdMGQMJNPJugB68YDw5yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEdT/JNG; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEdT/JNG"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so7612682f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 03:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773831573; cv=none;
        d=google.com; s=arc-20240605;
        b=KceZxezVx9eZci+enCn/u1SZJ15iSwcl3KgO3APf+i5+islyyie4dIVPvYWvUdvn8z
         cw/M4YtwNpnj54RQIk0JCzFMSOGPyoKTFCmX64i5rNXTO+yw3bAktwYetrJmD+ix9is/
         dzulcrLL7VROwFmeTBxpihgapPtDaUgDiAY+QPFOrNMhZevEGmfCo9GuAi9LfH7zKCc7
         /dNd8pxwtXK00gykIFC2sSiim5dm3XXdSwk81XVDXEDE6mPuIj0LPI38WoZycw0k0x+B
         HhxztvBuHWKI6iRc1cJsCeOePPmDZiW5btseKnjpmA6GGKHHOR8JNNcPbes26FTpgYgM
         XwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/1Satukh6eOX2Q2yp9irpav0rskLC7MIDb5UTQcoh4=;
        fh=fLHxjBqqtWjE5flFyX7xBggOaPGnrNWCngQuLHUpSWI=;
        b=OPn7ICVtG9q1arYD26LjLgRm8WRLyxKhvRBNJbVFhKx+iuAVvHNBYoydSjrIqYWgYr
         TJc7b/AYxGBSqSGiQVwwDIN+qrXwZdiiVg7TCvZ4CPDESyauy6DUztnWu+tAsK7NbrZJ
         l19IXuWwJ4c0rG9zhLrzcXLY1b4c4KFOcN0YE32txIy6n4FkoR/RzA6x9yrq8C2L+wbR
         6I+R5yCITqyh7kkrCOwVil9ugulN07yVofEXBn2ciK7WNW8lV0naa6uKaXDgPlEfjiP9
         WpnJld7WfAeshCGphXrZgvtwnQczHNTV5bSMWlZstYCs2NXLU2Yvxy4dzAt6Lk5JKHF6
         HwTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773831573; x=1774436373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/1Satukh6eOX2Q2yp9irpav0rskLC7MIDb5UTQcoh4=;
        b=JEdT/JNGEUJVFgKNl4stdFsMaonzwem7OZEJcq7ozT6Dxzvoir14qgUs05Jmk/jHFS
         jJcLf9UaOdLOcQZLiEFSZ0zCtXvHlNAXWIJLhnorMqOcrl/Vg6wOcW1BQrjHtMKLBcQz
         68cql43rzoPp1kYLuEqYQrKUNeC7x7O3WqFrXy2bb1yJBI3X6S2JQFV5qeGfvxWtHmDa
         u4v86Skvq8EwgVgzEBD80nIELKRW1LJqhkl8yhftyzK/cO1KHii53b4l7giD1zh7Ua5Q
         aP3drDjTrt5Nh9UvJF6v3m2InTz+ZbkP5rHr7/eIK69gNMGbwqiD7LjSCi+lJ82AlgEv
         3BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773831573; x=1774436373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S/1Satukh6eOX2Q2yp9irpav0rskLC7MIDb5UTQcoh4=;
        b=bZFhia8eaGIAolZUWZJ1yyRn0xi/J1VWB7C6BbbADQ8fY70j/DTG0ULtVfZ/agRkp+
         4yADks6/sGohzeg1/kAV7tjOPSUA0IPqYVgV+HTiqNRDC7jVHRtzFcLn8TnKowGSo5DV
         MEKNO1GVgZM+InPQ7zu21yWJp6QHJ2hKmsH0ltaOKhbvPvAR/yPsI6DfGy/uszcrp04B
         J8CpNXnYrXUCmwss+FguvU+9Ew9MvEumn6Faq1/qgxzngHtVhtVnIOeVPD+g8y6dIiy5
         LEzP3M1Qj+aAiAiXVqwK29Cl2Ekj9cs8sjjhLpvmbiPu+qicJ1TvFqEO7I5VoZZl0UnX
         KAlg==
X-Forwarded-Encrypted: i=1; AJvYcCUeAyYNFayep5UvCkVeehSmyEN6CdAz3om9AC8kZI92VSJwkVa9+VtWrzEodtxp+i/PIpojy87M4k9KTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyC8rCDPj68eVQ4bZdi6Ac+bCQM3B6a88312TTD9P/eLT1fzPf
	RpG4Sdr+j0wI7tAwWRxEvj2aInN1seQi296ptwJV8ezcCxbGLL0ieOneaoRUB9SwAigWR/s9X/2
	W8ibt43dt11eyHeiCNQIxE2eysqheJVRFqgzRkui0
X-Gm-Gg: ATEYQzzGvYMe5Vw4ADzzB/XJJam+UwPu7wx/omeQuSa1uFnSOiVJV/Bv30iq7J7HCOp
	cBMqSWGBbYfp8FWTMDD+tNC6j6USH+5wATnW5BnfIXqW164aSvWhYZwqFB62QUod85HFt9YJhOK
	uf45VjiYez0MJ9Y33TJ7JbsOmW7FHT3Z8tON9inXmbDl++malFMoJKz1CPLk91OGfWQsQJrL7yb
	hQJAA1OwN/wApKfdMRCBmZvkRzpFxP570iqWgeI8FPpuQIue6yV5fHGKHw0B7qVZDi52V6ysCxh
	/7sOKKt0RXrR9oeEVZgn5YmCUL2+xCbVDCC7iElz9+o6Zw8F9McHbbJ5qlxF0gDyiIIaSQ==
X-Received: by 2002:a05:6000:2dc6:b0:439:c62a:6dc2 with SMTP id
 ffacd0b85a97d-43b527c8385mr4835579f8f.41.1773831572498; Wed, 18 Mar 2026
 03:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
In-Reply-To: <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 18 Mar 2026 11:59:20 +0100
X-Gm-Features: AaiRm53Ixe1xgNfLSphN46y2ra7z4xTRu79njkh2iKHrEPi4sPbqBJ9Zi7PRuxY
Message-ID: <CAH5fLgjUMaC5v3SERZLosdD1ajU-fvKSgNq6OgbBBcoTS21-Sg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list interface
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
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

On Wed, Mar 18, 2026 at 11:53=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> On Wed Mar 18, 2026 at 5:59 PM JST, Alice Ryhl wrote:
> > On Tue, Mar 17, 2026 at 04:18:46PM -0400, Joel Fernandes wrote:
> >>
> >>
> >> On 3/17/2026 4:17 PM, Joel Fernandes wrote:
> >> > Add a new module `kernel::interop::list` for working with C's doubly
> >> > circular linked lists. Provide low-level iteration over list nodes.
> >> >
> >> > Typed iteration over actual items is provided with a `clist_create`
> >> > macro to assist in creation of the `CList` type.
> >> >
> >> > Cc: Nikola Djukic <ndjukic@nvidia.com>
> >> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> > Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> >> > Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> >> > Acked-by: Gary Guo <gary@garyguo.net>
> >> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
> >> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> > ---
> >> >  MAINTAINERS                 |   8 +
> >> >  rust/helpers/helpers.c      |   1 +
> >> >  rust/helpers/list.c         |  17 ++
> >> >  rust/kernel/interop.rs      |   9 +
> >> >  rust/kernel/interop/list.rs | 342 +++++++++++++++++++++++++++++++++=
+++
> >> >  rust/kernel/lib.rs          |   2 +
> >> >  6 files changed, 379 insertions(+)
> >> >  create mode 100644 rust/helpers/list.c
> >> >  create mode 100644 rust/kernel/interop.rs
> >> >  create mode 100644 rust/kernel/interop/list.rs
> >> >
> >> > diff --git a/MAINTAINERS b/MAINTAINERS
> >> > index 4bd6b538a51f..e847099efcc2 100644
> >> > --- a/MAINTAINERS
> >> > +++ b/MAINTAINERS
> >> > @@ -23251,6 +23251,14 @@ T:        git https://github.com/Rust-for-L=
inux/linux.git alloc-next
> >> >  F:        rust/kernel/alloc.rs
> >> >  F:        rust/kernel/alloc/
> >> >
> >> > +RUST [INTEROP]
> >> > +M:        Joel Fernandes <joelagnelf@nvidia.com>
> >> > +M:        Alexandre Courbot <acourbot@nvidia.com>
> >> > +L:        rust-for-linux@vger.kernel.org
> >> > +S:        Maintained
> >> > +T:        git https://github.com/Rust-for-Linux/linux.git interop-n=
ext
> >> > +F:        rust/kernel/interop/
> >>
> >> Sorry, I forgot to add an additional F: for the rust/kernel/interop.rs=
 file.
> >> Danilo/Miguel, do you mind adding this when applying?
> >
> > I think you should consider a mod.rs file to avoid this. It's tiny, and
> > just re-exports submodules, so I don't think the "mod.rs name in file
> > view" concern is that big, and IMO having files related to interop/
> > inside the directory is much better than having them outside.
>
> Ah, so there is a rationale for using a `mod.rs` file after all. What
> are the project-wide guidelines re: `foo.rs` vs `foo/mod.rs`?

I'm not sure we have discussed it in detail yet. Both are used in-tree.

Alice
