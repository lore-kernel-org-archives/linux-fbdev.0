Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5985276
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891494; cv=none; b=M7aL6J02fUz5+YOxKqkFsDDA9imaeHjI94kyaJ1QbkOwHSkpqIq/wsSl/VXurcmVfdb9dWFvQU2mlWlLKaQbduaV8D4AKbASyklNhOH41UtIkgvxZ72aBAOrH+zXLcGioQfafk1aAuhHjbrdXD/FW/hu6vMttCtyS6w5VbPXMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891494; c=relaxed/simple;
	bh=4XVNWk2SiIndxyiCSDVe0wmlG5Iye9Ll1wIzPMDeqFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM0QtG84p5OlBlOkp6AcLNKtrPw0s9MQl0vTN5SplJoZSiPZRQfFoCDcqe4LP73cvb+JVDtSxvABYIVuM9ff4hois7Xdyhj4XdNtHRpq69f2LgyFjAmDb0lYamvC1NvCAMECp/hueabP4KlHV4ABDyCuc3QfJqdUcLc+Isnhjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJJ53zC5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJJ53zC5"
Message-ID: <7f3b8c61-3266-4bba-b866-c3e5623b3893@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706891488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwKDah+9JROKYiTvmPGJVpBw/xhrL3KACrk4d9rdK6w=;
	b=SJJ53zC5KNtHW4DTTROBmgMGudmS6iaqT+cuLlcOO/V+WkJfQBjWO3IDlKhWLPQeJv2/mb
	kSiw5lJ0csIhIMeq1XOccyMmjqB5eXxuZ2TLZXdNeeGJgRoNRljKgrZEoqF06iyvwWDHzs
	sFR2kTEY68fDTW3q1e7lWtQbXR311lg=
Date: Sat, 3 Feb 2024 00:31:18 +0800
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
> diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
> new file mode 100644
> index 0000000000000..d959a4c6ba3d5
> --- /dev/null
> +++ b/drivers/video/screen_info_pci.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/pci.h>
> +#include <linux/screen_info.h>
> +
> +static struct pci_dev *__screen_info_pci_dev(struct resource *res)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!(res->flags & IORESOURCE_MEM))
> +		return NULL;
> +
> +	for_each_pci_dev(pdev) {
> +		const struct resource *r;
> +
> +		if ((pdev->class >> 16) != PCI_BASE_CLASS_DISPLAY)
> +			continue;
> +
> +		r = pci_find_resource(pdev, res);
> +		if (r)
> +			return pdev;
> +	}
> +
> +	return NULL;
> +}


I recommend using the pci_get_base_class() or pci_get_class() helper function at here,
for example:


static struct pci_dev *__screen_info_pci_dev(struct resource *res)
{
	struct pci_dev *pdev;

	if (!(res->flags & IORESOURCE_MEM))
		return NULL;

	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
		if (pci_find_resource(pdev, res))
			return pdev;
	}

	return NULL;
}


