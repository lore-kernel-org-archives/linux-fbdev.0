Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95B47CC8A;
	Wed, 23 Sep 2026 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157273; cv=none; b=euMfIlfx513gze8/Lgih7ZEld8TprtSpd0EgoiK6WpFS852Eq2BY6eaR6YrIirUN5HRtNXm93UvwmO9SONj+Sb80iB4K2NTv4E+PJc7p0CFUeqAoNcfw4XCCkQhXf8WeaZasJu4YoxrJzIvXfDk0OO2kumSta08/PHtA5B/+37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157273; c=relaxed/simple;
	bh=0YJmeCEZcPyWKHx1rFsYpNoHpdB0qdAQrtJlqxnBRi4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=evqdF8yQqOPW87EcvcQAm3/ByKOOtpzczPO3qOy6PkDNW0zWfEIMqCsex+9+/Fms/fdxOv5nWzBsmmDqt8GXyc6jmKNQ62ZiTvVlHQaTKDgbTVeTxrl5YMFARo8/BvJqA9HQzBmMYPkMcsEe40E35UhsPwuCe5b7XB0tQ0jLUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XvxsDhc6; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XvxsDhc6"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hqXPG62HMzMkr7;
	Wed, 23 Sep 2026 11:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790157266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNJQx7eG3HyvFQ0X0+FNFvV8AFm7jVjyATRQZ7QjHTw=;
	b=XvxsDhc6sDw6jWabjFnd7rqSASkwJCCSiyum0/HZmpONf/RR6qAw0RoMsDjXi++LHK59Tv
	9BpaDN5UqXUhgAF6ww8oO6sALQbqcjsH1xOCu/APUZpCtzpvmx9S6YLB28NUziOSEb6A6g
	2qw2Exsv9Q66x4Qtl18IxQ6kNp9/0QJztYuddLJZ6im/+9e2rfMgj4j3fWdyYLqYfMEnTS
	mVwgZ9L8vLDin/LbJ3YPyEXs6PPXLb15ll90PDhe2qwd9cdnRXZvfGHuTNro2Or923orFz
	7hewrAjOZO5jX7lK9NwMsmB8IavrCTgpIpF9FUVhDfimdykDuyqU89IX8p8MuQ==
Message-ID: <3b90b2c4-5acd-453b-8f9d-738370a52ddd@mailbox.org>
Date: Wed, 23 Sep 2026 11:54:17 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
 <588442c7-2589-4026-a8f8-e03f944318c3@mailbox.org>
Content-Language: en-CA
In-Reply-To: <588442c7-2589-4026-a8f8-e03f944318c3@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 11646ef09ad52a70421
X-MBO-RS-META: ds7zdfw7ac3mtbp1kbr9duz934e1srq6

On 9/23/26 11:51, Michel Dänzer wrote:
> 
> Either way, should these rules be enforced in drm_atomic_crtc_set_property?

Or rather in atomic_check.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
