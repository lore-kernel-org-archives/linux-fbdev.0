Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286834;
	b=dpG4lmMbiTd62ud7//9xiDZGu0ZeXgsEie0YJWuRJEKQWbiy/6F/2UDjp2XjzBoxU1mO
	 aUA+vKBs1E2hMS0xWNtajy1Vcat5GxNEmW/uBO2WOafrPnIZeNPYz78G6ej7lrL4I23bI
	 gX/Q464IJ99JrtRpIqkTNGKBYkQeZxlX9u7DJh5sifzxOWhl5aVXWA2OlHnffdn4XkQHs
	 Akfwbo6n1hBeVl4ShALKMBRTrmsURmTmyQ71kB7KzmydtEgETjhFca68bUwYp4xcuEfIO
	 y6rXrKLyz71/ARbVJKA8o6KGTREzunIE7uAAsVrgE8nzpUvAtLCz+IuU3Iq5hlWTTyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286834;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4O0eqh0/2N6SuevRIz4jY1zAOHwLnJqMFnfAmlKu68o=;
	b=iOnuFc/HuyqR7oDflNLlTSZIBrGiyGPFk33g10/M4aKQL1r3li0OueexeM3t9LfthQ9b
	 TrzlfljPpvmJetNgVLkJS3MXobOXVH8Zb50DHw3b6ZEhZX5F84pZZxuttBhsBRtostb0n
	 UiPtQuCKiLLlMZ3qJWqOGQWBQy+4IhdUqa+fSFtOBZMGjrzo3sVS+OjwFE3CygU1daMFU
	 3WToC6lnExO/uUjhYm9OEZ04tZ/r5AU8yP+AWvc+k0q8+0oQOnsQMPv2uDcXC82uFjb/u
	 51b1cNs+TuZ9XeWyRQRQGifJCU1bBiRKpfshuZSDgNXe425kv9D9QrNj69RVJuPnwBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cryspen.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D55606A326
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2026 05:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01D55606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryspen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e47347279so987274f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Nov 2026 21:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286832; x=1794891632;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4O0eqh0/2N6SuevRIz4jY1zAOHwLnJqMFnfAmlKu68o=;
        b=1rgBT6IsFgQBmpReDLl+KUT2mtjRl3Z2ANESP9pZohhCr2aV+FPMdFRQZVeow1f60H
         RceT4/cPmB+Lmejh2EQBen/BxHOCM/zp+Ym5zWCkgL4TfRpOrPBTAtiWGm9qGAWkl4l7
         6milkribsZC8a5+SBEQT9dmLYYLXAteTB47eBatCrmQIBS1sJt68pyYodnfFLEo9pCAi
         hJYc8uRwr1iM46B391HkSKmtL7GK3QEoOP39o4qm0ZaQ+gvo3TV47GkB4LoUBBhgRC79
         Zqo6Kyl8cUn/xv/LV7880I/y+G0nWTNOkrwyKRJ+PVzReuEjBcDJdGbjIU79TJ4xvvQ9
         bjhg==
X-Forwarded-Encrypted: i=1; AL+hErHTykrYHjIAqKM0TpqZ2SKlKYakwr+Ipbko8vooKEoxNJIVSMDyCExZl0QZzSwbLbY1qHj8weQNSLKSMA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/764aDkJIlm78wus2akb3wKXtU6v7O1Lu+HeIx+VoJUMR6cOX3
	LhIdprWC0qUzJE4254pg9quoTcnuVs3B1JdFVF/p/Uvxc6kgbqSDakcw
X-Gm-Gg: AYBFou3GMKL/hUnFUVfYbF/huMkptEvDeIQ20G07wE2UVXZN/lwvIeoNmmxb77BGryK
	rkR+9LSOaKMy6nbpDfI0bkz9naPu5HBDcZpiJKHjoyQmoCZGaNfd73Cx7iuCxu5LsZtSqYqgalo
	/7kSjsYuyx4UsqsJOBEqhVh4poVnzomv+Lfn5BJz02sy7xapTDgg7ckR6aytL8EjSgck/B7pZe4
	OfvbSl/KbG6oDm3tk9XXGtvhIsiYp7wylqUHhVe6CWL8a3LyCPBsKhbbEeypiP7KGIbY3+Sr8ya
	7oS+zALyDvv9LChYkdAn37rpO4/kj/leNV5IhxL1MKmC2tAIGivcZUYXPNm7zFUlh9dvRGhf0rv
	YqY5EQW/kpMMDh1nbuDu5VlxsylSVvMmb469s7gdQbP64ovzyF05g07zmcFYrQ+Ab+3qVV+7H3P
	qps62/swwzDWlKgx/EZOcO2Sim5UXQpE3F1T5ggiXMoLadGj3SKeg1EQKNsMrTltGfDYKbEh/VV
	VCE6PQHNNJF8qsjGNpyJr6r8m37ZHG6GthJ9o51Y/1MyQkptjuSab60CBrjxiGur14M19zRRT6Y
	3caCe8lzFVrGkmPRet+bRSvZzKoYb59DC4eCYoc+vLLVXb8FhivVzcgHLcZLHk8vGNR4gwpsAiE
	0YDQahk1SfAm53uhBAm+iVZsi2IkfzG60fyy/QJqpXgB2cQotaz3NVhaedaM6oS93
X-Received: by 2002:a05:6000:2006:b0:48e:5e20:1371 with SMTP id ffacd0b85a97d-4982b28a89bmr2510103f8f.4.1794286832242;
        Mon, 09 Nov 2026 21:00:32 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498361f674fsm2715343f8f.33.2026.11.09.21.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:00:31 -0800 (PST)
Date: Tue, 10 Nov 2026 08:00:27 +0300
From: Dan Carpenter <dan@cryspen.com>
To: Platon Miller <platon.ksenzenkokk@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: remove unused macros in sm750_cursor.c
Message-ID: <avKk63Z5_ofZZcGk@stanley.mountain>
References: <20261109231414.25021-1-platon.ksenzenkokk@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109231414.25021-1-platon.ksenzenkokk@gmail.com>

On Tue, Nov 10, 2026 at 12:14:14AM +0100, Platon Miller wrote:
> The macros HWC_ADDRESS_EXT, HWC_ADDRESS_CS, HWC_LOCATION_TOP, and
> HWC_LOCATION_LEFT are defined in sm750_cursor.c but are never used
> anywhere in the driver. Remove them to clean up unused code as
> specified in drivers/staging/sm750fb/TODO.
> 
> Signed-off-by: Platon Miller <platon.ksenzenkokk@gmail.com>
> ---

Leave this sort of macro.  It documents the hardware and doesn't
hurt readability at all.

regards,
dan carpenter

