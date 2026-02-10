Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC243382D6;
	Tue, 10 Feb 2026 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757814; cv=none; b=EwirOnxER11hzg6ofhZqh/ZEr1z7IryMFHVPae2hCReClJZ2Bez8qDy83Qe4v/YfeCSYfp/b386DaC/wLhC51NfoJrBstSGEdH/peqaZY07YPLawjDt6Kug1SMp8s3C9/RtTPBGpR76rOZir2HkFPzjqjnh6xVs71hAOxJKy3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757814; c=relaxed/simple;
	bh=UWSb7wjpHsusRVvieXLpHdxv/4zDaCUkIgy7QUYN+Qw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PTkPu1SfvLpVugE15GTACVlBUbXaxb+5KwQzAUZyL6+QMylXFYIgxG/AxkefyTkcxyQCB7oAmDfKWWXLFUkMErFTsiZQlOeyUwQvDXSj1omHI9IEB53/xCfTP5iDpwLpDpObTTKp36mIGeAaRxV1FWYNucxb0vs/IIm0nHxN1YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3bgbA3B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3bgbA3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5337C116C6;
	Tue, 10 Feb 2026 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770757814;
	bh=UWSb7wjpHsusRVvieXLpHdxv/4zDaCUkIgy7QUYN+Qw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=e3bgbA3BYcAKRl8iwbdJVkgrkS7A1nttqBdEge3iUnUgQ4wnLXe5M9C/gQST9Vazx
	 mTI9eXXs9l8hK1+3phBxmaosKEOsPCLxUv5EoIxnCTNTBXSuoHSTgXEX0nmjSSlBZX
	 etqvR3ijBk3JxLIBdOJr71PBelaIdS29Pmh3twzOnqsJQaHHOvHi5vSYlOe+9p0kul
	 amTGI376pQKDV+W8QZ05JdpeYMoYXT6yjUSFUxUT538ypdEgXgY3IbkeRQMh1ipnz5
	 4JBp6ySOVNWzst9QfT3XNGf2Nm6PjMXLJK3bbMV+LMDWQxjUetTaCqnbm7f9wN/NfH
	 NKHT6RpV1wiCA==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 22:10:02 +0100
Message-Id: <DGBL94I0E5UB.4LNH3JODOKPV@kernel.org>
Subject: Re: [PATCH -next v8 2/3] rust: gpu: Add GPU buddy allocator
 bindings
Cc: <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet"
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Vivi Rodrigo" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Rui Huang" <ray.huang@amd.com>,
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
 <20260209214246.2783990-3-joelagnelf@nvidia.com>
 <DGB9G697GSWO.3VBFGU5MKFPMR@kernel.org>
 <1770754015.1979311.8126@nvidia.com>
In-Reply-To: <1770754015.1979311.8126@nvidia.com>

On Tue Feb 10, 2026 at 9:09 PM CET, Joel Fernandes wrote:
>>> +impl GpuBuddyInner {
>>> +    /// Create a pin-initializer for the buddy allocator.
>>> +    fn new(params: &GpuBuddyParams) -> impl PinInit<Self, Error> {
>>=20
>> I think we can just pass them by value, they shouldn't be needed anymore=
 after
>> the GpuBuddy instance has been constructed.
>
> Dave Airlie specifically reviewed this in RFC v6 and recommended passing =
by
> reference rather than by value [2]:
>
>   "maybe we should pass them as non-mutable references, but I don't think
>    there is any point in passing them by value ever."
>
> The params are also reused in practice -- the doc examples show the same
> `GpuBuddyParams` being used repeatedly. References
> avoid unnecessary copies for this reuse pattern.

Well, that's for GpuBuddyAllocParams, those are indeed reused and shouldn't=
 be
copied all the time.

But my comment was about GpuBuddyParams, I don't see a reason those are reu=
sed
(neither are they in the example), so it makes more sense to pass them by v=
alue,
such that they are consumed. (I.e.  I'm not asking for adding Copy/Clone.)

>
> [2] https://lore.kernel.org/all/CAPM=3D9tyL_Cq3+qWc4A41p7eqnNDLS1APUEeUba=
QyJ46YDkipVw@mail.gmail.com/
>
>>> +    pub fn new(params: &GpuBuddyParams) -> Result<Self> {
>>=20
>> Same here, we should be able to take this by value.
>
> Same reasoning as above.
>
>>> +    pub fn alloc_blocks(&self, params: &GpuBuddyAllocParams) -> Result=
<Arc<AllocatedBlocks>> {
>>=20
>> Why do we force a reference count here? I think we should just return
>> impl PinInit<AllocatedBlocks, Error> and let the driver decide where to
>> initialize the object, no?
>>=20
>> I.e. what if the driver wants to store additional data in a driver priva=
te
>> structure? Then we'd need two allocations otherwise and another referenc=
e count
>> in the worst case.
>
> Good point. The reason I had `Arc` was to anticipate potential shared own=
ership
> use cases, but at the moment there is no such use case
> in nova-core -- each `AllocatedBlocks` has a single owner.

Sure, but drivers can always pass an impl PinInit to Arc::pin_init() themse=
lves.

> I'll change this to return `impl PinInit<AllocatedBlocks, Error>` in the =
next
> version. If a shared ownership use case arises later, we
> can always add an `Arc`-returning convenience wrapper.

I don't think we should, don't give drivers a reason to go for more allocat=
ions
they actually need for convinience.
