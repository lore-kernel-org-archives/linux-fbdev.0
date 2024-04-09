Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1B12FB38
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Apr 2024 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680758; cv=none; b=om10fxiwGZ2g/gPtEB6zCNKZG7+MS2jZxB2px2HH+3DQeCmq6HPY44sYXaU4IWUK4qky6szoty2pt6Zlksu1slgAkyc3sxuN3ndE6R6O7WK/TiDBd5cc/ro/UgMDsQyKfg9PKASMwcdGedW3v2I6i1t918RSkFSbiDwgnkCwLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680758; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=hV44phx8svtVt5ouAudKwfvQ24atYBCOjvKhDZ6cbCWvEtxkRXyCAKjhs8FAdq5sJN6B6yRcvfXjhdXjAvPYQi9bdSkgq9e/nQ7ADiXB6Boj19KRGjBxtoxI3yGqIGrSGEaBox720R9y4aA94yYWxNLNLZa+9kQy9zvNAIR72uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg/sl78H; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg/sl78H"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea243406f0so414527a34.2
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Apr 2024 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712680756; x=1713285556; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Kg/sl78H1vJFFtkVrIn5IbBDflfdQUrhtprIjLaLxOVD28FEmAkOIwZghL6vaTaCBO
         vds6lRIC5Ph3f10FYp3a+jpN2qnd7Z2+OPLN1QfWYpFMtd6rL2H6jIn2HlH28j9+f+Vk
         9IFi9jQPxL6hoQJ9baiQf4hM5kitp8lGIy0YRsRGI3jCZ9l/aWHVMLfQTRpMVMsdS332
         +3J587sqe6tuoAYMxHbUyM5zerxvrxv4XhXK6baS5/Ib1HzddkPJbh3RwwhZzo6VlPNE
         W2ftFH7HvtMYDnRKqq9WUR6766oY/E4t2GjrUZZLteh1vvuPdaa1mz0Bms4MkzktjpRd
         trnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680756; x=1713285556;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=GmJXYCqidHgkyUwuBE3h91/t44WdylxKzmDTqe509R+Jqm65zqsg6ghAhmYmqMXtJM
         aHCO3LaaVV+HYjHk5h/owTsRjswmLCdT9Vocp7fjFWpJI6kETS6Z4yh0eS/8wdc/4nm5
         SuSdKb9KZxz/YrgVL7Fof4IV37eV+VtDYpYcocaL55mycQkHquj2U92ak/X+74FWfbcq
         ZvZr8ej43qqJpKHPs11ofPQlwzhyyd4L8P1DWuBArVAxbA+AHP1cUvr4m0x/Iz/4Jjrz
         /DTVQaV47xWy0w8YQSji0YbCHYpeVQbXSC2QwtKJ0HgNrrCeBidAOaSiQ86cxQcp96Gt
         L86w==
X-Forwarded-Encrypted: i=1; AJvYcCWvt2nFjp6/QMwoq0E6EIlHjEIg1c/I6qIeg4GuM3kv9czD342IvjwkHY0YAfy35ZOydi9IyIBb60di+Hw+TlJptj0V3FKV+9tGsNo=
X-Gm-Message-State: AOJu0YwVv0Mnc7jclCdn4/FRmS8qgNiwdTsrV5MJtqjDxr5pgXyMYvKM
	D+k/R/mCxkK5p72+zPid7oIPNiTCRIeAMlvuBgkW48e7EGN317yJdaDPEuYRVwZwVtgIX58=
X-Google-Smtp-Source: AGHT+IGJ5lNrHVrSwjpXPTtHBITp8Ar+HPnfk7p7X7Bx+D51y+T47ROSf82PBpkVELv/QS3b8b7J4w==
X-Received: by 2002:a9d:734c:0:b0:6ea:1e87:4389 with SMTP id l12-20020a9d734c000000b006ea1e874389mr363607otk.8.1712680755955;
        Tue, 09 Apr 2024 09:39:15 -0700 (PDT)
Received: from smtpclient.apple ([172.93.220.120])
        by smtp.gmail.com with ESMTPSA id g4-20020a633744000000b005f05b06229dsm8481034pgn.41.2024.04.09.09.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 09:39:15 -0700 (PDT)
From: purofle <purofle@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] staging: fbtft: fb_st7789v: support setting offset
Message-Id: <6012A476-14B0-4910-8DDB-98BE0BFC9074@gmail.com>
Date: Wed, 10 Apr 2024 00:39:10 +0800
Cc: dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev,
 purofle@gmail.com
To: gregkh@linuxfoundation.org
X-Mailer: Apple Mail (2.3774.500.171.1.1)

