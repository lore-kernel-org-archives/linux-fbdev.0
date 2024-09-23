Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341582E419
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727132078; cv=none; b=ll2ErEsEqKe7AnY33ZRBFK/zs/jKuO7Cq2LvMXanmtZfutS2ebUpvgE9FNE5t+/OuTEQTsroDEPymaXhzbFBpXP+9qGj73jOv+OJOMwTw63eSpD2bDB2Cnr9E4TJ948QmhRzhlqK5ljJbXboRJ7WA07sAqPqLCvIZf5br5k/VOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727132078; c=relaxed/simple;
	bh=g/jzI/KyxN//eFCbYo0z9MLBROEAEJZWjDsoLKrMcpc=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=WbMQSWk4VJCk5lJqewr8oMRp0Dz0FjBxzkeyryL6+sV8bXU2cQiIFCzom8HhYzRiDYuTfZHf3FmaBUYJ1wMrtkC/axQgeMaYX5Ve2nPNLTGqtlVaLsbAyM9cQ5YT6HHc/AQIEqCQ68V3mK53H37ByHRasKeetaPUnpWLCBuc8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/Gdq8rv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/Gdq8rv"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71781f42f75so4561732b3a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727132076; x=1727736876; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTidrr6C6eVgIfFsaoNjyUeos11sgi4Nh6B5TkwURaE=;
        b=O/Gdq8rvbz0gVu1t+c+r+EDadEe55Rt/PcMfU/FWxS3hGzDpwO/JwyujAYpXNGD1il
         hsqFkfMTkGpUQXyBlBm8bFrMIEPALaNgJLPy/pQL36xPI+V7ev1Fu8sDclksUyXS+P37
         kKDn5bzD6FJYF0vLhAZdXc1nB43KQCyBPgkSVzPdzi61C/FP1R6uolyoMiBgMsipwfzE
         N5MxoNygCimdoqw8VF2ZZ9uzn6RF4envvGijNGGSnxxCWeSEYRwUWPLABwbEFLFK8Ufw
         iJz6A9j2wYXE6zLxiQZeE0zfcgWBdTKkky27vC+O6zNOQV5u5Cby6vDWio/PYQBzlPFz
         hUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727132076; x=1727736876;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTidrr6C6eVgIfFsaoNjyUeos11sgi4Nh6B5TkwURaE=;
        b=jjTBka7j0bi44TOoWKjBMvxZDywvB4/8ePDCCgDaydnjuH31h7SahquQBtkZecPgRi
         7/wKFN0MoA9EkqdXkIkP0biif1xr3JioHSkK5stYN8uL+/4wxwYHhz1sdyrxf+lmRNO7
         +7dREAdLKB7NAv8rvfFDkpJrpByfiLFtthswFmrOTL/1+Cgnf7oHUq0Jtc9raA5kFkBz
         D8B8Iptnz7lb795XUpig+tPIQ3isCJwjEi5z7h25cLZfWnIiwvLz3NBunk07Vg685ctv
         lAqXF/mPo6N8TT+k5oQe6RsdRQIWGrt+UCIDwNSw4lX0VocXEQNXcJ0xb3XtWUO9aPHr
         Tbjw==
X-Gm-Message-State: AOJu0YyWODE8jUcIx+uoEgqvLm76CeMvmJwtBGOogoQciHu9LrpQQfEE
	ijAcPMEIIchJn6xrwcYFPJtReKK0K9WXTUVwVRR+EIYw+E+ODapIdhpuSw==
X-Google-Smtp-Source: AGHT+IF4w1+Q/Igxoy/R3XoIK9ficxbZFQIp7e7x7oMWXdW+vZv15g13UTqJ8sNCBC6r4qqB+4ZX3g==
X-Received: by 2002:a05:6a20:d501:b0:1cf:4ad8:83bc with SMTP id adf61e73a8af0-1d30cb1cd39mr18762228637.31.1727132076168;
        Mon, 23 Sep 2024 15:54:36 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc93905dsm120588b3a.97.2024.09.23.15.54.35
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 15:54:35 -0700 (PDT)
From: "Van.  Co" <muffiekay@gmail.com>
X-Google-Original-From: "Van.  Co" <infodesk@mediasource.com>
Message-ID: <bc10549bee46df156358b07e6927ce24357b612f361cfce58c6dd645c544f87a@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-fbdev@vger.kernel.org
Subject: Sept 23 2024
Date: Mon, 23 Sep 2024 18:54:32 -0400
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Good day,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.

