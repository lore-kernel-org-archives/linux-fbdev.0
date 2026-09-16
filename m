Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A141443B
	for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560520; cv=pass; b=Vu87EMvzDj30fB41CNuYCFrfom5yvBFeE4h0L18iNaGIIyph6PTcK/2HHiXa5cKmS8jgbfr5c1GpOWSBstgm+L7st0DyZ+SWGmH90z6GTcW3IpJAtAYOLJvl5rQyWiNcSfgQmii5geFJb2mYyFMPOIQFJiJ5kjRo8oFPmtWfTvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560520; c=relaxed/simple;
	bh=xSq8f10yAtabOXxWdIiS/nzsSXBzun+1m9a/tEIW3Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaLfS4pHx8X47riBzggaXCUemexqRyUsnkxzXzqjYzSHeVhNK8Xxjl2EpqQKmPXfEcKa4m8jp0GMVj52bgLy7ylQGU34wvdVpAPC7ROP/rK/JRhqWR4zaLHrF9NP+/tsR3WTUxdSeNjF53itWeWeUO+G8l8Sj31HuGRgw924vLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTkCwACh; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTkCwACh"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530fa0716f6so8883381cf.3
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789560510; cv=none;
        d=google.com; s=arc-20260327;
        b=qaBvVGgFmgvH4eyfQzBHnheiKOT4PDghXW0bp76wStrBhvnjR/WUmMBRs/xKPu/4Jw
         lGTUdAphk+bYobjI6igVP/tx4Hw/fLXoKxB+ftSzmRPuIEbr0mKsZZr2c6BklrmOrhYN
         q1Xa7tymdX4dbJ95fyKWTfVkY521K7A+A4S3qHZaV0WVmesz5WbbpZ0zuf62EpONjBJz
         IE1A/7rS7Z/aZx0y5Q34v0FVHgvJNCf9oZYh8eu1u3DfVoTz86Mh8Y49DHUbs1NgArzo
         jWJG8Uuv+wC/sviszrzAFCLfkT0Lq2TXzuJbRm/I53HT95lVfTg+iH+TXZj1WIMHics7
         v2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xSq8f10yAtabOXxWdIiS/nzsSXBzun+1m9a/tEIW3Hg=;
        fh=1nMZ0HVXtIRZBFs23fzP49SxLj+Jl20Oi9H4QeMyRcs=;
        b=T3hhsXfHJfX6Iczu7pDqt1F7VlAv33PvN/zE9rOUNGTUv3a+9Sx8HE+7eaQvh6zCDf
         FqsCOYm4HOofm59S9FQgb1gmq4szyN1paRJAdS5ktHwT3we3TUlbGFjAGevoQO3mGxJx
         jXtCkqwHlFq3XYqa3xkkzheydsEm0CFPxMx8IpagM1/U1VC7z8yJ4eszsez5gqqcZBkb
         SUsDSWgs5Fhd4OjWIBagP6J0sSiPWgyBGjF8/U3+CeW9krhOgA6kXfY+T17q1ZPz+Ixi
         d/IoOO6SjHxDOp/6nCKHhvW9j3UOM6Cmvn8Y21/dLIO2UqdZUJIZTNH71wX5+3fKSRqw
         C8bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789560510; x=1790165310; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xSq8f10yAtabOXxWdIiS/nzsSXBzun+1m9a/tEIW3Hg=;
        b=eTkCwAChrQGmVSAzHGH4RJ3iGz6c4hr9TaTVS9hAzd9k/oqBCE+OlGlLSSQR9wl83S
         WY0Inor5ivbw7L64WoQ/fXZIiSpHsNIYrx5OUwSm9SWbGYaCuOclgPXHHpH41QRMgpl1
         9q6lRlVUMq/8hd3/o6Dr51N6oow8JRHKe3KLjNbZpMcxKc+USoRk6rBoigaBR/5keTI6
         5Y/vTYvn+uT2/WnI067+EdtsSvAyHBs6qUEFsJshuAMzq0dmLqkU+qK98sTeMum2p1iq
         xog6q0H93JnS4fLoJWqDRp7qHIoFv4O1mvDbvg0gfZwSbVc4OuHu7rcjHfybupkCyTk5
         81Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789560510; x=1790165310;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xSq8f10yAtabOXxWdIiS/nzsSXBzun+1m9a/tEIW3Hg=;
        b=mW5UGJMmZo65a9p8UqQvChgeCDmh/JgVp4ivyagIN1Ad5eVNB7Hbmmet0TGUR+Ai8r
         EsvG7i6+EBSvUitApzInxg/Xo+p4d5UEBaxFJkP6pdj3aDextH/Uf5SlamzZTNbgs8Lk
         2duYTvlQUBPsbodWlbl4JS0l9nQyME/S/TryXgE2EtzEpE7o3CAz9/PeQEYQ6dJUmyT0
         azdFq9dLMnVt8W6ppnknWBeS7HcCA+lgk7p8QvpApCx/ZHVJyH7kgyK8tgM2/0KuOcZ7
         Dh1SPBdb4KTRJQbGogRqjE1MrnQzjqao97Myt77A9fZA7iP4fY/BIXlqTcNlld1pQR9R
         mm3w==
