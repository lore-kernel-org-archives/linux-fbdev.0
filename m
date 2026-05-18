Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7AE1ABEDE
	for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131112; cv=pass; b=ocuSkeoAhnIb45Nd0jRnv4x+mQntn8Yp85Owun1kXDDs/OmHtX6VdMqJ8Wsv52vD9Vpw8Sx629k9Ye7yMoUTj5Wudo5NRwqu/emdpMPDIqWmuWszuKyYTYg8mmHrfLx5TmUiIxpxC2JgpN9a0P6XHST80DGGQzZ0KXHaXhlgBgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131112; c=relaxed/simple;
	bh=JaNa0tXw+T+BrFaG0RkXwcaMZePZsuxOPNlUwPVvAXc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uoHLW0AzB5N+bOca5ii4EuqabHZ3Dz4NIaULy61z2o2jvaS+WRbPzVPSlpy4WVQF/kULPm4yFGxxtkd+BPVjBM1HeJX15TquWXX2XvUcgmS4Xb/bU+msZC3Ry8r6knX3vPl2g5228wCQZjWIsO0+6oPUJsybufYbYnEKT/i2jX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6MiPokP; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6MiPokP"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so1550269f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 12:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779131109; cv=none;
        d=google.com; s=arc-20240605;
        b=bgu94H+zqkRtWCJ7Cx4ZSQqk+slG4NupGdhHHWUI3OY2OxgSbULIxolMOEecAKhubG
         TKkV0GOVEqQVzv4vUzlX/rYhh3qJlTxcuLSsdjJiAIvGnyXvNH90+LO12CN2vA55U+34
         88xNafDC2KZsvzc3h1FxjAXaG7c2GDfH27ab0PC6M/ltdyx/8taBkL1CTbfJ/7vbAsWG
         P18yqpm6/0U5ucG991YaTbsQeFDxlabZyy5EgovySxHAVH+1SCyQ3aqN5eKxf92KK8rK
         HNXrtCVLEEU5ec2KNr8PDEoYPnhFrwZc33l38Ahy+2A/WxbDVoe7hHNaBwK7w38N7W07
         6PGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=u31YXDFjxv7mXffscFNx6oOp8B/R90pltj1VyavSSyc=;
        fh=JOoM6K9idv17IUsjNhd4LngaspgoJYfnpFLLSID9NJw=;
        b=N7moqDnVclPT5otGoSG9lPAA21QWKTRxd5phmrLDjuDAA7TDynNhbtbBAFitaOtv0z
         wOiI03uont78uH77x1zbvfYm6vJ5TVtNesGYg1msRkBVEqXWdocYwBvu2fDuFO+RjukI
         0t7FkuyCQBpJS8USgdIa/1FV5J42P2el1d7nDq3Zf4A5CUgDY7w7h7HDkW091srmxjiX
         YZQ7mt1jz/wjw6ct4XkVYvrAl6gWxWjpGHoQtCcKHJQ9oaf0bFz0Wgkv8MZrWh7Ndlii
         r5AyPgmlIXcLs0/ftqn14M84jMtGTb8FqlzQ93GvWlQz6cWCmSLqsYluteGzHSG4YhBC
         kDvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131109; x=1779735909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u31YXDFjxv7mXffscFNx6oOp8B/R90pltj1VyavSSyc=;
        b=U6MiPokPrMdQ12ufroqCNDwYhR3UNILw65NS4ddSApOC+VSmJR+b3ym37Q9wERCShg
         xrCQUVVLhAKwQrsGmBmMduh8kOYEtNTHdvu8+YkcPixFkIaGJTvERlqa1Uuy85UMZpfr
         UFtDSVbF3s4LbnWdtrxP2Us2aEr7U6QDfvSInRBJzNSzv85lhE6oNULKZZqBiPMLGNvO
         8aHiedVlIKjQZEtsrGuuTQLMEczxsESJmYNIKftNp3rylQYNZhyoPMJNVv2G1t+X/mF9
         gAn+K/jAmCzsZMF7++nWL11luEjF4KgnyiV566nf+3BxwFZtU+PyZ9U2+Ix1tfkvoI81
         izmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131109; x=1779735909;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u31YXDFjxv7mXffscFNx6oOp8B/R90pltj1VyavSSyc=;
        b=PmY76q8+f2Gl8FbnamPfOgMWe9aspRIExfIDFKPCWDjTa3cf147mrmVHsjaUrTv6V3
         qlZm39Pt/V5vVA9bNy/cgSAXVFG4DJiq6ux2wqR4TF/zhzitHxgshLAl+hPAYwWGO+XL
         CklZIA5x2J4WGIV1sV+2NL8J2wOU0NpyYMXFiw6PHEdtyzPydiyoWhhVS55xA6tSb9Uh
         LkB77UrIQaUss9Z7b0p1wuKiB9WYbe1P5/g5G8lxHjthxGHrbXPqsYtw1dcVQCe0hPC5
         CbPhEWq1REvRHrCmF02QRgZLpHgIpA8VpKebyFgNU7EHzudyna63mlix9OOWrNqSDahB
         zuHQ==
