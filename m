Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755063;
	b=ZvpxtTY+w6r+MPpHhFWY/B51sIBQiGRcy61Z3TawZUp0PhKerF8DefRI0PKVF0YrKgiI
	 ZXzzpl9V83I/8/8V5UHONvZmDNnLKXjLiT+jSGnydFjGt6jHykzPJ2IRnOWJ6s/2ejsJ8
	 /hYsggo8EASkVMEBY95ld6Xe2yLkpA522yBaHrOuQd8yWD1GWW6sv+jIcrGhC4uZNUWmN
	 YEcMEMZ/3W0D49vV5wxbOTjYBRrD2NZjEPF0NRsTdv/DM6odWUYzgLnfBqvFsUePLXh5m
	 PWegVnCn11JGVnKEMpQqFfG0FP3xTGApFPTwyDjv6RUAKfBE/G6ZvfNe+nQCWBrhStA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755063;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GUIAxerpQhJLvh6XFl3jtOcmO7oPZcsLN/6gwcX+K9o=;
	b=HbyNtO394gRDBzn58XDoqtBT6NY3N8dU+ZoXwjyk4IrD8++8Co8XBAilTXdm4xK23EBC
	 oZl9OroPDgYzU3HzJqSbgyLh1ALvnNmZqNPrNVecuPCn93pxSrHPLBs+4vNy6y/7ejC3g
	 hWuoEyO2ZDoCRTPEgqtOG5Osrija8kYQI2JO5uF0A6342VmvTseQiq7ns2Z7nE59ha0vI
	 P6R2YejgJUi7ugGrUvSPBy4ojz75R//CLtY8n3S+Nc6LRY4chlyq5pvFdgIt9RxQEf4HK
	 s6cgA2VqDiayZOvJkeJgjy0K+rCD/fVb0PyzbbIwSgIU9opnjngEU7ghw6+Ee5DgpKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SKDAzxxa;
	arc=none smtp.remote-ip=91.218.175.243
Received: from mta0.migadu.com (out-243.mta0.migadu.com [91.218.175.243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B70606A31C
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2026 04:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SKDAzxxa
X-Envelope-To: linux-fbdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GUIAxerpQhJLvh6XFl3jtOcmO7oPZcsLN/6gwcX+K9o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795755059; v=1; x=1796359859;
 b=SKDAzxxap5+sRFhJP2dR4Np4gnDSlR/U2kkidITDtC56sldfEHfyPJ5R8S8J5OzeclEIkDjF
 G7a0kTx7JeIYPd9p/IFis2h5lyZo1thsAEdAjtcB6/H0HjPDrrBl1J4ver3u56J55Qu8gSf1Jdc
 aYlinlRU7L2y9rl8JeSZqA6I=
X-Envelope-To: linux-fbdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 24b8cb35b28b4af2;
	Fri, 27 Nov 2026 04:50:59 +0000
X-Mizu-Trace-ID: 24b8cb35b28b4af2
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: blum@kernel.org
Cc: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	mitltlatltl@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	junjie.cao@linux.dev
Subject: Re: [PATCH] backlight: aw99706: Clamp negative max brightness values
Date: Thu, 26 Nov 2026 22:50:48 -0600
Message-ID: <20261127045048.1317758-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127021423.656745-2-blum@kernel.org>
References: <20261127021423.656745-2-blum@kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thorsten,

default-brightness is also read into a signed int. With
max-brightness = <100> and default-brightness = <0xffffffff>,
brightness ends up as -1, so the upper-bound check misses it.

Could you clamp both values as u32 before assigning them to bl_props?

Thanks,
Junjie
