Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F93DCD91
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Apr 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747752; cv=pass; b=FF6nOPXTDVaYaNdyBA1unYlrTqwlXSUZ5jkV3/rl4GtVakBhYeNzHj1blixd8uuxcCCG5hTuL4mOWdZ8OtCRwp67XAx7GTv6ACzWU1S3LmIBgmyjmBIP1/MfZy2vHkObJrszOG4VD7IsjKnGUnaNiZQlO7mXn+1ozL3ofu3SVxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747752; c=relaxed/simple;
	bh=R2MX9fmlirsxos8KwwfyegHkzw/h5GdV0JmS82MR+SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzCxmbE4yd3wOHpYK1BWlve9e341NHWMxCPQ48bXmusdAGXTEggTlQzBSL2Cv/aqrFuE/LNPOiHebXOjAwGqxlRMOk8a5b0yizMCnMJnm5H7it/RX1hMVtjzgokQORJAIVM0qO8wwbL47kt7/LEBYJrOmoNXnUrUstiZpPUGjGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG1livZR; arc=pass smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG1livZR"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so918563e87.2
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Apr 2026 08:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775747749; cv=none;
        d=google.com; s=arc-20240605;
        b=f1Lzqy36zlwLGKnMkwgSz7fOG3qPOY1MQYxbz6lM9j+P+9IotgDqJEdCcWrntmcU2G
         jOyqbjgXY4IugzrA6eiCCqchPwb4vtlZl4nLvTFlwaZLDBMBegk5xheOVjBidwZUgn3R
         gVen5exwm6VZANbppTXNUy5hgvWy3GaVe2ATf2rxdgs0yy/ysYQmW7+nbP1EO0VvSGCX
         nwWgdBUXfHTZFAGxyU06mmTQuIQCFL9Wi50KGCrfG+ZkFdSLSSNn+wihQ5MDsZlJ3FgV
         WQqPD+khpPSzMXAQyePDUQC7BXznWuNDjckEwAbYH1wFnjZJK03gMFUKtSPU3n5YhC0B
         NdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p8gHcxWDojfxRJcIC8p74d59bToE+Lpp/Oh45XMXTnE=;
        fh=VBojSBxdVjwSv+E5ootjzDmzwttLPtbOjlpuJ9mCy9U=;
        b=ON6oIsjyLq1y7ky2GppT9DDZUwpYHe9l3shuqL2DpurW45/Pb339DFIYMIdNhxKr36
         +nG0Jf49am3CR3UDPqRBoJ01SzhgTvJXHklsyChRdqnTizMq3iMKDB17xvohpZqe8WTn
         9XQWk3OC8yOursQWwZ2s8QnBRqbBoDk9jigWqbESwV959lAFPrX4sEN5kYjE6T8I890D
         iAKQwpKZS7heVpTNjylkW84A2mxZnSmH+spgQcwTXG5VGUTTot++acCxp2uoF2KY5rob
         wseBiHm3pvBWWJsu6kIFZFokrAuPfDwwpXZRTaLZfpAymZKXJYmZPyiB7gGMfH3njSI0
         W/YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775747749; x=1776352549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8gHcxWDojfxRJcIC8p74d59bToE+Lpp/Oh45XMXTnE=;
        b=HG1livZR10oAIgjEUc/aLBj65hnLxuk0Fj4i7HxOXVdbQA/y/yl0dXAC/unRwgkuP1
         JzTATRoQBetFoWOi/kny8NPBDSqJf9DBr0xfWIxmXn/xxjNUkDhcwz+wa9x2AqBHM0fU
         f/724ejiaMZ2nAplyP8G+DjxYj2KI8g8n1ZMc3Ns4V00bXx8k09FJYhvxiRZF6XbHltK
         CiQ0jZnB8OqrJ31mnwiI9j5QKYruOcLean28IPcyegHCd3UYiWc0jxJuNwn0P2yHtezw
         AWHoU3RzGEhP/grWbZv/yykZt3OacVKKTJT8tJ5vyO2msQ8BDGhMDf/X3ss4j0bEgt5V
         dhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747749; x=1776352549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8gHcxWDojfxRJcIC8p74d59bToE+Lpp/Oh45XMXTnE=;
        b=MNX+UvIzDKWkLCDp9ZbPH4y2pkPlQP+pupHkRDZ1A6qoEJ2cpirgDs2XjSzaLlPtWU
         6+DZ3jo61HF7/q/U/5eOjHm97c9vyRChyYK2JB03IQddp4t3vi8RrlIeUmNOFdo6eDH8
         iR7oOMwkMqn+zr7ut5O97/VxZr+M4tYXeLTZJli0fZDvjoNNRF49DO1DlXKf6qDXXKui
         hhBEe2wXYvKZNrLbadzmdd7EORKFFA4nlLUyH3pvUr3lBWuVRHO9fclYTDPO4k1WfHV7
         MLykeDd8Dx8XbjofwFLcJBN8pCmbjxTj/BTd/P2QlLRi81DB10TdzmmyWVd2bwcxTpGx
         EL9A==
