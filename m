Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F6E414412
	for <linux-fbdev@vger.kernel.org>; Thu, 24 Sep 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267895; cv=none; b=uGfZ+XVH+RDy1HGKknRocU/CAtEGg21h2dWspdfwkJsdvxDiUUR7x7yiCG9PoPVg8HdvgT/uLQeBQls1hJvtomavnDCK5Z199SIRyBjiQBZPxfGW1nVkTuZpHofvNHlnGm9kFLVmLu308QIoReQH5BDjJFc6w8soDt0Toi9Rgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267895; c=relaxed/simple;
	bh=Y6dfgoDu9ENyHz35342iESy0PYqePxl/sIn9jSurkUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG6ZzNHm5zW1jgrquJE3ip6+u6Fl87Pcms7URa7RnRqDmby87opdW+fnXW5hzmzT3DUQO+XeEdRGFmB5CID5EZFk4OQfqlpqVw7Fn3nvNnWLJyhOhsgp/0cKWdWxNRPdpBqOL40gQ+JB9SQ42+vuu6x7+tgw5rg3onkwSPczeys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DELaQ6H+; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DELaQ6H+"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76543e2so141171cf.1
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Sep 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790267891; x=1790872691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=DELaQ6H+GoqYKhSPbbw83I2UghjOPLUKt/HJzwYXOl5vd4By1b/ewKsZIbd9ahXhZb
         TJDLBT2drAnq8j1D4gtZjKdZE54vfhHIW07z7SMjyhNrpJZ88lIXL27llafwJKgt7Hvw
         zeqWn52o1fsiwmzoo4rrDQZv3h3IiFJnFO2iuBnkUsGA3ktjvtFHA3Jr6K2ZEcGMg8M1
         1di2ZTIAJ2yTB2V6zmlctv6zG6tcG5IvMF9RkWmI06r7tX+skZxDuVThBB0MSr3NZe3S
         B2+XxiOTA95Xk/3/+mlBZ2rpvQSIcAx9lD43yFxhcrOBvTesr5mE416XkZK5Fw1vsdLx
         5Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267891; x=1790872691;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=yu2ZLf1l6ma0foWd8XkxX9Ynr0rZGMqWBcr/2bt93H8IJnSmwqYyjR3VSdZCQH04as
         sjM539yjlxAgmDkxH3OoZ2sPuGWBlUQAoWEF2Rz5iysyrTrF/XlpVSww4wDRvhLDhHc5
         +PPAlTt81TuqL/XPa2VYGg0neZqK+jCObQUCKl6AFMDMge94cr8bp/g/UcxTcE7fkIJI
         wUhqAuNrN+ONUaimKinwfStaVxc+M/xVHvy8TdrHHyTu7QKyC2iFDA9A7AnYblw1VszJ
         apmnKYPGy1iQmLfs3dbXObI0gcHeWAAPT0j2LG6F4IQdVPhzu3Y86sWSNKCJsgyjzbAw
         dRxQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1QMemTfEQ4rTOph41dwzl33nUqkJvfDA6PZnu1GwbZGTO5GC0Gib4cg1G8RHvoy9aILJD992b0CHpBQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kh1D4JgPxnuwd7vhTYGJHRpUxrhTxn/muxRgq0KyKsNmpZ/2If
	AqkT+dh7ehx762a0WOgY0YJkjjho9+xJdQLWWxanUP7UxPUhns9jfiWZm3LXDMkyJOQ=
X-Gm-Gg: AYBFou1XUsqcUjrDAqXAA8cgU0VXGcWnQwnIfMOni6fd4jj+HXIJHXWF4SaDGbWVp6F
	bAyqRmtuy7kP6Ry8uO2lNy4V7E2yHCMNreruzgKLVNqDeqPseCDNB/fVZGb0OU6tI6+fkpRMsn7
	vHgX10ez1DJAyBgOrkfnMvN7pMFa92coZmaxGyj0AzSVuqnSy/qk3uBXWE+OgG02/SfOu+lDtgk
	fRUV3da7mITnvJUH982qXEMhVTAzOAQ9y8BLHCgPm2zo9Hp9YxFQ3Cz1nHOE9DD8mZmXx8DbE9p
	cDAFPfPVFHU8P7xj1qQo5Pmiwk6s5Gd2X5Isee5uhogIZv5Aiy7Y6JwSbFgxqZM4Q3bUrA5leat
	eLGCq48IBlffYTx8MhOCaKqMszYnqHNZ8xz/DnfaKeSySeOsqhYPKstJmv5WbG/yJkcrpHB+7td
	WhAgv3IsUPPSJ/2aPcGAPfFJ5mdE1/8PXOwaGhuyT8NExNOtiEmbTnkNQGWfIzOqCM9rIq4+iwE
	0Q9p2p6FtULopeBF7hYEWYo9IKps6dku5f2OUnBbe6v4KsRTvqyZOQ=
X-Received: by 2002:ac8:5743:0:b0:530:d860:ffba with SMTP id d75a77b69052e-532fe9f05bamr29797891cf.6.1790267890993;
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb32f6aasm45064551cf.16.2026.09.24.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:38:08 -0400
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
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use
 vma_[flags_]can_merge()
Message-ID: <arVRqJZkql6sGunt@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:12PM +0100, Lorenzo Stoakes (ARM) wrote:
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic with
> two new functions vma_flags_can_merge() and vma_can_merge() and update the
> merge logic to use the former.
> 
> This abstracts the check and expresses it in terms of the desired behaviour
> rather than an arbitrary and confusing VMA flag.
> 
> This also lays the groundwork for making further improvements in VMA flag
> usage.
> 
> Also update the userland VMA tests to reflect the change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

