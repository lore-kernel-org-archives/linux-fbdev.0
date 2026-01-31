Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83733A9DD
	for <linux-fbdev@vger.kernel.org>; Sat, 31 Jan 2026 03:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769828475; cv=pass; b=mTi2V4+sIog1Po9RW9ohDWWtOoOAy0glBQxq/u8Wxt4q/A8HKvWIYATOzAtaBWKbPJbimcg5u9voFE8//1tFOam682f7yswP52H6NNl3bkKkT1LCokAPWduwF1YJt9Sg9BorKPKNKekmNOwyA/SxVN5zPkFqIlVbcqeRy63Yn/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769828475; c=relaxed/simple;
	bh=0dP1zizuvb+YCTfhetz0ht1UJLaJiSW38KjUpELCixc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucdioX1MPUB0wOztjRldphZGhV3JSimPZ5CTHl+aRQB3xgyBwXg1+leMweiXAAZrhcFe6NNYxoTHI2YZSrj8So8jyJc/olayLUSZrwNBf0fqJACEu8Fw3nA/TLVRxj71DACGE0+SE/rbxPhvhdt2N/b5ejlXcEvgw+/oUTXFAeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPz0hibx; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPz0hibx"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8946e0884afso46455356d6.1
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Jan 2026 19:01:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769828470; cv=none;
        d=google.com; s=arc-20240605;
        b=W31etr8klKGt4Hso/Nnn/0GjlK2cA6/ZhdyTavNw4WHBfog/UEyRuszXQyoYSsA9jU
         NnfGRyIReGWmF6YFWL9rdxKcKJdybpkThjGwO9JsmJqZqrhnkXIxZoBTiOO3du7wTtvj
         7Kso3SZm7EdqRuTJ7kPmhKZx1fwSLTs4yX3kLc8OHTMDDQMPWIh1NQeWEgKZo+9cZayi
         QyvU/RTCfBAOps0/S8qZSbXfBS2s4RIh5u0EqKjF73U3rHb6oynraWt3g3RwR+H2rErN
         BMHwkxc1E+sOhoCqTV/jKcfns7BbQynz7aKzvvUKLa9rFixpsek1b42ObSyEyJbLI0Y3
         Lkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0dP1zizuvb+YCTfhetz0ht1UJLaJiSW38KjUpELCixc=;
        fh=yrUn9Yk/lGHFCcFdMQISVaYMSWHpiP0CqW3JNf8W6dw=;
        b=hVFLyglMgz9MKHeXkxRccnZYq4F9rOhSLf8n5rhDzzaMfQMrDKRpvVYXiU/zNXlFkl
         6iqj8WwcaEsY1a/B5DdVuq3ZgB+BqdU1+OquppR4NFJrF6vwoCxrnGuSqRpGY5kRmTdh
         DlAV1WXuPtx2EtOjRkpXEJDE+R+7lA1707jW7zMkK1C7b7K+9SV0ZAI6ZeLilwjmX7vO
         5wL3OFccAam5KTo5D4VeyeF9CgZOMguPVCQF/hMcuWmBj4WS7P6kzAfpaIJX0+ShGKEQ
         Mq232FmF2X6OnAJrLSoVQu80TrtL1mzwU32EC0t17Ru2Dz/DyTzg4/yZscvTZeNWhhC2
         qQuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769828470; x=1770433270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0dP1zizuvb+YCTfhetz0ht1UJLaJiSW38KjUpELCixc=;
        b=WPz0hibx6GdNkusUtWCaf2UaHgvYNZqQ1U/vmDYmAFqzLTEnXLMcBhWQuBNLXuZiIX
         otUnCrtku2ISMwbZY9lc5qsisr6iq45nhbRx3YntkuAiCzcqYDa4niCSPVQ1nF7sqeas
         lVL7ZCTAqfcSM19/UIhc9mSXnawMpzBIyKVZVoRh5AulgRhPKfm9vHecDK0kYfhrrHeb
         2HeWLp3RtnUbWHBXaiWBrhCPCf5gAhJpByB/SFxKH3hnHFy837PLHfWJdvMNdpLvVWGH
         N7JTj7v7qRFeJQPKGmr6dwOsfgXqyFf+zNN8bHokW8n2xwAmM1XoJPacjCg5n4Ez+ctu
         tnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769828470; x=1770433270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dP1zizuvb+YCTfhetz0ht1UJLaJiSW38KjUpELCixc=;
        b=fsk8O4xrOem7ppIMmtUr0zFWkNx4UvecuaErNhHw1HsQUbP7bkPtLJLc50FQBat3Gz
         maRQpf0tWCb3epuvhwUfA11b8Rc2EKTbS4Oa/9frsY/6lxrdqIhaN6DBq6SZJiPe9ufY
         fQvLyKop0drvdcE6urGL3Q4fr+tAYR6IHgY+3eKbO+75Hm4kLlBZfSGEWxYYBRowDup4
         zAJmLlCWYzrnhYFJ5Va1Xot1R8nbxXDe4G8ETb1eRSkpPHQJcRPiGZod3IQpjHpHgrR8
         Hx0gm5WgKduau3MFrPgawhx9uEX/dNwFkdC1I2OIvkYeIGLoINhCLvNOg7QNtmS8Z/nj
         gBEA==
