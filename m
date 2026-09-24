Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1173DE450
	for <linux-fbdev@vger.kernel.org>; Thu, 24 Sep 2026 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272825; cv=none; b=NYY2CyxxywQMp7XBk0+M0nFYC3iI7fSaLzEG08lvTtgAejhIWh5gex8wnbBhTxsaHSrXCiNr+EhOFIvZ2GJnXu/Ob/Yl5haRUVdaTU3IUBQEBhiF44PpKs09fDiqoLpV8Kjg1ixJ5MHTz4uOmlRklRAD8mi76Vzk907BiuFhZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272825; c=relaxed/simple;
	bh=dIEo2BWot8KMA7bFyxIXMBMINiO703u3CNAgbTnUo2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1GqOLMvD4I8VNInvl/B35hHV24/7TQkfLnoSgJejQkLY9gor1ZTy+nPpJoK6d66kpL4M1kxKuBkt//YcXR1p/cHPEslfbE20QzDXn2mkVa/l4MRUQD1DzcJe6Z3hqfvW2yNXGtfkxwhc6IVH6BB/hU9c5S+q9biqhKaEfM9lXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qNcW8nj0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qNcW8nj0"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52f9fc510e1so8275601cf.0
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Sep 2026 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790272822; x=1790877622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yIrEACM/1hk8RvSSdnwytl7iIy1+VcppA4PP9Tt2BDk=;
        b=qNcW8nj0/pDdjrHX+ELCleXyhNSH46+yVTvIwKXf0KEsO2lrNq/+t7BLtAJv/5kwUi
         2AQLV5DG6nqODb54KYJ2Hhy8HyGJBZMXduXpgQLzeebEeIcn11k5EsbWxNYcGPXBaT1+
         /qweihLG7noAHfK+Zx5EEGn0ruWcXq/Gj/S2WSYYG/9cAsBnCCVbDo0GQ6tr6T6jIO6M
         OeOdtj4ZPY+H89quivLjIZrF0JngYycSDR0/nPJVKUYp/eeTnJbocj21+VpbAezcSeJb
         3sQPtmZy9+wwtqCXvsR5dE5N64+9dWM26DJ4nK/0tsdNaizI0KONqxKZScMTirDGCpdM
         wpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790272822; x=1790877622;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIrEACM/1hk8RvSSdnwytl7iIy1+VcppA4PP9Tt2BDk=;
        b=bJ+HhUiQz/QDAAXkdE1gZVaYMPxJwyCG1Aj+SnT65bkpcKWf90dwpcp6C0n69VNba1
         X6bptLVIVTvHP2VuCVy18dB6Suli6ylzcd6w5xbrWZXTb2R2ZEB60iVk51Gj/ZY1LiSV
         9adeq01wIDipWOWsL4oSSRZdnEU1LKrymc1dxoUeKo0XhCc+glZIXuyrYkGZAC6NzJsu
         ub+QDH2trHUD5cv1GmI0wBMg0YoSG+ifxf5QdTOQ3/WJARO/DPUNMIewKWCzYtyZLj6Y
         ch3c4wwn44wJCX4amfTO4SBbkh2pzMV2Saxl85kADCV4e9V4qDqJmHjR+qootCYLjq7+
         FsLw==
X-Forwarded-Encrypted: i=1; AKwUvByrJfXHOD1IZOxq5CPaSATP4Kz7NMVQBDR/QchPDEeE1n3q1X7psr3SyaNqJihJcbB/zY+vJ47hytoFbQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lOxIKH5y6q9/IiQbxl/7YJGHVYm53C3Xs4DeAu9kjTgiERS2na
	ska2x/j1btWRSv8QBjuKiXIRHgXcMZS9Eq18Pnydm5uLvCX/FpqlIVrf3fWX2Itpia8=
X-Gm-Gg: AYBFou3SLzXO+NLWW3od+601tPgLZwjLEqwzAP5s/fTBHl7QLaOv/TFDcvZVh9v2TNZ
	/IE2JBLZ/fZDtef6f6UUa6nWSL5VaGPS31isbS++GBbFR4oT7D0UAoRTCsJ8oJpXR6Os+FfDxAZ
	ebIhJB4RJIWwkOcImaPOHfzJNCY3CC9PQ9HvtTg3sQuSe2YSRAwvCp8jfWa6EFWxJLSbWohl8iA
	d2RI3dKlzBj+iw4PmrS7EM66zBlDO8Qeid9TpQAPnjrhd0wJYEjkcDxAJUqumOyAj8rD9q69/4o
	geW9XTvGCG968mHnMp+nK7g0z5CrTrBMXw1RGA/Xq4cb3D15b0HqaD2JCD2GgXj7DgN/RBUKyBV
	Jo1gJ+MsG86Zeu6e1G1zemQNK22JpbMvElRVXDkEak8m+mOZnLQ2TOyUqAFZjUyDWKI9QN+Tw4c
	YHFs0oVqITlT044Eb9qRtQvYhYfqID4iASIJpbv+KIQZZ1wfdEx4POoIRTHT9KjsIViWGy2QPgS
	aydD543V07Xnzp8+87WGV+sq2YA1u/ceWGj0zXVNvnRM502sxfqDCc=
X-Received: by 2002:ac8:5a46:0:b0:530:e682:87c with SMTP id d75a77b69052e-5330b6df434mr78501cf.33.1790272821894;
        Thu, 24 Sep 2026 11:00:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb38d347sm47450101cf.25.2026.09.24.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:00:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:00:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 05/40] mm/vma: ensure mmap_prepare doesn't set actions
 on a mergeable vma
Message-ID: <arVkwC_wNoTLjRYf@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:14PM +0100, Lorenzo Stoakes (ARM) wrote:
> When a user requests an mmap_action be performed in mmap_prepare, this
> involves populating the VMA range with data.
> 
> However, if the VMA is mergeable, it might then mistakenly be merged with
> another VMA without having populated the range.
> 
> Every mmap action currently available sets VMA flags such that the VMA
> cannot be merged.
> 
> However, to ensure that no future mmap action falls foul of this, assert
> that this is the case upon mmap_prepare validation.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/vma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index d6ed10cefc8f..62f2ce1ad5a1 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2809,6 +2809,15 @@ static int mmap_validate(unsigned long prev_start, unsigned long prev_end,
>  int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
>  			  const struct vm_area_desc *desc)
>  {
> +	/*
> +	 * It is not valid to execute mmap actions for VMAs which can be merged,
> +	 * as any such merge would leave portions of the mapping incorrectly
> +	 * unmapped.
> +	 */
> +	if (vma_flags_can_merge(&desc->vma_flags) &&
> +	    WARN_ON_ONCE(desc->action.type != MMAP_NOTHING))
> +		return -EINVAL;
> +

If you wanted to make this unit-testable, you could pull it out into a
separate function:

static bool mmap_action_is_valid(const struct vm_area_desc *desc)
{
	return desc->action.type == MMAP_NOTHING ||
		!vma_flags_can_merge(&desc->vma_flags);
}

then write:

if (WARN_ON_ONCE(!mmap_action_is_valid(desc)))
	return -EINVAL;

And you can write a unit test directly against mmap_action_is_valid

otherwise

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
