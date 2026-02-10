Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3D2ECE9B;
	Tue, 10 Feb 2026 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718068; cv=none; b=sPLrCpncNXC/9r75//OCfsecalm/yCHe3iqdhNNuWER070mOaUI/nZJsp8ezQsA9ItWrUUyaum2WZX/a/o7JJ43qerhRWHSvpeRdkPGsdlKRe+qPnwcLVGK6qKnnCkt6HGJIBm0EDPo02I75JQz8onM/mn8BrlN3DIL+gMWvtTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718068; c=relaxed/simple;
	bh=u8PznRMNHUq4nAGBxZMhRsI1nFCYrCQ3fE2qie4jbrc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NOybn/YMjrTd9bh1d7oeus0lTMptesHzNsGd5gfvpyvhn1LpYxI7GSw+zCOaumfi30DPQWAler5EqsFmLEjBxXMa98H64vbNOzJYcX5y3w8e4nKhRcdlsf05eW/z9Nky1FXdO4PcCRpDFmScNYc4t0eqwPlhTpGUsFdoASbCnDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmE+/FBO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmE+/FBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E11BC19423;
	Tue, 10 Feb 2026 10:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770718068;
	bh=u8PznRMNHUq4nAGBxZMhRsI1nFCYrCQ3fE2qie4jbrc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=AmE+/FBOXpx4l68K7mRYkO1VaqodkSC6EYBRpsvdmsAAuCtBUC0Ski789nLR1zq1E
	 TFTDJAvO/WZbEVJGb8S5jNstC+zYelojWUA/Vz701gpxjENKDqf79Whnceiw8FNbBY
	 ut8jot+h95U+T6RJ5kCKlxvUFRclDycYQjjaBjTHT6bLOEcE9HUbcuS+BZFG44DJnu
	 CVAHmq30G99r6V870J6tOn4+Jg52OrlgRgVX3eznZ31pPxPm5cEPxdXhux6nTT538r
	 +/0qFbG/tLyPxoR1S45Ir7yxIN7ouU4u22nUuj5eODPtQ6D7izQW76OuKa/9AuTQs9
	 71HQcI6dvN+Lw==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 11:07:37 +0100
Message-Id: <DGB75XMWML8M.DFZY5L52EBQF@kernel.org>
Subject: Re: [PATCH -next v8 1/3] rust: clist: Add support to interface with
 C linked lists
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
 <20260209214246.2783990-2-joelagnelf@nvidia.com>
In-Reply-To: <20260209214246.2783990-2-joelagnelf@nvidia.com>

On Mon Feb 9, 2026 at 10:42 PM CET, Joel Fernandes wrote:
>  rust/kernel/clist.rs   | 320 +++++++++++++++++++++++++++++++++++++++++

I think we should move this under rust/kernel/ffi/ to make it obvious that =
this
is FFI infrastructure.

> diff --git a/rust/kernel/clist.rs b/rust/kernel/clist.rs
> new file mode 100644
> index 000000000000..8aa72b5d54be
> --- /dev/null
> +++ b/rust/kernel/clist.rs
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A C doubly circular intrusive linked list interface for rust code.

Here and in the struct documentation, I'd suggest to clearly point out the
use-cases, i.e. that this infrastructure is for FFI use-cases only and shou=
ld
not be used otherwise in drivers, etc.
