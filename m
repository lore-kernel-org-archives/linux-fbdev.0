Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862092C234A
	for <linux-fbdev@vger.kernel.org>; Thu, 23 Apr 2026 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951778; cv=none; b=Vi1ZZNSTiWycq5Gjf4wCIGnf6KMCaG5kuCeC4Bx+I01qjSjTua6fXTBpTwwHzAJ0pvVoc8fX73eKPHwxq2EOJgTpLEj/Uu9UAC4HzUqpy5o++b16C/Oo9M3ydmKIGXg4z5ST3WVlq3YJpLf2yTAHMDVsDKJfJzZ7Gv8/CaIQ6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951778; c=relaxed/simple;
	bh=KGQTxPk6oMxh7QPY8apsl1ZPfxrpG+Y9tgOuHycUcB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhsjtHD2/Uo+k3et8C3iihtBhHjfOSTBG2sJJUSZOy4NWOjgYarEHW4u3M1FHz0YemnHdNMt0BKcAERPCZtVZt1knjtG9SOYPPvkYwvdVuVFKYVJqAma6egkYLcwkIg1B7LjDyno74npef+cG5apt9icVo5f9nKkrnkB7t9HZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpd8Ygq5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpd8Ygq5"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4411e1eba51so3279626f8f.3
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Apr 2026 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776951776; x=1777556576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rxz9NU02O++FzynrCeAoVbLT1PUkMktzynAKMZKwViY=;
        b=Gpd8Ygq5obG2Z1akpdvrfFFqTeSoIBLhCfYkoL06QquqMfR217bDObqppRdBMDbiwP
         ZxfmvG/X23is1vDfR6x4Ch7SbC27k8nfryk9/dgQJEDHAkHcO9DGTvqMdoFKHWoM9TKu
         dml5Z43g0zsza+cXdBoo37zr+7wvemZRNgPDckICgtfgK0LyCDvz4cOObUH2mVA7QXMJ
         vhX7PQii/JN28y9/gxy/LXnHoeK0IjQQ5QNBtm2ZE4c/cF9FgpA3u585v1z1F0roKkW0
         ZH8MQnb/l5jIZd2XmV+jMV+YZuqof0g9FmOV5i5szXNtx9s7P63EPhpQx1AJfBYY2Gr+
         q61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951776; x=1777556576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rxz9NU02O++FzynrCeAoVbLT1PUkMktzynAKMZKwViY=;
        b=W5tmGrOX/SpiTk6jjiXKa8sf5yI4N8l0Ya6SW1/nC8gZRSbLopnsFbdeq4DUEYPZSl
         kzp7lgRKkCOfspciDHlua0Ctjf7shvUyX8A2+FTB9fVtzWSBqmgbV1UdX1oJX4kplq/b
         p0OhA2+FV4Wald2HZOdycv+mKD4oOiRODp2Jeivk8KBHb0lx796lBdYrRdJ0N9dGl5DP
         nBP8yFKy9O7bZep/60eXTU007n9/4YkejjfQN4D8bXoH2oGdkoY+QXqKzb+epGHFnoVY
         jSEkzNUZVA7GOQ2afWtSSat/1EMp+nuPhPLOFfUAUP177g6j3N9Pw9fYC/vQrkC3eHGY
         z9lQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7j7T9G4Nj3SOzk3v7xsoBPLOjz4fj8Vz4vn7wwPkjFCtGEti4Koh42Yo0lMsPgj1NH/ZvDyX1sdFVEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4U4hNY0L+o0i8LtR391frwBfak3t5UUM+DjaFnlrPe4nUV/X/
	oaz4x8VVLSRTUQJcrdI954xkMm4lW968W/3FYp7nLZ3X4th1F7cx2CBN
X-Gm-Gg: AeBDievGNXx6CU6EgxDYwFZUiO0lU5fp/GPcYZgJMgYyOkg8AWhwGQ9hHFd2rXb7gVY
	YjSZ1RQq3UPHDN527raD+/Xem1gmZEvVRs2s+lj81kFoROBVSV7eaK1f/INePje64S2emF2PY5D
	3C5xw1RyLQvax/PKdMfUDsfVZCt7mThB0Pqbw3EMJwcVD6mtDJdH0xkQD0c9KaGXxP7jqz4uT+U
	IntMdnmh6bF19pLVK2kGvF4Hf77yzIKGrkV4ANOmqaj4MNGIglQQ5J7aNV2w301KxCmnFH6Y8RY
	/PlEiS7QhHJz9Kunwde0K+1HQqfbHmKfF1OZjQ+pzHNYkXOiFM6/3l4uIw8ViS3UbcGNbrAdRfv
	wqZBN1XFAuywDsG8D4uSxb6vqIiTQL9zj6XD+Eh2PzMlm8qPH08hQcflXU7GLBCVbXNvqbAqWTX
	zfbg2U9YZIZxjNCJkT7zQOUiY554Uu6XorxPgnMo+Y
X-Received: by 2002:a05:6000:2888:b0:43d:7b23:bc99 with SMTP id ffacd0b85a97d-43fe3dc8152mr43015263f8f.15.1776951775662;
        Thu, 23 Apr 2026 06:42:55 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e44f69sm55764812f8f.25.2026.04.23.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:42:55 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: geert@linux-m68k.org
Cc: amit.barzilai22@gmail.com,
	deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	thomas.zimmermann@suse.de
Subject: Re: [PATCH 0/3] fbdev: Request memory regions in platform drivers
Date: Thu, 23 Apr 2026 16:42:35 +0300
Message-ID: <20260423134235.230024-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAMuHMdWhpD5vjfzsYieVOrio0chQAU=s0z5rX8AKTon3S=v-OA@mail.gmail.com>
References: <CAMuHMdWhpD5vjfzsYieVOrio0chQAU=s0z5rX8AKTon3S=v-OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Geert,

> This file does not seem to exist?
> Was it hallucinated by Claude:claude-sonnet-4-6?

You are right, I apologize. The correct path is Documentation/gpu/todo.rst.
I will double-check all references before submitting next time.

> Have you tested this series?  I have to ask, because adding
> seemingly-innocent request_mem_region() calls without testing the
> result is a recurring source of broken drivers.

I cross-compiled cobalt_lcdfb against cobalt_defconfig (MIPS) and
clps711x-fb against clps711x_defconfig (ARM). Neither platform has a
QEMU machine available, so I was not able to do runtime testing.

I understand that is not ideal. The changes replace ioremap() with
devm_platform_get_and_ioremap_resource(), which is already widely used
across the tree and handles failure cleanly, but I can understand that 
compile-only testing is not a substitute for hardware validation on
resource-sensitive paths.

I have not been able to find a suitable runtime environment for either
platform. If you know of one, I have no problem validating these changes
properly before they go further.

Thanks,
Amit
