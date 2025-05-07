Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C80224FD
	for <linux-fbdev@vger.kernel.org>; Wed,  7 May 2025 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653063; cv=none; b=DbrsEZS7Wfo40FWzIGrO0JxV7xCIeobMc+Vf7pzEvVnPwNWCr5dPjGTGMJpHB4nELXxLRz8GCpME1qTOhNEw7dC10HIUqTirfpHYnTmP2ugt1e5x51dZ1qy3PNCiKcWJmja6+Co5Zn4PC5mFMA4kLE9xPEhw6J8wKxtQsR8lHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653063; c=relaxed/simple;
	bh=xXXlkiNEvfqaweYY5ahjAvOHZ6znhs0R/7Q9RpAZavs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ggh/BnZGx5kU0O18+XXke/C1j3XDT/bgKZeOXkvLOUuzmN9X1GfaiMqrSmy/mVMd3Nd03Y0x03SG05jjapW79pZrwlz+ccSBvF8MdB7oPwWcSpF2iV1+/RA7JQ2xDI0e6NnXtrXAV6pZrp/3Q5TDmSdoQEA1nYLz5CWARgyggtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=WJN+bby5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="WJN+bby5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746653059; x=1747257859; i=deller@gmx.de;
	bh=xXXlkiNEvfqaweYY5ahjAvOHZ6znhs0R/7Q9RpAZavs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WJN+bby5u7oZv2+OdTiLjOB4BgZ7Ehmz6+SHYEAaxAo5FSz2N9yy0+WkVHZWeWQw
	 XbmmdtIClPaSkVB0nSsfRcJ/C7gWLXXQkrohRvXm3ln8qEPZEhuzXeF1pX9kkmYje
	 8o9caLsHAj2Q5dJk5Rs9+wcMOLDmid8Xka1d3WhbjvWqQNx7eR397r6NdIcVucUI3
	 r/IvdxhFpaJg4tLoUGRrBd4RD39ykqPx1s1E1ka+UZX1Fb29Y11tZe/xdkDMhuJ3E
	 GfDpby2zGJoJn7yO35HdAur/0lQDv5VecWL2T1AZNLFTdJQODVykNWw7uVc8zffxq
	 RgVAtpq2mPXqFJYvpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QS8-1u8OXK39fM-002Wwy; Wed, 07
 May 2025 23:24:18 +0200
Message-ID: <0d5d12c2-774a-4df7-8f11-63c1e11530de@gmx.de>
Date: Wed, 7 May 2025 23:24:18 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernels >= 6.3 disable video output
To: Steven J Abner <pheonix.sja@att.net>, linux-fbdev@vger.kernel.org
References: <0PKWVS.1URW9ZPYBULQ2.ref@att.net> <0PKWVS.1URW9ZPYBULQ2@att.net>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <0PKWVS.1URW9ZPYBULQ2@att.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dDgiwg4ayZN5GBWq77Qjgd/4FMulvtMftPNe7cNdYb3wOvLcds8
 EEihqCQi9jbRG9xrcICwQcFkDiE0zJIVvhgFUESrohqesaQodpw7qxIq8YIkvwuc/D32B9p
 RmME2Fd+R+WSQaPUIICAZqXjK8oss16CrE5BtQ5SEZ5MWOz7zU02u+08m2/ZcpGwMYhArIR
 VaRVJBKKlk6w1HKNjsJNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:efUtOIyWQXE=;xFqH+sIu/sQxXkkgYPK9p/+0zhL
 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
 PGp4dZkW/KN1OBEBD2AYQwx5wSjMg/WiUN

Hi Steven,

On 5/7/25 20:00, Steven J Abner wrote:
> Not sure if this place to post but no response from main list.
> Tracked beginning of kernel bug to version 6.3. 6.2 builds work with
> some modification to build files to pass on warning errors. Less
> than and equal to 6.1 works. The problem is approximately 70% of
> boot-ups disable the video output, allowing me to memorize sequence
> login to reboot with a disabled monitor. I can say that I can reduce
> that to about 50% once you learn that they altered PState and set a
> default later to 3, instead of 1. (Not sure why this works, cause
> always was enabled before). I'm running a AMD 2400g Zen1 cpu. Even
> my Debian/Ubuntu based OS's mainline distribution of kernels
> includes this bug. There are too many changes from 6.2.16 to 6.3 for
> me to know what to revert. Can you please help? Get me to people
> that can? Please cc me, as I'm not on lists. Steve
Kernels 6.2 and 6.3 are around 2 years old. Nobody will invest time there.
See:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/refs/heads
Kernel 6.1 is a longterm stable kernel, latest one is 6.1.137.

Please try a 6.6, 6.12 or similar Kernel instead.

Helge
