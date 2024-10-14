Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A381D0F46;
	Mon, 14 Oct 2024 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937976; cv=none; b=MBpwQw0MvTbPBBfTrepC8MzOnvL3rnas9Ojp4Q33BIw7B3NzlCbgIkvpoSsHRjg3VuYAsQv3qdY4B1xpefT7++ZfrSAgUtMAy21sccr+oXaRI/qok6JK2662uZgZ0Ba2SQUWvmAEnbBjyVxexB4Luy+uZlh55e/MLdBiTlQuxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937976; c=relaxed/simple;
	bh=hTUJoPrnkbQXJg5xgopHbrh5CvOJ9FXkwrT5Y7U4tiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKRJhtpWSsNyD9lvU4Rf7jzBk8ffWbjr2k6nIPvoTRcEyi1Ff1kdmE5kudz1AW5JzedXupXBp7Xz20XG4wLfnnxjUeyNkJhIAS68deC8tjg6tbMRxgAVoBEgrxcULtz/KzyhzMuICpGhRz2ATucCpPSY/6H9S59epGwnY7nMZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=FMRJYNmU; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="FMRJYNmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728937971; x=1729542771; i=deller@gmx.de;
	bh=8iK/lwusazoVmWDx14MxRKCz0zzqnH40q8KQDzTJg8k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FMRJYNmUocN9W73nV68292yKAgVCKbKaLDgiFUuhQGGHfZu5DqFfj8CUReQ4KVn1
	 gCWOJCPLDEPPOwHnn4Xn8Y9jXm5G2IKtpBKGufny8Wz8YsDNFX8hJsQGqqFsMmptB
	 TTNwEhVWujkiFf8KTbl2rIjUtU0AUWNdAS7y8196UqObatEoppWk+X55rnrmv+9GR
	 X/uyIVQnl8nSSQNRoi/X70KZulbiMmd5k+qMtEiL47uLsztzgPAcmcwAw4gkm0AQL
	 YHWzcTgyqtv6XOeTCRFHRd156hzemMhmege//01QlK139Q/uO95HGBV27eaiOx0rd
	 3Fx2P9QsWl6M3jVYVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1tUI7g1XCJ-00QS0r; Mon, 14
 Oct 2024 22:32:51 +0200
Message-ID: <fab752c8-0193-4d97-bbe5-40c426ede668@gmx.de>
Date: Mon, 14 Oct 2024 22:32:50 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fix inconsistent indentation warning
To: SurajSonawane2415 <surajsonawane0215@gmail.com>, adaplas@gmail.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241006071514.5577-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241006071514.5577-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mNj/a86cD8apEWRxcMjWatukRifswok09XShWf9Q7PfLVTiUZ2G
 5bV5pTEgV7HclerciNJVDVklKnQKE6J/4jqeNQsA8wOv0190uLu1EJXDUeXPh+IjBO+XRNd
 KQt6Wz5Q1O3O9qNIIKpjwHxhflpNkta8AD7YxyF0zroGSPODBeH3dhdMYMowW1xeOTcElJ5
 4WcvEM25c/vzdPoZpKN8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b10LvR2bUhM=;WWcraPVa2+BsBoEoSmo41Xm5IrS
 8adCG3MGy7L6SMxBm+O6ZdkzLmVilMeaSqBuZPKS6P8VuO77+t583qFN0hzthHWUNW4K6wvde
 b5H501/jxd2kPACCQNj+3JNblAmqqwgFwNGzDav8Zn9wW5CJQXpKKeiIXV++Nb2xtjJ2tr+Os
 +S5xf5OKF3gnwxJVl4DS4t5l3W96HuKmo5M8Udsn9LwQfzJwai+SwVnAyTu8tzCLnZZcws4x5
 BhJeRL2lV6S7nwgBqSiGiyVk4CTV0LlGw11adQbUkqBS03vxFpPHfzCYcoJmcNd0KvlzPeKNj
 7F1P7cYXrx35LupGgW2RK4nXk0BFkK9uz0yRGv14Prq1fTpi8iuUkMu3nbCU8fVh9gkHGj/WY
 3Qklz5yP54lzxSwlWNTZU7gDbIhT8zgHraGXqt9rG9gOpMJV7zsDWWH5xtl446ha9w5QkqV6s
 auhEdBklaeT2N/EQMwyNX7PmRGiLBytKjiUI1OnICxexXPt2WUV0fQeRSBrxUNgWJb93YZUal
 EFjIu0R3GSlfAoeqqjJCh6FPb09OwSam+kc/U+WQHxJ5/RrvtLKg1WzJ4q5Gvb6owc4KwOHxd
 mgvALqcYCObsnTZarGfJK4SPo5Gtx+KTBXzK2VkwICKCXUzv/lwnuI2fHi3KnCqdw+yWHZ8RS
 gNN+j5IWUcXPH4sfLDYb35+LHVNjoqufQCjUcJahyOww61xTg5zPzDFwDQMy+hCRqWjCjhh6b
 5u9l2rb+sDZ+M+ohxfLKvvZVx8ka+7MVN0BxVfLsydB6UPEFKctXCbIj3KobjBX+F77VSiTIy
 i3aO7WJPkI2Wp5hTMeaBnkfA==

On 10/6/24 09:15, SurajSonawane2415 wrote:
> Fix the indentation to ensure consistent code style and improve
> readability, and to fix this warning:
> drivers/video/fbdev/nvidia/nv_hw.c:1512 NVLoadStateExt() warn:
> inconsistent indenting
>
> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
> ---
>   drivers/video/fbdev/nvidia/nv_hw.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

applied.

Thanks!
Helge

