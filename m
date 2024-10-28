Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2927DA9E
	for <linux-fbdev@vger.kernel.org>; Mon, 28 Oct 2024 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730077197; cv=none; b=KXI3LqT+V974WHwWgeX3Xr44Hmb0aMGrVak05IKvqkMml5NqODcFHdzpvoAhxmVsUM4cGQWLK7D5uPPXo9lAH6I2L7CRoTM7pAV0b5LRs9fXq+6iwSO94HtOqu7IGdxg4I2EO9MWHp2eGvpvZIopHginYwMXLMgdM3veHXz6NDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730077197; c=relaxed/simple;
	bh=Hd5GLAXp3ye3/4TWLWX6baeNpv4+Vy8H+HoPL8mosOI=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=NS9EdIdcqbDrHB5AENNfRaTOPlcd1K/dLjKAJNjS+rnwnjNRunIMEWjS3yZFPb3oTjYbbDRhiilcEX1Ul6WJZARPJFTouuvZdkTJ4q9mZd7qlZQ5ledBwlY53qRnqD1RzgXAOx+V8YlslspGmsPagGceyuVwZDtHxVHNrZ42V6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4TtHb+1; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4TtHb+1"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-431695fa98bso37327425e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Oct 2024 17:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730077194; x=1730681994; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hd5GLAXp3ye3/4TWLWX6baeNpv4+Vy8H+HoPL8mosOI=;
        b=d4TtHb+1ixxzNRTz2PZfsDZ/EDRawn20gYQa5My6X1xiEwaOFcGrrcBvq7qW72PImq
         fsShvA3gVia3IF0k9DIds/7nWLAa/PVsjjoTRVXucigr1vToN9LiTdNX3Zcbp4gisqCR
         dvuFkLkZY5lIWdiVq5ipSEZZb/KJG1/WGj6mlsBYHVhwr0GvaNJOmVFfXxcrpx/vzgxv
         b8sl6k32pGfgonrosDOtF0sDvge6vmZsEywNAMoBa74pKedVHYXdHYHV4kxs/87sVYeZ
         MwlW+HAugmuaKQ9QHTXxXslTy9qcytaffcPT6xuZYI34tl+sZmvOZnnU8h7PybVryiGt
         Ofhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730077194; x=1730681994;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd5GLAXp3ye3/4TWLWX6baeNpv4+Vy8H+HoPL8mosOI=;
        b=K2V0bUx2cQc7y8QJikA1KY1T0dUMcuxdus6OjpVBrl0GP3MwmOTLsinZ76H775uaLp
         oywURFs8Zisj0hKuKWUnaepOfSb3eS/FaP/t4Iopj9OYov9NmBYp+wK23h/lf49UDPGE
         nCtCySNLsSsSCJuC7/U3TaeowI2rQ2BS7aUN2eA2o1XgybIFBJ/tzBbudmh8tdU/4Z7r
         B5bjjvsuLejOQtnOgMv0CaIOkNdrG9D4tl3E1+MacUfm8S0k5nj97+RGSRRjtf4fhZ8X
         8CPZsTHtTUpgCHEYZxDeAxfmEvbNFJgThPiKZBqN8U7G7wX3Ce95xhnSEhYMffgCdCzz
         7NPQ==
X-Gm-Message-State: AOJu0Yzcb1YABMvwUPklVvcAutPODsNTpXydQ53iS3IAnzNLxWlKz3JF
	IYq4XxP+soACVmqaLzFGhHWCVig0F4PKCtfcDsM6cooUsUe/k8dggipUE3vZ
X-Google-Smtp-Source: AGHT+IGHhwL6s6MTZ42Stw51C5lpkfoQvEgV8I39Eus+EnUE7maLSsr/V4hw1+ly0dOZb7k+gmSaSg==
X-Received: by 2002:a05:6000:e88:b0:37d:4f1b:359 with SMTP id ffacd0b85a97d-38061220a5emr5560837f8f.53.1730077193614;
        Sun, 27 Oct 2024 17:59:53 -0700 (PDT)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb625810bsm2706532a12.14.2024.10.27.17.59.51
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2024 17:59:52 -0700 (PDT)
From: Kelly Hall <ronaldwilliams4r@gmail.com>
X-Google-Original-From: Kelly Hall <info@gmail.com>
Message-ID: <4207adfb4c2f9546551d89aba6b938b50b6a7cad4ec0e75bb269b6801e11a8d1@mx.google.com>
Reply-To: khallpb@outlook.com
To: linux-fbdev@vger.kernel.org
Subject: Free Piano
Date: Sun, 27 Oct 2024 17:59:46 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello Dear,

I am giving away my late husband's Yamaha Piano to any instrument lover. Kindly let me know if you are interested or have someone who will be interested in the instrument.

Thank you,
K.Hall
