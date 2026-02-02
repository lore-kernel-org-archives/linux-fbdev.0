Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6AB10F1;
	Mon,  2 Feb 2026 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037911; cv=none; b=Q5AZmiqtF8ocPXUFvs5vMtN/EN1rN55ctBGAGiThmuhUssYOnOjACJ/HBZxS8v4/WysPjRqK4AuBUYg6/xk8IBLkp5nlPB3J/7KciKeGfck4pULDuif8PFu0SvDIHHrvjk8NLXP6oeLTMUhl54RRGoSyxFYhj0SQWvutawTJaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037911; c=relaxed/simple;
	bh=NXNGVNeaQW2R9iV8yw1vl2YmrfhaAxYLr0oO9y1gOjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8EOfUSANg9kJGfS9TL5Gjszl8vZAVb+mXeW2zc63eMGzXittb8ecRg1TFpi4Xbgac2S95HFkxYc+PfQVgxPzo9l2z+02pzX5zihZwUf7Dg29CEIW4vRVrVtODzPwEyJxVn30bCwVMpcXQDwKNK/vKbslXsrSrW2OdGtbes7DQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=pgRdSCvb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="pgRdSCvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770037891; x=1770642691; i=deller@gmx.de;
	bh=NXNGVNeaQW2R9iV8yw1vl2YmrfhaAxYLr0oO9y1gOjw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pgRdSCvbK5KyY2c327VIPAq6tnujy0a9Qz3lLtM/aCXEnq4Rk3TUG4Tn4BjtazAd
	 s6sFaeLink7UE3AhuskZ/rHME+3O/E/M1MIhOmMti/L1OZSwknhHIa04R9TbS+mnY
	 1rG2JR6S4H7Paoh0/6ifLuJvCt3Bg5dy4E4TzZbEm/IwMBNCzbkf5Ga4NW+xotjnT
	 kyhJaz81hR4HqRWSYepV8xPRjZAX8Xi0ccraUacNbMFoC8mbdBLVunTwiJTZacDy0
	 ElMnnRQZz4OyfzYOmgvuMbe6v7mS8KKSnmXkL5Ub0WbAnZxTq1yHe0mvRjBBRlq4V
	 /ZqFAoxD+VuyWL8QkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79u8-1vlizG3HS8-015Uox; Mon, 02
 Feb 2026 14:11:30 +0100
Message-ID: <9de86cc9-a72a-4f84-9cc6-127fc0dbe006@gmx.de>
Date: Mon, 2 Feb 2026 14:11:28 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: fbtft: fix dev_info() device arguments
To: Arnd Bergmann <arnd@arndb.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Noralf Tronnes <notro@tronnes.org>, Chintan Patel <chintanlike@gmail.com>
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Matthew Wilcox <willy@infradead.org>, Jianglei Nie
 <niejianglei2021@163.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260202095743.1309162-1-arnd@kernel.org>
 <6580aa60-5f9d-49c7-8482-83bed12dfb0c@suse.de>
 <3384db41-0ddb-4c00-9af1-f194ec5dccc4@app.fastmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <3384db41-0ddb-4c00-9af1-f194ec5dccc4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lGRH+XTnruJqSGJPZa5rcBjADxslExrtZH4P75SjFTEP5LC4wrT
 yqoKIbEgnIcohq6x037zpRq2jp2ocoSJEB0Z+q8EqvpXknZatSFaqQ8c4YlQcP4WBr1kClr
 Ms8kL0YynQdPyFoAkWmb/pajd8N1XQChH2wlDdNurYlsSGYAuETayV7KwViWpilPkyJ7Nh2
 PPGeuhRG9+w8WLxTpkEiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5QtoIJATUiw=;iTRABtI1cLxuDBRI6/h3KrTF6eP
 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
 cLKWV62qdL9nwlQFaGowVxFKL4hgJ

On 2/2/26 13:12, Arnd Bergmann wrote:
> On Mon, Feb 2, 2026, at 12:32, Thomas Zimmermann wrote:
>> Hi,
>>
>> there's already
>>
>> https://patchwork.freedesktop.org/series/160468/
>>
>> which no one picked up yet. This needs to go into the fbdev tree, but I
>> can also take into drm-misc-fixes.
>=20
> Ok, that looks fine as well. The output is of course
> different, but I don't think that matters either way.

I picked it up into fbdev now.
There might have been some conflicts with staging tree, which I haven't
done so earlier. Let's see...

Helge