X-Forwarded-Encrypted: i=1; AJvYcCW4F0u7S78hSNIcyzhV8N1kmTdng3R9FrLsoVVPwYCh+iUSIe4/TYZXaaK5kdQitgaikYZcbFB3yIHb0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/v9Z7zFJZCamQTzbaHbl04RivmEMOQz6Cm59DxU5hZ0ltX3K
	htgh5W/COYue5uq5yPyyDJlC6fQHnxAVRzA9m1A5o1XbMK3uqhzhaGL13NOgeaa8ATA8yprdA6f
	6maVrO4BtY+5pwgNfmCXZ7ERTtcZxmnQ=
X-Gm-Gg: AZuq6aLfhNfRuHn49vW6Vxx634KFSx+Dsf7Udz4c3Nd8HLeCKQWlLqCc+A0u1aNHLjD
	UXwK7ESuxqmwX5RJlsOsB4aqBHeCwNDV2OEy3+uIz9jbtpcMDu4iOmJ/+/VurnuFMovLR4ZnouJ
	MlXut+3BFv3//K4oZ7JjBpJD11rl+Ss5bymNveGWYz9I26QPb41b5lAtxS1HeMo8MQzsk7wBig3
	Cv3Vyj20Jj0DVOqOTGLPAvDrA6QM94xHYibNYuTeSktMUgUb9JPNnFqOP5yC8XJa3VwWu2O15bH
	8YKsmjtJ04bU8M5kw/679u6D8sVQ4WsvalesQM87133EZTErudO+GS8=
X-Received: by 2002:a05:6214:260b:b0:880:51f0:5b93 with SMTP id
 6a1803df08f44-894e9fe6cbemr81159006d6.18.1769828470148; Fri, 30 Jan 2026
 19:01:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97af2d85-a905-44d4-951f-e56a40f4312e@nvidia.com>
 <20260130015901.GA301119@joelbox2> <c064fbdc-9202-437d-80ff-6134d2a33778@nvidia.com>
 <70d88203-2fe1-4bde-b254-51e8107744eb@nvidia.com>
In-Reply-To: <70d88203-2fe1-4bde-b254-51e8107744eb@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 31 Jan 2026 13:00:58 +1000
X-Gm-Features: AZwV_QikuSqbC3QYogib7-81aPfnOToX57Ol8yNxSKEx4_hXbDFs8a3hQtETIYo
Message-ID: <CAPM=9twm1x9rH==uoGQLYa8b4feQMz=Ne14WPuhCPy9_H1u5Tw@mail.gmail.com>
Subject: Re: [PATCH RFC v6 05/26] nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, Zhi Wang <zhiw@nvidia.com>, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Alex Deucher <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Rui Huang <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, Helge Deller <deller@gmx.de>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	Edwin Peer <epeer@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>, 
	Andy Ritger <aritger@nvidia.com>, Alexey Ivanov <alexeyi@nvidia.com>, 
	Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Jan 2026 at 07:14, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>
