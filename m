Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769033120D;
	Wed, 11 Feb 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801838; cv=none; b=pGVnWJsVetG5ts7Kaav/cvLzVuE1SY+XdaA8zkKoKM1K2dk+x5CvrrPNhHlrsaZm/dIqHdxGrCQmUsxsBl2rON70bOHtdfDLEv3Q2QgSGNMlHRfFjABi1Ha0w0E7NlKuwGeUAug4BLxr/pd2KwlWVmRJa2VKnMbC7lAgcojw7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801838; c=relaxed/simple;
	bh=zMMHzAbccCElgZnTTHunt2AaMFlxEi2Wrnpcdd+qN3s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=uoL/9j0Tby4XhX4Q4dePn7ulvzqcweNqX0j2eC51E4pCKcaIdmtJk8mBXcJbG9lDGZCYuPZ79D4zV8OmTIbR+IjR8UlH+3rxHTAQiYorrVc0W5aulCzqoDwIfowMXeb7Xf+/RCXL1SV1ide3bn1VhCroDkXuiFD019Lhnav02Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tskr0izw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tskr0izw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996A8C4CEF7;
	Wed, 11 Feb 2026 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770801838;
	bh=zMMHzAbccCElgZnTTHunt2AaMFlxEi2Wrnpcdd+qN3s=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=Tskr0izwQHtPS47ll8VMuwygb2B8/DvwdW0zs9mUMb8ojVZDptC61rB+AcbAm2pjz
	 nUqmYFe3UJPLOXlmQw9n66sar+7+PSp/cC8GmrS1MmQ9iG0KyMdAPLMKJUdCoxZF6I
	 9QbdsW4ZD65VV4kE1kktJCbrC6FPhk4Anm7UehAEK8qt/6YjOcQmLzp/ssYL5WZ6TW
	 MOXtvGDeRQT+oeG5fGA60KBgPkEGN7WpwC8TBKR5a0M1xmiKZofqk5hKsAPEpN4lyF
	 4Y0TF8++5DSzOgzUVPh2w+ypiVibGAMNBJsmzUnE+jpZwjzko6xDzXMyQDyWcW852Z
	 dmaT1NPn5BAbw==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Feb 2026 10:23:47 +0100
Message-Id: <DGC0UXBRSOPZ.PG0X6KTEA3RJ@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH -next v9 1/3] rust: clist: Add support to interface with
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
 Almeida" <daniel.almeida@collabora.com>, "David Airlie"
 <airlied@gmail.com>, "Edwin Peer" <epeer@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
References: <20260210233204.790524-1-joelagnelf@nvidia.com>
 <20260210233204.790524-2-joelagnelf@nvidia.com>
In-Reply-To: <20260210233204.790524-2-joelagnelf@nvidia.com>

On Wed Feb 11, 2026 at 12:32 AM CET, Joel Fernandes wrote:
> Add a new module `clist` for working with C's doubly circular linked
> lists. Provide low-level iteration over list nodes.
>
> Typed iteration over actual items is provided with a `clist_create`
> macro to assist in creation of the `CList` type.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Acked-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

I think you forgot to address my comments from [1].

[1] https://lore.kernel.org/all/DGB75XMWML8M.DFZY5L52EBQF@kernel.org/
