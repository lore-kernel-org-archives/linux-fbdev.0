Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68FE3F39FB
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960766; cv=none; b=P8FVM9DIFNBls/qSMpcnCbtAGJnb2mHu3sW9GxP0c68AFaLTj7DnmkTdXlOSRTgYUiRCkkH118TPEt4RyoAVq3GJ8UwukEB+4hWqeCyh3CXU9IxIiGf0L0ajDD4YHwcqWxO2kO95nMp+10OKqXki9y3mV0sx00khTDRqB5B9Md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960766; c=relaxed/simple;
	bh=CBhBOxKW9DXkHE6Vdw9XCfb+WTJBsS8SlILHHvnc8TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDW/6UT3Z5sjmSJzo8jUgmNBkO/NmtU1GBM5UggDiVKCqg6DxIGaaNIXVfVK0YheVGck5p3h91H966UglARTHl7CEzM3AViUcDirC56Kv3a2rcJxjhySksMGQFSxe3mwcm6qbFUYSeBq1YpCggaeenn7EIqUuWdfafv8sHzQyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r58tA3a5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r58tA3a5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495590dde14so39800255e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786960753; x=1787565553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n63sUKQMdSKf2IRWefDfMPcW8wjg+n1z3lYjhlrIgr4=;
        b=r58tA3a5JpXgezjaC1WENgcDK/zZhZPyZZq/kRqG8yfvp+6KVaGI+rQyx7k8pDDJhx
         5OPgbeqf68/fkhNYOHToyU9UaRmS0LSSd84D9fkKV9v9rtEHnzugLEvDstrPfQBbgmW9
         AXtKb4P01885viv3qCujfxuQR7Pa16eDUZfEiuOb1ERALdHnyUZsB+tEhyNCdJhxawcB
         /0HUsE1fs5fUhFGEEqfC175+yLKsITkopCrG4VtB0d2KohKsC8zv8JZ6B6n+gegcac83
         OeDHwtq7+onVRpDqcWgGqt6vOaz63uwzhRteI7fxokuruEl6qduZ6xGe6Qko0eyngd8f
         CjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786960753; x=1787565553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n63sUKQMdSKf2IRWefDfMPcW8wjg+n1z3lYjhlrIgr4=;
        b=Rt/9J8Iyl3e10wVCDvXe3zhZBxrqRTs74G09lOI5V3g1p87XXIwWQH1Gw/D5zhKPaA
         IrovAL1I7N1UYcSaEtJPqvVXQPvbsE3pgNwEkyINdRo8J5Ymm6FeJIfrL32fkT/W5hza
         W/p05F0uWbxlbWgvML2XfQ3RZnT6P0yd434mryNi+G+oqRBp0voPBkHjIpzi8Qo+YWY/
         PCfymIBeGqA/9qoSc/GjdPPTRJKMOGkNPiR1Uh2D4zLXNa7GLNDcoUHcIJkYSU148W+W
         mT7ivtnR5ea2cQYfmymJ/WLv4rP6gObBHo5b8ViGLI35kegxFbyGcNfBeMh8dpz0+0HK
         4Nug==
X-Forwarded-Encrypted: i=1; AHgh+RpuFHQA7wOCu7/GmeVZFhk9NVQLKBfys6cc5jCpTSKXLSBUPfl8ztoKnlUkHdyDMWhOpmbXvJLLXBVYZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhygnz4TGZviwqCq/96LAlhdnQPZlefAjGjjkvPx9h7miDYA7F
	ReTxuo992DB5E0BJHy+m8cao9t0+6KEGncKpsAbyeyK0+sLM4s5NQc/a
X-Gm-Gg: AR+sD11XWdyuU9j9PsloMU9gPfofZo8yqgaMhtaujGeBADDteJdJJXPxS3s0iFmJOUr
	PmFcyfWgaLj0bTD+7+qI4bBfd4LVcxhx6g7VhwJkZ8B1Jlj/OwMc1kPcwJWNAeaEwFDpq7JOesL
	GUmnJXDgalXwQtIvp82q4Wub8LbvBuNL0+HvVK6ljR6Te5AT0eRKgWA+SCr12DEbOehmmKZ6/7s
	NAUOzoKKNAQSUJzVw0QYqj0UrKmaOGaPvtLB38Fec+p6El2zEUJjFqdaDq9jQAmsq/wBHsUWhep
	OkWEkM+3iM0JndbrdOX6DwcBRVCWHymXA+OlkxrLh0iefNiWj+w3ADXjoO5YCAtJXA79ltDyRsU
	9+J9Y3xA/v1/OdRG4E3YJsYG5gpEY3VvQxF+Rr23BQyvEXt18af+sInD/QfBKJ44+5ZAp8vmk6v
	KrI4uvxI9q1AYk6KwSaQAwb6bLh2M2g8K2om5v8vMF536Ne5nG+Ev80AO7XA==
X-Received: by 2002:a05:600c:500d:b0:499:86f5:9e33 with SMTP id 5b1f17b1804b1-499879bc10emr392118895e9.18.1786960753464;
        Mon, 17 Aug 2026 02:59:13 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:9cf4:43df:e612:817b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm2863663f8f.32.2026.08.17.02.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:59:12 -0700 (PDT)
Date: Mon, 17 Aug 2026 12:59:09 +0300
From: Dan Carpenter <error27@gmail.com>
To: moonafterrain@outlook.com
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: do not program the PLL from an
 uninitialized value
Message-ID: <aoLbbZ--FrkVN3SU@stanley.mountain>
References: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com>

On Mon, Aug 17, 2026 at 05:13:53PM +0800, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> sm750_calc_pll_value() writes pll->M, N, OD and POD only when its search
> loop finds a divider combination with 0 < M < 256, and returns 0 when
> there is none. ddk750_set_mode_timing() discards that return value and
> calls program_mode_registers() regardless, so sm750_format_pll_reg()
> reads the four members uninitialized and pokes them into PANEL_PLL_CTRL
> or CRT_PLL_CTRL. Nothing bounds var->pixclock on the way in, so a mode
> set can ask for a clock the loop cannot represent.
> 
> Consume the return value and reject the mode; hw_sm750_crtc_set_mode()
> already propagates a non-zero return. Initialize the structure as well:
> sm750_calc_pll_value() returns early for SM750LE without writing the
> members, and returns non-zero on that path.
> 
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---

Greg is not taking AI patches unless they can be tested.
https://lore.kernel.org/all/2026080354-skater-urgent-31b2@gregkh/

I kind of hate AI commit messages...  They are so verbose, confident
and reasonable sounding.  But they don't answer any of the real
questions I want to know.  How did Yuhao Jiang find this bug?  What
did the symptoms look like to a user?  Are there ways we could
improve our QC process to prevent this sort of bug in the future?

Probably the answer is that the bug was detected with AI and we
have no idea what the symptoms look like.  Everyone sane automatically
initializes variables to zero so probably there are no symptoms.

So the problem is that the user inputs invalid var->pixclock, and
it leads to an uninitialized variable usage.  This patch addresses
it by initializing he variable to zero and checking if
sm750_calc_pll_value() returns an error code.  Either approach on
its own would would fix the problem, hopefully right?  So it's a belt
and suspenders approach.  But isn't the real solution to reject
invalid pixclocks in lynxfb_ops_check_var()?

We're not going to apply this patch because it hasn't been tested.
Probably we should invent a new tag so we can create a TODO list
of rejected AI patches.

KTODO: investigate unintialized variables in sm750fb found by AI

regards,
dan carpenter

