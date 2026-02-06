Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D582BDC03;
	Fri,  6 Feb 2026 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398855; cv=none; b=d5RPwj6FkyKdaW0ODsjYnUGHdF0JtL07WX6XRsv24CzhTSGU//j8Fpk40OIrpieSEd9ZPiYizsEg2+lyEtNczWSygrLICEVJw0f2EzwRwx3Cs1UG+rdff+afz0a0m4T4KHXYn0C4mIIE3QrWRpbWTviJIO1GFAx2jOrBArJefh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398855; c=relaxed/simple;
	bh=DviuGo6EMO94bRcj+LA1f5jItWFurA9I/2YyGvOCpGU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NAfx1CZvcg/2qAe+h+roHkKMG5OX1D3NM/h33D9psB1MeAFXIA/Hdaoq6FCUIio2NrtfB3i0tGWLEaDGRGjnA3RfFEbWBCJ31vwtKkKCDMp82Ktf5eHDxP8DLpaur60DJG+DWJ9NA+tplXCqdDAc8xemINY0YqCrylQXKtSgSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tspf8lha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tspf8lha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D969FC116C6;
	Fri,  6 Feb 2026 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770398855;
	bh=DviuGo6EMO94bRcj+LA1f5jItWFurA9I/2YyGvOCpGU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=tspf8lhaOr0S5m6oexxE02FpVJfe/g3YlvPtRQm+ttUhWoSGZvjKcGED7cmiNNhr0
	 eXQFIWQPMSaTrOwn/V0wFtMIYO109qZ75ugwHgsUgCZL6MiaRaAEvMUQtXQWD7LebR
	 13TF7sHuYRfNQfW+U3aHnOJNLYpG25SAMiGbBsDOV7idsq++Y/qd55Cvhrt1Il0S0w
	 /5aki+hD89tgnboX/3KaCzhwQoHPx49DF9Snfl0fEmpdsJhgI1mlUeE8d3FDa1rEWb
	 jiW6OOLaQiolq1nj5e0s4Z0rZuQD8Acylid8Bw10e/s4xEf/CoTT0Lc17tjRFkmoPt
	 i+US+xyzZ0HDg==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 18:27:23 +0100
Message-Id: <DG820GM5YHJS.11E92OR824CWM@kernel.org>
Subject: Re: [PATCH -next v7 1/2] rust: clist: Add support to interface with
 C linked lists
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
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
 "Boqun Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <joel@joelfernandes.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260206004110.1914814-1-joelagnelf@nvidia.com>
 <20260206004110.1914814-2-joelagnelf@nvidia.com>
 <DG7ZF1UT98RQ.3F42J3ULGV2OC@garyguo.net>
 <DG800TDA6OXQ.275PMMS19F1EX@kernel.org>
 <77ac3274-a962-469d-a2f6-6ccc0670988a@nvidia.com>
 <DG80FV3VTT6P.2ZP18EM8605GT@garyguo.net>
 <DG81PJ9QD8FC.2NF6VEKDD3F2Q@kernel.org>
 <DG81V8NG5RC7.38EYLHQZXKTTO@garyguo.net>
In-Reply-To: <DG81V8NG5RC7.38EYLHQZXKTTO@garyguo.net>

On Fri Feb 6, 2026 at 6:20 PM CET, Gary Guo wrote:
> I asked for this to be changed to `pub(crate)` because I think this isn't
> something that should be used by drivers.
>
> As you said, tt might be tricky to enforce that with new build system whe=
n
> subsystems are inside different crates. But until then I think it's bette=
r to
> limit visibility.

It should *usually* not be used by drivers, but there are exceptions. For
instance, it is perfectly valid to be used by Rust drivers that interact wi=
th C
drivers.

Besides that, my take on this is that we know that the new build system wil=
l
come and that pub(crate) won't work in the long term, so why bother. I'd on=
ly
use it in cases where you want to keep things local to the subsystem.