X-Gm-Message-State: AOJu0YzHvPkgq8l/1c06Y3tdv4QA2o1AiDnew6k5Rr7HNsQ0QJMDGJ0I
	zTjgzubp70bD97T47Pwt3KVclyIy9TIVekStYJpUNyW0aU/lAj105ok8riIx2WANoGsieUh+jjS
	WHh/fbdZ5GIiYaHByzeUSGkj00aErJx4=
X-Gm-Gg: Acq92OHbmbUqDa/YqEwYq2RKF0cRjw9kij9PyRkVqGFV/IXjMF0gqqPIoo6qWQx+WVT
	P+69vsaISg0Y/m0aBKgn0JugYXXdn4dFaG94gQHk/kMOfA1HAFXMHR/u5TcupbeCuN6+fRjvEiq
	xoai1zcezxlIbr7JizmSaX4H/j4EUkz5YnvlRqRM8UAgAvBJiLZSBiCTa/9l3JUhYB2IwmLd03e
	HtdnL83NwO1TJNNe60XgVi+Et56HTCV/t8zNhQxAVIgU33Xya1AgfS+A5M9C1vqDTESQESDsQcO
	/AIx3Asz
X-Received: by 2002:a5d:6083:0:b0:45e:8526:7dd1 with SMTP id
 ffacd0b85a97d-45e85267eb9mr3505962f8f.22.1779131109069; Mon, 18 May 2026
 12:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 19 May 2026 03:04:56 +0800
X-Gm-Features: AVHnY4JqD7F6NFItY_ez5TsTDteXgtDuNdUeoz_k-jjq1wjdNPe4El-vSTxFOT0
Message-ID: <CAHPEe=G26qGCko0FxMa5SdKpOeZagY_mQKcn9ZGPW0qn+i3vUw@mail.gmail.com>
Subject: fbdev: iterator used after loop end in fb_deferred_io_pageref_get?
To: jayalk@intworks.biz, simona@ffwll.ch, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

While reading drivers/video/fbdev/core/fb_defio.c I noticed
something that looks like a past the end iterator pattern.
I would appreciate it if you could take a look and let me
know whether this is a real issue, and whether it is worth
fixing.

The site is fb_deferred_io_pageref_get() (linux-7.1-rc1,
around line 203):

    list_for_each_entry(cur, &fbdefio_state->pagereflist, list) {
            if (cur->offset > pageref->offset)
                    break;
    }
    pos = &cur->list;

When the loop walks all entries without break, cur has gone
one step past the last entry. &cur->list then aliases
&fbdefio_state->pagereflist (the list head) via container_of
offset cancellation, so pos equals the head and the
subsequent list_add_tail(&pageref->list, pos) lands at the
list tail. That is the intended behaviour, but the access
is undefined per C11.

Jakob Koschel cleaned up many such sites in 2022, for example
commits 99d8ae4ec8a (tracing: Remove usage of list iterator
variable after the loop), 2966a9918df (clockevents: Use dedicated
list iterator variable) and dc1acd5c946 (dlm: replace usage of
found with dedicated list iterator variable). This site in
fb_defio was not covered.

A candidate fix would move the pos = &cur->list assignment
inside the break arm, so pos is only overwritten when the
loop actually finds a position. The default value of pos
(set earlier in the function to &fbdefio_state->pagereflist)
already covers the loop fall through case. The observable
behaviour is unchanged.

If this is intentional or already known, please disregard.
Otherwise, I am happy to send a [PATCH] or to leave the fix
to you. Thank you for your time, and sorry for the noise if
this is not actually worth fixing or has already been spotted.

Thanks,
Maoyi Xie
https://maoyixie.com/
