Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E83DA7F3;
	Tue, 19 May 2026 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176271; cv=none; b=NmmtMLEcY0+Ug7a4dGIqW2baiXMVuZ/EB0Tkau5hJWnZsIBHNSmzW5iHbVVRH7DnFe7Ah1tSArjkBMkU7xKdcA/C4B9xKBCedITg0B3ewGTkuBTGQVo6/sfCVJpZYCEyO0nweJeQ9mMQ9P5bvYe1coZKxY/wgQ+kWPpMUY1GY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176271; c=relaxed/simple;
	bh=So2HpGEP92YgdtZ7YgLbfRqyvJNXdK96Gxaz3PxdBYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3KNSDKtbKhD/XPkTP1Xe7zJ5Vl+qbiuNuJWqme9+ZhiesCb16jT+KcYQA2FUO505SXEVSQJH3a8F5Ym69ylB4kRMD73hxP0mjpyo2fiN15hIPK6mbUqgdchMWf8NkvfHr+UdROkO3aHWi3OhewJCGV67RHWDMkAQc644O9pn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=MCb8NscB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="MCb8NscB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779176221; x=1779781021; i=deller@gmx.de;
	bh=f8NhlNPDLIuqPmfv2I5UmHdnQ9SKvpexMqQF0e/GDh8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MCb8NscBzFnSgQ/8KbmXuwrGa6oZk8NbsnhAU/It0iejrGUf0QaDNLXEjbl1feF7
	 UpXYaGYsAP3ME0UQnudSUYt7BymMB9mPTa1JmH5Gmj9sPMsGmYQagtJCgC75KJ1li
	 4LIiikqalmvOIUcuc6YZH1g+ErFdrzMksyJkIVqgW5zRiGR7CYGztt4Is6TqXugS0
	 +YtLm/r0nz3+hdS83CbNY0Cz4SHewjjJdF6w1bz+JeurNmlcK3pqOmfC4lhksQ9mu
	 UrNNfL++AgliY5tUfd7btF5iDFjfqiJoSdV3x7s2c3Z/hXM52Bm7/YPhWDUMvKrdz
	 FSYIqHXoQqcGOZaZuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1xGW5h3SID-00xWZ2; Tue, 19
 May 2026 09:28:48 +0200
Message-ID: <91d315bf-ed9b-48d2-aa4e-59e3e61b343f@gmx.de>
Date: Tue, 19 May 2026 09:28:48 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fbdev: Use named initializers for struct i2c_device_id
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260518160808.802423-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260518160808.802423-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:txY7cD5l4wBbsbPltYJ/slzOhGdFmWkc21Yfwad306GRsqXG1bL
 yMfpj6CwJEI5eliZHJWFDPSnC49WqrLXpldFUD61GHb6dvO13mq2HpMXbMnaBcrM99ihPid
 M7hr57BzQvMkCNN1SbOrV55sjqpa3G6aUy5HljtvlPOlmux0h5p7w/jabIB9I5vU0Kd81PP
 noFJksxoSQgw/BOWHHWNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n5B5meIk7go=;KCxAsdrzJ0DuQsGsmthXuJttLjy
 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

On 5/18/26 18:08, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
..
>   drivers/video/fbdev/matrox/matroxfb_maven.c | 2 +-
>   drivers/video/fbdev/ssd1307fb.c             | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)

applied to fbdev git tree.

Thanks!
Helge
