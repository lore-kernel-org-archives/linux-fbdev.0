Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF52FE585
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Dec 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581135; cv=none; b=VljKsQWNELGXc6N3zUPQ1FPwhPiAAr2C/EorOfSNfUVMhJkToAi7hqCvRWAEGarAElxeYb3TYvHZJwSCMfhjYbmbEUMVGPgc7j165Gptxzef5rPyDP+GANC9yuR07giG2aczIVFM6HaTa7+81Wk32Ijl41a0dwIoGEpHMkpsG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581135; c=relaxed/simple;
	bh=ydTOmHPWY7Ybqezzk4k+0xHYKdDfJw0xqGof99RGWG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gYI8BfvGm84wsukFKFRxkbAZIpJVHCVH/dBtzt6eT8yla3DDjVTVAl52R+E8TvNSiNDNQ8vlJHs7YOu65iuL0QfJ1m5uvBAqn6MHkYZmzGT45VJrx8+Ux/ua8GNGjc6+WBqJ8+XZrQH0Rd9BiAkDCoRo8OGJ7//Au+wNzgYmjU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wIoSGk7I; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wIoSGk7I"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=70DyG3siVbXyJAmKkksFDasRdSXuYweryE3rvQYDiDw=;
	b=wIoSGk7I6j1eQMnEVlC2nFVDyEs/XaVDcO8SjWPUSfDJiNHZehJVGeVVMQ7rHtIxKrFZhGlas
	mPE1l2qF2FgE6iKIP6thTmWVksBXy71NvI3vCQLx+vR7XnOWDpA8AtOlWes0IGMoDdylv/y1gqr
	N9jc8tJ4qaFdlFoNedRhHmQ=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dKdk74bpNzmV73;
	Mon,  1 Dec 2025 17:23:27 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id B8BC51800CE;
	Mon,  1 Dec 2025 17:25:18 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Dec
 2025 17:25:18 +0800
Message-ID: <224e4e5b-14ae-411c-ad6c-f73c3b946ff8@huawei.com>
Date: Mon, 1 Dec 2025 17:25:17 +0800
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
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <148a116a-b893-4e91-8573-1eebc2bb5c0e@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemh100007.china.huawei.com (7.202.181.92)

Hi,

On 11/15/2025 3:21 AM, Helge Deller wrote:
> 
> That patch does not apply to git head.
> Can you try to reproduce with git head?
> 

fbdev has already been refactored by commit eabb03293087 ("fbdev: 
Refactoring the fbcon packed pixel drawing routines") on v6.15-rc1, so 
this issue no longer exists in the mainline version. Similar question 
has occurred in the past:

https://syzkaller.appspot.com/bug?extid=66bde8e1e4161d4b2cca

After the refactoring patch was merged, this issue did not reappear, but 
it still exists in the stable version.

BR,
Guber
