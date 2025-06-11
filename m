Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC6185920;
	Wed, 11 Jun 2025 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658333; cv=none; b=DAXY9vFKDylOTAsDw+7BaFGjdDMz2+e2fxbWArvAAW1b1GcfntXVRAnVC7SUm22vVBcZaWxxtq/UayHjCHj9ZqPmJpPSh0ZNjkgv8C4yANazJroLxj0in/aymf/4c8b13vhRPp4cApz13TJnNCYa2i8xHykOAT7R0fn5GcCZPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658333; c=relaxed/simple;
	bh=lel6KWnThfXW5zwACQgaKYQnlTF6ANQe3mMnf5Q4wUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OKgal8DwmrXwBCXguJb0cJQXLc1vz/Hdg32SV1PiU25+eEdPaJ7MQrdmrqSM6DuKAqjZNIVQ2OZtPuia1XljVfZvdevVT1q6WBcLOU66bCwuTV7GrGT7ZpJyhtccdW71HeKmSsgw/tC7AQ9fxfwmqPKCAOtO5syzXV/pj22kY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTaehJ/x; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTaehJ/x"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e81826d5b72so6632696276.3;
        Wed, 11 Jun 2025 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749658328; x=1750263128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lel6KWnThfXW5zwACQgaKYQnlTF6ANQe3mMnf5Q4wUs=;
        b=GTaehJ/xcvCdICqLK0Hy2AXZwA/eAdAnaURVW4bSARyacTohg3NAdFmhPS9wGsSlZh
         XxKcGiWV8Ggwl5uWA26aKzKZuNbPa/jo+Fu5kNqhMHBhA43pQTldvjLMW+0h3JI25ZAz
         C/SwVxnMVNUeN6MH04qdozyq/9gT9vv5XMY2XAYXOEHqzCFUWqQs4HaEeZcscs5M41cZ
         D3wGrDIkQi2v6P8HvspKPXS80CHK29bXTjfWk7ckpeLnlyolKhK6vv8uewnWweUg3b8q
         LS8S6hxJqLkIvfyHO6DxqeuRZFX8MqAJqqgdV6ROP2su9BQuBBH5q52PY2WRvEb/z9dE
         x99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749658328; x=1750263128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lel6KWnThfXW5zwACQgaKYQnlTF6ANQe3mMnf5Q4wUs=;
        b=YOeJFqOx2LlDUAPIniTpFghFFJOtMRiD3pKndDp/YdukMGsKfyIoM3g8LRE5frzaYx
         cjmJRqhZ71V/4MwOChQIOew6Eqg0GfoI4KGOszoSuQexguYZFT5eLUY2S+eGHL7pxwC/
         CD4VrZuX8/WMTbawFFj1Kr1nIMOH3fmkISJij447/udkXoKhECse+jDTldArpqKpX6wT
         aUTdNtvh0sKE0hhQ+L4x/xandf4eGC52WVGBdwlDiak8XHIdRjKCDydLj/+ZgRwKz/sV
         gHl+tUdz2U0kAdK3N9DvLIxz2pwNOVRITSEzVPVikW5Uuw9G/r+htqWw/EV+U09QSebY
         qzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdecroWnKiuaf3SnTQAXsz2w2otPa+fWw15HM8M4hlG3/2y1OhM3MY+L0Od0fgGD5wKcUmXDVyHSrH6A==@vger.kernel.org, AJvYcCWmtauJO051Oh9LmClqReo+XCrRZV8Ut9Cq3xI5RCITdhe/0K7fF0+L17uxN3tnSAD8Nz2/07vxUh7uCRVm@vger.kernel.org
X-Gm-Message-State: AOJu0YyTB726GfLx25nrykvaA0NmVR4B+KINBw4yOlWDYSEnd1ToH3Vu
	+efmGSg64iFs0/63IQNr3yg6C21EMIZbpn0iVE10JL/sa9pSgzlsdoMA
X-Gm-Gg: ASbGncvleQar+VyV4YALlKkeqFOmF3NK+iYny1c1qtZsfRwZ30nrW1w1zjuRXLssq7S
	vrZH0O3UDetyLzMbvvc/NB9g1122PHth+HvXGzQA4Mzav369JrItCcSDFOkMqGfZQmIbbLeYj7b
	R0RI/1jwviUG3nE5wU1r2PdpDOREfFkjiYumxwNTG/qKqCIaek/SYWrurSURSVe/Tq7CW/M3Vl3
	M/3gGjUvPZwJUkzLa8CTARO82ySzDJ1itqrBEKrZRWu0CMTG8lHvOhFJPCTYsONXbCwru3zz/0c
	12s7dwA8z3IhyS5MoiMCk6zZPoMXSRBCI/51/KF0wx2HeM/JSnKHngYtnxTftjx/WI1WifCjrG4
	EAyoCgcaO2QY=
X-Google-Smtp-Source: AGHT+IHw3jX341QHh9PMSkVnd8CwSMWalCeUuZZZCDXumNX2LqqM+bvwBjGn8YRcQyj9ycgeBdLTmA==
X-Received: by 2002:a05:6902:1690:b0:e81:abdb:5f91 with SMTP id 3f1490d57ef6-e820b6bc432mr168020276.25.1749658328427;
        Wed, 11 Jun 2025 09:12:08 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e81a40217a2sm3625106276.13.2025.06.11.09.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:12:08 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: geert@linux-m68k.org
Cc: alexguo1023@gmail.com,
	deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: pm3fb: Fix potential divide by zero
Date: Wed, 11 Jun 2025 12:12:07 -0400
Message-Id: <20250611161207.4031677-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAMuHMdW5wU1ForGOGD-+HDUu7wcnBx3jx911nLEqbJ71t4MBsg@mail.gmail.com>
References: <CAMuHMdW5wU1ForGOGD-+HDUu7wcnBx3jx911nLEqbJ71t4MBsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greet,

Thanks for your confirmation and suggestions.

I added this patch based on existing checks on var->pixclock in other drivers, such as savagefb_check_var, nvidiafb_check_var, etc.
Are you suggesting that it is better to replace an invalid value (var->pixclock == 0) with a default valid value, instead of returning -EINVAL? If so, could you advise what a suitable default value would be for this case?

Actually, I have found a few similar issues in other functions as well. I would like to make sure I am addressing them in the correct way.

Best,
Alex
