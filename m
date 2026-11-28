Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840795;
	b=LbWVUdTmtec6S9NwUy5rhYf1QoTaOcL7skx8XHEAzwXVOE5XZv9ec4tQnI0/Nrm+7WYp
	 o9ocvtxKvuqXw1Wbl1T8tww2+GtnmsWYXwatMPzBQm93NtO4hb58ENjEtgktzkdLAji2x
	 oqzp9VXDIdazZoq/2bpAp2q81ZMe2tE+/5dZPOKt8WDS8NDok5FPqOhjqvlUGrvvnL9zG
	 oZcNFRveIHFwhqj2O+NQM31YWu77zVB8FOCAqFqc8BwGIdy7iASw8YfTpllyOsRIhU9aE
	 XqcJqzAqGvvqQFQpmwcrlU4TgZrqpUkAkdJwBk647vKruh+xX291YsjxnbL3ryF1+9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840795;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/KtrdqgSMxLfjdJO9L89s3kUAEIgOvl98/T2RWkfGzI=;
	b=wdUKjnPiaugkz5SwUNgALtrPUbDUkbnHuGT6grOSVCIEVC5LJU9XmRJs97Jwp1qNeLTL
	 DSAWkq5zYeoIJ0xx63Qe0K7FqejGZE8+o089IYPTj+2R8nZWV7kEupxyKso8daEvX7dB2
	 OMRhWSXmOZeSq3FUI3ZTL2rBoYVihzay7EkWMxNXjt/5mHNeS2naVGAbnD/2KCYbGLhRn
	 hBstkhDUdLIvuCN2kMMyh4jsB1z1xaST/K+HUxNiCBwBleesWcjMe+faxbTbWQqPE0Yhv
	 McoMTn1uXSQh9irVXyQV2/vO7wg208+AQx+S9A88X6udC0YmfFfOdaf9BKxbt15FGOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LtdIVG8b;
	arc=none smtp.remote-ip=95.215.58.152
Received: from mta1.migadu.com (out-152.mta1.migadu.com [95.215.58.152])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61F606A31C
	for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2026 04:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB61F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LtdIVG8b
X-Envelope-To: linux-fbdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/KtrdqgSMxLfjdJO9L89s3kUAEIgOvl98/T2RWkfGzI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795840791; v=1; x=1796445591;
 b=LtdIVG8bh0hwGE2YVGQvJhTQgI8w+hmEZqyQ/ex3rGA4qqGlDVXmwOzN0+aozVfNC6KhTmb8
 4GCHTmW8W0EoZ5gWibN+PodSv3GUVgaaQd+otbdio5wHzZnle5J2Z0tCH1ig/r+tQVBJ9LyhbHX
 iNRTYDWB1JuKFERU0IKTH+zs=
X-Envelope-To: linux-fbdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 19db7fbb5df56346;
	Sat, 28 Nov 2026 04:39:51 +0000
X-Mizu-Trace-ID: 19db7fbb5df56346
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
Subject: Re: [PATCH v2] backlight: aw99706: Clamp negative brightness values
Date: Fri, 27 Nov 2026 22:39:47 -0600
Message-ID: <20261128043947.1375645-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127103341.663905-3-blum@kernel.org>
References: <20261127103341.663905-3-blum@kernel.org>
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

Reviewed-by: Junjie Cao <junjie.cao@linux.dev>
