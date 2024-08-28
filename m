Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC61AAE05;
	Wed, 28 Aug 2024 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868126; cv=none; b=tDHlDvveAd/e7p0KzBgKAfwHgBqwdRs9HPOFDqfZf3lszbbXPwxXx+Q5nxET0Y4/BiN+Wczw//zH71SeQu7HeXnbHd2meNRm/eTDrLqH2vjJenR3/4N9IpE8F1R8fzXkNKHb5ZxYOxLBEruja/sQh4+GcSu9Zz/ZbHVi/vnrFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868126; c=relaxed/simple;
	bh=QuePnwgrberchF5b8A7Qd8TRUahxmlriVLDISllrQsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvjpsfsIVFtyN1n/tgv1EIcJ2tkkGxfw1LxZF2VwOqT4qWnAFnC7GqKxHCmUr9gRE5Y7orRIBQgzl98qhVLNsNJgQL+f73b1XIQid7JkBb0f5luXpcY/VlHmRGNPLGBWgWTxNEOZwyl9kvwWdjPk/fjz9Lf6ECFB3BTcvk/rY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=BBJj8YXt; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="BBJj8YXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724868113; x=1725472913; i=deller@gmx.de;
	bh=3WKzp3jxj4oL7NnhGmEuHNfXJaFVqo6E2pumyZ0MNik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BBJj8YXtD0kyfN1lrYv3y3Q5/reUpFdAWIZz+7pvFh+ZiP6NIzW05y0PN3OSb3Y/
	 kGiZnEfysMyMpuBOulF8QqNucZ4ZqUjAa48fb7XW7p3nITDWrGq+ntM+IzoRj8ZAM
	 uTFWxgfpcVPitpiyseUgYp+ILHRVLODDQt3iXJAOSCngUNu3EVaB5vJHrq+3Prk4w
	 9iQN+Vg2CYlZh7AUhVovFmyoCc1+8vii4T+lHcLriqEM2PKVm60DY3kq0290yFJaL
	 5R7y8r5JjALF0HlzK2cYMok0Z71/RhjVZQr2gBuUSA9bj5NgB5s6bt9xX+pkEbOZB
	 5Vq8QRUxD0Gtps7aEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.126]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1srJDe0k1j-00GTlI; Wed, 28
 Aug 2024 20:01:53 +0200
Message-ID: <17ecc1b1-4816-49bd-9a80-f5d4077ba145@gmx.de>
Date: Wed, 28 Aug 2024 20:01:51 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: mmp: Use devm_clk_get_enabled() helpers
To: ying zuxin <yingzuxin@vivo.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com, yang.yang@vivo.com
References: <20240823123027.5753-1-yingzuxin@vivo.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240823123027.5753-1-yingzuxin@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hfVl1ZH2+4oT9W6xsRe4S6mvf9I9IlMjXd5VHk41RTmEQYg9nKo
 riILnUmckgq4tWfEgJxiZSYj+ETu7PKF1Xf+KoG8TpniXYnaT8NylewGPBhhv/q4N7HCCQG
 8aeGB+mFSckzVqwEj5PYcrayGBQwJ8enS4qKnj+HW6AtMWQprj7XgVWkCenpLvxFluZC+1k
 kg832O+1Mu13D+PW4tpMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n8YDgf4NAJQ=;9qW72B6+FMY3lioOdPO75F15jOF
 R3WEVRdKe/LRTcVpym6Wum27Fu+kZjkzcn6yq/rXMw8pkG4VaPzm6UKnSgjxf41ERg5GFfg0u
 sPnduYLz5VNL9cSecGXYM1c3skJe9wpDMKR6W+ExQnv8JjMGSOkO7EN5svPP1FhoSHl8kcPN/
 krjy5HQShOzerULyik3/JLeWov91LhkQwyFdUknSGGsJ3e72V3/zKQfJ4xttw9PJr92vDxmOG
 eLwcORenTlLzk3CEN2+RFvmPFzZsy84iUpvzxXiT4FFppXYyiHx+7jg/+kJTvV0yCN7GiA2MN
 9QitV5/vwKfoWOwW2Dl8+Tb9s06rMN5H5KgYqG3SqakPM6L79920RB08v+8uOvMjkEvdHyIqO
 F4IK/HnFDJn+t1ulRkgjMefAMzXPMpXoAg8xEtOLMEVBm8/+P4QMd3KH4j4rHzwVcT4eAK9Vj
 HiCE5WOGYBm70QqiQ7xVyKiEqle1G52iIDGKkwgJK2qZk+e4bmmuZqh15eBUCRFdtNImKZwVX
 VV3c/vsVOoC5jO5GfaXSYhBvNmwMFnPAhLMbF4gNDEuLsTzd+6zPr2zJhRzG7Oemo7f6/p53A
 ooABOwbywltMhUkShOGH0QJHOc5AZqSmXdvjH+eMzZJQPPuC6EsNVnoHwVupigedIAC3kQTmH
 b9KHhX8h2Q0Wt312FLLNtSAZWgN++kYUTT4ih/CXGULC9RXHyEDrY87wCN9IR85kekqoYdJoo
 4SUvCDSEkkUm3EJ1P+iff8lIBeAYacKPM6aEiWDSRXLw86A5mD6jgMu3eUsA0DQiMt+fTXRi1
 dCjFi+u+VVzPMsWyhq3IN20Q==

On 8/23/24 14:29, ying zuxin wrote:
> The devm_clk_get_enabled() helpers:
>      - call devm_clk_get()
>      - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
>
> This simplifies the code and avoids the calls to clk_disable_unprepare()=
.
>
> Signed-off-by: ying zuxin <yingzuxin@vivo.com>
> ---
>   drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

applied.

Thanks!
Helge

