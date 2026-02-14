Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF726299;
	Sat, 14 Feb 2026 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771034201; cv=none; b=LcAhHH98U6JTDq9Nyx1F1UsqrDULXLKGpaVvCDaWovHaOuVI3o8sBjvQvd6xEK/OKJsUsNArlT455az1JnzH3xpsu9aKPVxYX1M6EDZ+IGpxVee/RMrudQL6zA7KeLmzIKxq7zFf9HLgIya31eqlkAZIRCdc0zEz1tX8wYhVRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771034201; c=relaxed/simple;
	bh=y0qFDWHJzfmp+ZG3ctiKK8oU8El8fnF24uYzp+cdIrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Czc3HniHUXZMSnHtQr4/I2+e2ajEsmZ2jYEuTerEkvRQbKOsixT8KT+UT/9dzqDTz6LGPwNO2e61QmOtYrHGDMwF5wS6PNiOt+/oDpV7s4s990iTBrUYsYSGNR6bfmKJDNiGhT8W8N+G47r6i/Fw+r0gfNoX879UIJmDsNBoJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sb+n9RJl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kiWXtmdX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sb+n9RJl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kiWXtmdX"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771034191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HUCehdSv7BWEJjhfmdtQXE6xdl/l2tpt/Faur9ywDM=;
	b=Sb+n9RJlLw5aRhJL1coedSR3IQEhPxX/eo229RhG4uPC2hnFkwLuT2zI+FdI6ZXzu3s5co
	KG1y+JSZU8IhSqjtOf3bOpOYdPeJXhepdXfcYVKnLdMVMjM3kRk3KMObWwypooQB3N2rOi
	8YkceM0/YY0nkhphPqPMlzZL2WHtk92ZyFbxn02Bquw/O4TYjw7/Yzv33TrTGo4dt5Fz20
	5jtoQjXrsAVovBDp44ErUhpBUOkR/XUjge0ZbxRAGyJxnh4iJnwWM/+L3UNqHZIP2fTKIe
	+xC8JMWnSqZBsE/NNrLv6aQgFhKIkBFisYtTD8Xd30riJa5sdXAcGPymVFO+jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771034191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HUCehdSv7BWEJjhfmdtQXE6xdl/l2tpt/Faur9ywDM=;
	b=kiWXtmdX2JmlffBLFKeHYNy6wTbO5pOzAxmHN1tFbK0Ip2jAX3qWh022l6VUsKxHxT25z6
	j9oQv4p0GxM06vCQ==
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Optimize partial write()
In-Reply-To: <aY76ixvOUEkvoPk0@smile.fi.intel.com>
References: <20260213085946.3673695-1-namcao@linutronix.de>
 <aY76ixvOUEkvoPk0@smile.fi.intel.com>
Date: Sat, 14 Feb 2026 08:56:09 +0700
Message-ID: <87bjhsqe9y.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> On Fri, Feb 13, 2026 at 09:59:46AM +0100, Nam Cao wrote:
>> When user write() only to part of the screen, the driver still updates the
>> entire screen. That wastes CPU cycles.
>> 
>> Optimize by updating only the changed lines. Improvement is measured by a
>> pair of trace_printk() at the beginning of fb_write() and at the end of
>> fbtft_deferred_io().
>
> Can you elaborate on the HW (the exact model of the panel and [sub]driver)
> in use?

My hardware is the Adafruit's ILI9340. Driver is fbtft/fb_ili9340.c.

...
>> -	/* special case, needed ? */
>
> Do you know the history of this comment? What is "special case" and when does it appear?

This allows caller to pass -1 to "make dirty" the entire screen. The
only caller that uses this special case is removed in this patch.

...
>>  static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
>>  {
>>  	struct fbtft_par *par = info->par;
>> +	u32 start, end;
>> +
>> +	start = off / info->fix.line_length;
>> +	end = (off + len - 1) / info->fix.line_length;
>>  
>> -	/* TODO: only mark changed area update all for now */
>
> Ah, this change actually targets the TODO!
>
>> -	par->fbtftops.mkdirty(info, -1, 0);
>> +	par->fbtftops.mkdirty(info, start, end - start + 1);
>>  }
>
> ...
>
> In light of the last TODO line I think that the change is desired by
> the original author. Nevertheless I am wondering about these side effects
> that might be (very unlikely?) considered if this code (partial refresh)
> runs for a significant period of time:
>
> - some bits of the screen (on non-updated part) might be flipped
> - the static picture may lead to wearing of (decolourisation) the panel
> - what is the thermal distribution (probably with backlight off)?
>
> Maybe it makes sense to refresh a full screen from time to time, but
> TBH my knowledge of TFT panels from last decade is quite limited. I only
> think from the point of the general physics and common sense. That's
> why this long footnote rather philosophical, but I would be glad to
> learn the state of affairs of the modern TFT panels in terms of the
> physical parameters lasting over the time under different application
> cases.

I can't tell you much about TFT panels, sorry. My company used to do a
demo board with one of them, that's how I have some hardware to play with.

If user uses mmap() instead of write(), then full refresh is never done
(well, unless user writes to the entire screen). So if lack of refresh
is a problem, someone should have noticed already.

Nam
