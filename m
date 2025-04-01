Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AD1A83E4;
	Tue,  1 Apr 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496819; cv=none; b=GoKV/35+gk1zPXhDXQsipXSBRlIlbGlKz6epI3OmiJXTfq2OnYdhPaS3vDKducqy00Tc4YjdTQWKyNOBHQm5ooAmUcv/uBLZWsyq2n07dS86E8SNSn4vICjc6qFWH0BsvxsNF6g6z2HqmwW/KFK9lAb+FfwYE+P+Wm57fcE6KDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496819; c=relaxed/simple;
	bh=oSXQoDk5rnHxTGq0QwglgYgL8weJwwWigb4+0jYl/Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b15sJC7B08pkHG6MECVb11vc+Q6jG/8ne04jkYN1u+07LUiKcOk4AtEnKeyUS1JHu0P5n1r6gLnxEofOWHgtZfnCxXxhODAm4SxL4Ldw7KVYWAoLRCgDvqP+8HcUA3c1ZDcmD4Zx+pObHVEKSJLWFKY9ZDJgWmJMY0cO0gHFTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=SjWDIs9N; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="SjWDIs9N"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1743496810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70J3qbqUkhpGfcXlW2ynPrpc/c8CjZPQmWcMnQ7zHgc=;
	b=SjWDIs9N+nxAtJw5mMhsl6F0LJ9DBEVxQ2zXCX+TwQTUnNH9sq/DvmXxBW7d5kM7GEvUg5
	o2D9ah2UfPkm/pCmqQqemJvyoe/lsKVnvn7ve5c2SNs0lyFf18apuYNN5WXz6YBo8UnkBE
	qq/f5dV/d9MU9ILlm9SFmd3GHRWqu4E=
To: ville.syrjala@linux.intel.com
Cc: arefev@swemel.ru,
	deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	jani.nikula@intel.com,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	tzimmermann@suse.de
Subject: Re: [PATCH 1/1] fbdev: atyfb: Fix buffer overflow
Date: Tue,  1 Apr 2025 11:40:10 +0300
Message-ID: <20250401084010.5886-1-arefev@swemel.ru>
In-Reply-To: <Z-rzIfUMmOq1UZY1@intel.com>
References: <Z-rzIfUMmOq1UZY1@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ville. Hi Jani.
Thank you for your answers.

One small question. 
This chip (3D RAGE LT (Mach64 LG)) is very old it is 25 or 
maybe 30 years old, why is it not removed from the core?

Regards Denis.
