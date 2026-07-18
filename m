Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04A1E5702
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784371147; cv=pass; b=te1x0VolhD+zroTlvD8Q7BI0KWf8hMG1N6yTIoMiMUafTWVFXiBJwMIfmrUnjqRwdT9pUpQz9ePmXZOb8valGpWn6doyAdYVJwiukDlI3hTQb47vT0Zrq8NCDrZBVNGAziS+2JqyBn7i1oMUNM+mGnr0PawQzlUBU9UMYTSbCzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784371147; c=relaxed/simple;
	bh=8Aq/GZsIYH30vV5juA0A/3LOFGnfhbf0hAiSugt7pG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBDBj+L+iBehloWjygJIsJ5PGv56oCZrMXYdobXw4CmuAla7AqBD3Zv6J3L+M3YZPwt6hJlhuntxzurUq6MDJbNIb2MpdChATKikhTR+Xq2lukJwM6TUkGNg0esdmleEi3XWVtEcEpOG0/j0A6mnUFppVnvPncycwjn0XFbtElM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJHh9+0Z; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJHh9+0Z"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so12470215a12.2
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 03:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784371144; cv=none;
        d=google.com; s=arc-20260327;
        b=VmfueoAfbHJhsekW4zolHthkTH4kTcH16h9r1p1O1JeaId9sk9pr8rzEMex0DaRzDD
         0nlEmfwJqUMctW/vzMxu9WNlTRJyLB6gEOV4yMY7f49RKivAsyqh0uvrldxDM/bDrRZh
         kWMTMSFXqE51r9aIb3vp7QSP1Bho9vXQt93XPykaWgvgkqlnG6EcjoVLWGMfiA21bk/v
         TcsYIWiayNYNP+IEHr+S1ZwPzEnkrGNYMUAP186f1SqwhY5dxvbd/O59hoC5mcCRXPvl
         yl4kpYn/CR1F0Ya/Fn28jbaHTrpxk1bW2iU8Fy43xyNwYmspxpSdQRMdhoY791N2B8pw
         OCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qJjvulD++VEURCpHeAgytVLyufur3iMQTmC2gR7Z7VQ=;
        fh=mKuIJTQXILq/BpDXK8DdsLO/xvhYl8OV2sUpw0JHLqg=;
        b=hvNO6y43gwzU+ZxtuulhX/r+ZeaxKyBt6D9teXVlrKMb2+D3uH5kYz1KoSmZ2EntFk
         ohFSrUZoxPARs8LFqUgkNcCGCLYBF+ZyV74gi17eZfUhxCPU5u/qH8KSEp2vUQWgqHPc
         /2kjrHh4DUfCHivlDA7UF6m33bsKF6VtoA4nlIblrwXuWm7HtHKX7tfHCA4vSxGfPo5Z
         kCuJ3mJSsoX9ca6EuhIfAY4FETIHbezr0Cw6jo+GJb7p2pGLo2tTVLv92J1SXe7R/XBP
         Yec/aePGhHEXXNlBiEWsK0cHTijPLDQogMRbxTEFArulOpyFdeJZYh2hGI9iDF6K4sK1
         LHdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784371144; x=1784975944; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJjvulD++VEURCpHeAgytVLyufur3iMQTmC2gR7Z7VQ=;
        b=dJHh9+0ZRv96muyRZhDgxSi8FWWBUYV9R0qes0D4QccYIT6zdBOj+PGqLXNBQUvhA8
         o6j/D0U0hunCmdSdjPZXO8R7Gg4DR77w1f8m8M+FZGz0pS5VTiE7lIQL5lrtExx1a8uX
         3a+g9zmZESu9Dt6zhsSIgz3HzOGCSHfZmZtr8/1th+uDL6fer33kxBPCXa3v12QqlUVB
         wIfD/nHym7JJ/MuBm03sdaHixf5I5/gqjmiv1VABrsasZCPKXh8gWleodWahQpCMv7gN
         Wdaq1KBdRk+aCe5gy2GBvbIkWCYCLSb3psaJZ03C8VtUjcenJbjCCrSmaYzVPODZ2G1l
         4tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784371144; x=1784975944;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qJjvulD++VEURCpHeAgytVLyufur3iMQTmC2gR7Z7VQ=;
        b=mXL5LQljlA10B3BkjCkTU5d1tFfEj7j7zoDKgkUYgUeZdCrnaK6e7FjMEPO8lPBTw8
         hOoRDzaUUJEHiQrYOkGrJEdrREhEdGXnn+NIE+g+UIUWY8r+0y8bxiV8/2eA+fr4C9jq
         5eUAY8qHeK2RRtFovrMEKIWo1XFxmn89ozybgKzfqvx9RGn7ntjdmWJrRHVpvZahU9Ze
         JMR/3XggV5bWg4z/DxpoI8mqbBrByqUq/78apJNi9iKhU7MEEF9XGeJl71F5lipaDCe/
         VbONFtX+Wd0CQJPGFZ9oxZZTK4uI2WwWH2dfTqPTi7HoxC7xX+w0e58iPbpRIF0lErr/
         15Tg==
