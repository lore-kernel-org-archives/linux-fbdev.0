Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAC14C58B
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897265; cv=none; b=XEdbda7POKvj/IpbI5wCret+msa7+yiO82jLyOhw9HuPFqc6Qow/TBFk3Xl5xhauCnhuuBEZF+wrXV47Jzdw+SyUCFoInA1xsmdI5TI2uYFYNOvFXnjwMqhVmxN4n/8nfpxicxffXZw9gRKTfB0eWcimlJ3nFUjyWYks3LbIPZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897265; c=relaxed/simple;
	bh=7MZ2fnP4nMz2ezvFtFW0bkUpgRFT0pXg5LdsuNjSZhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lepKbzOAYik+salVpL/+I9Gr2T4YAP3c6GQZREDlGib/PAAAmqnIABLMhV4LR/+n1D2GpMMiTwii/XfuWW9o1vCfLq7bWxnxKTcBGTxN+hews0Nob/hXctgk50maOs+jbX6HiLLsmLDFmHj+5f25MjIZhnREsViaRx5tjDeLkvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hDWElelD; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hDWElelD"
Message-ID: <cad42648-4add-4820-b40f-3f713ebbb5e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706897262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytMHC3f1GOpt4JbRweei/YmnhLHZS+eeFsBfpdA2ynU=;
	b=hDWElelDUBe4ueIGOT55ovLgHkbhFclhl7LSpcI94+ZEEZELfa0K7sYSMQB9hp3oQZC8mH
	HThz+oH4qF/2PXNlqbNpGBqwV4Xc8mhkjH4aTbki5m3j6TeQgP3CZ6YBVCz+3mU7+Bl8Tc
	269EEzkFzSUGSRcIVuTPt3PLkGpXvgc=
Date: Sat, 3 Feb 2024 02:07:35 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2,8/8] fbdev/efifb: Remove framebuffer relocation tracking
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 pjones@redhat.com, deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240202120140.3517-9-tzimmermann@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240202120140.3517-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

Nice job, well done!

Because this the fix the problem at the root level, I appreciate this 
solution.


On 2024/2/2 19:58, Thomas Zimmermann wrote:
> If the firmware framebuffer has been reloacted, the sysfb code
> fixes the screen_info state before it creates the framebuffer's
> platform device. Efifb will automatically receive a screen_info
> with updated values. Hence remove the tracking from efifb.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
