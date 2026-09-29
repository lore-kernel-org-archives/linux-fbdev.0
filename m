Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7A46F4B8
	for <linux-fbdev@vger.kernel.org>; Tue, 29 Sep 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697503; cv=none; b=nlDgga4EAzZAMuUeuSPmiRf6YjakF/Sxw4DCUats0u+7VKc7oiZkCLfQFFEI+xVSByEd24d7qN0u6CA14vOKgbY9rS8k0DNAOh5M8H3HObK6K7niD6Rrxb1uXktCeGCJnAISXOqI37SMRuOrfYPFaHmpfyBUDN5YbmN46SjE2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697503; c=relaxed/simple;
	bh=nR4yrTOIgVgspvjCPgKKmvkm5cZCrViKQN79fpTorck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5/y+oFj3KA8CJ/R8i9iKwRMNE22uDT7dDHeN9DyKopo3vWjDYy8K3sX142jHw6f54jkEuaPvIWi4qlKMxYxV0aXuq9Cey6T7PJ67R3GwU7yckd/+l4YHpb4wudB8LwujiwoWjfF5Af5xpOP6z26TJl5hL721enIUiZvFJutILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TGjFZgg5; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TGjFZgg5"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so41089255e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 29 Sep 2026 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790697499; x=1791302299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gf4CL38l7K7zHB2Jr75kV3VIF1+DE+Av3C/FhqhlLqk=;
        b=TGjFZgg5lUHeZxukRtGDBpWWXiPuev8gp7o7FIX6qFXoKC2EajqRD+/ExUDCSfZjoC
         i4OrZjFiZGSOtA6mpUM4f/v/zeZAXWCL3g41cedVNWBPRLuxv+9Dd+SWUiKp5re4pZfU
         jJ7hvCUY3S01HlnQisdD/KK+9JhEQayTnTWsXyOQs91JsZXPSkOOZZ2+4l+vktxu61vb
         8w/OE2ayTWQXiV2FZWNafA6HdPrYCAqgm4k0PQXdk1/Vwauf44GR+0YcnVQSOaFVxjpB
         d+/mHzpjlC5QOs1jyDU2SN5c6YrW8WpQYyg2fsMt9DDG51eS4rnjRbgfKV2Dql7KmKt4
         ocqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697499; x=1791302299;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gf4CL38l7K7zHB2Jr75kV3VIF1+DE+Av3C/FhqhlLqk=;
        b=vaTzZzfHlSOiXBWIWHi+SXsJbl+3qpJAmI/yBKbeowQVFcxVAG6eHO0R6DX3HGcbhc
         OyEPU7qJKon8SxKi3wuwxwgR/+ByMhzOGaA49pVtrTyhm21wRPkey8nXG13ayCIFscu1
         i4wG0NRFhqqmGPunKcKbIfeBWrHvfouqSgFhVGM8ZrwM/YWvYrZ9vT4+wOsxyvLpkfGS
         aR0atkrp8kxbYZDkLFYHcvYHb3WQbp7yUv1XRQKlMxqy/aGM+l5u9GiY7DI0BJyPp0xw
         vul9wW1vCLoZbtpVv44jGjRSqUFL7Ot2q7epQhiZ9yaWSCxmZ+7ayICUH/8HjRpvCrWr
         jLXQ==
X-Forwarded-Encrypted: i=1; AKwUvBy222tnR7KcIoW71swrze41lVEw1609fMMYee+jP0DvyQZNJQaeIgDIkTkemIl0Mq818orufKWByKfZFw==@vger.kernel.org
X-Gm-Message-State: AFuF++ltrw56xeukCbTM1mGXOnlF3/Hr3y8/pJxgc2Mh7H/62i4cuM3P
	weOPxxtqQswXneWTY3VwvPFtdGWQcKoqAd51z1kTNgEOf1Ny5zckykwflL725tq2Df4=
X-Gm-Gg: AYBFou1XKuHxIuRy5ibwTxHA3gkM+4D/d6cY+l6+TBK4GcA3BfxFYuGzeDx4lPNwX3C
	Sx/W5pzJDgevh4JLDBq0FEAi3z9OpXC0ftjTpCt6dXLmWQjF9Rg/bu7WaN63w81FbFliWGsovwg
	YVCdBeGR7l2rLzWh/66judj2RMj59fUVTUn84/8aJsWfapaYNCS1L1Txa8ni5Mx5VOo7OJM/JvE
	45jaXYUOBTTAxUffaoqQuuU7n66mRT4kLMtySvrVRjGSA3xW4FcDCvSNkk2+Pk4mQYVb0KdDVm/
	Vyxu2zMst4hvbEqP3fcOHlefC7eWUlzM5Cju9sgh3Y0wjdome35wBr/cRnPU5GftD/y7Ql0/3oY
	fbghddVlbtNGGGcvHybUSm2IlYRYWEzMOehJXUJP5FO+Z6IM63bWj640s1H3VaMxT4hFUXzaV6U
	VWRDryYNuz27TENJQDEJrs6CmaaJcvZthi7P7hoqaQNaG5N5jjJKwnfrEEPMhn1SZ5zKkgNbXOo
	Eq9
X-Received: by 2002:a05:600c:1d1c:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49fe66c9ae3mr284330975e9.3.1790697499193;
        Tue, 29 Sep 2026 08:58:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dfdbsm127631095e9.1.2026.09.29.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:58:18 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:58:16 -0400
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
Subject: Re: [PATCH v3 06/40] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
Message-ID: <arvf-dEnIzsXhzkL@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:15PM +0100, Lorenzo Stoakes (ARM) wrote:
> There's no reason to export the symbols for these functions which are only
> called from internal mm logic, additionally there's no reason for them to
> be declared in mm.h.
> 
> This patch therefore removes the exports and moves the declarations to
> mm/internal.h.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

