Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F13016E0
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jun 2026 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898878; cv=pass; b=ravrd84nxoZAm3jwUxHZExXSqJCfwoQm03Su8MyN4Fe2BecEVijvu80qT9XudN4ho4EP8gBaXY0eFVCD56wNqQEaUVckuv0I8Xdev7xqN1z3Xp+mQjHrAKn/HteY9W7G82LJU95HWRR2CypoU3ZoqQ6C7g89z0S+1/6h0wUCOII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898878; c=relaxed/simple;
	bh=aQx1aBx3pJAjf7b+AK6aN2nd9CeKmSYl8X/XBRVssB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXoHjbu7jVfaggfSO/Q4n6hFSgE64Etx/JxtGv6Gdpw8yggMaC5cWZRmEeZFSTOOw5iq0FU/Rtj7OUfdnrVoroxSfzzgFfO82C2qwZcKsxk9Txz9wTo8dg3SsGV6NScFhE/RKnZ/mSPq1Kj/oWg89/Q0h24Rpkuf7RscAVqBjhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EktuT57U; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EktuT57U"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6912f4acca4so3616181a12.1
        for <linux-fbdev@vger.kernel.org>; Sun, 07 Jun 2026 23:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780898876; cv=none;
        d=google.com; s=arc-20240605;
        b=W3MsHFLS+abB3gRS4EhC7ISCZcOtXtIf5nm6SiHePwdIT6wYLqhr6grmSF/5Q3g8KI
         1fvLsnSkG4CO0m36BCgebWLAJ2Jx2gvVkipv6vsyx6UNWlHeeVVadj42wHoo0wPsAFmO
         SRSJi8wWsB7PUtZBkR+HhOnXd4BUn2LLW5H3agOkuWWjEwG8gEOQRCUhKfUuckmmCKot
         fW5Sq9ibBcs/hXp4BynPxyt9iLI8PvLrJnFv5Pg2HqSUWmnW2/WWZ5BhqldvGsgMMBMg
         ne6RoPdzmVtVl7Z736lc9IyPYyuKCIRyqEvklzkOasVBwBYb6fRgxHWMnxPN2vhQiSqY
         rMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aQx1aBx3pJAjf7b+AK6aN2nd9CeKmSYl8X/XBRVssB8=;
        fh=DpVtPqYZ1ERwNFzSabns4AtLox/JMYzgjChk9232fT4=;
        b=khJaPjy3pxCWIGIXyruhztI+b3Slw9w1dlh0pWLxthUdA3j6EuQcIrDnBmpqEaql6S
         s9e3k6KiiiRVqgYerdNYMlWf5I5saM/ny7UFmOHtGi4gOgWnZavvSQz1OsV9/lHTYj4D
         Xz+2D/41QMZAIYxSpFS1C9X0vPSJj+Oq8W7MRvoM77X241SBNAcvSWleczvb33cJEqMJ
         qLuua13ehbgRcJQ5I7Ij3gJUfwBdqPJgDzmJarCUqQky3PHzQsP1DIGIzZanZ7sFzB3G
         7EiXO181SggQZr3m/8JBNFznveVSxxqC9cE5T1LSLndqJeGuFThhhbT6Ud+WFc7/n46/
         fMLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780898876; x=1781503676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQx1aBx3pJAjf7b+AK6aN2nd9CeKmSYl8X/XBRVssB8=;
        b=EktuT57UrHDF56mV/UyEJkZ9yA8K+zTm2SG54EBfm4IxmDm1lBBjbbIjNGQz2WbVrG
         DGM0j5z8DJXpKX5sgOUnOJVBKAGZKGyZVZ8p7gOKTUM+TDYrT99vJz49oGX+3QHVMnsR
         s2839hL+0Qh13NZbXcq8RJD9xnr94NoQgM/f8VIdHQrgs1rKFPeTFDLQ1eYqGmmdhzfv
         kd3Tpfzk4lNdO9vf6ihO6N7hCtePvj3lU7sNnzpCSMiYamgMUOOG9b6+ENQ2l3yQSnhQ
         sh+AHyzLrLK9yFekf0LEGTLDUgRwy8AkW1xSmIfeBTNsenMyaf6tgEcI3c6xBlatGvvY
         421w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780898876; x=1781503676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQx1aBx3pJAjf7b+AK6aN2nd9CeKmSYl8X/XBRVssB8=;
        b=FYkBnuIFARSlM8l9ikl11U1W9CvWpsUte98ad+1b8Zai3oGVXJ2mR8h2eh1uhd+3Ih
         2sOjiP+dbO6tTPDWXg5uBnnkGTD6zGc14vku+h9ZQVgm6eMlvv6xMsC2PdNqpXDuMK9U
         guic/StXgtAgC8zAa1xSohhhXOWGFxEX1UVnCit6TLEh5PXDn5aiL2k4Rn0jMLNpF5iZ
         GWmai5qtW8AI5Rdwksxttph05LdFwpeJG+aptUGRPybUZka39CHTLITyI++LW4d6hjvi
         BuEvBtZ5aKK1uAQlYi13596m4/K2QVKuBfN76qxaFVrz1wjGCgW0+77STgPYdRD2hsSz
         Yjog==
