Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C323D7CF
	for <linux-fbdev@vger.kernel.org>; Sat, 14 Feb 2026 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771109287; cv=none; b=OqHCOzBl38R88/ha1JwcRj6pbOc1F9RxsMd1BzvIvVreE93u+VssZBRgXynF8tJLxNrD6hkk1V7RPjsDqoyxO0sChb2Q3KNT5ZBGwzqueKqG4AGMaHUhfgRtiX4O6/fXFPBLKKuNmIOl3WxZ7VpV/CBHCnayj+uTY7/bVX60bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771109287; c=relaxed/simple;
	bh=LbE5Z72PD3MPJ43Bce1pDWGIiyWmIGts/W+3nAK+cjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2jpRua79tj0OAQRst40k/kmJGy3S4WLPBRIbIi5nv3kzAm8lLiqo9Mp0xpcfV/myJ0uXtRwJSyxEjHwJV0l8dIqZC08Q/oT5Ry2tryVJdvixVY0NNfqchDbwuo4dxdjn5A9hiuGOiKCnBXWCCnbmj1FTTnP9PH44mUOawRkWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ap1zvP/c; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ap1zvP/c"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65940221f7eso3512192a12.0
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Feb 2026 14:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771109284; x=1771714084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mYkdhtRoL4GjkDCyjPYy3UUZTydOkdf7syWKV5f5AgY=;
        b=ap1zvP/co68pfYmG+93DgHX4MimyvyH5mdFE4b0VoWKuhRCnbyn2gkjyazIleQKXE9
         IACJ9A25sGHHn80gc+VwbQPWGTaupw3W83rjJtv+qxnCW6e6UL8SChwpb8IqcyLSeviT
         IPjk42byPpDGm1/ZdfrOT0nJoHjMs7f3E5ue8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771109284; x=1771714084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYkdhtRoL4GjkDCyjPYy3UUZTydOkdf7syWKV5f5AgY=;
        b=D2Q0kRKqDDyKEu6iUPez3HWuCptGsRLPfz5D2SkxZnRPvMZYW+G+0XcDYeahTZ3NpZ
         2ZA6o2GmyRj3Hru6KCWCy6+5315TlyEHs2QrkJc4c8Zm8M3CsNNYsdzZhvFCir7dyWrg
         1EQXWrWME/c8v3wd2Wpyes4we35OFKfqwiZ4B0aJQ0Qc0RTHi8ZyVoOmzbN8DwCEBQmX
         QAuVXj8vjE9bdjhI9H2ERcydBheQeudREn8fiN8WKMrjb1FF9UbjPiyB+ocTUUNMUUzN
         KbADTSREatAwKHY0cWcO+tpy9GMD03JCuTflDLX0qMbMqRdl9mZQuR+Ik2e28ZQUB92y
         YN3w==
X-Forwarded-Encrypted: i=1; AJvYcCX5uvunLIpajh+1g+PIXqZa84H5ZtvGu+F6BSnJDAf8cctLzyyBRxZWljV51bnfENh9nwoigf1gClopsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2WCfyXwSAKUuCL/BX6zypcVb3P7ai/nWSnH0mF5gjNjncwik
	uKm8F1Yq0ZPnBdm0rUPHlbh8kfeiZEM4BiwkD2KIofwsUot3SoLa8lPLuhki+dVww/STeYVFFU1
	lxBtGLPQ=
X-Gm-Gg: AZuq6aL+I1Etro0j0HaoR1FJKEEBEE0UDf9x2VCK7tEExmkCI6rv5ktwG1hgmmoeWfC
	/jnq6jL/jInCEmXYg16hchNtease8TeIOecHm5U3nK0qthFsDT3DnzUAU34cD5+a1Jdm8LDzFab
	MegJbp3Qr9APpE78lzwO49foVitrenK0821pGl/RaLTsYCEVFRO5Ml/BJ5XZjJD0sd/hd8utyJD
	woKbTpRnbWXbpcc6oG3tBqj2nbsTSkt64n4B1uTnWjctXVLNCy/DMZUMW0DaINorFNTClKfuRso
	+bKQIwocyiNJjDgq0p1MFL1qJGmDwAy7oiZLcd4oYoqExiaPfayXpXY5z6fKXtS/BMYuS9WTvJt
	hc2R1b90WpSno1m8FT7rgPMS44N/bAJjzrO4AStaDO2Lr+qEV/FMmSOW9kV5PE4lDtf/wVwsf6l
	sd8l5ODhnx+Faou225OGYd1wa9lBNq/rJU2h8tlFy9ACHHj1xtHzRpeO+pS1Ughr/z9g5AljRx6
	a53LDTO7MM=
X-Received: by 2002:a17:907:1c83:b0:b88:21cd:5fcc with SMTP id a640c23a62f3a-b8face2b48cmr347937866b.36.1771109284456;
        Sat, 14 Feb 2026 14:48:04 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e587sm105894266b.2.2026.02.14.14.48.03
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 14:48:03 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b885a18f620so267226366b.3
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Feb 2026 14:48:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKRuqLptcjLAfieAZrDU1RY3ORFRyN3s8sJK7adQ3W+3B8e5fYTbCAY737pz9Cruz5C5Ib1ZYwZkv8TA==@vger.kernel.org
X-Received: by 2002:a17:906:7303:b0:b8f:6f75:f9e with SMTP id
 a640c23a62f3a-b8facca23a8mr343042466b.1.1771109283474; Sat, 14 Feb 2026
 14:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZBlTsIwTzS0tqBD@carbonx1> <177110244909.2897141.11184148040863874004.pr-tracker-bot@kernel.org>
 <aZDpCUcIXLmuydoF@carbonx1>
In-Reply-To: <aZDpCUcIXLmuydoF@carbonx1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Feb 2026 14:47:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj03hLzK2D=+OYmjgcmGM+XYymp8GyaEs=C0=rXG2nb7w@mail.gmail.com>
X-Gm-Features: AaiRm50HHjVAcxBlyn1res84hJ74BQRuPE9I7BE6WlfzWIM12HlM8cBqswuaZQA
Message-ID: <CAHk-=wj03hLzK2D=+OYmjgcmGM+XYymp8GyaEs=C0=rXG2nb7w@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.0-rc1
To: Helge Deller <deller@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[ Adding Kconfig maintainers and linux-kbuild list ]

On Sat, 14 Feb 2026 at 13:30, Helge Deller <deller@kernel.org> wrote:
>
> Linus, I'm really sorry, but I messed up drivers/gpu/drm/Kconfig while
> trying to fix a merge conflict.
> My patch series should not have touched drivers/gpu/drm/Kconfig at all.
> That's purely my fault and not the fault of the patch author.

Humm. Funky how the Kconfig parts never complained about the
duplication of all those source lines, so the problem was basically
entirely hidden and things still "worked" even though that Kconfig
file had been so messed up.

I'm not sure if the Kconfig tools could perhaps warn about this kind
of duplication - we might have some of it intentionally - but it does
make me go "Hmm".

Nathan, Nicolas, comments? See that commit ca4ee40bf13d for the
partial revert, and notice how Kconfig is entirely happy both before
and after that..

                Linus
