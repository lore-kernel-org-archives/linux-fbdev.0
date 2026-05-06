Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4239B974;
	Wed,  6 May 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063814; cv=none; b=Z6VruoZjwVXyJVPx4GV70N8VbtDggdzKwoH6nQQUVqiFAhyH8cNmMyAGPn9Sb+W5MWYx4EcORgHQkFvKyW4WoxLiOKilNpF00ldq0bU04lfwTcLPX9L7zTW9KA+nHwfNbk6MPdfyVX+GWvZp4F2V8ThbX/u/TdjIY4we7NuLt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063814; c=relaxed/simple;
	bh=85jm+PYgnumy8j2HIghlncsKAzQWFu46X6bs7TQ0zFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwKtbMaIIY3YEVpLG/+vaObDiXviPYP8Cgn+btFMSbKAsrdQylhiU2vkf50r+sZ/pvYOlnd7RfWZ4uM+T3/46FYTAYuhJdYDFXhO/RUZ2Zvpu9/6MKaZaIH+Fk+YK0fG4Fqt7TNLj7HJyOyFMgHf1fZMrcq+kS87FIwG19/CF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=KDjMeNTx; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="KDjMeNTx"
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:d788:0:640:6e4d:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id EEBC4822FA;
	Wed, 06 May 2026 13:36:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp) with ESMTPSA id iaeFkxCTuuQ0-Ewmm3Lxf;
	Wed, 06 May 2026 13:36:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1778063808;
	bh=f/4pXRbWa3C6gp/L9bI4BhgpHXs3g2EoNlLrOnC+FXg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=KDjMeNTxKOfiIx/mM/J7901LC6W4jvIbfK8NRMqb2YjoXizzVsP6aIIlNiNWKOVlE
	 R7Ur9080hCQFQ056O59nhhWmYP7Dl7SFFqg9mAiOF3u1wEDhPL2TDgxiOmE9SmFtLP
	 Dealahe4O6tIAj/iLdSqux+m8xHVxfMzS9/tVejA=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
Message-ID: <5113f014-f0fb-406a-9b3c-725acff62c9f@sezginduran.net>
Date: Wed, 6 May 2026 13:36:43 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: add const to g_fbmode array
Content-Language: tr
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260506035641.5060-1-chaitanya.msabnis@gmail.com>
 <fcfbdb1a-188a-4ab1-b7cc-b2c430d2cca4@sezginduran.net>
 <CABjkosGtM-bju-gn9QtBfOMKMUsoYFb22noWjELnNi6B_ZBQ3Q@mail.gmail.com>
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
In-Reply-To: <CABjkosGtM-bju-gn9QtBfOMKMUsoYFb22noWjELnNi6B_ZBQ3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/26 10:14 AM, Chaitanya Sabnis wrote:
> On Wed, May 6, 2026 at 11:57 AM Ahmet Sezgin Duran ahmet@sezginduran.net wrote:
> 
> Did you compile these changes?
> 
> Yes, I have verified the changes by compiling the driver with: make
> M=drivers/staging/sm750fb/
> 
> The build completed successfully without errors.
> 
> Regards,
> Chaitanya

Are you sure that you had enabled the module? When I apply and try to 
compile your patch, I get these errors:

 >
 >   CC [M]  drivers/staging/sm750fb/sm750.o
 > drivers/staging/sm750fb/sm750.c: In function ‘lynxfb_set_fbinfo’:
 > drivers/staging/sm750fb/sm750.c:785:33: error: assignment of 
read-only location ‘g_fbmode[index]’
 >   785 |                 g_fbmode[index] = g_def_fbmode;
 >       |                                 ^
 > drivers/staging/sm750fb/sm750.c:787:41: error: assignment of 
read-only location ‘g_fbmode[index]’
 >   787 |                         g_fbmode[index] = g_fbmode[0];
 >       |                                         ^
 > drivers/staging/sm750fb/sm750.c: In function ‘sm750fb_setup’:
 > drivers/staging/sm750fb/sm750.c:896:45: error: assignment of 
read-only location ‘g_fbmode[0]’
 >   896 |                                 g_fbmode[0] = opt;
 >       |                                             ^
 > drivers/staging/sm750fb/sm750.c:900:45: error: assignment of 
read-only location ‘g_fbmode[1]’
 >   900 |                                 g_fbmode[1] = opt;
 >       |                                             ^

Regards,
Ahmet Sezgin Duran