X-Forwarded-Encrypted: i=1; AFNElJ8mOO6JgRYLxtlSUJK4mIQ9VMNtmozIbpmzJMLe/47+L3ig3GbYhWBXYf/SeIaCYvFjYGouiOLwTjUrDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtoNfPOHEoCX4mqA2TAQuGHMD0R8MxA9NrfXfoJvX7VzjTmkT
	/bjqRyjj81Efr+r3aJFQXnjddVSHKYweMapXPM5rWNGOfqDpeCrjiBrmPwmT3uDvlNUSYOeTMTY
	KfgzJV4ivs3jmP307VE69LgnSg9xltpQ=
X-Gm-Gg: Acq92OGLd49YxCrzzxzC+TWkzHXo/e1Lv74YN+NRTswJPggB+D90Zf0FtsIJo4lvh9F
	ERkJ+0S4pPeinelOXdEsI24wMWYRp6+ZPQ8/NeMJFDvD06WLchEWh5gyylMxEpzspcHGkORDw88
	3wLRfI7PW7wHljEaX8talXzP+FSD5CDYc4ImQ7+s2M1B4C9sBYWfIUpbEOxq+bwJLgFkhC08GVA
	vm66PTn6OVj4KQItnM8N5cxPmrRmwlFYhGFU3z5o1XVEsMTdFjHRObEMnhNFASP8WHK3p6KQj7/
	+V+97AWBwVWQdpsJ8B25VX4bilk1C3d89X6/JcF9KCCVrDVjrYZ5P3BElK1j1FbVntcOJ6hlJXT
	LH3sCyya0LvrwLWtGgYXrbpRTTF/w0rzxxV5GRSQSk3NTUwoiQWlrlV5OqJDSf7mbRQHnuj7fy0
	Te+F4=
X-Received: by 2002:a17:906:8a62:b0:bea:a8c2:3d02 with SMTP id
 a640c23a62f3a-bf36fba1b5dmr514497466b.4.1780898875739; Sun, 07 Jun 2026
 23:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
In-Reply-To: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Jun 2026 09:07:19 +0300
X-Gm-Features: AVVi8CdSZ41x6EBhGrW-maqYqFvmYxaB5rlMq92vcxyr-Rwo3G25Posh805oQgQ
Message-ID: <CAHp75VfcrHn5R47PCDOoNnmLNbKA8sX3Jz9T-AoMSnbmqqyP1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: fbtft: fb_ra8875: prefer usleep_range over udelay
To: Georgii Druzhinin <ilovelinuxgames@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 11:17=E2=80=AFPM Georgii Druzhinin
<ilovelinuxgames@gmail.com> wrote:
>
> Replace udelay(100) with usleep_range(100, 120) to avoid busy-waiting
> and allow the scheduler to utilize the CPU during the delay.

Nice, now go to the lore.kernel.org mailing list archives and check
what was done previously on this and why none of the similar patches
have been applied so far. Also read README in the driver's folder.

--=20
With Best Regards,
Andy Shevchenko
