Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188135BDB2;
	Tue, 17 Mar 2026 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778849; cv=none; b=SmkM3HMLAAdINY2LNoz7NEIIrih4FHcygJoqQC5SLthh7BIp/YRSlWfe8pHfmh/ETPWGSTXlW+RSR3DdpoXikOc+S9VQLnK/NGlFcW2xNMkZHOq3l/tys98pSkkz7BmlfdZqasL5RTtJ2qmnd2oyS416XNBqAgQHzjY8rRX9dDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778849; c=relaxed/simple;
	bh=Qmle9txu0KZ/bF0+kcgC8Uln28DfPARF0J6ui6/x01Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XUaJCIUKPIjKQLIdUGkqkzUt9oNwqug780ARaD/1rjNUd/+hWggFh3ZBkGO3bTI/MUmcil20aUmAEtW74bmZVoyOVv+v9mSgOc55+jzvfG50HJfDQIVYoR9a4uP+hIk/npcMFWEqDHDdjIPSLmY8I5IrEPo8lu8h99lBCfuBVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5jqVpcm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5jqVpcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09757C4CEF7;
	Tue, 17 Mar 2026 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773778848;
	bh=Qmle9txu0KZ/bF0+kcgC8Uln28DfPARF0J6ui6/x01Q=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=r5jqVpcmS+5zZBfGilDMs0BFWj7L8gwoVVURthNmeotNe7o0FpSLAzqALX/pqW02e
	 zm6Fx6y5YS2RcmczPhdxzW70/HcKt6CXR/RnXz+01g7GHPezNpZm/hkVBXx5DRRr83
	 T8F2On0S7JNiCJODM2K/5TsOOhPoXJxxj7H0qYv8P3eqGf3vqL+lpVFSt2l6MAHjea
	 2VqHFC+rzaXyceLXGBgG8n6zUCG244Zxyq4gc2/bRAtHxmUARPUDXnRVu2lBEdRa1P
	 LGQvIcb+DaWHOiOCwsm+BKVR4EqDm0YKWm5/4KDwRjXyGnQvfTb2Qcnf5eTZ11KIs9
	 Vnp6ay6q8KdSA==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 21:20:37 +0100
Message-Id: <DH5C4CMXIPXU.3AM5V38WUQRWQ@kernel.org>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked
 list interface
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Dave Airlie" <airlied@redhat.com>, "David
 Airlie" <airlied@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Koen
 Koning" <koen.koning@linux.intel.com>, "Nikola Djukic"
 <ndjukic@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Philipp
 Stanner" <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Jonathan Corbet" <corbet@lwn.net>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang
 Rui" <ray.huang@amd.com>, "Matthew Auld" <matthew.auld@intel.com>, "Matthew
 Brost" <matthew.brost@intel.com>, "Lucas De Marchi"
 <lucas.demarchi@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Helge Deller" <deller@gmx.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
In-Reply-To: <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>

On Tue Mar 17, 2026 at 9:18 PM CET, Joel Fernandes wrote:
> Sorry, I forgot to add an additional F: for the rust/kernel/interop.rs fi=
le.
> Danilo/Miguel, do you mind adding this when applying?

I can add it, all good.
