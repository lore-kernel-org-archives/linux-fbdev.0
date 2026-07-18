Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3A3438B7
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375707; cv=none; b=dRU1qadKIh8BAvZ6G/aRj5OYmiwafWOEvuGUynbHi4Pg3EW5mOJn1Mzbcn6dHjTDLoSUI9UVN2ZP3pblSzjO3BoXW6VaNJXH1Orkr21LcgSzJ2PfK4LVHQTBkh7VVyAea6GZneF2eoQcvjA3yCpsfTiWszVMCRrNtEzDw8NZ/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375707; c=relaxed/simple;
	bh=uL1h+zcBYTdhfJh+Pjb1mkpqWBcpEGzZ2496SPN7xBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql//taeORbZ5zIjlztBEJrxWcbx4mh+Em3EsEZQPVMp+1yBdJ8N4FA9mN4pBukOY2BsHkuP2AKkaKl7SDyMZxydA+rP7nzsbYnwkMTixyCpnMglpd6JdmTcRFEZseIyDA2CXzi24ZM/tT6eSfhCVAqQ4XJUSFbbrBohs+Cr2euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+IJizRu; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+IJizRu"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4472500e25fso4086371fac.1
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784375704; x=1784980504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L0tz/h43xnvUpRXIsTHo/6Kg9VzM1jb7Ry9KU5PShuk=;
        b=p+IJizRuT+wlIzgsHokbYWeF7YvgZwyyx8sAdzt2lUHe2aGzit+hm0HDRNtaojvEs7
         BR9jqHlOYRKFtIuMpIydE5jkBVpQ7fiImiKlNgazr9dmYrkbH3S3Hcpv0ZlLQIVV9/Nm
         vcZn0U6bpKusVyDqjrgvuZ6gay7vnyUSyVe5S1gIoajHhctGEVeFo5EsuTWQRzB+wNUK
         q1ZAdBGlL0sezDkA45qHdx6BYPr5ayN5eX0lDWA3uWPNbLQ3KOeugM3Qe9V87T74UQt2
         oMuVd5WAerLs8s833RcUbWDFTRC5dNlGR6dy3hV2hv6fGrxd9CLtA1RWIbnmUTM96pdi
         DAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784375704; x=1784980504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L0tz/h43xnvUpRXIsTHo/6Kg9VzM1jb7Ry9KU5PShuk=;
        b=l/cbG9DyWuRYSGTm7whQA4xa5CkFJgGTR89onE5LLZKCvQutQBTIMu9dndG2lyTcdh
         +KT8CxROJNkDjQB5QE7v9y4LS50zHLCVRoXd9YXNmryWDf5qEXzxbMCLVHHhsNY/Qjj2
         b5mgwhEMTPVoPkJQlp7u5xGdYhkQ10XvfISbStWVdhabpUGgsdUEwRJumgcltA0rUHMx
         qEqR92hpvnEmb8k3+/OGneHDtlPzcwf2TUUrjGFSXAwwpggmuDBwUi+iWpDUtukloliM
         q/2romUk/uE5lEKLZPc0aG3/yZMZzQbdMFIE0sNTxEZW2CUbHptRK1QsJxNn8S7Kcgp7
         o0Kg==
X-Forwarded-Encrypted: i=1; AHgh+Rpar6DJKEAqcsAEzbdBcIV4rUESjiGqKGeDUsgOnAJm+1TnBiQiMbh0VZ07BRrq83VOS9m5VGJyiTWEvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylzomNxStgXjE98xySVOJFtavCito1tLJXA590JIBlM1bHl8+E
	jK3DPjSaGOj2c4Jzx1stWoYflGl+WrxGQ6uo9d/oc84BE5Z/D7OjxTHx
X-Gm-Gg: AfdE7cnPvQxqIka/9pUscBqAuFWqIDf8aAY9twG8DALRPB/7I6vcRRD4UvPDJ96pPCu
	6uwNK3z4qBHZOZicUOCFgf7nZHgP21QR01MRN9N5I3mWksb2CB4CWziV6Ex6tVeoKijxgLQigRF
	a0Omdly+ojo9YHCeUMTHnwa1W15xE/2UvzEuDXvKe7nIS279mgeG0tM59+fq3gkiPKs9Mkes1Wm
	QFSzlw0tBqWBxVZjeMzn6iC6mbXv1Vy7qr7uz1S8y+rft4CKWWBVO74H+vQWon3JTSAms1eMrea
	GfUQNyLD5m0UCcCA1iOUT43H/H6dKliharO6LlmpvO1sLjEMmolAdrzm7HF6hRd65v2vwh8xvZp
	Dr+iL2ptPIqiz2sOAuuNb0Ddx5v7j5LVmTVfQzFwbETgRs7Q0gAvq6dtYHwFEgksK9eYDWw==
X-Received: by 2002:a05:6870:1b83:b0:448:558c:d83e with SMTP id 586e51a60fabf-45690620df5mr3110708fac.35.1784375703743;
        Sat, 18 Jul 2026 04:55:03 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4568e6a92f5sm3425488fac.15.2026.07.18.04.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 04:55:01 -0700 (PDT)
Date: Sat, 18 Jul 2026 14:54:55 +0300
From: Dan Carpenter <error27@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix mono image source stride mismatch
 in lynxfb_ops_imageblit()
Message-ID: <altpj57xQvrY8I4w@stanley.mountain>
References: <20260718045641.468640-1-meatuni001@gmail.com>
 <alsSp5tAe8tunTeG@stanley.mountain>
 <CADqcGB=F6Qvk-3zQ=DCPewfpOAQvCta2q-WrfuSPanmoVqyGpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqcGB=F6Qvk-3zQ=DCPewfpOAQvCta2q-WrfuSPanmoVqyGpg@mail.gmail.com>

On Sat, Jul 18, 2026 at 03:38:52PM +0500, Muhammad Bilal wrote:
> On Sat, Jul 18, 2026, Dan Carpenter wrote:
> > Looks reasonable.  Add a Fixes tag.
> >
> > You have this hardware and are finding these with testing?
> >
> > It would be better to move the source delta calculation into
> > the the sm750_hw_imageblit() since it's just width rounded up
> > (or rounded down if you want to be wrong I suppose).
> 
> Thanks for the review. Sending v2 as a separate message since it
> came out as a fuller rework rather than a small diff on v1:
> 
>  - Added Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to
>    staging"), traced via git blame. The bug has been there,
>    unchanged, since the original 2015 staging import.
> 
>  - No, I don't have this hardware. This was found by auditing
>    sm750_hw_imageblit()'s internal stride calculation against what
>    its caller was passing in, and confirmed with a clean "-Werror"
>    build. No runtime testing on real sm750 silicon.

You really need to put this into the commit message.

regards,
dan carpenter

