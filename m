Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE6319848;
	Tue, 10 Feb 2026 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724513; cv=none; b=NxgZ8X+eh9z4wkV6QGC48+UOFghCFWYfqcXkk/K9dRm0t5Z30yTK5ueBg1yK8Ubh4XtazOAbVR3pWmoDB9sJbPKMTA41VRn7gAF5LFo78v47Ub3Hflxg24zaZlh8v8IX+uuTEVz/eSL4IG7ErNlguNhvE9DjMvreXeMKvcTIlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724513; c=relaxed/simple;
	bh=YHEMObMfKBsNNt+IT3C08BQUnMajYKrlxt36jnYTOM0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=bHgeR/e+AzSb/pRMWKIv9WnsArp0rkME/rFo7tins213UlGG1r5jDND+AQDeDnfnyWAEOpuUqTtUrzZOoEDDvCJRufycnpYjzT+/FIHUpEQ3tUBtDLYIhXVDV34Zel3SS9WfIVQ9t5HxTlS9Ii+4SkeJ/Qr4XTL8cesgdVEOLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxy6aCvE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxy6aCvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED62EC116C6;
	Tue, 10 Feb 2026 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770724512;
	bh=YHEMObMfKBsNNt+IT3C08BQUnMajYKrlxt36jnYTOM0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Sxy6aCvEEWcX6KtHkVp86DsMNpHLyi8vxUEzWWv5iEbbJQMUCCLpdLhZIydCwildX
	 7qnplmrrcs0wFBVPQu9lGnb2/Ignd1wgEPIn4qAhM5g1oLSrOwhNxBf6aT6TTU7x+z
	 Tp/js3mNnpH1gxO0pS9Gm3YneMYNJXqA8KJzwMGuI4RHhxxB114BVx/RhSy5L84rZl
	 BK3A7CP6H9z6jzPCn1MZQg50WLDBKQVinrDnkSXXc+gv93wJgo5zb82EnPNv/5q47m
	 rILSI5X2da1963xNdLQeBl2Y4ZW6PANjF0ScCGGfAO9krr86Xnw7BBK6kyiT3pHJFs
	 fKSLbeiscHScg==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 12:55:01 +0100
Message-Id: <DGB9G697GSWO.3VBFGU5MKFPMR@kernel.org>
Subject: Re: [PATCH -next v8 2/3] rust: gpu: Add GPU buddy allocator
 bindings
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
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <joel@joelfernandes.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260209214246.2783990-1-joelagnelf@nvidia.com>
 <20260209214246.2783990-3-joelagnelf@nvidia.com>
In-Reply-To: <20260209214246.2783990-3-joelagnelf@nvidia.com>

On Mon Feb 9, 2026 at 10:42 PM CET, Joel Fernandes wrote:

[...]

> +//! params.size_bytes =3D SZ_8M as u64;

It looks there are ~30 occurences of `as u64` in this example code, which s=
eems
quite inconvinient for drivers.

In nova-core I proposed to have FromSafeCast / IntoSafeCast for usize, u32 =
and
u64, which would help here as well, once factored out.

But even this seems pretty annoying. I wonder if we should just have separa=
te
64-bit size constants, as they'd be pretty useful in other places as well, =
e.g.
GPUVM.

