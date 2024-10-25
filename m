Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB920EA2C
	for <linux-fbdev@vger.kernel.org>; Fri, 25 Oct 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729886459; cv=none; b=bSBRQKBwqJO1p8lWaO5fqEPHLKdi94ICuml3Z1UQSui6KZ8PNA0IHoHL5mzAv5fON/fU8p/ZEoR0D4/t28Z7zMmLiqySh3+wX1U2kMd3Z+xx8IeLBzudxGzckPmZWLpZlC1257P70XvTAvD5dzWfBNqFJZYXYXs1zBagLo9MAY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729886459; c=relaxed/simple;
	bh=1AY21VF9QbtDmLyEo0XVNNzYJTjrWXkGsQFcI+D/qBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekdKjkwsmr6ZDxNmn9cN6XBadkVQ/NEKWcX4Qc3dz6Sf0kY4ejt/sa8lE7cJE6j5roAWdCcV2yLwzBdEN2qdzgMf/aQaoh8+TflfJ6cJ5kZjjIaW/MoHWujIQSsw0z6Ls5hOhUoRq2R80oj3ZEVAPGsWuEsUQK07b6DzPp3ijxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D8lYcCWw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D8lYcCWw"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so3128994a12.3
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Oct 2024 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729886455; x=1730491255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RqgVnPZ+sAFjUIPKthsMDBXPwRC2/usor5uwXmwjBkM=;
        b=D8lYcCWwhoNANkERzTRHT5ubhgb2Y1/JpTAjmQuxPKkwAUkli1XDTR3+nVJoX2c/IH
         e/UpIntZbV9YW3OAgEJEuZH7L0VDryCeFEXypzrGVZbpe3NbhHFhvi4aHJ508CjQxj+U
         wPdPzJE4lxibCtv3hrj06V92IlEPZ0HcQ0GtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729886455; x=1730491255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqgVnPZ+sAFjUIPKthsMDBXPwRC2/usor5uwXmwjBkM=;
        b=fJjLcFIgPVrEnDpAgal7WqpMhFDULdj6W36yUXwVShVer1vjpk9BiPdutGk8StjpCc
         Wuc8Do33Grb/R8g7FgCfCbBIFrlVnBHS5cG3QP6IUVFEiYkUMT6NTWF3RCRcyfo8m4b0
         NNMkk3b+ycoF3m8Q51mniKFmvoKjXYmnuq0TosSQf7Zko1RBFA12X7ZTEQ+McC7zrvY1
         /lKO+4XU9kD6f8IRj0aNDqSMxHpXnfkQBDxwCPWWfdQOeFujvMvFJ84MSsHA+2xOfpXx
         o2gW33NmWaNYiaquGbiZ+9oenQTQ3gArj1UcsgfPfk+sRWELBmGD7ZwArizo/otsV7EA
         kHDw==
X-Forwarded-Encrypted: i=1; AJvYcCUhxcG3HatmjJuPD3Royd61woYhr/4BKNUJwSY1fD57DgvopZfLqzLGjQVE1f6YnmHinqPQusZOhYg4FA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kcipmjRhAWTDMiVj1V9KGZ/A92ZUUkUo73QjFSQ3pHibSbNU
	JG3oV/7R19eHON3woegKtdKkB9RUcnSU5FSM/dfbmUJMPOAthsDCUhB2u/vLiug1gUBVyTV2p4q
	DpkQ=
X-Google-Smtp-Source: AGHT+IGGzNchys4fajetDCmDectCakmjn192IVUzuoV+oSXDaMxP0ZBg3tmTJOtcHRCB3mR4UXlaDQ==
X-Received: by 2002:a17:907:7f1b:b0:a99:61d1:348f with SMTP id a640c23a62f3a-a9de61e8ddfmr20893666b.52.1729886455087;
        Fri, 25 Oct 2024 13:00:55 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a08b29asm101884166b.225.2024.10.25.13.00.54
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 13:00:54 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a998a5ca499so308274166b.0
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Oct 2024 13:00:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBWja+zEXyorSk+aO9xdMsliBuwnylzh8be+Bb5nygE3tSNemAt3oQSg6gSuPWF+BqvT31ue7JU4naUw==@vger.kernel.org
X-Received: by 2002:a17:907:7e86:b0:a99:77f0:51f7 with SMTP id
 a640c23a62f3a-a9de62ec48amr21019766b.61.1729886453894; Fri, 25 Oct 2024
 13:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxvBfDuqSC_TEM78@carbonx1> <CAHk-=wjKouRizUF97ZABtCmijjKR+sAOmWA4uiYhhSOwhxCT3w@mail.gmail.com>
 <e3debf69-0507-41bd-999c-b3de79c809b5@gmx.de>
In-Reply-To: <e3debf69-0507-41bd-999c-b3de79c809b5@gmx.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Oct 2024 13:00:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhG+UYcrFWc5-XzF73R-ZBLqquXWDoEgZjOTGe2Tkuug@mail.gmail.com>
Message-ID: <CAHk-=wjhG+UYcrFWc5-XzF73R-ZBLqquXWDoEgZjOTGe2Tkuug@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev late fixes for v6.12-rc5
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 12:36, Helge Deller <deller@gmx.de> wrote:
>
> Do you want me to send a revert for this specific patch?

No, it's in now, more churn this time around just makes it worse. I
just don't want to see these kinds of non-fixes in the future.

           Linus
