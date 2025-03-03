Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B51F0E44;
	Mon,  3 Mar 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998221; cv=none; b=BOWZwKCW2x1NufVGcQ1q4D+SiNGXA9PxrGL+8EZUD/rngKMUrtmqUzYl64uuBGZFcCQqglRCsPNUynaROCmlbPi/kHiKXwnSoBfr91xDGQfu5WOc9PG5W/KuozQ/y3KGzQqugrShK8anKpcxZUjX37NLix6dV0nMqrL/OQ8695A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998221; c=relaxed/simple;
	bh=Gd1dlzOdtFDhJaQmIY23pfMlDTcKoNMpTpwfvcXDjhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0VDRw/gYgJqDq6BtHMb1Dxw9XaDgBddOszfmmmXofXkb6LvBsZnuQfqQPefHi8cTLx85XfLhzeUztW1m5pvIEQLa1KVzu0TVGNs+D85Pt5Pe/mJwgWbGbdn+tT9U4xykEO5E1QCdpz6OyNavcgO3fkuVUYe4bKJJj9D4EBU7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=syaRRWYg; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="syaRRWYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740998190; x=1741602990; i=markus.elfring@web.de;
	bh=3I1wcV88eyEZRxUAaJIlfqeblDAV/oemtgH82LOxxOs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=syaRRWYgiccYmjw9qtXIAxcZR+keMGcrCcJdHVt3VXZv09UXatyFGPrquv2NFk2k
	 8rkHgHgD2g7XPO0fprbnhkv5tiw9dbQ7kToh8TeUXF2qrzl0gPkszu7S1y9QYT0uJ
	 EdrUOqUsU3gcsYd0migjTQbC7m89boUFAQ3arY3U+U5KpxRsvuuWXw6Fqn+/vXIJA
	 /JB1W7WK4mstuz12wAav1C8lfgxLH90kLihkhaM9hRy3pxFLl9ufqxjItLQCiJ9e2
	 y1+sB5ANVpnTWI2WPIHiytD9OZD1+m6CkUMSnBiYSD9OnWFy50JqU5cd91m+dhzyx
	 NPWiJzd8UiFK0dXpCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1VL-1tH5qj13Ed-00i7EN; Mon, 03
 Mar 2025 11:36:30 +0100
Message-ID: <82bce096-271a-43a7-a2cf-95b48669ce3c@web.de>
Date: Mon, 3 Mar 2025 11:36:28 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: video: au1100fb: Move a variable assignment behind a null pointer
 check in au1100fb_setmode()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
 <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vdcLTwaxRRUTNKgdh3PAdhRaE7ojz7Hr9lnrj+MHgE+1lORdgI3
 LdUTlDAHkrkILlfVtj8Y+FWZ7efdKmsh7dpqRFXHOeHBR7Y2LJkXflzI4TeVUHOA+5S6WK7
 ducSX12HIESWGnfoCyf5qkT0mmHMrzlzrSiA2hi/nzhZG/O60wWcTcMWWLl8EQv29pU76Qj
 NN4uq50yUWCyJv4fhWAoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6QNZLrdoyzo=;Egynd8vm+A0h2t4Qd75YIb7BLKe
 VujM9TYK15+bBtsLBJI53tpI65Z4qlFAJE3j27GIjFsUKW3YLbe6Ml7tsNYhWq8ZZsczz9FB8
 GMgmVT7galXa2FAsES6Vm4e2mqhxh0T3k8okb1CE+oz0zcBelDXH4X9hHRPZ1WDYzTiQC+1/z
 7Z5yA++/5VTizt5XBCfRe/Rk8FeecqeV0tcUrfMcbedMFJKyTXkXRBUWvB8jl7wAhKuvOHv28
 wUjJ57e6/oJfNchJKaGwkHrqYalUgvcfgrUav1YLTB/ZErIiAu/InyQjaNaOhNf921AxS1wP5
 KMTvBhrB/jNUGhvB2Vu7g9T0Aa/LponvTTVJb/MjQslfUhKEtB22JiQuRW5QJNgsTqIt9TpGF
 voUzCyoJJ73UnuH0qQiyrQEvJeOt4D6ysgXc0D0T0ejvSXqaFQGThYmdqBzF08OkuAlgTE3FN
 QXyUsQDZYK+Ao9gsml6vzF04hcH9wcN07W8jvrRtE858AYpo9mLff3+MFwSWQZZjbw7IU2Ktq
 sGlcfJn+LLnNRNA6YGrs/gnE1mXZHia8aZKJIroUHOufq12kNdJJ1aOVn8xeE9EPa+2TM9jwF
 u+zQINKT/giAGzWtl9aUo1Y1Q7JiIOCG5IOMB3imAzbWn+uEvxyI/aTdCKRcVMjJ/Jpnb/i09
 ukl/8yYwNFnYUmFcYWwgxhnpdW2QIXRmXNs8gZAAKnZ7H6fhXsKb76SBsMtLek+gUQygi1FYl
 AwMiQuxAFmWA/BoG2wyx81eB2y2oqsRlGOsPB7eN+2/YA9P/XtvoRZHpfQzW9NaJHm2mMJr+E
 d0wLekUgx0m8tzDUOEhzK01OzEb0PpogQ4vbf8/zNshffO+iAHCCwe++RmaEr/NW6DoCJVGGZ
 AKHyuqFG7EsegodcRap+TSO5amIhA8eAvb3iyCEiCX4YEsB+UHKavrceeuvoR5n1yngXui2sV
 hTS4uTTfeGEdC0HARsj/h2tJn4PsmkEv8/pKaZ3SEjCLSNU/I7QnRbUHt++MIoCI94mmOVtEe
 wyLH6sQ8rowX/WWh7heBZrI8klsxOA6k2q+OavDc3UnIdAw9WV7Ob84tjlCdlljYGmNUs2QzN
 FaDVv/RLFHixOjpF72nSHnDzZubHXNSAdJE4rNufcPYv3x8d/W47Xs8T/4HEkG21KwW6dcw8O
 sQY4I8H8lyn+SDBhynfhsFODV7w3PYs8bRWeoBsy4Thg57EEIn1XW1DX9BVp9xzuvRQWr8et1
 gZnVkpmWZt2ChNp1QP5hzUUxp3w80ANE4R7MFUwdqzCcsIsrvT/qmZGAqhkujs3bjZTvU3fN1
 UphLrxY+3rSfMzlIUG7KBA0/qJk7CRVuCSSyYE9I1xX4TovyKtV6Eg0u7YzHHi7u1Cdzr0u2C
 VONrsep64vb7vqsMn4mZSn12IFGLP0O6anM3zoxd0XapdR8G+0iHCECWBHeAXsw1ODFMGcnro
 /v/p4Ag==

> 	struct fb_info *info =3D &fbdev->info;
>
> 	if (!fbdev)
> 		return -EINVAL;

Is such a null pointer check still relevant for the discussed function imp=
lementation?

Regards,
Markus
