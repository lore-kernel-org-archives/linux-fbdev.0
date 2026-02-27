Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3F332ECB
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Feb 2026 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207513; cv=none; b=O4LxQBnCWEsIWeybV0ZtDR2+dpErduw4rK7lHEts/y6KyAXep4xvUxVYFlDu4zP6MiSshpzHSur6Dzj7dsI+mO3ZoiqhF5z2UwxU0lpsCaR3PA/bOwZyXXouL2DMjli6flgV9Gba6URWcnc4JBcdx+MfgpofXELgsZb+6hjelVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207513; c=relaxed/simple;
	bh=v+ZzH2ONIU5UzI0hdG284tUJ4QN5VqVURM/gZR3mibQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8sCLCIHktS8eAHHGzMw6BKOvwQYI1zly4HPn87IAmLNyU1wijdN2ruV0afD1EyVeCLAIyS0b399jHyulNQv2avhKLfptJmHk/MkQHL/l5UyCsI/wBm/blpAANSnEiQ/ZQ1qq6N1fpSrLhFgb1UYjs1y56K7T5NY3UsL7D1dONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O4VApGig; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O4VApGig"
Message-ID: <1d3c1c86-7382-4c2a-ab3e-3e6938d055ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772207497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaJxtRy1gxu5Hm6tq13uMb/9SHoCAIyHdACW5TaPNP8=;
	b=O4VApGigh6dfWOJ9Vb5+0CQiVHhKjSZySfd6btG/EKcPBAUptNJb4/YDic3YfSQ0J8VAGe
	hZ/07Q7h657LWWPzTUyyfY/nw/ws6+i/16B29wlwXRCsnqs1muOE91VHh5HeFCpqC42LSN
	SqIKXtc4WN41DQjWrPhh33QzvyF2Et8=
Date: Fri, 27 Feb 2026 23:50:59 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v11 2/2] rust: clist: Add support to interface with C
 linked lists
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Alex Gaynor <alex.gaynor@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, Nikola Djukic
 <ndjukic@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, Elle Rhumsaa
 <elle@weathered-steel.dev>, Jonathan Corbet <corbet@lwn.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Helge Deller <deller@gmx.de>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
References: <20260224222734.3153931-1-joelagnelf@nvidia.com>
 <20260224222734.3153931-3-joelagnelf@nvidia.com>
 <dbbb1a93-93fc-4ea6-bd6f-6f7fbfcc4710@linux.dev>
 <20260226193442.GA4077409@joelbox2>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <20260226193442.GA4077409@joelbox2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/27/26 03:34, Joel Fernandes wrote:
> On Fri, 27 Feb 2026, Alvin Sun wrote:
>> Thanks for the clist abstraction. The Tyr debugfs [1] I'm implementing
>> needs to iterate over a GpuVm's VA list, and I'd like to switch that to
>> a CList-based implementation.
> Thanks for looking into using CList for this!
>
>> Could you make CListHeadIter public and expose a public constructor?
>> Or do you have a better suggestion?
> I think this can be handled without exposing CListHeadIter. See below.
>
>> The VA list mixes two node types in one list — GpuVa (with driver-specific
>> data) and KernelGpuVa — so we have to filter/skip nodes and can't use
>> CList as-is. With a public CListHeadIter and new(), we can implement a
>> custom iterator (like our current GpuVaIter) on top of CListHeadIter and
>> then migrate that code to clist instead of hand-rolled list traversal.
> Looking at the Tyr code, both GpuVa and KernelGpuVa are
> #[repr(transparent)] wrappers over the same C struct (drm_gpuva), linked
> through the same list_head field at the same offset. The "two types" are
> a Rust-level modeling choice for safety, not a structural difference in
> the list — every node in that list is a drm_gpuva.
>
> So CList's typed iteration already works here. You can iterate over all
> nodes using a common Rust wrapper type (like a #[repr(transparent)]
> wrapper over drm_gpuva), and then skip the kernel-reserved node by
> pointer identity — since drm_gpuvm has its kernel_alloc_node as a named
> field, its address is known. Something like:
>
>      // Iterate all nodes as a common base type.
>      let list = clist_create!(unsafe { head, RawGpuVa, drm_gpuva, rb.entry });
>      let kernel_ptr = unsafe { &raw mut (*gpuvm_raw).kernel_alloc_node };
>
>      for va in list.iter() {
>          if va.as_raw() == kernel_ptr {
>              continue;  // skip
>          }
>
>          // Cast to &GpuVa
>          let gpu_va = unsafe { GpuVa::from_raw(va.as_raw()) };
>          ...
>      }
>
> If you need a named iterator type (e.g. for returning from a method),
> you can wrap CListIter in your own GpuVaIter struct that stores the
> kernel node pointer and filters in its Iterator::next() impl. That would
> probably also be cleaner.
That's a good idea! I will try to implement GpuVaIter based on CListIter.

Thanks,
Alvin Sun
>
> OTOH, with CListHeadIter you'd need to do container_of manually on each node,
> which might be more erroneous code, whereas CListIter handles that for you.
> And anyway, the pointer comparison needed to skip the kernel node is the same
> in both approaches.
>
> Would this work for the Tyr debugfs use case?
>
> --
> Joel Fernandes
>
