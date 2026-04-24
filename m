Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889F38AC75
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023749; cv=none; b=rpMjIyu1xFSaTXHQR3Y1jheT6vXipwELtz2Q9RvIUm58iQyE/vZdtN2aT9VIDyzWt2TT1DFFYhX0j6qYb4bKtNoeDzFDdmr1IwnYAx/tDsBtQad3EH3giNMDSN0OdDAUCRLaAOdrBctHWzpAsOthoOXHk1L0QJpkZh2mimYbdfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023749; c=relaxed/simple;
	bh=hDYc1MW6S1MSpliI1TbPg+1F6w7TIPay6jp2YVrMVdc=;
	h=Message-ID:Content-Type:MIME-Version:Subject:From:To:Cc:Date:
	 In-Reply-To:References; b=UJjH7/9RflHYAVitrbLbz+gjvMS06jS9riNDwItbLQt8EmrFb58XESwLRa/CVu4WQD6fmzsH0yjU0RZO3NajKzBz/G4xNl6aNDaI5cBNq46CfDnP5RQn6W3JYAj2IBSJG7cbDdD274k6QC9sRY+0w39ed+IASfgpZJMgrl06jsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEDqFjiN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEDqFjiN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d73422431so6629852f8f.2
        for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777023746; x=1777628546; darn=vger.kernel.org;
        h=references:in-reply-to:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDYc1MW6S1MSpliI1TbPg+1F6w7TIPay6jp2YVrMVdc=;
        b=CEDqFjiNYxaCzW4nvbq716mDb/8N3Djv9eNEYuxfKI7JzPA0vibcluTxWSkWOczANX
         /9jqZFxezZtvjJub85n8bD4JVi5FQ5ZdPHdNwB+H2T3b+VrgLDDYjXnRiMsZjevWaz4q
         q2A5oJ9p5oMiHAeBDGdLKW9murdrXxnza+q9A4qPqeIBDTFn94sJDKT7QEO5O8gsnEb8
         J7WYa+w7vGpeWQS0pulIqCF9zgrwyG5aOLk0cNwJROe0LKx2ERyVUp9vwCovj8USeN7w
         AKqzdqBA/UtzK4VwdHSodkS2VHhs7HoKXUywcRg324LPwB5ITAGn7iXgM51BWJyHWZWT
         bYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777023746; x=1777628546;
        h=references:in-reply-to:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDYc1MW6S1MSpliI1TbPg+1F6w7TIPay6jp2YVrMVdc=;
        b=k/+ExVRMVMEK/kfWpcA66bg0q6j/rsDHIQKiB4wV+MI2Lbn3ab8hkUvPf04idvedMz
         6KvZ38yv46eGiGtL2MJzVJlPQ0cNZS0paymDbaO+CeDwf18G/mdbDBS39uxgdDPRPo98
         +prLzhiE45R7+8zkfZYs1pZ6oAiEtXv6ZyejaM0gXrp/9nsqfx0oD6pXBqNCW4TPUsyX
         7I/3RwNoZtfZy9eYUWUwRD8drW5jE7TOsdAMhZWirAOHR1ew8QfQgnsdi3ObGCd1hGFg
         pC4AyucaX7Tj4ANhrCcxYLbYAj8gUcLddO3A8y7alcFFNASJjgEW1fu9A1gZ3kG8XAyw
         oxeA==
X-Forwarded-Encrypted: i=1; AFNElJ+FJU5LTvPh+G9e5eEQVcfkGFzHu0azlPS8b2WaM4FpbJBCSDKk4FPdbk59N07w5ykK76xL5ZD4/VKWAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyALqmg9D4b/oKazFHugPMIh5v6gKcsob0KVlf3LSSWkBfTRqh5
	qKBahSAK9TXhOVW5KVNp/Ghzc71xd1xbz3/UW4OjsA214/DtFQjqjUrE
X-Gm-Gg: AeBDieu/oR17iDdzTTNIePmskfq3GPXnKJEHOnSs43gz+hl136vPea1XCHFerQ1j1tL
	/MN6EewEkfohcYqiPRHkKBvmr32DMs7XIBJ/MsskN2Clw6bF4QNBnRcWEKp5Kf22GEgT+k2bCSx
	cyG2NiQNIEJIxJdVp5Y7DhdP9geyGVEd5p/Z6BF3YcxyXWoMURt6soYBCTC30qfeqsHJVHLQAbw
	bzcNShXgiL9NPLi2NhbpPf8wYPJOoAiEWQAdebo1PW7/eBfi1/i9xA/5x6FATG184UVhEyZA/iD
	sJLGNorB8vnNhfiWt99+m58SBUpD1zYhQMODMt9M/e1GpcZq12+YvYZTjLwsieqWaACnDp7d2+R
	zhKNvx1UObtgDasobEjG1wsTggaDspEpQCT0NaQ4+GqhpdElfxfIOmPWVUx5CnXBF4HYyUdp9KK
	Aam+l43YdLY1qu82eg/lLiHixeEhTBGxTGGQ+AbZuhgPAVw2otf0V/TkQAoEGdSYvTe9C9LM5+W
	Dr9l5ST1H1+vf+BeJBAAwT4sdXYlK1d2lv27mB4ky7MA0Tlew1afEfakWYnkr6uK53E
X-Received: by 2002:a05:6000:2303:b0:43e:b020:f8a2 with SMTP id ffacd0b85a97d-43fe3dd5208mr45925335f8f.19.1777023746069;
        Fri, 24 Apr 2026 02:42:26 -0700 (PDT)
Received: from ahossu.localdomain ([5.14.131.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44123d23e0bsm19540453f8f.15.2026.04.24.02.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 02:42:25 -0700 (PDT)
Message-ID: <69eb3b01.5d0a0220.3c3ebd.f35b@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] staging: fbtft: fbtft-bus: replace function-defining macro with concrete functions
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Fri, 24 Apr 2026 09:40:48 -0000
In-Reply-To: <aes6JY3Ht6p1VpFa@ashevche-desk.local>
References: <20260424092818.3322248-1-hossu.alexandru@gmail.com> <aes6JY3Ht6p1VpFa@ashevche-desk.local>

On Fri, Apr 24, 2026 at 12:38:45PM +0300, Andy Shevchenko wrote:
> I'm not sure this patch improves the code. What I see it's harder to follow.
> NAK.

Fair point. Three near-identical functions hide the pattern the macro
makes explicit. I'll drop this approach.

If there's appetite for a minimal fix, I can send a v2 that moves
EXPORT_SYMBOL() outside the macro body only, leaving the function
definition untouched. Otherwise I'll leave it as-is and wait for
Greg's take.

Thanks for the quick review.

Alexandru
