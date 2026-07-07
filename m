Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8C416122
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Jul 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430906; cv=pass; b=WTTGlmQxph1DTULe363EdW7kidIshwPzyldhFO5ixoX2eY4reoRo7NiiOcpQdkJCLq8v61IMOdX5nMWS5u3PE/SlVoHLCCG2W1wBRS0gu8IDK5411TVgd0y0n1SoazeSZCdBxk7Txr/Q+7+S87QB2SeyX7TxPcjN19jXDy9KNMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430906; c=relaxed/simple;
	bh=20IqqGBnVvGjIfSi3DFJXqNEQAaNfil+bS+MiKOJZhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/p6nWA6nqzQq3fda+/tIwqs/RHPRm42/gJXZtlqwJAWNzkUokU4jH4unYciGhiPDu2y+A6YG2gqG5nRfK//sfGYlaRfExwY7hExGQSbQyMADzXucg0FXzKZ9C7l1t1whxeDTDdoE9qmS94aCjd+bmgLEu32IKbw5nHK9nzFYEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvh1q05a; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvh1q05a"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-738f3419eedso996076137.3
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Jul 2026 06:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783430904; cv=none;
        d=google.com; s=arc-20260327;
        b=Zpd+awaXUiI5WbQ/ZgfscmCfxVfMVj+1DkCx8AwBJAF2JGx+jWpU9p5RPib2GxdtV6
         NuufAuIxK+mnTryArg/BoIPr/cyeNLGrnC1rCdEOaC95oKxlumpV2cOHLnfJLTfy6/D9
         hLQ6VgpEgXh4ScqVjQc3Lf5AnRmd1/rmeSpqFcqT0qfsuCTRVnL0PQ/WrdtzNxp6SLh8
         DH+k6dWsJRv1Oyr/6a9jeX5Fd07WXaSjj3VghgbGSN9fJNHX+5KZm1t7cRZroqCC3Wwf
         k3QF81xHuI2XpWEht5YISHxs9YuK2KFSeeDbCnfMP9zVrJdzBlCfVwp18z6qVsYgNqAF
         cJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cOGlQ0ru/oNUpQ0lA6d/gMFDYWSl8uOsn6usqjQw688=;
        fh=En2a97SyuneQuVCZoxIKW8eBSQd0m9rRMJsHMcZFoIQ=;
        b=MIAdavhiCPOZiXWVG4YjbpQxXUj6AUEmy3QclKCcY+dkylDqJTPkHmosMr70VjhbAO
         VsWUrpaI0NvqrMjM4jVxlO7Tp5zA/VEVnlQdjWS+MeurS1QrXA8U9xLiEeKsgfRKdFRC
         ViRKIPhdxdkOVrH+hLfzs+tJK/f+DBSNsm0zeZOubFsjCgIvlEDuSw7rtSI/TPmu5/1F
         ZTtqImgrF3zmDoAZx7e6QY7EWKrZvB85M0PiDAoPR1078QPvDXJ7ub4MIX8a9pfGFOCs
         UPhgvYJb7sb0SA/xihtPye0e0j2yAM3wYe4KNQ/TM472lPpPHTWUnOHniuwzydeLW7AS
         njpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783430904; x=1784035704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOGlQ0ru/oNUpQ0lA6d/gMFDYWSl8uOsn6usqjQw688=;
        b=pvh1q05axVekA37O1ZpgKm2UqworHGf2njOyRwEtocaKTI9ZgSTEYZBb1RtUWRJARn
         1Dr4Mf9LQK5xZsKROSn/Ye9KehRL9/hLZr9tJ7rFjU3yEkfSAC8CJNZRCZkKcVsJhISU
         uZ2hLpi8dy+PklHtw7zRwlMddT3zIP9I1Yl/LTAyff0MdV9KEmARV52zdk7cKnCS/AQv
         2BZFwCycWboY/EOECDteeUOw3CzCSDWCCac98wuAfBYJpcxEYoo3+2uSWilR+yTHkWSJ
         XFZUr6c2NmNG8G/MmfMusJZthbOS1pNVlDTAsGUsKuYtFafHYvthEH+UG32I3PfFmUtV
         mgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783430904; x=1784035704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cOGlQ0ru/oNUpQ0lA6d/gMFDYWSl8uOsn6usqjQw688=;
        b=bfZV0neQhIjkajhYzlLlAUEu6o1yTK4Ta4fHDWvAIBuuqZwxBGCSduHzDWRs8y+Cuw
         uyFJKaFWw9sy1kj8lm8Uxyh0gCJHyjhcXPSP/CHy4l04zERwx2HjOO1rXsJlZOl091V2
         FTGU1vR2GAif1K+iLq5IfKYYLenQhWD8+Z0lYPM5KghprufzX8mjHiw9x3GhH8nFZt+o
         QYyVVDfdpRw7zqI/GBfKEezfc5Mud6ME6dorkFJ07/gncJroymAyIHr4/dFBPenli9ul
         Kn7ssPqvNtaZPO0/iM3gLXjsXv22f/k5MqunEalbPD2P98ls13Z1hDxfbadloDA5PoZw
         XdBA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6VMkHr8m7kXPJWHtSox3wFHr638dFQnOvrf3Of+pr8R4zLMB/MQ/Saw2lyKPR2L3/koGwhj8iT5+oZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPVG7Dyuqn1z+eUSAvO6vodgTZDvz1VSXd7MdOkPDNYsWi7f6
	bPUpEyHaWG79KvzNVvII7+ALnqINVED8PTF80IrVIEPMfY+voi0eP+6czUMFG4VMx+s6yze8ntg
	/EaOS4IOnjwDTCEK4sZ7tzRvGSPTOY5I=
