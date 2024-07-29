Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BD18A93C
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jul 2024 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288941; cv=none; b=NS3x8IozDWBQHifXXrB4nKPHMWGGuOmwMhIn5LUGwXc8+dxnKyYdym4v/9vQ0Zs5VdghBPc6yjYtc8g9ceERxhx8m3Z65svOscCYSaKG0pbCm1TwlGSJkQUtyp+j0rljDBiPbxBdsYV3PIDGxX1bdNl+AnoFyjxf3Fu4ODrlJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288941; c=relaxed/simple;
	bh=DhOLdiM9YWhv6ZcKyKdrGJbx+EvMKRcY5IZ/2bt8Y9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEO9ECUuMQHe2xk2ldmDdcca5tETTJSStQ8PTQk5Z76kRMUOaHqFdz2ffulKK9F9xKWn6JhHgpOhkuDOAkQ9D1ARYMl5HYAScA0AnUjw6mnS4z577mi8WkgpmYBaxSPdJB8lsvHry+YIn/KVBGQsB86xgldKDWt7rjZdW52wK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sZqvj1Ze; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZqvj1Ze"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7093705c708so3972440a34.1
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jul 2024 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722288939; x=1722893739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8jCZ4dJacok9yS/sGhPIVw4hVTsTqbKuUreZrjjqP2I=;
        b=sZqvj1ZefP41wGT5cKfvYjUgsSEWnLED+8SZ8UWuiFkEQaapBicrOvzh7j0fFw14S7
         GrvoOwAYGzJfSbiy2404qrobEOzOoAd1OR5i832vT9n4ZsuKr5CC274YKICZSXaK5O1h
         9AgWyC73iWi3TOPioWrZ1z8Pq4SF6UWbxGJoJf77wwptsMwN0brgKJvJaKSEp4P/78Ht
         7Uix2+d1Kex2S6/yxxXWHzIkjek4/X5oxppNKArEhXCcOdi64JEcvJqc1lM+zzRgZaH2
         G75ExpGW0uXR2uPCy3DLXefqM1cx7DlPi2dzCyLtIVMwB/raea7lxNlIKC0ahGgJwRR3
         lhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722288939; x=1722893739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jCZ4dJacok9yS/sGhPIVw4hVTsTqbKuUreZrjjqP2I=;
        b=L5WjFdG+vJeLbct9Ll2i7oynJgMeQjb2eXdfgGEGxJVjuaAoooqI2fnhSZQyfSkhpS
         JrvaBaOf4xnhYK7JDF4AIVW/jQdJ3GI85799wXQVywfLOYyllFAJ3aIi0zKeENMqY+wc
         bQWs8sB8lMzvdNSDxgJ8mggGArsE42SJ7NXoxB6GIHcyVIxg+ZAi7PY69NCdugOgRXIZ
         7gl6TNgAnBMlNQ2yO6bMYOoY4+cp+wNfLBkv5lYGB8en1c2YnlpoCiOTZSLHZitnq8me
         QvoIicaQWdzS4TsmPzxX+awlGU6u5xGM3UNeElbuowkFzKtFD1WESgs3J5deGZmlfgCk
         EVlg==
X-Forwarded-Encrypted: i=1; AJvYcCW1ohgDBlKCpi0Il2XdOrq1vEbmcWoBgjgw4ofRlB39X7SZs6liRoq16x3/dttDEAT8YWnzRLC84l5+7eS4p3+pxfdGtra64Y6D76s=
X-Gm-Message-State: AOJu0YyPKB/reu9eszOjuxbgOFN+IItnQL86pj8LZCCNkUwVAJTqyB7z
	TcGhg5jo4AFRB4AIkasailuy8PcjasrAQGm++NFMlfg3GZ53vHjKmWKH/fXJQ1k=
X-Google-Smtp-Source: AGHT+IHDvjNGEn3OlMcAR6Il1gwE9cH+Q82mJfYpkkx7Ley40Dv5Z1neEY9qJN9BU+smiLkpIMX/Og==
X-Received: by 2002:a05:6870:46a9:b0:254:8afa:6914 with SMTP id 586e51a60fabf-267d4eedec3mr10816825fac.34.1722288939167;
        Mon, 29 Jul 2024 14:35:39 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7095aeb0acdsm61008a34.64.2024.07.29.14.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:35:38 -0700 (PDT)
Date: Mon, 29 Jul 2024 16:35:36 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Helge Deller <deller@gmx.de>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev/hpfb: Fix an error handling path in
 hpfb_dio_probe()
Message-ID: <9cc6ac18-3804-486a-8549-fd13b6ae121e@suswa.mountain>
References: <dc4fe3d857849ac63131c5620f1bacf1a3d7172e.1722191367.git.christophe.jaillet@wanadoo.fr>
 <698958fb-4fc8-4288-b067-5843c651b093@gmx.de>
 <ac4c6712-c47b-4414-9640-3018bf09e8fa@suswa.mountain>
 <9dbb2b52-4fc9-4bbf-a6a2-ab6ec32adb8f@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dbb2b52-4fc9-4bbf-a6a2-ab6ec32adb8f@gmx.de>

On Mon, Jul 29, 2024 at 10:09:39PM +0200, Helge Deller wrote:
> On 7/29/24 17:59, Dan Carpenter wrote:
> > On Mon, Jul 29, 2024 at 10:13:17AM +0200, Helge Deller wrote:
> > > On 7/28/24 20:29, Christophe JAILLET wrote:
> > > > If an error occurs after request_mem_region(), a corresponding
> > > > release_mem_region() should be called, as already done in the remove
> > > > function.
> > > 
> > > True.
> > > 
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > 
> > > I think we can drop this "Fixes" tag, as it gives no real info.
> > 
> > If we're backporting patches then these tags really are useful.  As
> > I've been doing more and more backporting, I've come to believe this
> > more firmly.
> 
> Sure, "Fixes" tags are useful, but only if they really refer
> to another patch which introduced the specific issue.
> 
> But the tag 1da177e4c3f4 ("Linux-2.6.12-rc2") isn't useful, as it's
> just the initial git commit. It has no relation to why release_mem_region()
> might have been initially missed. See:

In the last couple stable kernels we've backported some pretty serious
networking commits that have Linux-2.6.12-rc2 for the Fixes tag.  So if
it's security related that's really important information.

For minor stuff like this, the commit will be backported as far back as
possible and until it ends up in a list of failed commits.

When I'm reviewing the list of failed patches and there is no Fixes tag
I think maybe it was backported to all the affected kernels?  In that
case, I could have skipped the manual review if the patch was just
tagged correctly.  Then I wonder, why wasn't it tagged?  I just assume
it was sloppiness honestly.  I'm probably not going to spend that much
time on it, but it's annoying.

When a commit lists Linux-2.6.12-rc2 as the Fixes then it still ends up
in the failed list.  But it can't affect too many users if we're only
getting around to fixing it now.  It's easier to ignore.

regards,
dan carpenter

