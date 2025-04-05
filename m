Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092371A9B58;
	Sat,  5 Apr 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743862062; cv=none; b=TBgb8vsDs1TZeYlTAMiGDm6paZlinofxk0r5t9rlBK9+9dQu4y5/z7xq2v9jByKZ8H6HuIli8VGZB0SygETSM5bY50c4RSYGOf8tsXEBpATGRgIw5PVnikpkabtP/ox3NEQWkj7fOfQUFxI6vo/8aIQiF+xmtpjJggcT3n1SAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743862062; c=relaxed/simple;
	bh=TW/qFu+aWszAthY8Exk3Q7IfvRnYfk5DV3H/Ju136ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G62M6jGIM7zXsue7aGnYOrofnEyxfmAFk4bAumpIc+CViDfmA1BIRoIhaQGVHVlkzp2Sap2cYZu5dr6vLGhIhiTTKzsO+zqHZuz0+H4okGayiDOG4/PViFotSP72zfDkrg7p/1v85FL4jQN1qNbJsAr5/eHwWlz8lynTknh6a3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHrNcslf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHrNcslf"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so4789209a12.0;
        Sat, 05 Apr 2025 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743862059; x=1744466859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD1hZvcYFeFSAZu2X5kKQKqViTPGY7rCLuRuENjfek4=;
        b=FHrNcslfEMgYNX4LFVfXms2VRXcwLdo+E9sV979FyXoRFxEkfKxXzCySFQbaA9GnUy
         qWHrLuEv+GQnz7oS7KAtmthkJsDVI3NgsJEQzviaDGvAziq9CAWwdY55GH93VP1T/bt9
         HXNZwpdgOvg2HttCzEt0dXqc8v9w4vr61CAo/hBez4FEnI08wVksk/a0f7oJojQovnZr
         jFu/P0lhFyvKYM1VOrXi9evS1hM3in16rnpu2LwMikIl24sxbZqtMwW4pu+6A4RMe1KO
         JXwSjIDrG1gRv71Hx5f9UYW4JCDnc9n5sUDK1eybPXrturktHKxWzM4G/9mzYNDsXsQO
         ++CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743862059; x=1744466859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HD1hZvcYFeFSAZu2X5kKQKqViTPGY7rCLuRuENjfek4=;
        b=t0PaGWv5BiHyF08Cgy6FXFCbD8p3CX7agEcJhWkO6F+z+0cx3NHJnZvbrMqOQmLG1l
         KGpCodeZnFMz3ikhXIQf0GRKBU539SMU08Bf5MZHB/ryl50CJCG/P691G3q9vEY+glmh
         SmAT1SQ/ShEk0EDnkJ3CAyLATCOEj9hX6FOrPI1vUlXeBF4TVo8CoZiuJMZx/t/DM2Gl
         3YdwZKL9e+Bi0/OBd1zpaYlX3Ij3wKwHoCAjZa49l4/2qh1O6duv/eTsVVTodpaOsbZV
         M/HpI7l0oi7O3jI9iEl+obk+jkvSQFg5RDCqWPEzdkvhSDkAt3iVHkZUQM5KkqnpFkDr
         aEUw==
X-Forwarded-Encrypted: i=1; AJvYcCWApi8GhjfpcDS0tn29uLUamx7Z3yyWv0jwyuIZmZJ9c3GLoR/kk/FRP3EgQI0ZjbovlQhjMNLKRpn5TQ==@vger.kernel.org, AJvYcCWvFQ9GxWOXv6s9BkyQONQ426N+FyjsRToZdMk57WsgEa5yKmJieeq3MHNCg5HFn8Ebi90HPlcR1bAB5ZNI@vger.kernel.org
X-Gm-Message-State: AOJu0YxA66eoke15TznKHRk+AT+ruX6TW2XnJ+aRbSXeTCFVSAm6fslH
	2npyKstXXl38xpnMlZdZSXzlTgc9/fUu1Vv136/fwD1YlEbUI/JMTc8mQNWJ/wXuwOfigQ0ww3C
	o0LlDRtta14sCnzOsDdmTL7Xm6NU=
X-Gm-Gg: ASbGnctZfUz9M16UaEzXJRN2iZZ4oMut+SjVo3uj4EmSuKLG3UahGmvPV93rxxTXdo9
	d9hyVrG4tofuX0XzUmV1ny0KI79WyV+uPaetgITi5Kv9vCKh7PmJpGguTyv97D/ZIW+EgzxPHIa
	A4I5FyJXJXkj3mse5c92Zus1l0
X-Google-Smtp-Source: AGHT+IHiet2f3bcaBonLcfoiGSUSwIRjRouGym86K7CJ0AxLO/11DTx1uk6spLb4qn3Yh2GsuM83+faO3NWHdwV5IP0=
X-Received: by 2002:a05:6402:5204:b0:5e7:c438:83ec with SMTP id
 4fb4d7f45d1cf-5f0b5d82c63mr3892267a12.6.1743862059139; Sat, 05 Apr 2025
 07:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743857160.git.princerichard17a@gmail.com> <2025040538-breeze-espionage-dc6e@gregkh>
In-Reply-To: <2025040538-breeze-espionage-dc6e@gregkh>
From: Richard Akintola <princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 15:07:26 +0100
X-Gm-Features: ATxdqUGdkNBE7aDC6Q9smp5nGGHzBaqpLv-oW63nuKZ7Z7aRYltMJjkqXnfZN1Y
Message-ID: <CAMyr_bL4Qo_eeVSHhy-_z9_PwcQAvD6N4jfqBb+rtN-Lj+YdmA@mail.gmail.com>
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
To: Greg KH <gregkh@linuxfoundation.org>
Cc: outreachy@lists.linux.dev, sudipm.mukherjee@gmail.com, 
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 2:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:

> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.

Please, how do I resolve this issue?

Richard Akintola
