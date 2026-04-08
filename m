Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C03537FC;
	Wed,  8 Apr 2026 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671273; cv=none; b=VI/llytgjDSjBgF+SkdyknZ0Srtq/9RsW+uXSSzcad5rIs2DmMpmt5hsiX78CowlPA9lXEiOKsyDfM2llVKC+BVVYSoxfjMoWu2e/QoXiq9lXH7f7YKAQkvxGqjQZn9Z/dHo+xpZ120DU2cjg+xjYevywBWpY+xd2LpDRAV+Rz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671273; c=relaxed/simple;
	bh=vMeMK+n87aZGl3H05qmgvP4N4G/hHJPPTA9+9weNZ94=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=e1VrFSe7TU4uA6fAwa6Goir7eaF3xFQDjYUx2jzf/hDpyBuBVh/ZyuOTirpArtvp5MHpm+Hn8CH2zv8S+8hlAQuGw10rtGPwTC2DhETwyQik4mTEaa2p1vgBovs5GOblwbZl9dHAk77ZGcFafW63LHMO0ITeNpzdadF6GFUGKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz55or9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz55or9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CE3C19421;
	Wed,  8 Apr 2026 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775671273;
	bh=vMeMK+n87aZGl3H05qmgvP4N4G/hHJPPTA9+9weNZ94=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Cz55or9/FmdbXo2d5UahkCjF5PYt1L4nL7LkO8dKTXHIp13pUXjVQ996CuZ2YmJBh
	 2POkTq2nv0uCHmNMsFvZWFtoH4OyfaCVu3+BHjaViU9ip9OEFMztcHaRF08gcHH/SW
	 P0ZozX65OAjZTAAXPsuavCA3DK0GW4zw895UdyqCDkiAPxhNOkJ07D1VlNlZ1Kw5zu
	 Gq5uP4CsUQ4RgjkKuRkTETtSZAY5RQ/JTIIeg1O/mSsz/rFHRWcgR41YYkOldcLshk
	 TtW1/VI6qDJhAEqjfBuBzYVnk4+5uXpl6Dg4Sk6Skz7shIetnoI/ANCtbLWAaivlkU
	 33HfPiJK+044Q==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 20:01:01 +0200
Message-Id: <DHNYXGAVLNVM.3TV1VDZ9YXA9U@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Dave Airlie"
 <airlied@redhat.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Koen Koning" <koen.koning@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 "Nikola Djukic" <ndjukic@nvidia.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet"
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>, "Christian
 Koenig" <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>, "Helge Deller"
 <deller@gmx.de>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 <alexeyi@nvidia.com>, <joel@joelfernandes.org>,
 <linux-doc@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v10 12/21] gpu: nova-core: mm: Add unified page table
 entry wrapper enums
References: <20260311004008.2208806-1-joelagnelf@nvidia.com>
 <20260331212048.2229260-1-joelagnelf@nvidia.com>
 <20260331212048.2229260-13-joelagnelf@nvidia.com>
 <DHIFF98P1YQ3.1IXUT02E3TF20@nvidia.com>
 <5db2aab1-4b65-486e-ad9b-27a108bdb0d6@nvidia.com>
 <DHMYSTLVHIFJ.A2BDMPVNZNLS@nvidia.com>
 <537a8c5a-3885-4c47-99f6-963b48ddf87d@nvidia.com>
 <DHNT32C2Q5HN.LLME0RV17Z8V@nvidia.com>
 <da8d03f8-0294-417b-b684-2c20d577f94a@nvidia.com>
In-Reply-To: <da8d03f8-0294-417b-b684-2c20d577f94a@nvidia.com>

On Wed Apr 8, 2026 at 6:58 PM CEST, Joel Fernandes wrote:
> So you're making the code much much worse than before actually. We don't
> new traits and types pointlessly.

I had a look at both approaches and yes, the traits can be considered
boilerplate. But, they are not complex and they just list method signatures=
 that
each version's types already implement functionality wise and they get us r=
id of
a lot of dispatch sites. The implementation turns out cleaner as there is l=
ess
parameter threading throughout call chains, etc. Overall, it seems more
scalable.

On the other hand, there are indeed more abstractions and type indirections=
 to
understand in Eliot's code. I.e. there are advantages and disadvantages to =
both
approaches.

That said, please engage with Eliot's proposal, it is not as off as your re=
ply
implies and dismissing it right away is not what I'd like to see in this
situation.