> +/// Inner structure holding the actual buddy allocator.
> +///
> +/// # Synchronization
> +///
> +/// The C `gpu_buddy` API requires synchronization (see `include/linux/g=
pu_buddy.h`).
> +/// The internal [`GpuBuddyGuard`] ensures that the lock is held for all
> +/// allocator and free operations, preventing races between concurrent a=
llocations
> +/// and the freeing that occurs when [`AllocatedBlocks`] is dropped.
> +///
> +/// # Invariants
> +///
> +/// The inner [`Opaque`] contains a valid, initialized buddy allocator.
> +#[pin_data(PinnedDrop)]
> +struct GpuBuddyInner {
> +    #[pin]
> +    inner: Opaque<bindings::gpu_buddy>,
> +    #[pin]
> +    lock: Mutex<()>,

Why don't we have the mutex around the Opaque<bindings::gpu_buddy>? It's th=
e
only field the mutex does protect.

Is it because mutex does not take an impl PinInit? If so, we should add a
comment with a proper TODO.

> +    /// Base offset for all allocations (does not change after init).
> +    base_offset: u64,
> +    /// Cached chunk size (does not change after init).
> +    chunk_size: u64,
> +    /// Cached total size (does not change after init).
> +    size: u64,
> +}
> +
> +impl GpuBuddyInner {
> +    /// Create a pin-initializer for the buddy allocator.
> +    fn new(params: &GpuBuddyParams) -> impl PinInit<Self, Error> {

I think we can just pass them by value, they shouldn't be needed anymore af=
ter
the GpuBuddy instance has been constructed.

> +        let base_offset =3D params.base_offset_bytes;
> +        let size =3D params.physical_memory_size_bytes;
> +        let chunk_size =3D params.chunk_size_bytes;
> +
> +        try_pin_init!(Self {
> +            inner <- Opaque::try_ffi_init(|ptr| {
> +                // SAFETY: ptr points to valid uninitialized memory from=
 the pin-init
> +                // infrastructure. gpu_buddy_init will initialize the st=
ructure.
> +                to_result(unsafe { bindings::gpu_buddy_init(ptr, size, c=
hunk_size) })
> +            }),
> +            lock <- new_mutex!(()),
> +            base_offset: base_offset,
> +            chunk_size: chunk_size,
> +            size: size,
> +        })
> +    }

<snip>

> +/// GPU buddy allocator instance.
> +///
> +/// This structure wraps the C `gpu_buddy` allocator using reference cou=
nting.
> +/// The allocator is automatically cleaned up when all references are dr=
opped.
> +///
> +/// # Invariants
> +///
> +/// The inner [`Arc`] points to a valid, initialized GPU buddy allocator=
.
> +pub struct GpuBuddy(Arc<GpuBuddyInner>);
> +
> +impl GpuBuddy {
> +    /// Create a new buddy allocator.
> +    ///
> +    /// Creates a buddy allocator that manages a contiguous address spac=
e of the given
> +    /// size, with the specified minimum allocation unit (chunk_size mus=
t be at least 4KB).
> +    pub fn new(params: &GpuBuddyParams) -> Result<Self> {

Same here, we should be able to take this by value.

> +        Ok(Self(Arc::pin_init(
> +            GpuBuddyInner::new(params),
> +            GFP_KERNEL,
> +        )?))
> +    }

<snip>

> +    /// Allocate blocks from the buddy allocator.
> +    ///
> +    /// Returns an [`Arc<AllocatedBlocks>`] structure that owns the allo=
cated blocks
> +    /// and automatically frees them when all references are dropped.
> +    ///
> +    /// Takes `&self` instead of `&mut self` because the internal [`Mute=
x`] provides
> +    /// synchronization - no external `&mut` exclusivity needed.
> +    pub fn alloc_blocks(&self, params: &GpuBuddyAllocParams) -> Result<A=
rc<AllocatedBlocks>> {

Why do we force a reference count here? I think we should just return
impl PinInit<AllocatedBlocks, Error> and let the driver decide where to
initialize the object, no?

I.e. what if the driver wants to store additional data in a driver private
structure? Then we'd need two allocations otherwise and another reference c=
ount
in the worst case.

> +        let buddy_arc =3D Arc::clone(&self.0);
> +
> +        // Create pin-initializer that initializes list and allocates bl=
ocks.
> +        let init =3D try_pin_init!(AllocatedBlocks {
> +            buddy: Arc::clone(&buddy_arc),
> +            list <- CListHead::new(),
> +            flags: params.buddy_flags,
> +            _: {
> +                // Lock while allocating to serialize with concurrent fr=
ees.
> +                let guard =3D buddy.lock();
> +
> +                // SAFETY: `guard` provides exclusive access to the budd=
y allocator.
> +                to_result(unsafe {
> +                    bindings::gpu_buddy_alloc_blocks(
> +                        guard.as_raw(),
> +                        params.start_range_address,
> +                        params.end_range_address,
> +                        params.size_bytes,
> +                        params.min_block_size_bytes,
> +                        list.as_raw(),
> +                        params.buddy_flags.as_raw(),
> +                    )
> +                })?
> +            }
> +        });
> +
> +        Arc::pin_init(init, GFP_KERNEL)
> +    }
> +}
