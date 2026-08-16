Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440F3A4F3B;
	Sun, 16 Aug 2026 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786891122; cv=none; b=jLtqBUPLGNTb6xUHQgSWtTf4lbUM83M1NJIRyCi9Ea5rGaSS1ac8u1UHBIqTL4yH7v5C7tczsMoi2aaBmnC81fxQmTUDLGubD4TDzlC12SLv2PN+XINq4OpY5Z2OSmT8gyp2ynkICjzla+f7f507rY84WaPkviCRpr8MaRy0QQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786891122; c=relaxed/simple;
	bh=bSYKv5+BrhmcQHGhorru5Qi26kJuzg4+U68s2lYhVXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swHAGLTgN6fIW3hsr4AZ1d9Wn2MC+xVQxKEaaq07e5+G6Fy6GMFzSxngQcv7b2e3wWn5QgIHrIU1GZu5Uj0/GfvCyWtRSboEJW+OQNImZj4bpqf1V9o77OtzXqLIs9EOH11wF+b2ri66D3iYc6CBOlZm0qLCJyrgksuSfOr4VEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=cwP3Mtjj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="cwP3Mtjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786891116; x=1787495916; i=deller@gmx.de;
	bh=0M9CyY1Dhb7QRvnNUCMdra4kz62/27G3eJekvgcDarw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cwP3MtjjtWYrC9OUZw1vk+5N3bXVc+zldlPoeJKNu27UPnOccdm8HcGCzYsdN5Kf
	 mNrmbk/L7YqZt/JJKcQKaoNRVm5Jr+XNuHnQwm5Ns/uINE0zAc2gBlbISbdG4jHaz
	 WBviSAb7Hizb5pvYCBRoZeS3nIKtN0w7IY/we+n+odjapnWejE0vpYEbTnDjdFeKo
	 IImO57+lYTLbcNW+4Bp8H3lnodN4xVodoEEN8u4vmMBpZfHtx4d+v+pcfTSGZLRnQ
	 4rrM39+BqBYPO8bH73OUqY+mcaLNZpwF1/BHK4tsVel1jBTb8wpEtSpGvJ7Rg9qWC
	 y4EV5HR9D+5AsEEmoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1x3KAy1FSW-001ySA; Sun, 16
 Aug 2026 16:38:36 +0200
Message-ID: <3d215ce1-6298-491e-81ef-b19bed7f1d9a@gmx.de>
Date: Sun, 16 Aug 2026 16:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fbdev: Give atafb proper parent
To: Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
 geert@linux-m68k.org
Cc: Miro Kropacek <miro.kropacek@gmail.com>, linux-fbdev@vger.kernel.org
References: <20260816073752.16656-1-schmitzmic@gmail.com>
 <20260816073752.16656-3-schmitzmic@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260816073752.16656-3-schmitzmic@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jqFYABAayl3IDwn1+kgvdWwicfa8am6km67VWXSB25x81YZedlO
 Jb3LIxAgkLXjTfFM93JMhkSajE3RPku//2tFi1is6kcKhLImhpTqZCXzRImbwnzlhtaWBbd
 nxktV+bd8Y6eCDLLWOX4eAt0WXlQjO9f8oeEjqTw33XlOJj/Jp0X/S8O3AXpJwA4RLA1nvM
 DMIFgd8magZBFGAemz1QQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+g3GBdHgRjc=;XTV1u1KsBok44pJ5An7QYs+P7Mz
 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

On 8/16/26 09:37, Michael Schmitz wrote:
> From: Miro Kropacek <miro.kropacek@gmail.com>
>=20
> The atafb fb device registers no parent, causing a missing symlink
> (/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
> symlink when scanning for devices, so add a parent node for atafb.
>=20
> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Cc: <linux-fbdev@vger.kernel.org>
> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html

Did anything on the fbdev patches (#2-#4) changed between v1 and v2?

Helge
  =20

