Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903B386459;
	Wed, 18 Mar 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844997; cv=none; b=RfR2qG6anc0aq3mJBkh+ufCgsPqMxSG4g0n6MRFoBdSOwe5kss4aZx1Y0K/SV278QhJfoi+V6kgB6yCxWY99zzmDr3dD1IPzY3x2jkCHpMuAoyAosrCa8QFO2h+kLa29LeXltu0kZo1zUUiDE7Dr3hYOWXe1YjphQ0lC4c+mH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844997; c=relaxed/simple;
	bh=u09Mfz2oaK3eFSNZEBbTIAth83cK6rCPlN/GqyTfmgM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=HOs9oPDfIyemnfvX/YqrERxWgdB8eeOXhOQTsqFmn1PJ/DH0gE1RrleU72frXOP9CofaFKNn8QG854WXKNUyzwAUu9VFt6Nc8TsHbybA6eeLEUyvJN/x65e5zI9Fk8vkErmJJmFLfl6AM7tZFzn/w49WTF3Nq5XxIrAKIsIFRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLG63xwv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLG63xwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00284C19421;
	Wed, 18 Mar 2026 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844996;
	bh=u09Mfz2oaK3eFSNZEBbTIAth83cK6rCPlN/GqyTfmgM=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=PLG63xwvR24HD+XRf5cIoXpB6gh/EZwGvlYiSAWfypMrqe6k149dqeTeFuuOlHOzk
	 fcG/KWD2k6CF2gw8wZ70N5s1KGkhpWr0bZ6nj9ecBLJXrgBjuX5q8TqMjGEIeN3crF
	 v04TSv3PsLfnKRjuFmX+477UMqR3tBmetg2zHzpmS0G3XTXt4LzNtbLeulLOnWGh69
	 RszEmfLO8Vd+CTGg+m7CRnid4OA9PSrcl4HWxc6qxPalVR9qBLjogmPkWYqo+vYULp
	 vQWpMOPg/0zvKylcbrrPprf4ruVLQtYMeYr8CX3v5Oui7WNBP/BidARKIxRYx7GqJN
	 khYLlO+156bnw==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 15:43:05 +0100
Message-Id: <DH5ZKGFWJ0B3.21DGB876S2FYE@kernel.org>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Dave
 Airlie" <airlied@redhat.com>, "David Airlie" <airlied@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Simona
 Vetter" <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Koen Koning" <koen.koning@linux.intel.com>, "Nikola Djukic"
 <ndjukic@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Jonathan Corbet" <corbet@lwn.net>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
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
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked
 list interface
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
 <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
In-Reply-To: <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>

On Wed Mar 18, 2026 at 3:31 PM CET, Alice Ryhl wrote:
> On Wed, Mar 18, 2026 at 3:21=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> [*] I would have preferred a middle ground like  modules being inside
>> but repeating the folder name, e.g. `.../pci/pci.rs`, but I doubt that
>> will ever be supported upstream since one probably wants to support
>> the other ways at the same time.

I very much like this, because, as you said, the pci/ vs. pci.rs completion
issue is indeed annoying me a bit. :)

> In principle this is possible using
>
> #[path =3D "pci/pci.rs"]
> pub mod pci;

Not exactly pretty, but if it works I think it's worth.
