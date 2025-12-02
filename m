Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831B1EB5CE
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Dec 2025 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700631; cv=none; b=uz33A2TVyMzY0QgndC4UGeqtU5V8ZYbBLhxRkmDBoSi2pgfR0Ke84S1VoQttLzRsk8M9RteBEbjA3dVmZFh+k3W/j4z2UJUKaUgRGhv+h0fCjZEJTHc8rFnCHz14AqTfPwPveHx/L8fZVzY9az1O+adLJGvNXyPrgNBiPjpNmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700631; c=relaxed/simple;
	bh=dHrqYREAv05QJx6hYd0S8NJACtertzfsRgf28ojK+Do=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Fb6VhjrgBotTGX0fFujyVigfmqugBmddzpDUwyaVJT2e6uBchRjqWTWLyvcKs4csZCnlgOyx3Q5NkRQuUHcAtVZ8NSgTHa0tI+8ed/08aNEJOSS/NtAymNXrJyhA3ksPBqP4aKKyK3r8ycxyDSo/inialqDL9KGLxa+3JjEYiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ftGOcnAt; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ftGOcnAt"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764700612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/daahefy1tziCXh8rTYQKwXMLI9Q8fbfkXdYGxbLymQ=;
	b=ftGOcnAtb7rEwvHSSaaZRAO+AOQgEOurnOKBtmTodsWO6JSY5m4ELSaUaLb3QvmB3Hg/zk
	BCYA7h/gq9CLtke1aSUTUXoYJVv+0KP20C577EP/At6w4zQNSlNgeNykAbMmaebxY3wpR7
	6xbWczWt2V6XEa+3RryqlGgsHFMPMDY=
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] fbdev/pxafb: Fix multiple clamped values in
 pxafb_adjust_timing
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <a7213b69-f6ae-4975-8c8b-2783dbe9f9b3@gmx.de>
Date: Tue, 2 Dec 2025 19:36:17 +0100
Cc: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Raag Jadav <raag.jadav@intel.com>,
 linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C3FDBCE7-14D9-4999-B463-C2E3E384E7DB@linux.dev>
References: <20251202181600.511166-2-thorsten.blum@linux.dev>
 <a7213b69-f6ae-4975-8c8b-2783dbe9f9b3@gmx.de>
To: Helge Deller <deller@gmx.de>
X-Migadu-Flow: FLOW_OUT

On 2. Dec 2025, at 19:28, Helge Deller wrote:
> On 12/2/25 19:15, Thorsten Blum wrote:
>> The variables were never clamped because the return value of clamp_val()
>> was not used. Fix this by assigning the clamped values, and use clamp()
>> instead of clamp_val().
>> Cc: stable@vger.kernel.org
>> Fixes: 3f16ff608a75 ("[ARM] pxafb: cleanup of the timing checking code")
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>>  drivers/video/fbdev/pxafb.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Thanks for the patch!
> It looks good, so I'll include it in the fbdev tree.
> Out of curiosity:
> How did you notice? Do you actually have the hardware and tested it?

I only compile-tested it.

I stumbled upon another driver with the same bug and then used grep to
search for other instances and found about 6 or 7, including this one.

Thanks,
Thorsten

