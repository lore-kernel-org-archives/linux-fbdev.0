Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59315623E
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Apr 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683708; cv=none; b=mL7W2MfcGrXhsJRRHs/Jn8iHaHSC6Sx7HKEvSpQtQcx9VvYgcWpUayof2Fo1T16h9vsZ0LbdkY6X0HphHFiiXQgWP0C4+V2Xbl12Hwwu/LkazAGrMRMSYyWNTI+mXGtiBHAQQatRhKnDEU/3ZIioxzQB8FlVBu286CSRBrHmF78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683708; c=relaxed/simple;
	bh=fa5Dmlr/NPrypZkGeE7E1g8PAi/Q7m7ruLjA0BtX6rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+43b1CesRWGZUrShqOMBcsUBKD6ye8XvH0C1Iz3Xu4/h/RZF8/OEtO+kEYgioB/Sk2Qzui6QjbSIvx9oC/pTd8eXSpjyinRrlI3qi5CA0I3SHEelPYXcVRWHNWQn7fjxv28GA/aarAp3Aa6P7DpZmxv/hgeAXuJDRecoatYbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dwg+BqEo; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwg+BqEo"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso3645428a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Apr 2024 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712683706; x=1713288506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa5Dmlr/NPrypZkGeE7E1g8PAi/Q7m7ruLjA0BtX6rQ=;
        b=Dwg+BqEo4Ce78piPZT2Ct9wnXxqIwIZqEub0q3HG9N6Sz+JA6UVxWJCNqDNETb+ocv
         VmM4ZEtSxtWQBL/hwu62yiDc9UnppP7KkVpyIwe4Ycft0A7rxo5nJiSc40hvgOZx73l1
         xgKzSZ3POXAjQjJxTed181034tmSMO/xowmjHE+3d+xNdS6Mk2UjNeKVjHmTFBX0RSyN
         EIdOZmT+RTw8xYCBGqMeXwJtI3ohLZGB9vQZQ5TTN5ceMTY/A4/XcLnQKSzgoD2nVyeO
         tH4HVnCFk8j0/EVo5dL9sYumcG7Bb+L2tNL0A67BOSzQpN2tszjuOMtNo4OLBvMyJiic
         ddgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683706; x=1713288506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa5Dmlr/NPrypZkGeE7E1g8PAi/Q7m7ruLjA0BtX6rQ=;
        b=R6q9SenDsvbSaudX7THO1UMyHB7MURm8sxf2dzBdtGacAiFFQ1odbd/h1ov2DN//lu
         fwyAUdAbajSK55JZ0VhFgY7KqgLmFl4Bucb0ns5DetEx5OqvwMsd0Yf+Uk+vjK7Qjf4g
         OJDQyeLywDkPbJSgOFr7K3spFjHRSCMJ7gyCUC+ZgicCd2JMU+mi2L5Bi+Zna83buKH8
         dGaXEyBFLaSE+IWnflo0PSc+GPDPkvjrlTU12AyupLT6VRVyCf5I/2NofER4QgIJtG56
         JYu5Ymb3dbsu+IhDiqG2Q/qabQR1llkkkkp45bKW9AsQE1kSg6sFAuQs3MBGEL8sy2/v
         jXGg==
X-Forwarded-Encrypted: i=1; AJvYcCX5+TLS/429jZo98edqg5d/3z2NV26XVfVnR0VPX+CRGCTmGMAAL8KPNcl2rJb3yf5lMeCgaFbvXwIyruA9UFQzsnF4kSMix+iI/iA=
X-Gm-Message-State: AOJu0Yyej3fcJY62MP9evUgeT7KYGbILKSEj6GSzxldNa/TZCQMnYzxI
	aGIP0q8wv3mErWvdapdreNvXccmDDEXk5k46YzsYaNxnTN193giBNYT0GLXYgEoXPGNlBE8=
X-Google-Smtp-Source: AGHT+IHWbihX0WFZNpRScBdUcc2XFZ+GfokTuBZqI3IxOqoMWFCNXFSpx8VlYzMg+AyQE9dKmaJDug==
X-Received: by 2002:a17:90a:ac9:b0:29c:7566:a1d6 with SMTP id r9-20020a17090a0ac900b0029c7566a1d6mr330992pje.25.1712683706037;
        Tue, 09 Apr 2024 10:28:26 -0700 (PDT)
Received: from localhost.localdomain ([172.93.220.120])
        by smtp.gmail.com with ESMTPSA id n5-20020a17090a394500b002a55198259fsm2136700pjf.0.2024.04.09.10.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 10:28:25 -0700 (PDT)
From: Yuguo Pei <purofle@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	purofle@gmail.com
Subject: Re: [PATCH] staging: fbtft: fb_st7789v: support setting offset
Date: Wed, 10 Apr 2024 01:28:06 +0800
Message-ID: <20240409172806.8527-1-purofle@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024040935-naturist-skimmer-391f@gregkh>
References: <2024040935-naturist-skimmer-391f@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Apr 2024 17:49:25 +0200, Greg KH wrote:
> So you are now hard-coding the size?

Yes, the change just helps developers who want to adapt to different screen sizes.

> Is this always going to be 0, if so, why need it at all?

Not sure. For example, when HEIGHT and WIDTH are 240 and 280, LEFT_OFFSET is 20 and TOP_OFFSET is 0. Different screens may have different offsets.

In addition, do I need to resend the patch to modify the Signed-off-by?

thanks,
purofle
