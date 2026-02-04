Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426A2DEA74
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177319; cv=pass; b=ujEcMhcTNhiU6xPpke3t8vXBm+Vl/g5upAcE6+t1hHkpPXrkZMmx00zLoFPitC2u0pDhjr8x4upwfBrHh9ytJ5XIdeXILzlzdMLYdKi2csZ2XBDeN/+FrHKExXMkbunSR4sDtMchVGpnaD55o3X48KsaiZTVBUa4Qi+xjjCf+1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177319; c=relaxed/simple;
	bh=H4pGZZbvseyzZif1fPnr/a6oisfe207lURmhI/AzW40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duCrJcZOb8mMQDxEoiUFhKjap/Ihux8Rs26facDtgiPS6XyqiXL8lkPvn4+dhAhXhHCIJZcdV8MEmZP6PJaTYuWwtTz8ne+X9/ecie5YQ6l9T+1y/92apEbRM7AFM0hSjq8K3LUqL1rGEUwhSy5K79dAPt503MzzP01Hv7B9Pn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2BCyLWj; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2BCyLWj"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8947e6ffd20so85800966d6.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Feb 2026 19:55:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770177317; cv=none;
        d=google.com; s=arc-20240605;
        b=aSf0FP0CeKcQxUnaK+NdBMlLzwY4A7UMJyDmDbY9xueeEtABllb1m/EyvMn0Aw52um
         knYXckVZ17I5oOQKwn8sd6cPLF62SiAB382Tx1eQKkfhZkD+7lWYnyMEw8SLRflcgRse
         oIpVpUdRoYf2V8QorK4jQ5bjnPug9+g09Jg+e9VW0Ie7ws77T7g9lW7aARlblUJ52kbU
         K6TvSM/GFW2WkADxn0YFXwdSFBNfc7Mv+sYpff52D2tIueBe+63kobIM5PKGj8KpSbjy
         7OXg/8kDjxbUIr2OnlzkTTWxh5ypBg0k3nuLPWYh+VkJnQifKUg+yqOvEbSnqQZnQxaF
         48Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tf5RbUuZBD7vAitiDxd/SxMvRKm2h5sg9P3f0WhMpEo=;
        fh=3SnLqRFqNdHyenqe83v5gHmXOrz82oFT1vzUWusI304=;
        b=BfJN1v100N/sHHC9Wefm3nKlwQTQasdW0GOl3kj+vgDglpIaAhRN3gi3ElgugmWmKV
         Y3EjADgHIRXaD1F+dwvldzTEmJUjLN9SnVBGmevV9+CeXLzt53pp1ej/+wy9/Htyztpy
         CfHnprHCrE255libeHqO2PLwKkPE1w1qVOnr7/tCnUHOC9sAfwtkJrwx2Lvk29fGvCOr
         vzN9duqUULpErnw7BYCCGQ6aHnmBlEinUyOy/t/m4Oqq1s1PYQ4xi5dDJNciQWPKk9Ys
         +FUEYgGL7gi4JgRYiE0+dUglWII8L/OBkX3ouShdLw3b/V5hcm+wMLptfKoRQvB5q6Ou
         uQsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770177317; x=1770782117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tf5RbUuZBD7vAitiDxd/SxMvRKm2h5sg9P3f0WhMpEo=;
        b=H2BCyLWjTFVnk6YAsRp5cqfv4BzlHA5oHJ38C6XoYnZs+p7zMYyFyNTe6C5QXvWGvS
         TxlQsm79iTSaJ0aE2VIq0ItN8oO5D9VsDb9NUr9gLs/2bgo+HkElkmxg6V0Gcg7ZbEih
         hgTumfLllYEh3//RO6nsCgS+O8p9b6aex1zkLBGd4TS1irQOKkNatK2b6SgVOCPJxNRJ
         t54PmJwr5nQ5wlbC95g9rIrYDHKr277TOu2g7n9pxtOx0ecganKGojPfW64ce1FznHBy
         RK6pUtIHEQyKWk9PIoXqLYMlFFACXFy3O8U4PNSmzpWHWxN1E5hL8Tj45WFZxzb9Of5N
         ctgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770177317; x=1770782117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf5RbUuZBD7vAitiDxd/SxMvRKm2h5sg9P3f0WhMpEo=;
        b=LZHH/PTqy6zkTOabqtj5mk3Nsr661FjibzyuUbAQdTLWpvoG/Hfuo4OKzz81NVLK6y
         5DiB+uW2ZtM6zyDQ9RK6cJYmgxKhNPkhbeFQ4eOWTmkC1hNkjmgKSj5HrIXH0mEgHu1h
         VIxdoJzDcYBm6npr1s82jduYH9z++dj5mO4skIOQGlsys1RrzXJszFAUFKimZZJ10Ukn
         eIqrI8kc6mHqRoN9H3d2yK0CRkznfVMZlb8CHLCSTS2UrJPGHNjoO2evdkgKnPQ9KNiT
         G82akcu06Z8nYA9Yu2ricQjZSYVaE8NgSOcBHZ5BDr+Pp8oxtlgvnEm1Q44z0N2tQ004
         unHg==
X-Forwarded-Encrypted: i=1; AJvYcCWSDLx53MQD/eUlApFw9FrT6oJZ+Iclg5c1X5KaZVg56gDfkoS4LUT7ync7EKKaZrhcsiLGGVo9JXH/NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRAFbD/OGbkOWcYNkPQIE5mfETo68WJegfGj54t40YJXPGi+B/
	CP3gYBnjKooYrTYbA9ozASfU3GnVeMw2DrCnmha+3dzd3vEbtU3l9BrK30tR6fayCFI4hTO5REa
	jtqHYmwSBSbHCCr3kNYClULcWryxy/mU=
