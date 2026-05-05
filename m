Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080921ABD7
	for <linux-fbdev@vger.kernel.org>; Tue,  5 May 2026 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777945165; cv=pass; b=R9aRwxF9G0pF6petWnuu6+01lmX/64e3b0zu156Vkt/4wewoF4Ie8BLGgpYXP/irb2rLRC/14pco8SjUxel1WUF3nsWbf8Yx70UHcU5j/22+TZnJUYlLXi553rCABdOag5YORgQ+ct3mcCusHoZdpku+cI5wRHKssGKcZxEpqJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777945165; c=relaxed/simple;
	bh=zW9srXy5sasOXgSYMEpoWBjtDtHo2tnh16UC7yjH1Xw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phDL1jXoKij97bK0ITe1JwZFcGWJ06wX9/7CXuFuugCGldhS6z+SbPCrGlkYukv+dyX60Qm5vzoeX7eqhAfsbmWml6AtdaEW+7igFIZxxpb8TA8ydKEJ9XTG0x1Q4CrnetGNdHt12QGwFKaxCIyRThTgAUDeOgFDhR8YqBtwZtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMj17CNc; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMj17CNc"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso4159860a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 04 May 2026 18:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777945163; cv=none;
        d=google.com; s=arc-20240605;
        b=IMwXJawl9QL30klMumeXKpeyEcQBsBHD0NBAranJCWgH88cGjbskwvIMehhzXnqnE+
         K3Mz/2R4CvXGXCyqqd5rqG3w6NFqdzh/gSTmp0vKFKyEvhRXVob81SSAgl0PtiUdkXQ5
         AGpYGm4Te7NKEwjtB1orVYUn6pv/zCUaiEM2noLAeYhiy69QZ9Ux2pLfcdNf0/Hjq/Pp
         izQqtAffJ2AvHdgyxjOnVWCHukY3ZW0mWVyG1Yr8TxlsKBDhFyiA5I2HszE+Ax+s/S2N
         pAsgWBkPdB6zZRuAGY0RZ3wfBk72NhDxcY5s18wVdo5A9kbOYYPtrgUHy1TAIwyjiknD
         24/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=zW9srXy5sasOXgSYMEpoWBjtDtHo2tnh16UC7yjH1Xw=;
        fh=TvXJhdFciXSioxAVQ/M3qKy5aTOVlgVaKQbmaY6dq8A=;
        b=hzU27ywMQ69QL/4JNOV+JU+g1Evi44oYjIxRayq2JrIWTwDT4wvE+WxUyWcjnOt9DS
         6+olLMO3KQWvxhV9yC3fkYtHaZGtAYFYzBZpQoSDwz8TMNNrJtUuR3ejny+0xUtUJ3nG
         09Zv3zKtvY5w3HWu/Q/L2TetGtM0blk1QZbwi1IpjfnUEbhrvHcQE8EqvObY+anVr5ja
         vvFpawpogw3EgpXm2slc668Wt2U5noT/iARWx8b0M0PtwOhjMYfBwE/OBcecFA/3u7dv
         Ub6iklVhMPbdyRZEhK61rdM/HQCg28JQkqbAZ/Ovkv2jOyj4/a8F/UqMhFN8vjJemoKq
         FoTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777945163; x=1778549963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zW9srXy5sasOXgSYMEpoWBjtDtHo2tnh16UC7yjH1Xw=;
        b=NMj17CNccVtyjw/otkBHkD0v41N6h6krQEv2ud3+3mPNMkqsjO+XcZYCcZwTjpz9Nn
         x8191/g2y4cEbtNsDKIYNC7k3+jQF8LFtNoH/Y7yk4GZn0T5oRLv3q3ko7a0Oymmt9Ap
         a3z+E8lcrTFxxJKlmeg5blAFPDBwpXF1hlIlbLjAVYG8nz5UTiCGqeD9fv3R42U0SD+C
         JUR5EdCglX7jrFODOB2euRkvOOURWe271kByHCPSK9V0iFjprdIgaVvvuN/97wxDOEF8
         m7ACCMMMUPVY6o7YvQmo4WOw7UcFoTNxOpKVxmlUPty43jZHi1EBFEyp/uliPP1lALe+
         B4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777945163; x=1778549963;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW9srXy5sasOXgSYMEpoWBjtDtHo2tnh16UC7yjH1Xw=;
        b=ZLH7XsB+DYpE5WWbz9jx0/EwO68s7Kew32mjxctsRQJbO8Aogq/9EN+XQsJR5fmfQY
         zGjJOYVbTeI5XhcpPEzrJuHQEuFcGfqrom7tkdbct8QTzTk9uCbtaBchGunMnszba1mn
         pMMXPzw95d71NDPBvx6lEY+BIoRPDT3a3Gh146/l2Nf4DUd38/+JAo2dbuflQ6lKMQbX
         1XZh472XgZYJ7wWbYX7s+yv7w13IPfY24mN7M87kVSw0Kv41v+n8jC7VsA5vnI56hgy9
         ogElFKqjs0WNVyIwJrqcZs3n/M5Aoh+qOtbR4kUyRofK72Pq6Xpbu1S/iIPgEc7jn2Tw
         /siQ==
