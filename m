Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55157E792
	for <linux-fbdev@vger.kernel.org>; Thu,  8 May 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718796; cv=none; b=cbZuCdPIeF8P564WbF7BhBhH+WNQHjmfOXfOMV48FDiXwG1Z2+b70VfuHAtcJSmlNUNleybFn0+nmDaxtr2d3T5L6ZSI/m+Hoamzq37CyChA5+UHqEMGL3sqkOmwmDh3WaFoF2fccMx2sK7q/Wixrcb0PMTbxTA3s1VvEId4rfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718796; c=relaxed/simple;
	bh=6YIkHDJ9Sqep2+qzwn2sPxx3nSNkJlHTq34EQoa8Nwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAL5euOQT3cUbXIqEdV8XNMcZZ7uCnpmrWTuprw/UdhUGbrN1DuPKdANmYUacteybKUKh/zcawXlHvxOYCfflVAOZRGA4zMxSTJ9a50foQEsM/vkHErIgZpMMMQNGzQ2EC/6cUFZvbQw1St8NwMdv3nfHUQruCQyLErc87NrfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=KH5ROYr2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="KH5ROYr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746718787; x=1747323587; i=deller@gmx.de;
	bh=t0mKtaRABkJFkFEP4micK+sIw3qNa892nnA2trSO9y8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KH5ROYr2KTf5cBWug66zlI7p4NCwpsQbbRezXF6hsAYPH0W0vu6gsnOztggnDbh5
	 lqBYK9I9CZC7kNpIT8SK8My7PyBl+jKgNPN9Mzxgqv+VZhdmAPzgDtI1k3wI93ii1
	 ruDsPTiMegjmBMoOzN3mAEREnd/EsfWL6FXPJYLjrCOaMNNj0qIQofIkvj7DR+XtD
	 SqU5TcFh8WxuNgyjnhIp0S0XE/4HkTw2+R3IQwdtNHx3fzTwktsV3eKKDiyNQMmAN
	 evDOtoI4r7KCdWdBl3TjqR8J92/5fQxkd526np2o7fsZUQU18+5jMCfqIaMVEk40Q
	 Y3dTDEyTcH5f8zpaOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1v1jEB23ib-00u5mN; Thu, 08
 May 2025 17:39:46 +0200
Message-ID: <1ba2cb59-289a-4494-ab64-e014637886ae@gmx.de>
Date: Thu, 8 May 2025 17:39:45 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernels >= 6.3 disable video output
To: Steven J Abner <pheonix.sja@att.net>
Cc: linux-fbdev@vger.kernel.org
References: <CS2XVS.S2O4K4ZU50ZS1.ref@att.net> <CS2XVS.S2O4K4ZU50ZS1@att.net>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CS2XVS.S2O4K4ZU50ZS1@att.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0oplIwpw2dYzXirYInUPND2pNvfXBZQ6NF1QM8bjhyb+M19iVhM
 xnSeO5liSDGu+syWE3hAtFdqN6rVjyNA0AjPSMRZguTAEDIpdCfdxhjePZGF0DHGGW3ccoe
 ysmk0aAPR35ijSYRpumNCACslSq70l0V22jKUQLbJ2reRata12ifdqFK3kK7/345B6pHBzN
 L5lB2f11jw6Xt39fOc05g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6iG6z6PZ8Gg=;MDcSu6kknWfzHPm0pOvjZVJM8ys
 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

On 5/8/25 02:31, Steven J Abner wrote:
>  > Kernels 6.2 and 6.3 are around 2 years old. Nobody will invest time t=
here.
>=20
> Sorry I guess I phased incorrectly. 6.2.16 is the last working kernel. I=
t's mentioned because 6.3 is breaking code. This applies to all code after=
 and including 6.3. My current build or home OS is 6.1.137 since it's long=
 term and working. Orginal build was 6.13.4, Failed kernel from both build=
 and Mainline of a Debian/Ubuntu based OS distribution of 6.8. Failed buil=
d of 6.6.89. Kernels I know to work are 5.4 thru 6.2.16. Kinda did a bsear=
ch type build to zero in on breaking kernel. It was the place I know factu=
ally that needs code regressed to fix all kernels >=3D 6.3. It could be fb=
 related, I forget my test results based off of original 6.13.4. If I reca=
ll, both with and without firmware produced igpu shut off, yet kernel will=
 run to full console use. Don't quote me on that :)

Ok. We somehow need some more info which card you are using.
Maybe the syslog / bootlog shows more info, e.g. one from a working boot, =
and one from where the screen stayed blank.
Any chance you get the machine booted "blindly" where the bootlog is store=
d, then
ssh into that box and get the bootlog and post it here?

Helge
