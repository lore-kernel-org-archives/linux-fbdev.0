Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8C42A97
	for <linux-fbdev@vger.kernel.org>; Sat, 16 Nov 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771631; cv=none; b=Hw93PfqQFFSgI/Vy67aSAWDujsceoQUILF1EBMZ+yniaZhnj07ZLaSLJjITq5ImN8u9zQG0FkU2txR/BF4bFIPZcah8K/OSQue0bpaDX7zbXpu92CAcCY9qeQlOuu1gVnU1ANRez6IdpTSAjyZCh4qrywX4LNsK+2CpuWH4l5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771631; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=SFTfJD35icCtM25yk1sE2SiB0HCxMNv59Nz+W8rTz+zaASGz2P6/TyMh03n0MvP9ikOi64wBwU0YpgGrLDy2aUr5Ig4+gLm8w1TKO68uFdAbzI3F5SzcFIqkUVotDse1QcWpply/WMlPf+ZTz3W6piOuayWPlJ9pgcyYAmT708g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cndXKJeu; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cndXKJeu"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7206304f93aso505124b3a.0
        for <linux-fbdev@vger.kernel.org>; Sat, 16 Nov 2024 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771629; x=1732376429; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=cndXKJeuEb/lJSz3Mu9/fgKkG3mNcZdZZBpW5ICjNxrtV8nmtUiBgTchGD4kHRDFIU
         D/qE1rPDpCJ3Oso5kknGM8l/2Wa+LRwzMKNtvpAs2lW/tV0Z8E6cinZhTVj0DOVr0lfC
         xjEIZjKqrX3mZU7sbOGdMioD3I+R6vbCZ/IhiwOe3Q3GQihaTeMPZZ1UsO5ddJfO+Kqn
         ATpzlmCqKWGGk9bJ5NVOwXWSJieuNWsDwRVTTHlATVC6UW0rXdboHiP4meAg/uht7BLD
         Fzp1oxqK4KhAiltFq7vxITNC1x399PeHABwz92nZUAxErwk4HyGSE+GQUhktjgN77+2w
         oYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771629; x=1732376429;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=E/utbx7brmsEXQprLsRHvZZpE6M+X6Ba6zq+f3qm5z//9YcojZgo/hAH2oSDzKcwlL
         HuVdJTeaqzwXvmpbQnbwSDyVBwNuonSAptBR+VV1Gn4/C9nF/ALPA2/kNB0EVBEvIjGx
         jIR9HWJBGuCAwmNPsHPw38QHWTrQw+jgV+UMFBD1QTI/yAEGrWqquwgv8WmqW8nuZv1h
         NuOMd0rx4k13gN+4P4eIgnqNK459mKZt06UP+qJhAebK8Amezkk8XnFgUpajjqpya0ke
         dm8KApf/PyaKg6FRSTvqBdPlCOsdMWrTFnJhriXVvgQDSz2VVZZ16Wdw6mhqiYm5iEt1
         u/3Q==
X-Gm-Message-State: AOJu0YwTLjpvGxxZgbwXEtJjnC+nSXYTnm5Laa1HhzLA5uNwp20hah7C
	jZ+3HT6m20mKdApIu+IgF1oKHw+5VPyzF4diryp3V3oTsPTagcXH4AlyW0AY
X-Google-Smtp-Source: AGHT+IEvj9Sn0zBuMdN0H+/dFmCAehTFuJ1Bijwo38KOgCeUqbbV1j1os61XwtusqUHI+jko1MACtA==
X-Received: by 2002:a05:6a00:b46:b0:71d:fe19:83ee with SMTP id d2e1a72fcca58-72476b97fd2mr9118997b3a.10.1731771629332;
        Sat, 16 Nov 2024 07:40:29 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477200a99sm3273268b3a.182.2024.11.16.07.40.28
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:28 -0800 (PST)
From: "Van. HR" <yongsaravia48@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <0adf78ff24f8074c89daac667ce89dbe09645c06f891952d48b407ebd2727246@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-fbdev@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:26 -0500
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.

