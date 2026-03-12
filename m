Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1B366561;
	Thu, 12 Mar 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337551; cv=none; b=u/xQa9Rv5L+GC1FpJXciiFkKMG53dAxgjzAJ50oDWka/yhdG+OqC10I+bGb9H3RnZ70KvYDkywYPxobXNKzfFL0EtZigRy3bK2qM6P8Ye8f5e7RPSstMzL/tSOxBq8iBhEDsOm82PETi3aEqT/8tZRfnPl5IwTwlcfPHSHgy/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337551; c=relaxed/simple;
	bh=924fPqP8+L+UqzjLyzy+niPgmDpAM2woHTsOuNDY1wU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=NkMLuYCOHG7EbFQy/Ve9oTwilMIBU+4mrzzpLhfNgB/S3TBrZ99l+0YNFwp8ntJaGte7AIoY8FTyJocXOmKx26Y1S8MP8EXXLyZAuJx0Ie18j5NCUQqfNZB1fk9uSBBGRs0r/F9n3/ZkSSqKUMACW9FB92Bv4Cxjk4ZzIFxW3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR29QyOj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR29QyOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BA7C4CEF7;
	Thu, 12 Mar 2026 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773337550;
	bh=924fPqP8+L+UqzjLyzy+niPgmDpAM2woHTsOuNDY1wU=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=bR29QyOjk+UQadnDYTttijofj7pT/M32zA2gtbabtCX+vIMEwUUszq0eNQdEp4Pyz
	 5vL0TxE5fOYixb4Zg93Gijky+sEBxiknpT46Qv9W33ZgQ7nOwG3I7rNhWd2se22G2l
	 x9I1fDthxQD5G85C2RrNXF1+KU7pt2Te8Ty8FsaTDLY3d6b5vKdFn8F2fX/fQBBBUv
	 vg7D28qzxs9Ed2pzkzABGwT0MsyBtj+VcLicjBbY8pwIgiNeQEPkNcmkiCTh2H2Knn
	 RDPf/o+mJ+QXHCz0AxSkSVf5L88/s3c9fB9hemAwoFC0DNI9WEVd7iIJY7vnleEXMD
	 gX9z26K4hmQmQ==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 18:45:38 +0100
Message-Id: <DH0ZOYNAP1CN.1NL9E28UC2C95@kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v12.1 1/1] rust: gpu: Add GPU buddy allocator bindings
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Dave
 Airlie" <airlied@redhat.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Koen Koning"
 <koen.koning@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet"
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Helge Deller" <deller@gmx.de>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp
 Stanner" <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
References: <20260308180407.3988286-1-joelagnelf@nvidia.com>
 <20260309135338.3919996-1-joelagnelf@nvidia.com>
 <20260309135338.3919996-2-joelagnelf@nvidia.com>
In-Reply-To: <20260309135338.3919996-2-joelagnelf@nvidia.com>

On Mon Mar 9, 2026 at 2:53 PM CET, Joel Fernandes wrote:
> Add safe Rust abstractions over the Linux kernel's GPU buddy
> allocator for physical memory management. The GPU buddy allocator
> implements a binary buddy system useful for GPU physical memory
> allocation. nova-core will use it for physical memory allocation.
>
> Christian Koenig mentioned he'd like to step down from reviewer role for
> GPU buddy so updated accordingly. Arun/Matthew agree on the modified entr=
y.
>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  MAINTAINERS                     |   6 +-
>  rust/bindings/bindings_helper.h |  11 +
>  rust/helpers/gpu.c              |  23 ++
>  rust/helpers/helpers.c          |   1 +
>  rust/kernel/gpu/buddy.rs        | 611 ++++++++++++++++++++++++++++++++
>  rust/kernel/gpu/mod.rs          |   5 +
>  rust/kernel/lib.rs              |   2 +
>  7 files changed, 658 insertions(+), 1 deletion(-)
>  create mode 100644 rust/helpers/gpu.c
>  create mode 100644 rust/kernel/gpu/buddy.rs
>  create mode 100644 rust/kernel/gpu/mod.rs
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c66f8261ff2..b2600dd05fc2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8513,7 +8513,9 @@ T:	git https://gitlab.freedesktop.org/drm/rust/kern=
el.git
>  F:	drivers/gpu/drm/nova/
>  F:	drivers/gpu/drm/tyr/
>  F:	drivers/gpu/nova-core/
> +F:	rust/helpers/gpu.c
>  F:	rust/kernel/drm/
> +F:	rust/kernel/gpu/
> =20
>  DRM DRIVERS FOR ALLWINNER A10
>  M:	Chen-Yu Tsai <wens@kernel.org>
> @@ -8926,7 +8928,7 @@ F:	include/drm/ttm/
>  GPU BUDDY ALLOCATOR
>  M:	Matthew Auld <matthew.auld@intel.com>
>  M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
> -R:	Christian Koenig <christian.koenig@amd.com>

This should really be a separate patch as it is unrelated to the addition o=
f the
Rust GPU buddy code.

> +R:	Joel Fernandes <joelagnelf@nvidia.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> @@ -8935,6 +8937,8 @@ F:	drivers/gpu/buddy.c
>  F:	drivers/gpu/tests/gpu_buddy_test.c
>  F:	include/linux/gpu_buddy.h
>  F:	include/drm/drm_buddy.h
> +F:	rust/helpers/gpu.c
> +F:	rust/kernel/gpu/