>
>
> On 1/29/2026 10:38 PM, John Hubbard wrote:
> > On 1/29/26 5:59 PM, Joel Fernandes wrote:
> >> On 1/29/26 8:12 PM, John Hubbard wrote:
> >>> On 1/29/26 4:26 PM, Joel Fernandes wrote:
> >>>> Based on the below discussion and research, I came up with some deadlock
> >>>> scenarios that we need to handle in the v6 series of these patches.
> >>>> [...]
> >>>> memory allocations under locks that we need in the dma-fence signaling
> >>>> critical path (when doing the virtual memory map/unmap)
> >>>
> >>> unmap? Are you seeing any allocations happening during unmap? I don't
> >>> immediately see any, but that sounds surprising.
> >>
> >> Not allocations but we are acquiring locks during unmap. My understanding
> >> is (at least some) unmaps have to also be done in the dma fence signaling
> >> critical path (the run stage), but Danilo/you can correct me if I am wrong
> >> on that. We cannot avoid all locking but those same locks cannot be held in
> >> any other paths which do a memory allocation (as mentioned in one of the
> >> deadlock scenarios), that is probably the main thing to check for unmap.
> >>
> >
> > Right, OK we are on the same page now: no allocations happening on unmap,
> > but it can still deadlock, because the driver is typically going to
> > use a single lock to protect calls both map and unmap-related calls
> > to the buddy allocator.
>
> Yes exactly!
>
> >
> > For the deadlock above, I think a good way to break that deadlock is
> > to not allow taking that lock in a fence signaling calling path.
> >
> > So during an unmap, instead of "lock, unmap/free, unlock" it should
> > move the item to a deferred-free list, which is processed separately.
> > Of course, this is a little complex, because the allocation and reclaim
> > has to be aware of such lists if they get large.
> Yes, also avoiding GFP_KERNEL allocations while holding any of these mm locks
> (whichever we take during map). The GPU buddy actually does GFP_KERNEL
> allocations internally which is problematic.
>
> Some solutions / next steps:
>
> 1. allocating (VRAM and system memory) outside mm locks just before acquiring them.
>
> 2. pre-allocating both VRAM and system memory needed, before the DMA fence
> critical paths (The issue is also to figure out how much memory to pre-allocate
> for the page table pages based on the VM_BIND request. I think we can analyze
> the page tables in the submit stage to make an estimate).
>
> 3. Unfortunately, I am using gpu-buddy when allocating a VA range in the Vmm
> (called virt_buddy), which itself does GFP_KERNEL memory allocations in the
> allocate path. I am not sure what do yet about this. ISTR the maple tree also
> has similar issues.
>
> 4. Using non-reclaimable memory allocations where pre-allocation or
> pre-allocated memory pools is not possible (I'd like to avoid this #4 so we
> don't fail allocations when memory is scarce).
>
> Will work on these issues for the v7. Thanks,

The way this works on nouveau at least (and I haven't yet read the
nova code in depth).

Is we have 4 stages of vmm page table mgmt.

ref - locked with a ref lock - can allocate/free memory - just makes
sure the page tables exist and are reference counted
map - locked with a map lock - cannot allocate memory - fill in the
PTEs in the page table
unmap - locked with a map lock - cannot allocate memory - removes
entries in PTEs
unref - locked with a ref lock - can allocate/free memory - just drops
references and frees (not sure if it ever merges).

So maps and unmaps can be in fence signalling paths, but unrefs are
done in free job from a workqueue.

Dave.
>
> --
> Joel Fernandes
>
