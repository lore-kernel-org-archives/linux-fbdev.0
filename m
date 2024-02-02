Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735F5FDD3
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896505; cv=none; b=QYixPiLUtwBDJ8hqYC8NsWX6ynwSzopp5bB83a/7fZz/B7/Cgl6UTs6vgk1up7QnfwLpGti2Y819iBC5K7frmFTaiQTHdf7x2lWadauZReZaDpoh7OQE7ejZWO0swmtYOcaejfXDOdrQNuKWkUC2OJ8MJtfnNOJtHjE0fqUDLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896505; c=relaxed/simple;
	bh=F5ZLJDRcIuZytiNwfBjzwFjQkSnMSGZTVyrSQASiERM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBtagbZps4cGpf67l45Qkxhug6jvBMx1KOFuaRg3CYzcFYL7uN4vUEnhLzBoLPe7sw2Ztk6YSKlVenvKs+LCbyxKS4MJ/JOIsKAkOsaEZ7mXIzS0h9+cl53ZO28vSswj/hR4uFOLvDH5vith/5vIpkA1rqCtE8kGH1f7XSnrQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gM4GFtbJ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gM4GFtbJ"
Message-ID: <0fffeeba-b5b5-4ead-92ef-ae0fa7696d17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706896500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sog/RReS2NWyNE4PZRnVt/GhPxlyLGb3WF+6769+1Q4=;
	b=gM4GFtbJMjQQGVZhkUC0WlyN3PR+R0Ptw8RHPKq5qZpEn05v6MI43d3aul3XDeFcKGlMg8
	IZjDpXnykx1+5kUgIz5ARX3c8SABbEV45DObm/9NQyfzWhCLd4cjvv22FUSelmSBn2+Z59
	gpkCn96F5+8v0gImpZA1PL8yPKO18MQ=
Date: Sat, 3 Feb 2024 01:54:53 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2,7/8] firmware/sysfb: Update screen_info for relocated EFI
 framebuffers
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 pjones@redhat.com, deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240202120140.3517-8-tzimmermann@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240202120140.3517-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/2/2 19:58, Thomas Zimmermann wrote:
> +static inline void __screen_info_set_lfb_base(struct screen_info *si, u64 lfb_base)
> +{
> +	si->lfb_base = lfb_base & GENMASK_ULL(31, 0);
> +	si->ext_lfb_base = (lfb_base & GENMASK_ULL(63, 32)) >> 32;
> +
> +	if (si->ext_lfb_base)
> +		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
> +	else
> +		si->capabilities &= ~VIDEO_CAPABILITY_64BIT_BASE;
> +}
> +

Do we really has a need to modify the si->capabilities at here?

