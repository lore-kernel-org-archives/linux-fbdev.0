Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0230800
	for <linux-fbdev@vger.kernel.org>; Mon, 19 May 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747620328; cv=none; b=QMlODFuipZig/lKnCc6xdXLG5B/UzpTPk8RdNy+BM0XyGxJzhkr8zUVX5S2DynTrVSz5jTXne5B9JUFm8rkDfOqRSXG0bamN8W5L/wHxNDn69BtpSTK3zrbMIu7Uqi1A+hXeGDUliK7yyy4YmJ9aWQU1W6UUo59pREpudrqmk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747620328; c=relaxed/simple;
	bh=g9TCDvkL7vdglguYr9J2B8LFxxhkUXoRYKW+v+UkYHQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZS+Ohml/qPz6HgXmphhq5c6UTfZMGblgksIm+kUOPcTkBuOwCk3s4Kd6mIS1WZpBMNQdilGahr+fmkQGh11ITV6OuOMK1dwXppZiYPzi6gNM6QwF2uZqUuNmjBzVve3OkhG1fj0rm6bQmJmkSQjTzHtVIGwpA1EfM9hj+dJEjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gn+fJmjK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gn+fJmjK"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e9b2e7a34so1413517a91.0
        for <linux-fbdev@vger.kernel.org>; Sun, 18 May 2025 19:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747620326; x=1748225126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k4noPrc0+PmWjnqoGI34UlcvKKumIdg5SuK7l2WcSpc=;
        b=Gn+fJmjKuXq5ylnkSu6abgTlBwZcxUSpmMr3u9uXgJr7flyK+lb117MbwuZGPSPYrp
         tQKtWF2bU+qXecI56izsI8wh6jTGvOFoPLUgawLhp9MP5T3zSgZCVMX4g0wBVYEZpn+X
         ShrHK9y/GpD+nacwxm9lmvAfzxeE8F+En/ZDDIEDIuWTqQF9fGZVBGp9KyM/SkyotDEu
         LeqdTvGB4Fn0dg4xCFDGulYEqmrXiUusm37Zal4J+i0OHz3UYXImWsQ7jWPgpqpdp+xM
         wu8qH6vxT5dPtQudKcvjBOKeTMqOFCZ9v6fjy864NswZV61brPEbXh/gXCpz2j77PQb1
         qwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747620326; x=1748225126;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4noPrc0+PmWjnqoGI34UlcvKKumIdg5SuK7l2WcSpc=;
        b=lh7nwsC3gJECf/qrKQB6Fn/qt1jsM5D46y62tCBUvcvVHEPItvJU9Lgff0Rcz7hjgB
         UblXBAEVZDhzOfvI3kboe8CJNWp3ktWqq0xyCBTg2U3xOvChEgCtzb+kPiRe2Q37g+2J
         bd016rkQ7oOND6cIbwkFFSOWb2wgmrDi2onQ4ZfF8xdK7s7ZyK2M1xpPPuAvw+/aHng0
         iKQDg51FavoFdsotPYzJTS571VU1gLFLjjm7ugg5EHec7uix6AjT1e6ZXRBA5lAsuxb3
         n1LRx3UlWNMt6O7T7B7lrAP2prCYVGXy4w/EdjDUuaB1NX4Smpy0wjxI3kKG1dZdEVNt
         N7Og==
X-Forwarded-Encrypted: i=1; AJvYcCW8MTXEG6gg3OlIB+nYW/DdchcuF57dXG8RTR9jA5fWNqQJazp6PtHxvWTtU85JBFPVoVHFDbVhR9Di2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KRq+sOM7aubOLoIUWfwIEiscROMr8HgpdOK5TQC7QRUDMr+Y
	ALT3TteSrZ/Z0kAmrCrosBnWFBPP7vZXcFMXxKGcZh8mSsf0a22G7h99jgWOsU0s9Ua3uwzSElM
	1F7aY8DQ3JqElkKvCCOfIpA==
X-Google-Smtp-Source: AGHT+IGbCZYYy+GBc+rke7WozoS3ZvUtccE9nDq5UAt3ravq7+I3UfQ2ippF4HNUX0ce/AnnRjAOKvEGxBtdeP1q
X-Received: from pja16.prod.google.com ([2002:a17:90b:5490:b0:30a:3021:c1af])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d445:b0:30e:a1ec:68dd with SMTP id 98e67ed59e1d1-30ea1ec68e8mr12033666a91.8.1747620326231;
 Sun, 18 May 2025 19:05:26 -0700 (PDT)
Date: Sun, 18 May 2025 19:04:43 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <cover.1747619816.git.ericflorin@google.com>
Subject: [PATCH 0/9] staging: sm750fb: Rename function headers in `sm750.h`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

This set of patches renames function headers declared in
`drivers/staging/sm750fb/sm750.h` to conform with kernel style
guidelines as reported by checkpatch.pl

PATCH #1: Rename `hw_sm750_initAccel` to `hw_sm750_init_accel`
PATCH #2: Rename `hw_sm750_deWait` to `hw_sm750_de_wait`
PATCH #3: Rename `hw_sm750le_deWait` to `hw_sm750le_de_wait`
PATCH #4: Rename `hw_sm750_output_setMode` to `hw_sm750_output_set_mode`
PATCH #5: Rename `hw_sm750_crtc_checkMode` to `hw_sm750_crtc_check_mode`
PATCH #6: Rename `hw_sm750_crtc_setMode` to `hw_sm750_crtc_set_mode`
PATCH #7: Rename `hw_sm750_setColReg` to `hw_sm750_set_col_reg`
PATCH #8: Rename `hw_sm750_setBLANK` to `hw_sm750_set_blank`
PATCH #9: Rename `hw_sm750le_setBLANK` to `hw_sm750le_set_blank`

Eric Florin (9):
  staging: sm750fb: rename `hw_sm750_initAccel`
  staging: sm750fb: rename `hw_sm750_deWait`
  staging: sm750fb: rename `hw_sm750le_deWait`
  staging: sm750fb: rename `hw_sm750_output_setMode`
  staging: sm750fb: rename `hw_sm750_crtc_checkMode`
  staging: sm750fb: rename `hw_sm750_crtc_setMode`
  staging: sm750fb: rename `hw_sm750_setColReg`
  staging: sm750fb: rename `hw_sm750_setBLANK`
  staging: sm750fb: rename `hw_sm750le_setBLANK`

 drivers/staging/sm750fb/sm750.c    | 12 +++++------
 drivers/staging/sm750fb/sm750.h    | 30 ++++++++++++++--------------
 drivers/staging/sm750fb/sm750_hw.c | 32 +++++++++++++++---------------
 3 files changed, 37 insertions(+), 37 deletions(-)

-- 
2.49.0.1112.g889b7c5bd8-goog