X-Gm-Gg: AZuq6aKuG/nbBIvHHyfEJSOXxctDOpKHE51YCGzdmKXpP9VcMIN3DMPwObIh5p2bpXj
	uK+gcnOE9lzy/100XXz7sboHIuyDeoDL+HQ97Z5ZzMaq7fmX3NsJjZDP7NnrMrvan8AZP62pUSj
	AEcALDQkDRtxUfDfOo/FgjLmykd5MaeCW+8/kDD0gO2+PEiZ6YYgt9KAqCIodZckRVT/Yw83RQx
	pV+tLHfhIagDwrRGzXAf9pB6Qw3mm8jBz3F13WF+lyZh/my8I6TzUPMjLUt3IVTcPu7WnZZh8k9
	Vc755bF2/2XLQSqN10urx/ztEt15ZYaLAaMQ0f8nAslNEapFQ9M3Muw=
X-Received: by 2002:a05:6214:1d29:b0:894:7eb9:ead2 with SMTP id
 6a1803df08f44-895221a66d7mr25922916d6.32.1770177317310; Tue, 03 Feb 2026
 19:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120204303.3229303-1-joelagnelf@nvidia.com> <20260120204303.3229303-4-joelagnelf@nvidia.com>
In-Reply-To: <20260120204303.3229303-4-joelagnelf@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 4 Feb 2026 13:55:06 +1000
X-Gm-Features: AZwV_QgqNJTzw-ZqXx5fJP-IeYh6sbx0Oiz2PE2A1U4oPqZRrSE9m3Umv0I5kN4
Message-ID: <CAPM=9tyL_Cq3+qWc4A41p7eqnNDLS1APUEeUbaQyJ46YDkipVw@mail.gmail.com>
Subject: Re: [PATCH RFC v6 03/26] rust: gpu: Add GPU buddy allocator bindings
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

> +///
> +/// These flags control the allocation behavior of the buddy allocator.
> +#[derive(Clone, Copy, Default, PartialEq, Eq)]
> +pub struct BuddyFlags(usize);
> +
> +impl BuddyFlags {
> +    /// Range-based allocation from start to end addresses.
> +    pub const RANGE_ALLOCATION: usize = bindings::GPU_BUDDY_RANGE_ALLOCATION;
> +
> +    /// Allocate from top of address space downward.
> +    pub const TOPDOWN_ALLOCATION: usize = bindings::GPU_BUDDY_TOPDOWN_ALLOCATION;
> +
> +    /// Allocate physically contiguous blocks.
> +    pub const CONTIGUOUS_ALLOCATION: usize = bindings::GPU_BUDDY_CONTIGUOUS_ALLOCATION;
> +
> +    /// Request allocation from the cleared (zeroed) memory. The zero'ing is not
> +    /// done by the allocator, but by the caller before freeing old blocks.
> +    pub const CLEAR_ALLOCATION: usize = bindings::GPU_BUDDY_CLEAR_ALLOCATION;
> +
> +    /// Disable trimming of partially used blocks.
> +    pub const TRIM_DISABLE: usize = bindings::GPU_BUDDY_TRIM_DISABLE;
> +
> +    /// Mark blocks as cleared (zeroed) when freeing. When set during free,
> +    /// indicates that the caller has already zeroed the memory.
> +    pub const CLEARED: usize = bindings::GPU_BUDDY_CLEARED;
> +
> +    /// Create [`BuddyFlags`] from a raw value with validation.
> +    ///
> +    /// Use `|` operator to combine flags if needed, before calling this method.
> +    pub fn try_new(flags: usize) -> Result<Self> {
> +        // Flags must not exceed u32::MAX to satisfy the GPU buddy allocator C API.
> +        if flags > u32::MAX as usize {
> +            return Err(EINVAL);
> +        }
> +
> +        // `TOPDOWN_ALLOCATION` only works without `RANGE_ALLOCATION`. When both are
> +        // set, `TOPDOWN_ALLOCATION` is silently ignored by the allocator. Reject this.
> +        if (flags & Self::RANGE_ALLOCATION) != 0 && (flags & Self::TOPDOWN_ALLOCATION) != 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(Self(flags))
> +    }
> +
> +    /// Get raw value of the flags.
> +    pub(crate) fn as_raw(self) -> usize {
> +        self.0
> +    }
> +}
> +
> +/// Parameters for creating a GPU buddy allocator.
> +#[derive(Clone, Copy)]
> +pub struct GpuBuddyParams {
> +    /// Base offset in bytes where the managed memory region starts.
> +    /// Allocations will be offset by this value.
> +    pub base_offset_bytes: u64,
> +    /// Total physical memory size managed by the allocator in bytes.
> +    pub physical_memory_size_bytes: u64,
> +    /// Minimum allocation unit / chunk size in bytes, must be >= 4KB.
> +    pub chunk_size_bytes: u64,
> +}
> +
> +/// Parameters for allocating blocks from a GPU buddy allocator.
> +#[derive(Clone, Copy)]
> +pub struct GpuBuddyAllocParams {
> +    /// Start of allocation range in bytes. Use 0 for beginning.
> +    pub start_range_address: u64,
> +    /// End of allocation range in bytes. Use 0 for entire range.
> +    pub end_range_address: u64,
> +    /// Total size to allocate in bytes.
> +    pub size_bytes: u64,
> +    /// Minimum block size for fragmented allocations in bytes.
> +    pub min_block_size_bytes: u64,
> +    /// Buddy allocator behavior flags.
> +    pub buddy_flags: BuddyFlags,
> +}
> +

(not a full review)

Any reason these two need Clone, Copy? I'm not seeing a use case for
that, maybe we should pass them as non-mutable references, but I don't
think there is any point in passing them by value ever.

Dave.