X-Gm-Gg: AfdE7clIJpKtoLmu+pnVZ6SiGJmaKK3k6qOL3XNDMSNQF9AJisn/whafdPEnXgpOqNR
	1XUDt5lPs+O4z/TAoQF5g1pWz4b9xJSvYXQHVF3Twh10EyCMsw3Q05uSgT5L5BeUrBfAkKQYJ76
	UDcL4n62Rvqp2rywAkxkf2LZiN5gyvv/uJwgoUTi25P/19goZZS9QBqjNqmwf12Ecqm9Vtji0Fy
	38PpQdGwQAEKDrRWzeOOfkrKU58VSE6EqIwks18zj37SswExy2XoeaXJD0794hN/3c4s/Ey9W+y
	pRgoshNR
X-Received: by 2002:a05:6102:440c:b0:739:77a7:90bd with SMTP id
 ada2fe7eead31-744b7eaa2d9mr2663891137.26.1783430903719; Tue, 07 Jul 2026
 06:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026070710-exact-unveiling-e321@gregkh> <20260707131529.38340-1-andrem.33333@gmail.com>
In-Reply-To: <20260707131529.38340-1-andrem.33333@gmail.com>
From: Andre Moreira <andrem.33333@gmail.com>
Date: Tue, 7 Jul 2026 10:28:11 -0300
X-Gm-Features: AVVi8CctDRCOTX5qGqEfPyxWGD9YLPcZTNP47ks-LFrtZ_mPqmuPeYfvt0Nxn9w
Message-ID: <CACO0qFLD_7BiG_Dfy8x_SQLRHiGMejPmwGLFCWjTZZmc6h1Ovg@mail.gmail.com>
Subject: Re: [PATCH v4] staging: sm750fb: rename variables to comply with
 kernel style
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard this v4 patch.

Upon closer inspection, the 'init_status' struct has been completely
removed from the driver by a previous upstream commit, making this
cleanup obsolete. Sorry for the noise.


Em ter., 7 de jul. de 2026 =C3=A0s 10:17, Andr=C3=A9 Moreira
<andrem.33333@gmail.com> escreveu:
>
> Rename 'setAllEngOff' to 'set_all_eng_off' within the 'init_status'
> struct to avoid CamelCase and comply with the Linux kernel coding style.
>
> Signed-off-by: Andr=C3=A9 Moreira <andrem.33333@gmail.com>
> ---
> v4:
>   - Drop register renames 'pvReg' to 'regs' as they were merged via anoth=
er upstream patch.
>   - Keep only the 'init_status' CamelCase cleanup.
>
> drivers/staging/sm750fb/sm750.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm=
750.h
> index 0324778768cbc..3a1bd38ab347a 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -39,6 +39,15 @@ enum sm750_path {
>         sm750_pnc =3D 3,  /* panel and crt */
>  };
>
> +struct init_status {
> +       ushort power_mode;
> +       /* below three clocks are in unit of MHZ*/
> +       ushort chip_clk;
> +       ushort mem_clk;
> +       ushort master_clk;
> +       ushort set_all_eng_off;
> +       ushort reset_memory;
> +};
>
>  struct lynx_accel {
>         /* base virtual address of DPR registers */
> --
> 2.43.0
>
