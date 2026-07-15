Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894DB3C343E
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Jul 2026 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100534; cv=none; b=HZtrjNxLCvz9MqAJbhXQiH/bB0R4ekkeKvMAb74zyOsVr+t5g+UwR/7ZI9eppOVOZx4uhVW5VXjFVnfDisAs8hb+4KYx7+m390q981eFMHF9WH/nyePJj60rskU3Xtes0fxfljdkNPPPFDwN1G0QNp1CRY6ciHweislr88HLiGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100534; c=relaxed/simple;
	bh=kyLCZZV9kbfs2YsCqC/zFnPHyjufd3uJsLGVylKb0mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opCliC+OenSiynmExpRl0zkhe2GmS3Qi6PcRX542KUEaI5iuGNoLkx8qGnYN2qXAOqJbN3eCOZZ1OlZyjI3pdNyAKajnEorIN0j/LjV4+3KuBxIjSOGjgU85s+WRd9EJOF3kxv+2We54fBTJsCCaFLffUzQRzf3QNlPH6t6AM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfqnnlAL; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfqnnlAL"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a3d9aded38so200507eaf.1
        for <linux-fbdev@vger.kernel.org>; Wed, 15 Jul 2026 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784100527; x=1784705327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UxQ0BxbdBsXkQRkJTN/tYd3cFPb7z2YjlCsAC7VkUCY=;
        b=RfqnnlALI/z9GiNooOhqDwqyoMUKcbUBag3Xu+nwbDbYggTYg7kukHDPvyDM3NWofi
         6Ny5AY51is/RVcCw6KkRFolWkQ3Ip1PVdnrpuBxw+ds7+ohq2J6st+YNQ6mOMyD6xoS5
         aqKQwNo3yiea/T7yxCKXvGJE4iHcj6fqOww63URwQmS9XjNRPF5wzChgpPvcdNqYjHMb
         NEgFWvN+ri8sgALOQRx+wzTodkiG1y9vE5q6FrzUVG9mZevbNU8F6msBS/p/RVp1YkJr
         K2OMpR7nvGH3vYmd6BDsUmIpOjLFb+tobSpAKv4GaQ4yDBxlvJmuly//SLwwC1NzB+PX
         +8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784100527; x=1784705327;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxQ0BxbdBsXkQRkJTN/tYd3cFPb7z2YjlCsAC7VkUCY=;
        b=OppgBTeYoun8tUZ/WZQCCdkLBwtQsS9a9YpKo04n497z8ebZc11sEnFbBMNRhmDFpO
         DaPNMaPRGbYdUIITMCNEXqn3HksBVuvgqtILrkD/n3QGooaC+zdpuif3WiaowkcS8M1k
         +ZHZmp3VqbQJbpwyP4LvUPdSB27cWOnxVvs4GQH2GjAM015XOXlPBgX2sTQiaOExUDBK
         sUy1cx254LKdUVj+pdMStv0UGXCRUDElrz2mFkwOZqTQadxVgzevu67o7ZI0l5DFpC6A
         3lY2vmsrMq55E8wZx4ASfifcScHinNONyOWoRdMJCdWFbLJ+51lql7eqCHjsE26KIntS
         Xj1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqkaqxCEHH2ZOrpG8DJ64pV9xRnMBoJKpiCr8Ayo3WYnz9YizDpkNhRzBijqeIxUF+jBxotcfpXWgKOHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxErEwbHOeS4eHh32hKiKvnSRm/3RLed8dpJ033RRLRMHKdZMLV
	81j581KXgahUjWMBH35ssxpLG2q4mj9ALhsz8P++LJ2WArE9g++V4T8G
X-Gm-Gg: AfdE7cntSVy+lDuvrVJf4G/lnicV8t0PrZyuj9K9OLuUq7SP5jx8GbNAw1OtxRphsE6
	Y6TPldT7PMO6LUrQuhgSqC1H+yIKlK062qX2cpxdogsEntizbwbDGJl5G3/jmU19xhQJ6CihIKz
	YnTV/Kumwl5KZH8cjeaMGzPgWjwab32s4QAV/HKTsq7WddKxdRd5D/fXawQU8TH6Rze7VMJHV1b
	UoXqtKPtZkYjDfEj/ElAW4CxLDJpYUdkJJdF8HEuZb+cTfzAt2/Ru3HqVbQRMG2Yxms4ljUBqMV
	eBtUCIddWRloJ/LTacx6gyaGtJWrsJJwUrA2Zi05c4R6HPqebGH4jc4liRRn2ZXJnV1wnuX7SYX
	VegZk1QxJWNghtN3yLHOwk7EhApmcTPjXfhru0Vn4Scu38jekVj6+m0xf5g05ij/7P55fzrVpl0
	9bpZD8
X-Received: by 2002:a05:6820:f021:b0:6a3:1b9a:48e8 with SMTP id 006d021491bc7-6a39bee8e8bmr7442734eaf.33.1784100527217;
        Wed, 15 Jul 2026 00:28:47 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a3b0d60sm15711707eaf.0.2026.07.15.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 00:28:45 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:28:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
	tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging/fbtft: Minor cleanups.
Message-ID: <alc2pxlSIEv5FMWa@stanley.mountain>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>

On Tue, Jul 14, 2026 at 10:09:38PM +0300, Panagiotis Gravias wrote:
> Solved some style errors,
> parenthesis spacing, aligning arguments, replacing udelay() with
> usleep_range().
> 
> I hope this makes future checks with the style script cleaner and more
> helpfull.
> 

With old code you should search lore for why it still exists.

regards,
dan carpenter