X-Forwarded-Encrypted: i=1; AFNElJ+D/W7GqtOwZ4valDh0Q5yScrApmU28DHMsqUrbdyiNzDieObAKD1Qwuov4QqXnuEaA5f4XTWTXPEEHrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbyfBa76Y8iQqStBGn41MjRDr7uR77k67XMMUl7Uinhl+vmLMS
	xIKFzr/0OpfRJ0KhoQ18LbDtjDdDk7PlJeRV2jY5ZoyXu9KgnMbRTo36eYQrRiZwWu2Iww/9grg
	N/I4YwdxwRaUvIqXIxZtQCAqxQdcBY6Q=
X-Gm-Gg: AeBDiesPXqK7ZX5z9SSpE9G8UOJCLMWLgkIU0yxfcLy1VHdK5NcHsb0E+19QdN1S3R0
	nHtV+rvQ2XSG+5XgLUXAMZXTZ/dZOUzxjjDCkWsoNkhOOTWIbEE+E6DeiNupYueuUeXMtG8E/i9
	kIMmHbhffXqbxTCkUWhNMLOEZGTs3iW6/6TpC4pStB686chTVqrOD6Pa1YfdcZcjrtOCpxIsBqX
	W6fd5cnTVsrXjIl6refgZEfg9UoQUFf+xbPXwsIGQ4UZokAnVDLi0nuOcTyZFL2plTaptIRBpYl
	R6t0E2o8oeFvuAJr
X-Received: by 2002:aa7:ca45:0:b0:672:a1df:9c6e with SMTP id
 4fb4d7f45d1cf-67c1b2ba7d3mr3855060a12.25.1777945162456; Mon, 04 May 2026
 18:39:22 -0700 (PDT)
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:39:22 -0700
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:39:22 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260420010118.17960-1-dbgh9129@gmail.com>
References: <20260420010118.17960-1-dbgh9129@gmail.com>
From: dbgh9129@gmail.com
Date: Mon, 4 May 2026 18:39:22 -0700
X-Gm-Features: AVHnY4Kw6-D4RoLgxVbTrSVYepdJksfw9sC-SZytHwR6bu9D1ZYkczGjKA77IZw
Message-ID: <CACrCO_VZg_2PXG011qQ7NWo3iz-u2HE6DdHZWQdQ_UnRk4A0Eg@mail.gmail.com>
Subject: [PATCH v1] fbdev/offb: fix PCI device reference leak on probe failure
To: deller@gmx.de, Jason@zx2c4.com, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mhun512@gmail.com, ae878000@gmail.com, tmk5904@psu.edu, dbgh9129@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dear Helge and Jason,

I am sending a gentle ping on this patch. Please let me know if you
have any feedback or if any changes are required.

Best regards,
Yuho Choi
