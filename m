Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4B134AB
	for <linux-fbdev@vger.kernel.org>; Fri,  5 Sep 2025 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757034053; cv=none; b=AyTsEACTd3IBVl/vdEatDsiCcJeg+6TDueHaZ+gauX/Ax/E1QRIgiXiQrN4wlt5199SV5bnytvnp/kY7ODdapWLkKyJRYk8ZrP3KEFKabYyYX9x5nvV8ltVYFZjp19JomDcbuQOpxTKBRIz4TXUMn2OLM1BuYZ2fxP5An0YijRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757034053; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PE5dEU4rLiSviRgOFyQMTIcK2efezP+xTRYsRt3pmPOI1UWIk9yG1Hr9rx28JfnIuTMB8vejRYxSTmq+s0kMua84L3c4wPinPqyBSOm1NkfCZD0+gx2/5QSH3GV6xmSkDJjUb1w9Z1NX+6nlyxgHwD5CgF9Q7IcJfFJXqM2lKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cHyb001C2zQk6r
	for <linux-fbdev@vger.kernel.org>; Fri,  5 Sep 2025 08:56:11 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B4B5180B66
	for <linux-fbdev@vger.kernel.org>; Fri,  5 Sep 2025 09:00:48 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 09:00:48 +0800
Message-ID: <2871a168-1028-4935-9f7c-c20a8818dad0@huawei.com>
Date: Fri, 5 Sep 2025 09:00:47 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <linux-fbdev@vger.kernel.org>
From: Zizhi Wo <wozizhi@huawei.com>
Subject: subscribe
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100017.china.huawei.com (7.202.181.16)

