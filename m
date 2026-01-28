Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDBC2FE56A;
	Wed, 28 Jan 2026 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600277; cv=none; b=kHTY2gsyFLMenv5qKRL8XQ+SmSXiB29vrz31PXC94vRaKetL6yN1aBrpws6aCOCiUSv9uSNtLzIxh1eMJ6pmSLab6RoS2lJ0z4s3A6ACGsDO/r9LXz4ax2YA9KABvqEq2U9hk0rzxCr2iMXW8qZP6LS1aOknxaFW8teU8cz9Q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600277; c=relaxed/simple;
	bh=Q84GU8xgsjGXyT/viKhB7wVI26KgRvvwxmD1gNRdy8M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=u5LzkUqDtNn3OFjchTCm0JW0TTHxfZrJcqaV8BpdG2muoiOWCm39yt04UemmKE2U62HTHI/x2q3oMnDgT1wOTf0mXZ2BP7FVIvtikvohOEWjjFv950KuhPtF480Y1jOWPJp6COjBvaW58cEYT4A6TgW+Ccnk/IQgRNycmgWurws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEC26QRf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEC26QRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23404C4CEF1;
	Wed, 28 Jan 2026 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769600277;
	bh=Q84GU8xgsjGXyT/viKhB7wVI26KgRvvwxmD1gNRdy8M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=VEC26QRf+0VxV8vqSHDh+7/n7HJgr9VHxk0DfXO02krOr0HKGpHnslA8xQM7F/Sfx
	 uvgpjvKWl80Jt2NzzrP5Vf4WzZEKkgkCutpfrCte31cGJ0oyWexjKhZZJaw9iMT5Kr
	 MRJ659ORGYlPWX98JxGlDIa2zLTppGEXexk40IyQd06aW2Z0u1J2et46X9rBROXCpr
	 3Eu1ofi7CTwfE7MEJTfTYl337ZPaHDbJf5Fxu+NXyXcRqGvGFSqH2uIoULyZTrma/o
	 gNvMYUWfo1U6149cpZkMVGRsGAZLiRYJ5I0009kg+Guok8oyVcMNOqbgdra/drRR6I
	 tev/SXp8kLopQ==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 12:37:44 +0100
Message-Id: <DG06XUWOJLO5.1ESB8ES6A6081@kernel.org>
Subject: Re: [PATCH RFC v6 00/26] nova-core: Memory management
 infrastructure (v6)
Cc: <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
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
 "Helge Deller" <deller@gmx.de>, "Alice Ryhl" <aliceryhl@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Alexey Ivanov" <alexeyi@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <joel@joelfernandes.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
In-Reply-To: <20260120204303.3229303-1-joelagnelf@nvidia.com>

On Tue Jan 20, 2026 at 9:42 PM CET, Joel Fernandes wrote:
> This series is rebased on drm-rust-kernel/drm-rust-next and provides memo=
ry
> management infrastructure for the nova-core GPU driver. It combines sever=
al
> previous series and provides a foundation for nova GPU memory management
> including page tables, virtual memory management, and BAR mapping. All th=
ese
> are critical nova-core features.

Thanks for this work, I will go through the series soon. (Although it would=
 also
be nice to have what I mention below addressed first.)

> The series includes:
> - A Rust module (CList) to interface with C circular linked lists, requir=
ed
>   for iterating over buddy allocator blocks.
> - Movement of the DRM buddy allocator up to drivers/gpu/ level, renamed t=
o GPU buddy.
> - Rust bindings for the GPU buddy allocator.
> - PRAMIN aperture support for direct VRAM access.
> - Page table types for MMU v2 and v3 formats.
> - Virtual Memory Manager (VMM) for GPU virtual address space management.
> - BAR1 user interface for mapping access GPU via virtual memory.
> - Selftests for PRAMIN and BAR1 user interface (disabled by default).
>
> Changes from v5 to v6:
> - Rebased on drm-rust-kernel/drm-rust-next
> - Added page table types and page table walker infrastructure
> - Added Virtual Memory Manager (VMM)
> - Added BAR1 user interface
> - Added TLB flush support
> - Added GpuMm memory manager
> - Extended to 26 patches from 6 (full mm infrastructure now included)
>
> The git tree with all patches can be found at:
> git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: nova-=
mm-v6-20260120)
>
> Link to v5: https://lore.kernel.org/all/20251219203805.1246586-1-joelagne=
lf@nvidia.com/
>
> Previous series that are combined:
> - v4 (clist + buddy): https://lore.kernel.org/all/20251204215129.2357292-=
1-joelagnelf@nvidia.com/
> - v3 (clist only): https://lore.kernel.org/all/20251129213056.4021375-1-j=
oelagnelf@nvidia.com/
> - v2 (clist only): https://lore.kernel.org/all/20251111171315.2196103-4-j=
oelagnelf@nvidia.com/
> - clist RFC (original with buddy): https://lore.kernel.org/all/2025103019=
0613.1224287-1-joelagnelf@nvidia.com/
> - DRM buddy move: https://lore.kernel.org/all/20251124234432.1988476-1-jo=
elagnelf@nvidia.com/
> - PRAMIN series: https://lore.kernel.org/all/20251020185539.49986-1-joela=
gnelf@nvidia.com/

I'm not overly happy with this version history. I understand that you are
building things on top of each other, but going back and forth with adding =
and
removing features from a series is confusing and makes it hard to keep trac=
k of
things.

(In the worst case it may even result in reviewers skipping over it leaving=
 you
with no progress eventually.)

I.e. you stared with a CList and DRM buddy RFC, then DRM buddy disappeared =
for a
few versions and came back eventually. Then, in the next version, the PRAMI=
N
stuff came back in, which also had a predecessor series already and now you
added lots of MM stuff on top of it.

The whole version history is about what features and patches were added and
removed to/from the series, rather than about what actually changed design =
wise
and code wise between the iterations (which is the important part for revie=
wers
and maintainers).

I also think it is confusing that a lot of the patches in this series have =
never
been posted before, yet they are labeled as v6 of this RFC.

Hence, please separate the features from each other in separate patch serie=
s,
with their own proper version history and changelog. In order to account fo=
r the
dependencies, you can just mention them in the cover letter and add a link =
to
the other related patch series, which should be sufficient for people inter=
ested
in the full picture.

I think the most clean approach would probably be a split with CList, DRM b=
uddy
and Nova MM stuff.

And just to clarify, in the end I do not care too much about whether it's a=
ll in
a single series or split up, but going back and forth with combining things=
 that
once have been separate and have a separate history doesn't work out well.
