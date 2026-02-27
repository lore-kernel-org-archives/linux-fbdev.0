Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29451279DC3;
	Fri, 27 Feb 2026 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194113; cv=none; b=HLyZaihayCdrhMd63xaH5+4+SdjW8v5EHi6JLR2V17Lm6ZlViupdHK03z/GqR1LoqBy7PtushA8JSGepKAsfyTuEai7X2wzXK1dEbyQ+MU2e2nza9sjSAvFhzIAO475e2w99s1lJtwUpHTqOJRCHxNu+DTwD3sjxKmRPEAb4ZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194113; c=relaxed/simple;
	bh=qAtzFvPSOXnzfEHHpuXtEDUenZLY4fuD+gHebSXsq+o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ir6ByfkPe2oVu6V3e/OlA7UdpJG6XGlWBCG8uB/Fs4hlwzN53TihYMVOZvGOt2oUY7voJ2m32KrdEmfOv0n333luiT6ig8mi82PAZFUooh0RA4/3zV/3gRhZpXQhSqjUYtd4pMGjJIbPZ/QNuDebLrVNOWdoSttez/sFcdC30yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkJy6AXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkJy6AXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02C9C116C6;
	Fri, 27 Feb 2026 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772194113;
	bh=qAtzFvPSOXnzfEHHpuXtEDUenZLY4fuD+gHebSXsq+o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mkJy6AXeaXTGR3B/SplKCc80A9j3T4GSxAnM/FQb3BVDZ/9cRaKn+K0MNfFxKz/Le
	 LrtgHk/QA4YaWZ0xFQkk6WEWlx05nIPIjZSUwOUhn9mE7TWheUOHKQ8IBMqSA4UM4/
	 aU3sXixuKTqPjhcewoGvs1a4aDQB54z8QVEVDAMemNhb6pSyUOF/DkBDZlF29HAwsw
	 fl6tdF9JSvAWPHo4UJ5GlMtl13TfgoufVjlda4BXGleiG6TnmaL89WmgkRE3jwOztO
	 p3srgWPCDcw5VgsHjNJtVL0PpHifRLeyRbtT1RQotg8uqPxAZpnEWZC3cyuKmm70Vo
	 Ou45+nkvmx6Fw==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 13:08:21 +0100
Message-Id: <DGPQDMR88BBG.2RO77IS0XQ0HF@kernel.org>
Subject: Re: [PATCH v11 4/4] rust: gpu: Add GPU buddy allocator bindings
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
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260224224005.3232841-1-joelagnelf@nvidia.com>
 <20260224224005.3232841-5-joelagnelf@nvidia.com>
In-Reply-To: <20260224224005.3232841-5-joelagnelf@nvidia.com>

On Tue Feb 24, 2026 at 11:40 PM CET, Joel Fernandes wrote:
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 58dbb02c5197..b8287601f464 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -97,6 +97,8 @@
>  pub mod firmware;
>  pub mod fmt;
>  pub mod fs;
> +#[cfg(CONFIG_GPU_BUDDY)]

Has to be #[cfg(CONFIG_GPU_BUDDY =3D "y")] for now.

> +pub mod gpu;
>  #[cfg(CONFIG_I2C =3D "y")]
>  pub mod i2c;
>  pub mod id_pool;
> --=20
> 2.34.1