X-Forwarded-Encrypted: i=1; AJvYcCWs6u9g+O2X8nXqImrJh33QGWFN9dR6DkCqt3yppJ806+a4eo5h2NlOffyoe5FXL32USMDllooA1KpxcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxp65R/ObdvThVmv/c3wbjaC7ZkM6ZosKSrWDbVFH46OYFRHa2
	mkfVyLtQt1YUIpAc22eGYQWizGJOAnCN/1DItghqBiekUt1s4aXc+85fnGxN698yl6nN1IWdQeH
	u5g+/POQVAzTae6DQWce4cmXdPr8Ljmw=
X-Gm-Gg: AeBDievk7I7O4dF14jzWGFazs+Qx5gFyQrExN1v+ST18oZindcRIN5HEbux9+kI8dUK
	+0txkYoxz0BuFPuktM5+/4lFBUAu6be73mFbzEqnl4pJw4Di7tEn1kXvAmYGQdtna8y+uoGcX8K
	SJy0iYtbBX05BuL0sBC3G2kXF33Yk8Z6NtlArX6ilUy2o90KOJsXHZY2apkN7VBpW/kmrKuKuqQ
	6iuYSy3xlps5R40I7cS4DB9zVYXRILTRrz4QJkrrom5D+fn59Vs3UCn0dO6KN0Iu2uj/LxhHeSs
	od1AeDWU0Ed/PySCFhothBcpR9/ZLBwKhJlVdqvN6w==
X-Received: by 2002:a05:6512:3f12:b0:5a2:bd67:25f with SMTP id
 2adb3069b0e04-5a33754ef53mr8698291e87.5.1775747748452; Thu, 09 Apr 2026
 08:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409144119.21500-1-dennylin0707@gmail.com>
 <20260409144119.21500-3-dennylin0707@gmail.com> <2026040931-robust-siamese-4e11@gregkh>
In-Reply-To: <2026040931-robust-siamese-4e11@gregkh>
From: Denny Lin <dennylin0707@gmail.com>
Date: Thu, 9 Apr 2026 08:15:36 -0700
X-Gm-Features: AQROBzDb0z-udGv1p6uIXsT5kgU3DDAZ9fQ4ecatT1Aah_tIVvEKU-D_r-sJsBo
Message-ID: <CAGEkeHd8p48H6U36VBFAAMffz_tW71jcb90POekDgG51JN4YUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: sm750fb: propagate error codes from de_wait()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

> Why did you delete the comment?

The comment was removed as part of simplifying the code while
changing the error handling to propagate the return value from
de_wait(). I can restore or update it if needed.

> And when did de_wait() start returning correct values?

de_wait() starts returning a proper errno value in patch 1 of this
series, where the timeout return value is changed from -1 to
-ETIMEDOUT. This patch then propagates that error value.

Thanks,
Hungyu

On Thu, Apr 9, 2026 at 8:05=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 09, 2026 at 02:41:19PM +0000, Hungyu Lin wrote:
> > The sm750 acceleration functions currently return -1 when
> > de_wait() fails, discarding the original error code.
> >
> > Since de_wait() now returns proper errno values, propagate
> > the error code instead of returning -1.
> >
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> > ---
> >  drivers/staging/sm750fb/sm750_accel.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm=
750fb/sm750_accel.c
> > index 0f94d859e91c..891d12a5e2cc 100644
> > --- a/drivers/staging/sm750fb/sm750_accel.c
> > +++ b/drivers/staging/sm750fb/sm750_accel.c
> > @@ -90,14 +90,12 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
> >                     u32 color, u32 rop)
> >  {
> >       u32 de_ctrl;
> > +     int ret;
> >
> > -     if (accel->de_wait() !=3D 0) {
> > -             /*
> > -              * int time wait and always busy,seems hardware
> > -              * got something error
> > -              */
>
> Why did you delete the comment?
>
> And when did de_wait() start returning correct values?
>
> thanks,
>
> greg k-h
