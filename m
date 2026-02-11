Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7C34846D;
	Wed, 11 Feb 2026 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844680; cv=none; b=car26qXoRcg39HF5QyTdBNeOX5boQhWYl9mWnw0huw95OxHZQPyuG1WRLrxYmw9BA/4O5pkoQEqd1d0uq1Y75RhsNGr4oxSoj5DkMC4bBrL7dcv+UPi1DjOyOnBp5mLzL5pxuiwenWeimPwKelQrdr8abVxKce1xuwFnUR8uSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844680; c=relaxed/simple;
	bh=Xk2na6235/6MdtkvIhpTRHZmnBktjn8EJsmkNHoHgrE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=J4OXBAjmoz7SgMmc1j09Q4JsRaPMVkJjk5p9Zxs93+LRoOelzPQw3g8f8SYRE2WEa4/VlDSz2t7eYW9rPjkn9UmSuw+o7VABghcV2bmkvHjw9tpCU8O0llcE6FyiBnC16ZG0hK3QSVaRsMQI1zSlFP1zqNIxq28q7gPJ/eJBPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvFSgP7e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvFSgP7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3614FC4CEF7;
	Wed, 11 Feb 2026 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770844680;
	bh=Xk2na6235/6MdtkvIhpTRHZmnBktjn8EJsmkNHoHgrE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pvFSgP7elG8OioKaof0a5y8V+UeqIvIJPG+ORj4CYPFr0S2UTkWWWbG0TeASObmAG
	 ld/2Ev08iZ7H17laDT6HY+vl5c1KPccISOEmTY5yNnb0KHbHe7X7dwBH35O5Kj5V80
	 I1nSWjqVMOy7jX1jsYA4lloLS+T/lz8JVK5hco0RhZ2RE3BYPtFbgpKTVxHX9+kKBm
	 bOkKsO5SwTP3Vmc05Ti8merg7u0PtlDwVpPXxdTxMW62HnkGuhSqcsU9je/EYTJFW/
	 Jahai5V1xcB29kEuBDG9/KadzI/EDX63FjALRne+JKjabdUH/sLG44pAVNU/YFu6cV
	 VPb0rG16+zFrQ==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Feb 2026 22:17:50 +0100
Message-Id: <DGCG1MWY5SJC.1ZGMNKR8E2NPW@kernel.org>
Subject: Re: [PATCH -next v8 1/3] rust: clist: Add support to interface with
 C linked lists
Cc: <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet" <corbet@lwn.net>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Helge Deller" <deller@gmx.de>, "Alice Ryhl" <aliceryhl@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Alistair Popple" <apopple@nvidia.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <joel@joelfernandes.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260209214246.2783990-1-joelagnelf@nvidia.com>
 <20260209214246.2783990-2-joelagnelf@nvidia.com>
 <DGB75XMWML8M.DFZY5L52EBQF@kernel.org> <20260211210952.GA3632639@joelbox2>
In-Reply-To: <20260211210952.GA3632639@joelbox2>

On Wed Feb 11, 2026 at 10:09 PM CET, Joel Fernandes wrote:
> On Tue, Feb 10, 2026 at 11:07:37AM +0100, Danilo Krummrich wrote:
>> On Mon Feb 9, 2026 at 10:42 PM CET, Joel Fernandes wrote:
>> >  rust/kernel/clist.rs   | 320 ++++++++++++++++++++++++++++++++++++++++=
+
>>=20
>> I think we should move this under rust/kernel/ffi/ to make it obvious th=
at this
>> is FFI infrastructure.
>>=20
>> > diff --git a/rust/kernel/clist.rs b/rust/kernel/clist.rs
>> > new file mode 100644
>> > index 000000000000..8aa72b5d54be
>> > --- /dev/null
>> > +++ b/rust/kernel/clist.rs
>> > @@ -0,0 +1,320 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +//! A C doubly circular intrusive linked list interface for rust code=
.
>>=20
>> Here and in the struct documentation, I'd suggest to clearly point out t=
he
>> use-cases, i.e. that this infrastructure is for FFI use-cases only and s=
hould
>> not be used otherwise in drivers, etc
>
> I am curious why we would not want to have drivers be able to use CList. =
I
> thought that was the point of making it pub at the module/item level as w=
ell.
> I think it is possible a rust driver may have a reference to a CList in t=
he
> future.

It is a (partially) unsafe API built to support FFI interactions. The absol=
ute
majority of drivers should not have any FFI interactions themselves. nova-c=
ore
is the "odd one" as it will have an interface with a C driver (vGPU).

Besides a few "odd" drivers, there may be quite some subsystem abstractions=
 that
become users of the API. In the future build system, subsystems and drivers=
 will
become individual crates.

> But I will update the current usecase above, as you suggested, good point=
.
