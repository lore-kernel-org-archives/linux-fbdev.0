Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C442E8FF
	for <linux-fbdev@vger.kernel.org>; Thu,  2 Jul 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998001; cv=none; b=cQ1/0SLQQvYxWCy8g10J5bI1oMmQjOu1F6owms4GJvDAwHde8JgPHz1OG0Y45iKxwlvW8vX7HzLPNCVw0xtSzCUtyNZNfpqOWXD5LPJ5jYC7ePOXN1bvWNJlYFehjSuqnLl9RFjfbI7CeTRJS5mUNOuU6tCwcpT++fZmjo4cf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998001; c=relaxed/simple;
	bh=pTjKKHwaFHpnWuOGJj9sjtDsv7AR/wPgTwwTBWMLOoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+8A1jnNu9VKChBsVObhZSTRspHfl6/IjBYqL4+gyFWPd9ojal0kmyYxS8OvZELJc8tW7ITwwXcI9q/8JMHnnF47LQF4CwLvsthmVX1u2XCWXeL+h/tmNhkp2XKD2iNamIi0f2hT9umrfod9q3SaAUVoa77lxGTPdPKoVf84Log=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHDhEc6C; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jHDhEc6C"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782997985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WkYIESER5H1pxokBfEp6m9xEZZ5ghGe4TjZZy4BO5I=;
	b=jHDhEc6CTiPftGqyHzVdl3xS/wEnOHSN4PeeVFnRX9fUml//8WA53GAPbsxSbJvWuzc/sf
	tH1rSEqcTxDFS7qyJ0iIaX/a6tA48FPP/mFE4c/byOkvPcPlvJwYSUFubJkz9Jxs6S5ya/
	AItLuFoisprFM8kvEpkf04Kk84Cg/T0=
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	tsbogend@alpha.franken.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	l.stach@pengutronix.de,
	inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	robin.clark@oss.qualcomm.com,
	lumag@kernel.org,
	lyude@redhat.com,
	dakr@kernel.org,
	tomi.valkeinen@ideasonboard.com,
	hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	thierry.reding@kernel.org,
	mperttunen@nvidia.com,
	jonathanh@nvidia.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	zack.rusin@broadcom.com,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	oleksandr_andrushchenko@epam.com,
	deller@gmx.de,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	hughd@google.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jannh@google.com,
	pfalcato@suse.de,
	kees@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	xen-devel@lists.xenproject.org,
	linux-fbdev@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 10/13] mm/vma: convert miscellaneous uses of VMA flags in core mm
Date: Thu,  2 Jul 2026 21:12:33 +0800
Message-Id: <20260702131233.59026-1-lance.yang@linux.dev>
In-Reply-To: <1e7d834c887b6a65627d730addcff13d458c6268.1782760670.git.ljs@kernel.org>
References: <1e7d834c887b6a65627d730addcff13d458c6268.1782760670.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 08:25:33PM +0100, Lorenzo Stoakes wrote:
>Update various uses of legacy flags in vma.c and mmap.c to the new
>vma_flags_t type, updating comments alongside them to be consistent.
>
>Also update __install_special_mapping() to rearrange things slightly to
>accommodate the changes.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---
[...]
>diff --git a/mm/vma.c b/mm/vma.c
>index b81c05e67a61..ab2ef0f04420 100644
>--- a/mm/vma.c
>+++ b/mm/vma.c
>@@ -3417,23 +3417,27 @@ struct vm_area_struct *__install_special_mapping(
> 	vm_flags_t vm_flags, void *priv,
> 	const struct vm_operations_struct *ops)
> {
>-	int ret;
>+	vma_flags_t vma_flags = legacy_to_vma_flags(vm_flags);
> 	struct vm_area_struct *vma;
>+	int ret;
> 
> 	vma = vm_area_alloc(mm);
>-	if (unlikely(vma == NULL))
>+	if (unlikely(!vma))
> 		return ERR_PTR(-ENOMEM);
> 
>-	vma_set_range(vma, addr, addr + len, 0);
>-	vm_flags |= vma_flags_to_legacy(mm->def_vma_flags) | VM_DONTEXPAND;
>+	vma_flags_set_mask(&vma_flags, mm->def_vma_flags);
>+	vma_flags_set(&vma_flags, VMA_DONTEXPAND_BIT);
> 	if (pgtable_supports_soft_dirty())
>-		vm_flags |= VM_SOFTDIRTY;
>-	vm_flags_init(vma, vm_flags & ~VM_LOCKED_MASK);
>+		vma_flags_set(&vma_flags, VMA_SOFTDIRTY_BIT);
>+	vma_flags_clear_mask(&vma_flags, VMA_LOCKED_MASK);
>+	vma->flags = vma_flags;

Maybe worth a vma_flags_init() helper here to mirror vm_flags_init()?
With this open-coded, we lose the soft-dirty WARN_ON_ONCE sanity check.

Might be nicer to keep that check in one place ;)

[...]
