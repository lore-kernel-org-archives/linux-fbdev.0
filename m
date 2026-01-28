Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB28238D54;
	Wed, 28 Jan 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601854; cv=none; b=pH9Qse2jD7iz3N/Kn/uGyt2t8WBXU3zEXFiBNHsy8slKU/X/y2WJ4Hv5l3yMgF/7nqWO6TPkjvsJUNPcRq9Pv3IkOa19/DQ7UOJZhiH8iVoBgGxmXV0BFYfyai4lltsTw1HvBPhtQsvCF+iZLFSeCK79m4N1YRM32ktxTVL35wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601854; c=relaxed/simple;
	bh=ZmWp47hdVxyqv1Ds+2Hq8SoLybTurOLu+L6KbG5zDis=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=uyvQz1nesuLugqVfxcbUArLkuArvjdIEeb6gogshqUwIbFh5XAcSZMfSqhe3w0oBPe3KGRflAkTogF3es5QvNO0pYrJaGbKYIdfxrxjLT4hgQkkJf7F9QhGoV11t/PnMIz/PaOHjU8jWASfUPCn0IYYUEf+GKigQseAFbObYtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx8cf+jz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx8cf+jz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA89C4CEF1;
	Wed, 28 Jan 2026 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769601854;
	bh=ZmWp47hdVxyqv1Ds+2Hq8SoLybTurOLu+L6KbG5zDis=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Hx8cf+jzc7ub0hEm2EJD7hjBM5GYjypHZfOvHh9LRFTILWZObQdgV/HK/IWv+uLPy
	 QzwMaPaZwA+V+WErhedeik+QeYs1j80V+8P+jOhgKApsZ1s79rGFAC6RUq4+D5Ardn
	 n62+ipYg5+OX6sXbx9BsgWCbDyUkOOSoZW9EPkqcJk4sUK+fsaoJcXefEI/9RvlHNC
	 eqkqF2D98GiwsjvyxkKugFrsM93/vx/v/+zhBRaGrlGsp/aOZuQGevj0bw7jmsrvBG
	 cv+blyDHbdlOGVFLw2q2+VMmk/cjQy252+jpZJPmDd65c5tggySUXW4QONEzl5E3Ao
	 RqgAJXywJWoUw==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 13:04:02 +0100
Message-Id: <DG07HZN0PL87.X5MKDCVVYIRE@kernel.org>
Subject: Re: [PATCH RFC v6 05/26] nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
Cc: "Zhi Wang" <zhiw@nvidia.com>, <linux-kernel@vger.kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan
 Corbet" <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>,
 "Christian Koenig" <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>, "Helge Deller"
 <deller@gmx.de>, "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy Baron"
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Alexey
 Ivanov" <alexeyi@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp
 Stanner" <phasta@kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
 <20260120204303.3229303-6-joelagnelf@nvidia.com>
 <20260121100745.2b5a58e5.zhiw@nvidia.com>
 <e186973c-ce31-405a-8bfa-dc647737a666@nvidia.com>
 <DS0PR12MB6486717785F6DD14EE1F1C46A397A@DS0PR12MB6486.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB6486717785F6DD14EE1F1C46A397A@DS0PR12MB6486.namprd12.prod.outlook.com>

On Fri Jan 23, 2026 at 12:16 AM CET, Joel Fernandes wrote:
> My plan is to make TLB and PRAMIN use immutable references in their funct=
ion
> calls and then implement internal locking. I've already done this for the=
 GPU
> buddy functions, so it should be doable, and we'll keep it consistent. As=
 a
> result, we will have finer-grain locking on the memory management objects
> instead of requiring to globally lock a common GpuMm object. I'll plan on
> doing this for v7.
>
> Also, the PTE allocation race you mentioned is already handled by PRAMIN
> serialization. Since threads must hold the PRAMIN lock to write page tabl=
e
> entries, concurrent writers are not possible:
>
>   Thread A: acquire PRAMIN lock
>   Thread A: read PDE (via PRAMIN) -> NULL
>   Thread A: alloc PT page, write PDE
>   Thread A: release PRAMIN lock
>
>   Thread B: acquire PRAMIN lock
>   Thread B: read PDE (via PRAMIN) -> sees A's pointer
>   Thread B: uses existing PT page, no allocation needed

This won't work unfortunately.

We have to separate allocations and modifications of the page tabe. Or in o=
ther
words, we must not allocate new PDEs or PTEs while holding the lock protect=
ing
the page table from modifications.

Once we have VM_BIND in nova-drm, we will have the situation that userspace
passes jobs to modify the GPUs virtual address space and hence the page tab=
les.

Such a jobs has mainly three stages.

  (1) The submit stage.

      This is where the job is initialized, dependencies are set up and the
      driver has to pre-allocate all kinds of structures that are required
      throughout the subsequent stages of the job.

  (2) The run stage.

      This is the stage where the job is staged for execution and its DMA f=
ence
      has been made public (i.e. it is accessible by userspace).

      This is the stage where we are in the DMA fence signalling critical
      section, hence we can't do any non-atomic allocations, since otherwis=
e we
      could deadlock in MMU notifier callbacks for instance.

      This is the stage where the page table is actually modified. Hence, w=
e
      can't acquire any locks that might be held elsewhere while doing
      non-atomic allocations. Also note that this is transitive, e.g. if yo=
u
      take lock A and somewhere else a lock B is taked while A is already h=
eld
      and we do non-atomic allocations while holding B, then A can't be hel=
d in
      the DMA fence signalling critical path either.

      It is also worth noting that this is the stage where we know the exac=
t
      operations we have to execute based on the VM_BIND request from users=
pace.

      For instance, in the submit stage we may only know that userspace wan=
ts
      that we map a BO with a certain offset in the GPUs virtual address sp=
ace
      at [0x0, 0x1000000]. What we don't know is what exact operations this=
 does
      require, i.e. "What do we have to unmap first?", "Are there any
      overlapping mappings that we have to truncate?", etc.

      So, we have to consider this when we pre-allocate in the submit stage=
.

  (3) The cleanup stage.

      This is where the job has been signaled and hence left the DMA fence
      signalling critical section.

      In this stage the job is cleaned up, which includes freeing data that=
 is
      not required anymore, such as PTEs and PDEs.
