Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D6168BD;
	Fri,  6 Feb 2026 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412967; cv=pass; b=lcAeBWZ8SRC32d8f+zCRrWvnoNYgsmvl73bEO1VTWSgIlJi2U5lv1apRxFJr5XgBRDZ2/FccsIngOTI5urHHRxVeDpAxnjpx/PjfBR3RIFT6Gjp7orBoV4e/CUETR4P/L0lN/+6qJOYZQYcspLH5lIJJg6F9r4Jb9fCH6GQ7zuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412967; c=relaxed/simple;
	bh=RBLQtKx2Jti1sGLacAha8iqZpMBQR7z4cgk/du+X34U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p3+AEMaVRW3aKYqI2balSnl77NJ17+h4EgMfZYVRNQvBARmNFTdx+8JeccHXfJC8CK3g0toY6IbsAH8Dz8SkG+oMKKofBYakQo6ROQ1uWNHIG9UOIPc8sObeM/qZ4waFlUNv8MsLkh+suzv48aSnvp1DJAdI2bDzBH018y/W3dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=KNWGfNTW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="KNWGfNTW"
ARC-Seal: i=1; a=rsa-sha256; t=1770412941; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jlRx3Axi//OcdEtCwIPn/1Z1oHTgsNj9Gp1Sz62B+i0fuXYM3awPupBsedFWukSCK4pdbRit8PfHBJn6n3vDjWkvcrLIfGQlXmsdMbptC1c01zX3ZzINB3Las6BH/5aeluMyBvRTEKKdTjnF62l2UQO3C5K8nF8Ee4VH9nD470M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770412941; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9p9Uve1OvoP/hhPChCwVy79pt9sgbM0talsEQ48KP4w=; 
	b=e1y8TMu/q/lx2XIoIpgxEogbsQu5x256cIdjz157Pfmdg+rdzAi/pIYwP2N29TuDIgj9RVBXheV3eTECuYZyXjQGEM7HTY3MTYzmhtaaUfIfsY8aJjke6g8fWOB+4U1Q3ObXXiGxD6/Q57CgOcVA9dufT+uLCa7PbcdkYxIvFFE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770412941;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=9p9Uve1OvoP/hhPChCwVy79pt9sgbM0talsEQ48KP4w=;
	b=KNWGfNTWEr3eSNPqwfcOGfaAxG2pqAEENFavV/sMEpic4FVh/BFSXaUPmsoBfl23
	QF/6If1D50FNecmqxc5gUR2zANuKcq2DJLUI07nBSk0wSssW8fu1D0xTZEz1iiT5qp5
	Z9rUlYEEWhY7KRA0dPchpoOqK9zBqZL7RdRgbwo8=
Received: by mx.zohomail.com with SMTPS id 1770412939870871.29038559048;
	Fri, 6 Feb 2026 13:22:19 -0800 (PST)
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
In-Reply-To: <7ed85eca-2a5e-4e8f-8356-e7fbbf7d3a8f@nvidia.com>
Date: Fri, 6 Feb 2026 18:21:56 -0300
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
Message-Id: <E846F3BB-DE64-4E6B-ACA3-00F965038478@collabora.com>
References: <20260206004110.1914814-1-joelagnelf@nvidia.com>
 <20260206004110.1914814-2-joelagnelf@nvidia.com>
 <73B64D35-6574-4776-962D-865465C40226@collabora.com>
 <7ed85eca-2a5e-4e8f-8356-e7fbbf7d3a8f@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 6 Feb 2026, at 17:51, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>=20
> Hi Daniel,
> Hope you do not mind me replying piecemeal as I can reply more =
quickly. Thank
> you for all the comments.
>=20
> On 2/6/2026 12:49 PM, Daniel Almeida wrote:
>>> +use crate::{
>>> +    bindings,
>>> +    types::Opaque, //
>>> +};
>>> +
>>> +use pin_init::PinInit;
>>> +
>>> +/// Wraps a `list_head` object for use in intrusive linked lists.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// - [`CListHead`] represents an allocated and valid `list_head` =
structure.
>>> +/// - Once a [`CListHead`] is created in Rust, it will not be =
modified by non-Rust code.
>>> +/// - All `list_head` for individual items are not modified for the =
lifetime of [`CListHead`].
>>=20
>> Can you expand on the two points above?
>=20
> This is basically saying that a C `list_head` that is wrapped by a =
`CListHead`
> is read-only for the lifetime of `ClistHead`. modifying the pointers =
anymore.
> That is the invariant.
>=20
> Or did I miss something?
>=20
> --=20
> Joel Fernandes
>=20
>=20


Yeah, but my point being: is there a reason why the underlying list has =
to
remain read-only? Is this a safety requirement or an invariant that is =
established
by the code above?


=E2=80=94 Daniel=