X-Forwarded-Encrypted: i=1; AKwUvBwwTNeMraKAIf+OYXwqnzMcPxW85UBhNi0XTbYUYBwetoOqvHYbeTtvTuofTYu8GtaoPBkoW8eCeBiI4g==@vger.kernel.org
X-Gm-Message-State: AFuF++nWfENv0WWefM4FDxSMNSrJknbnOtEKfPI3Y+bz/43rYfVl3rMq
	wgCyvh+8cdRJnkrBYjFIqlZq5mQhPWxea8opfubm9cecW5u/K0hDyiGZm1gKUGpB95F9mqQ+rGJ
	TEOMAjGq0UYr4erHcwr9nC6BVoYV8mPI=
X-Gm-Gg: AYBFou0AtUkxAAi6euwN7N5MKvUR4Oh5AXawrQLO6VCrXmWEEg9amX+SjJzzTPc/MCm
	yV5cEkIdTN4SewbdI6bC7l63SatzSZQDn+1pTVcij+yjwk1+7EN235YEZUUGrC9W6fQKn2qzUtP
	HuLFeawaZNQl3tH3DPMAZCQf3KAmdmDLougAv+f3VjJ1Nrfr9lgFAmzuMyoRiBxQH73/Sn4f++f
	snfGnlDdBsbdmz9+RlvRBlDpAfZq9GsFnLZWDz4gQs9B6bZyxUAfz0utrt27XVdrKQP0JP7+khv
	6SbNRfxmDoWBQthFcDDHbeQNKh0sZu4cdyz8SSlwx1sl7Mv/y6EgB9rb
X-Received: by 2002:a05:622a:1b19:b0:530:5ed1:561a with SMTP id
 d75a77b69052e-5327eee82f6mr43123021cf.43.1789560505709; Wed, 16 Sep 2026
 05:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916093928.52057-1-palaomer100@gmail.com> <87ecet5xos.fsf@yellow.woof>
 <aqp4GA1q6cLKivZo@ashevche-desk.local>
In-Reply-To: <aqp4GA1q6cLKivZo@ashevche-desk.local>
From: =?UTF-8?Q?=C3=96mer_PALA?= <palaomer100@gmail.com>
Date: Wed, 16 Sep 2026 15:08:06 +0300
X-Gm-Features: AcwNN1WOW2WDT240y0ILa-CLMyO9YvF4o43EaQSFbhxhDmsrCMG7d8RZROqqgSQ
Message-ID: <CAKhZXnr0GdUrEu9vyMAWRCWyQzPM7cWQ6LRDa8fX0hnMkTN0RQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with usleep_range
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nam Cao <namcao@linutronix.de>, andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 16, 2026 at 12:39:28PM +0300, Andy Shevchenko wrote:
Replace udelay() calls with usleep_range()to avoid busy-waiting and
allow thescheduler to sleep during delays.
First of all, too condensed commit message. We have as twice room on each line.

Hi Andy,

Thank you for the feedback and review. I note the line-length
formatting (~72 characters per line)
for my future commit messages.Second, do you understand the difference on what
code is doing before and after your change?
I understand that udelay() provides deterministic, busy-wait timing required for
hardware register initialization, whereas usleep_range() introduces scheduler
overhead and non-deterministic delays.
Out of technical curiosity regarding the driver IC: theoretically, if we knew
the exact window between the hardware lock/stabilization
time (min) and the internal state-machine timeout (max) from the datasheet,
would a range like usleep_range(min, max) be acceptable,
or does scheduler wake-up latency make it too risky for
timing-critical init sequences without hardware validation?
I will drop this patch series.

Best regards,
Omer
