Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038551DFF9
	for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703322; cv=none; b=RYEYZHRmF8O40DOeM47/ta88+VDeSPuY9ODYYr+OJkZu8AhX9VKkxc7+K9HCxUrntfdjBP0aZWSH80iYauIlvatQnymcS5NdMDt97UpWeCBTX/rHll5z/7r7p+goQXTQKN7XKNXeJ3s3qR9eFZt+7T7hXBwYcPLkOFpK0Cqepfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703322; c=relaxed/simple;
	bh=/w0sMOdosuJR8gBbyzS+UuCVLzXNMgDgWI4OsUspM/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWXY5BFkoCEOdgKIUdPsJymktwgyCFZGzPiLsp04avFHCyfYA455r9DGV2BSDABUoL31M4djDOpBuP4WDdPSWixvr8YvaxM71Ig+K1srQeKQtxbfj34wklFLAsyNvh5OKVPg9FQ8bf4thTyJ8m3TF/PAu8cbmBf42CMDH238yPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org; spf=pass smtp.mailfrom=tronnes.org; dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b=L/fuIYJO; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tronnes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="L/fuIYJO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
	; s=ds202312; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fPiuRQjfGwmzq6tQC0tmuWjBjyAWCeBiTs0Il+P+iZ4=; b=L/fuIYJOSeQTDWNVBCQstBLP0B
	A2ta4W8zyxmMsRZminzbqq6Os3rRv0LMDmNectq7tY/EX1kxpXUR862uefF+z/H4C3NY78N+PrFE+
	LbN9772ZwpAmPh6fKlodUpvoDLySU+DMqDdpoDW0dS7A3VHlbz9Jdi20TjuIaZIEHfjECZs7YrmW0
	+q58kLu1El5QSS4idmXBGv+V1WQHc5q2pzRC1JkJR4Sn7vfRGc/qw3HjRP2KdF1rxMR5Su0I1TUCW
	5vC+A+F6JooPf1HrDvRZa/LsRXvGll2pxgjXd/SAlRQACaTRZS/eKrsZv9zVGaW16i7jxT1pkPiZm
	fNqvFoQg==;
Received: from [2a01:799:950:4300:268a:bbd3:738c:c4c6] (port=39794)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <noralf@tronnes.org>)
	id 1rlw50-00HYIi-VN;
	Sun, 17 Mar 2024 20:21:58 +0100
Message-ID: <e279b999-8835-4ff3-806e-ec6a57f827ef@tronnes.org>
Date: Sun, 17 Mar 2024 20:21:58 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/43] drm/tiny/mi0283qt: Use fbdev-dma
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 noralf@tronnes.org
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-38-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
In-Reply-To: <20240312154834.26178-38-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/12/24 16:45, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by mi0283qt. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> ---
>  drivers/gpu/drm/tiny/mi0283qt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Noralf Trønnes <noralf@tronnes.org>
