Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2EF23ABBE
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Dec 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707567; cv=none; b=gbiDzoE+koYPxoGJ8Q+9n6wI4gUvJ3v7XNd+Ahnj4hBImAgjQPwvXTM86+LrDNpHoWHeftaqsZWuQ5dsYk3qZqQGjoA/Ea+9MRWvvIeKCOLZBFasXHUZ9hA1NksgwZpB9y5o9HhKa4RbUUOJz5vXgEnqs2jxh1EWEFUsw3prWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707567; c=relaxed/simple;
	bh=xu08GN+iaE1NR2CiJs7br+IQxgHuECSd8j1tKJjCegM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ylv1MQvGwqhU2xeeXdYIB8WnM4OGHbsoJirZ2a3UVAOTG0ABCJGGNun2pbYPKHc5NqKjRdvg36JeorDpO/qNQJtrrs8rGRXdzPcNlpQTwf04QtQG4PBYTU3nERqD+9jHQVH9mSoqfcPVNwOSEszpEdjuQ1tUnQJrRxc/WJVbcfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SufxYRkA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SufxYRkA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477563e28a3so1375555e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Dec 2025 12:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764707564; x=1765312364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUBtZ8cLKM5d5hZ3mQmHNgCoY0mmWdEWs/wmEJwMqZY=;
        b=SufxYRkAmLlVxpv4POQc7Yy24G6Z7cfoCVr0wrOHbkr+bBCQKKb14vJ+ShUdzmTUGP
         7x1Q1IsfS3BMIWAofuD5szDqePIqgjgQj/yvqMK1xaSKRivJVGm806VihXQgCpls2jms
         Shy/82wx/1djoMP6TeMC5ZkHfyV2vX+5ONUdV8Fsj3aOgSUqfmLZ48bbxVWdLIx5Om5m
         Czz2PWhUOlolnZ/Dz8Diq1gNegtynP3PZiQUJ0UD7ZRdjIeC9X6JH9RSx6MRrG9au4bW
         mRSQjZuBxZkjRmApbVpL/6gakTBfbtKtSlB6teBuO+8GAqFeYHO6oRuxpEXfWxz/yaUW
         /LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764707564; x=1765312364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PUBtZ8cLKM5d5hZ3mQmHNgCoY0mmWdEWs/wmEJwMqZY=;
        b=BVjx1HJKUIAjr0NrmT3lZ73nTed21IutUdJjf9QjiPw8KCM1w2nvFAz+39I3mlLgf6
         3cONqYCRJ1sdQmACGnwbveglYT2oC5EDQbUgQjonOby1Oq+EPMeUSYd+rfuQEPD07nob
         /bx3ZVmiAZUEehoUILsOu5b1I7OzjHLIwkG3GsMeDHEkr4PyckAgTwBDPEt5CCokdFiW
         2qS8pU3ENjPonqmS1y7MZwgXYlp1hFgCbfBsJoV5i6H3BFGJg1LX1OJ4DKWKteorHs5I
         vuMW+w4c7MQ7gzCv/AFeWFEGaIaJWhxUVZsnv5pBDwl5fe1DWPktAqZY3dS/TDH/FSfd
         j4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUipX8bPlK5Y2UTRpennGuGvRfOURH4+6TuYFPB5TMhVVct7f103vue9HC5WxgFpRsbX0spdnOu9eYwYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyA3uRop79Kdzt36s6IxwiDT9WXFP/rFw8JKwlv8k6nuE30o3u
	+KW2G1nGTFTMkW8RkT+UH/xsADxC4eBzqlmDxu2fPJ0KQaCf1Jhp+U5w
X-Gm-Gg: ASbGncvpxnI39apHdoMdczWmu22MRKz/znkfHmEih5uV7/0wmDtesmyjVfqD+9qagDC
	ZJoqDjuyFTxJNncLPlOQCmDIdV8Ehg+xgD22KZbNDZdG8QK7c57B+wvsT8U1dhf38sq+An/PWWR
	HSOPlF6z2PhstR7elzK5hwqlzTVGfDwZmNHp1cCuYVJsgXYFuM8dVNKTLQ+sZg5FtKxmYN69OHc
	5vYj426ShtM7f8ZkFX4eiBXV9dwwGAZ3SRHBb8+NRkfw8DNlIiGyw0lThsJfhOh3taIqEbAxNRo
	9/hEv8g6AB5tK5afMJnn0DMVV6aFpN3IgUIii0UJyr2KIJAIgRVGmggtHhp4Q8I+OWhJjRj+yze
	ixGDCGHiPwCdzrAJndRRRUQGP361YCv5+3R89zBCzcSv72YqwkDmi5/JZMaejm+ojT5n6wepmge
	YNbiWcOZ1qTgHG/O4LwWNqRT7jVUf4ibuwYORb8+kwY9BdqzVtdby5
X-Google-Smtp-Source: AGHT+IFivlozvH6bBlGbstrebUkwLUxZxo6lElB4cxa3RUVfhbge2mArpvbfT4BqVBOBwBydEMFZ6w==
X-Received: by 2002:a05:600c:c8f:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47926fa069cmr46582875e9.13.1764707564292;
        Tue, 02 Dec 2025 12:32:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a8ccbfesm6461965e9.13.2025.12.02.12.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 12:32:44 -0800 (PST)
Date: Tue, 2 Dec 2025 20:32:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Helge Deller <deller@gmx.de>, Chelsy Ratnawat
 <chelsyratnawat2001@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Raag Jadav
 <raag.jadav@intel.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/pxafb: Fix multiple clamped values in
 pxafb_adjust_timing
Message-ID: <20251202203239.63084e0f@pumpkin>
In-Reply-To: <C3FDBCE7-14D9-4999-B463-C2E3E384E7DB@linux.dev>
References: <20251202181600.511166-2-thorsten.blum@linux.dev>
	<a7213b69-f6ae-4975-8c8b-2783dbe9f9b3@gmx.de>
	<C3FDBCE7-14D9-4999-B463-C2E3E384E7DB@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Dec 2025 19:36:17 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On 2. Dec 2025, at 19:28, Helge Deller wrote:
> > On 12/2/25 19:15, Thorsten Blum wrote:  
> >> The variables were never clamped because the return value of clamp_val()
> >> was not used. Fix this by assigning the clamped values, and use clamp()
> >> instead of clamp_val().
> >> Cc: stable@vger.kernel.org
> >> Fixes: 3f16ff608a75 ("[ARM] pxafb: cleanup of the timing checking code")
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
> >>  drivers/video/fbdev/pxafb.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)  
> > 
> > Thanks for the patch!
> > It looks good, so I'll include it in the fbdev tree.
> > Out of curiosity:
> > How did you notice? Do you actually have the hardware and tested it?  
> 
> I only compile-tested it.
> 
> I stumbled upon another driver with the same bug and then used grep to
> search for other instances and found about 6 or 7, including this one.

I've just hacked minmax.h so clamp() and clamp_t() (and thus clamp_val())
are 'static inline u64 __must_check clamp(...)'.

Didn't find any in any other files.
But I think you missed some double error in the same file (nearby).

	David

> 
> Thanks,
> Thorsten
> 
> 