X-Forwarded-Encrypted: i=1; AHgh+Rpk+AHz2orjbIx9isM0LArmmSjlEFzIogfgE2U7Rsn1K8eLQhj6rQlKNEJUuKEE9EAwOctExfz8aerXNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTlPoMMWfyjdDjCR4eiy5qVQWgKihoHBFmG7b1x8OK5Ko5Zbs
	Ef0eNPxnqXGi50NTVaKNLzIoZKjR3ruHeEK53SBXi95eZgaKJHYxax/pqZYs1Wf5OdnyVrVfCIV
	9ts6Lp+fB0/c8+CvBWM+s3+CE4I3qdFP/wrykAHczNg==
X-Gm-Gg: AfdE7cleLQIFm77kEnY2DE36e3Z/zEXich10f+I19tGzvUtHzZey6VhKraiWxM47zr6
	z9LDvqd4YzKjQIuusu8tu89uyJNSyl1ygBjDjJKztRyGduJ7xbyPISLw/Sex2v6x+KtGxABFrGS
	GKVQkwloVvrW1+edEPSr2LXDgZS01FMAyMeXrM0g4qofpvJYzyq2UimwWLnbdU4BvOqI2cyZBy2
	I6jR5opD7DPjC2JTLhai78VOMIdHSHjeSGTGeBdjiESGnffDfjyW2ToJwEcLiHX9P2gvRsfNPoZ
	M5hletXJUsN266MkWXUX4ZovVo2xEUeaA4kPjjJml2Qy4w==
X-Received: by 2002:a17:907:d09:b0:c12:34f0:49b6 with SMTP id
 a640c23a62f3a-c16b486b27emr278236166b.57.1784371143830; Sat, 18 Jul 2026
 03:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718045641.468640-1-meatuni001@gmail.com> <alsSp5tAe8tunTeG@stanley.mountain>
In-Reply-To: <alsSp5tAe8tunTeG@stanley.mountain>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Sat, 18 Jul 2026 15:38:52 +0500
X-Gm-Features: AUfX_mzWEaXEc9_dlpV7jH9CpyxeBMPVeiU5aDpieKtm7CrbxKF0a-_KtoDkwso
Message-ID: <CADqcGB=F6Qvk-3zQ=DCPewfpOAQvCta2q-WrfuSPanmoVqyGpg@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: fix mono image source stride mismatch
 in lynxfb_ops_imageblit()
To: Dan Carpenter <error27@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 18, 2026, Dan Carpenter wrote:
> Looks reasonable.  Add a Fixes tag.
>
> You have this hardware and are finding these with testing?
>
> It would be better to move the source delta calculation into
> the the sm750_hw_imageblit() since it's just width rounded up
> (or rounded down if you want to be wrong I suppose).

Thanks for the review. Sending v2 as a separate message since it
came out as a fuller rework rather than a small diff on v1:

 - Added Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to
   staging"), traced via git blame. The bug has been there,
   unchanged, since the original 2015 staging import.

 - No, I don't have this hardware. This was found by auditing
   sm750_hw_imageblit()'s internal stride calculation against what
   its caller was passing in, and confirmed with a clean "-Werror"
   build. No runtime testing on real sm750 silicon.

 - Moved the stride calculation into sm750_hw_imageblit() itself, as
   you suggested, and dropped src_delta as a parameter entirely. It
   was the only caller and was independently recomputing (wrong)
   something the function already had every input for - which is
   exactly how this bug happened. Updated the declaration in
   sm750_accel.h and the de_imageblit function pointer typedef in
   sm750.h to match.

regards,
Muhammad Bilal
