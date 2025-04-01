Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692161EFFA6;
	Tue,  1 Apr 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503022; cv=none; b=syGPQFjmH4lxehrsotZeS2/SL1CJ3B3dkyj1hcskSqzbseDQ+Zsw0/BZdlV1ym4FDAmKobWt+ggvBKOrdxYTOwlsjwVAuEZtQlP+utlGf8wXnetrKnse60P9oBRYTLQjX1Q96yzZUG9J0/RhKCdVRf8tKol+mcoEod62pSrUNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503022; c=relaxed/simple;
	bh=jXpDLeX8YckBusCALW0+v36m5It5YYxf80HKSDlDrcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7FvvepYk7rhHm1Kh1Yae1x6LeHQYPWlncE8T8uvcpySq+uclc6XPYXQXB+95EQLdgnFApyCuZTsOmUpJXxaPTUfGgdLSIl+j/pdCmTiJ8larn07tyybuBZeB/bBVxNGcYdrFzHzr+8L0Pt6q+yvh3pHwkkAzVLZ/7UET+cBkyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=NIPG1LGp; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="NIPG1LGp"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1743503010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVQCdjXGU5FONNoMrHgE92TVvqfU4Ncashfmh1tdRCs=;
	b=NIPG1LGpmkf27pacGyKPjcTpm1iVXFR9MLSPebAlb1sXiLvbOZJgE+ayqwX7DJamCjzZkk
	s7bpqManxChYpYeCAC1eyQfaGadYymC8Q52uHvCV1NhGc3ABuj8p0ok40qYROyWrTe0vj6
	HaGr0YrX7VhDeyxZxVAN/kHD/tYqF/4=
To: deller@gmx.de
Cc: arefev@swemel.ru,
	dri-devel@lists.freedesktop.org,
	jani.nikula@intel.com,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	tzimmermann@suse.de,
	ville.syrjala@linux.intel.com
Subject: Re: [PATCH 1/1] fbdev: atyfb: Fix buffer overflow
Date: Tue,  1 Apr 2025 13:23:30 +0300
Message-ID: <20250401102330.7759-1-arefev@swemel.ru>
In-Reply-To: <e04f012b-cf10-4a84-8fbe-ece1a06f0f66@gmx.de>
References: <e04f012b-cf10-4a84-8fbe-ece1a06f0f66@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It's old, but still runs in some configurations and people
> still (although probably not on daily bases) use it.
> Also don't forget about the various old non-x86 hardware machines
> which often used ATI cards too, and those machines are still
> supported by Linux as well.

Hi Helge.
Thanks for the reply.

 Ok. Everyone agrees that there is an error (buffer overflow 
lt_lcd_regs[LCD_MISC_CNTL]).
 Ok. Everyone agrees that this code is still needed.

Then I propose to fix this error.  :)

Unfortunately, I can't do everything by the rules, I didn't save
the chip datasheet. (I didn't think I would ever need it again.). 

Regards Denis.
