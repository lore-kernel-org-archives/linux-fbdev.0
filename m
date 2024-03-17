Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97FA1EB2D
	for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703290; cv=none; b=ZyVkwA6eIE5GVAeT8NXkEia1DVAudi1FLQn6fXdsehc4H3sRV2iDr8Shga45G4NzufIRvtrfr9/OjINozJMfKfBQyDxTMycBOT4DwLs1lrZjVQkY324dHTK5Gss40CFIVmNpFj6ehV9SVVV1iD4IuwdNTB6h8wCqi2/+P4+F0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703290; c=relaxed/simple;
	bh=qFISJhYK3/f7Mm/FeYSTbm6L0VGKPq6fbfJmjNTOmmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7PKPa6yMcNHzG0GzT8HAiYeYIHkz0JkyLHg+8NMlhkXQP4n90HY2CnHoLop2Bh/IPsxEEP7d+yO38LTqVFq+SyXHjeIj2Gvo1TNcabTT13m3jzXy95lLIkNSgKLStfSFLsifMiRSfFBTh041UuTqmnllbkoG53EQ2WCk/7hYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org; spf=pass smtp.mailfrom=tronnes.org; dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b=bJ1KRpox; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tronnes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tronnes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="bJ1KRpox"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
	; s=ds202312; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oCAlG+NauGSjJyPDaULovlfJyBBFh1H+GxIHtBEWSk8=; b=bJ1KRpoxPHO9Fl7hh5XLacnps4
	BXxHJX3GUvX03NqjMabSdptaSUqcyZ76HqlwgiQz+Db1kOUsf9VaX9XGDWDtseNi7ZM8VblboaQjR
	dUIBHFNcwK1Viti1TkeJ/leo9B1pdkZLw0uqc0P5O96AYmZ7j1kUSYoGPyTkScLiDLIXSNiwv7Gg9
	VAXmhMExhrpyMgLsgdvRu5LuBEqvyPA0JSzlR1dKnoqSRwfyhch9AS+Gi0gOHEL+YGbm1qK6HqZru
	4rZm9CyW+6yViQ/zfupc2uBK91GdHAijFugS9YD1NuzfJWKex1uBaStefc+iVrgAdu+vn1nBVJO9h
	zXyS6oLg==;
Received: from [2a01:799:950:4300:268a:bbd3:738c:c4c6] (port=39794)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <noralf@tronnes.org>)
	id 1rlw4O-00HYIi-J3;
	Sun, 17 Mar 2024 20:21:20 +0100
Message-ID: <836275ee-b8dc-4e73-b4c0-defe64e9f69a@tronnes.org>
Date: Sun, 17 Mar 2024 20:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/43] drm/gud: Use fbdev-shmem
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 noralf@tronnes.org
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-11-tzimmermann@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
In-Reply-To: <20240312154834.26178-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/12/24 16:45, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
