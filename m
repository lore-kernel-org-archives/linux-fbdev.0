Received: from sender4-pp-f119.zoho.com (sender4-pp-f119.zoho.com [136.143.188.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4441E86E;
	Fri,  6 Feb 2026 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417262; cv=pass; b=l2+paK39srRPQLGeUN1cQ21y42GkQxF5oATQb3QaUaRkC8N5odLv1aJynDTn6JtG3ZxXx+Rf7ON+YYfDf4q6LuxOYRh4pnNs+OdsZJtaTmmOsfZT2E4HwkB7uK9a/22KRs6qZDkpJUp2eA7ItuuDhqgUYmKbeFQqlLrcJ7iWydE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417262; c=relaxed/simple;
	bh=nwjhQnmuEp1LuAUXAWUvtthxUjfgsoNmRvkb+Zsoafc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gyIJdOUBz0pUwwHZYGrjXVwzkRfijxoNY7MaWk2vvXYO+uFDtZLqEmxrT6GApua6GHCQsbXYqr7lLt0/Q0Uh38K/6AZTLbtp6ICeBQhA4IXZougATEd2+74+uK0BDJc27IpC3oO6thZpN/WCIGXfyxXg6Y66eatJ1pl5pddter0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LxHZZ03J; arc=pass smtp.client-ip=136.143.188.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LxHZZ03J"
ARC-Seal: i=1; a=rsa-sha256; t=1770417234; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RiExs3bv4Y8H0GNaO34C2uPapynSVMRbvsT5doKr4cOkDCxxL3Hjgim05gX+l6zfycGBZ2ExaPDbNl/o2DN0HNRn4pT/1/vErz3mGPkwjoyc1Is8t6VBysJ9jFz2LGbzGO4aK6GJjcSmGg3OTZb2FINL6mSpNg9jeqewzdXz6lM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770417234; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tc02K9ea6k3a52rZLvnILRHeI4xxmaVSZwRgjd+aJI4=; 
	b=JT+j+YUNy2cWcpE6v/9YDklaQqixjWMof+qoB8V9LQThjMKDcV7e6TVmKIWAWCCiNhUIHWYcm+amncZP+Ad4FrHbGYf4fd6TDjZ8ULczWdJeGqdae29BpL+YtcayHWGETrbT5j8hjAwLY5u09LCs97H4K+VXC9A8wkwiQvC29Go=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770417234;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=tc02K9ea6k3a52rZLvnILRHeI4xxmaVSZwRgjd+aJI4=;
	b=LxHZZ03JDNpDc+8PFnHHYRltxbF/8YH5RjJUuPQHRAC/7Sf1UXgxB2yT7gQd/t+e
	oVa+fMJpJ/Uvp4FX6oa9pKZ5mgQBrNSwAil+Mlu0bTHqCuvOW4lgTGYDEvoAs5fMd5d
	FISZyzqUUxMOdGD7sAsyHylnFw5C4xWLXRRutqqM=
Received: by mx.zohomail.com with SMTPS id 1770417231622597.8188882201408;
	Fri, 6 Feb 2026 14:33:51 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH -next v7 1/2] rust: clist: Add support to interface with C
 linked lists
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <983b7db3-b0e6-45d6-866e-f001b64abde1@nvidia.com>
Date: Fri, 6 Feb 2026 19:33:27 -0300
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?utf-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Helge Deller <deller@gmx.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>,
 joel@joelfernandes.org,
 nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A87E3FC-6A04-4A92-9230-4782D75FC05F@collabora.com>
References: <20260206004110.1914814-1-joelagnelf@nvidia.com>
 <20260206004110.1914814-2-joelagnelf@nvidia.com>
 <73B64D35-6574-4776-962D-865465C40226@collabora.com>
 <7ed85eca-2a5e-4e8f-8356-e7fbbf7d3a8f@nvidia.com>
 <E846F3BB-DE64-4E6B-ACA3-00F965038478@collabora.com>
 <983b7db3-b0e6-45d6-866e-f001b64abde1@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

>>=20
>>=20
>> Yeah, but my point being: is there a reason why the underlying list =
has to
>> remain read-only? Is this a safety requirement or an invariant that =
is established
>> by the code above?
> I'm not fully sure if it's an invariant or a safety requirement, but =
anyone
> creating a C list head on the rust side must guarantee that it is not =
modified.
> Since rust has no visibility on the C side, I believe it is a Rust =
invariant
> here that the existence of CListHead assumes that the list cannot be =
modified
> once Rust has access over it.  That is up to the creator (user) of the =
CListHead
> to guarantee. In the DRM buddy case, once the list is allocated and =
accessible
> from Rust, C code will not modify it while the Rust object exists.
>=20
> Does that make sense, or is there a better way to document this?
>=20
> --
> Joel Fernandes


In which case, I recommend moving this to a safety requirement when
creating the list.

I assume the purpose of not modifying the list on the C side is to avoid
corrupting the list in Rust somehow?

=E2=80=94 Daniel=
