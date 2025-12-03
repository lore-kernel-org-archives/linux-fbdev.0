Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E641C8604
	for <linux-fbdev@vger.kernel.org>; Wed,  3 Dec 2025 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764727892; cv=none; b=r9yvKmuy0jwQrSdDwpabyJUNbu7TRGDCH7LrFc9jWIyfs111cwMUAVSPvgnzRIVQRZU2z64zIggX8FBI85krh6LynnXT5xo53jwC+Omc6XFrU3C7r41FT5rWl6N+KpJ0vzYsL+P44eABGkBRYN1RJC9zEy2l96lesJ8Sk0poCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764727892; c=relaxed/simple;
	bh=hP7ewT0cxn10SZjKXPXLB1BuJyzmF3bYd3KpswRtHwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=slJb/K9qPyF9y/N3fRUVZ+10lZC2fLT9DixcO4ZDv9Q6v4K6xqjtxB+CW5DLLJrfTfR2cPY2+G3E25FLnisCEqOAPGa9zv2XPcos6DgRU9bdowaTGjkYdms8fihfm+8IZWYQveXc00ofiLRInKR4/IYWJi3oWtwhlLYiF4ESWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EvNxGn0K; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EvNxGn0K"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RHymky0mCi8FdyJM1fdcwkFMhzCbYMUp4/7yC5JYEvg=;
	b=EvNxGn0KQfT20Ph11XdB6jlYZ2H827zT/t/LWyTApz0CQaXrCLE+JjhOF6ZK0gC44RoP6c0lX
	Lf9ZMQiOdEu6cfn6absIZlH7II8HzWvtqQODlMeuYqpLIxeLvWcoSocyAtgsytpwKIuvSQPLJeY
	3vx3xiVnwpwrCN8bwsUPres=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dLh0S2Kstz1T4Hn;
	Wed,  3 Dec 2025 10:09:28 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A3A8180B49;
	Wed,  3 Dec 2025 10:11:20 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Dec
 2025 10:11:19 +0800
Message-ID: <dcea10d8-880f-44d7-ba45-78a89133a824@huawei.com>
Date: Wed, 3 Dec 2025 10:11:19 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] fbdev: Fix out-of-bounds issue in sys_fillrect()
To: Helge Deller <deller@gmx.de>
CC: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Lu
 Jialin <lujialin4@huawei.com>
References: <20251112073207.1731125-1-gubowen5@huawei.com>
 <148a116a-b893-4e91-8573-1eebc2bb5c0e@gmx.de>
 <224e4e5b-14ae-411c-ad6c-f73c3b946ff8@huawei.com>
 <aef7d5fd-2926-4c58-b720-4af58aa380d3@gmx.de>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <aef7d5fd-2926-4c58-b720-4af58aa380d3@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemh100007.china.huawei.com (7.202.181.92)


On 12/3/2025 4:05 AM, Helge Deller wrote:
> Backporting commit eabb03293087 to 6.6 seems unrealistic.
> So, maybe adding your patch to stable might make sense.
> 
> +    if (dst_offset < 0 || dst_offset >= p->fix.smem_len) {
> +        pr_err("dst offset out of bound: dst_offset(%ld)", dst_offset);
> +        return;
> 
> I don't like the pr_err() in here. I do understand that you want to print
> that something wrong happened, but we are inside the console printing code.
> I think we should just return in this case.
> 

Oh, you are right, I should not add pr_err() in here. Maybe we can use 
pr_info_once() instead if you don't mind.
I will send a new patch until I receive your feedback. Thanks!

BR,
Guber
