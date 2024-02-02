Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E71420A4
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893439; cv=none; b=TfFyA2yUC4ddfsPYKRcQRZWQqpUkSNoOqj7ucyI702LwMqMAyBvpGORFnVrx08C1E7CaoSyJYhwydqUYX/rX8lTIgiHJ6QsIj4E1ua4HJ9oqKLDKNVDaoOhRYQci/pzxfBcOy/HJBP3IRF7GWkG6ecSE0ssnB1ZiA/7YMerd84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893439; c=relaxed/simple;
	bh=wsYfim9dZczdSkXznaDfsgHSqe+jAkkTUH67c/5W9Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxlEdXVylwb/POJas+Q03apQuFasShPSxQTPhGGwDMc8ex4CTkV5ikWNOSJp9HU7o84XcNVvELlkimRhS01K7q/Vq7vpavIUhSiVZLxU3VmJsJX950t8A2Vbroukeq5t1KPV3l4MZtSY8ZTtoefSBNd+SaXRObY8SFSCQarAghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eIeXMofi; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eIeXMofi"
Message-ID: <16b3f80f-9b55-4b91-8fc3-9b8ad414437b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706893431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJaPMNeazUzXDoh/gUAOxSSPoKtwbUU77GxfKC9lEu4=;
	b=eIeXMofiIAiZuvFInz6yrJS98T4hDr+aIksfA30EHCqFQt+DWX7C05snBoADsJOpHkM0no
	XJhequ3vv655zksTgmD8JM13Jg8jAwtn2jFBN3AfLn0M7qU6Cogov+gQ6fYmB6QWjBfNrf
	n4+DnUjXy1Iegl1u+30WauEUDUzVU8Y=
Date: Sat, 3 Feb 2024 01:03:43 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2,2/8] video: Provide screen_info_get_pci_dev() to find
 screen_info's PCI device
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 pjones@redhat.com, deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240202120140.3517-3-tzimmermann@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240202120140.3517-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/2/2 19:58, Thomas Zimmermann wrote:
> +
> +/**
> + * screen_info_pci_dev() - Return PCI parent device that contains screen_info's framebuffer
> + * @si: the screen_info
> + *
> + * Returns:
> + * The screen_info's parent device on success, or NULL otherwise.
> + */
> +struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
> +{
> +	struct resource res[SCREEN_INFO_MAX_RESOURCES];
> +	ssize_t i, numres;
> +
> +	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
> +	if (numres < 0)
> +		return ERR_PTR(numres);


Please return NULL at here, otherwise we have to use the IS_ERR or IS_ERR_OR_NULL()
in the caller function to check the returned value. Meanwhile, I noticed that you
didn't actually call IS_ERR() in the sysfb_parent_dev() function (introduced by the
3/8 patch), so I think we probably should return NULL at here.

Please also consider that the comments of this function says that it return NULL on
the otherwise cases.


> +	for (i = 0; i < numres; ++i) {
> +		struct pci_dev *pdev = __screen_info_pci_dev(&res[i]);
> +
> +		if (pdev)
> +			return pdev;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(screen_info_pci_dev);
