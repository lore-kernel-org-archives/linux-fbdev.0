Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9020E6E2
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356308; cv=none; b=Mt/vITzMMyCLZbl7i/RxKCMlo0puKz+Vpbm+/YV6dLZUHMYLjSsTSnPy3eSvfhG0DQlkIp27ryQ+XSKdQ0RuglUBjQ9n22JDWj4kiIVRYd7i4Ont1e3foqwxkOjhix52/0/bucPQdr7Xntwwnd9lZ8WYUC6i5D+NYdBDgU1pr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356308; c=relaxed/simple;
	bh=mMtIswAhI8qZcuduakcR5UZIN95rcBY4NgjYYxIhNpc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2rk+TM6hsSqE99UZM4JEQJ0oTtZWqsSzMbxIOKSGXBlDU8z5T1F0rS1AVzUPcTI1Hac05W5wfhrzNSFSKQPHVlQClBwgJY5cY7KpqDBy4evViU2xwYtW0uHjdwtmBtFJHGWeApTndZTzm+P/DLqGLs27+62CSvw2vmEI03f/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H/Rmkl7Q; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H/Rmkl7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784356297; x=1784615497;
	bh=mMtIswAhI8qZcuduakcR5UZIN95rcBY4NgjYYxIhNpc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H/Rmkl7QBjA7tWYgd+WlyAZ1xaZjmsrF5k+SZSp5AslPCFywlYKMaZFKfkDkjFrA0
	 se40bBGUA6skSnKjAzg45pmpWFY+c4JPLEvDcWhqTpYu2RmdR4tSbvd4TS9CBF3hh2
	 ElanWYXPY5kiOSWr8yUIBAmxa8maS0zFuKrvq879v4WkfgJZKD8yWo4f9XwtcGGTWH
	 JIuLyj2aUMFYA1BEiPgqEdaQPQYVKc/N1FrS8A1gN7pCFoYl8yBat5mNJWYkr69Pht
	 TVRaXHhN19LFLANMkhdc+MsN0HFKl2qy2EWua82rV9AW2C9Y4D8uq/+Bdhz58j3T39
	 +eAmI/PD972Lw==
Date: Sat, 18 Jul 2026 06:31:33 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Nils Lehnen <nils.lehnen@proton.me>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: unindent defines left by conditional removal
Message-ID: <20260718063105.5980-1-nils.lehnen@proton.me>
In-Reply-To: <2026071810-reprogram-decade-7537@gregkh>
References: <20260718055132.441-1-nils.lehnen@proton.me> <20260718055709.466-1-nils.lehnen@proton.me> <20260718055709.466-2-nils.lehnen@proton.me> <2026071810-reprogram-decade-7537@gregkh>
Feedback-ID: 188354734:user:proton
X-Pm-Message-ID: 357e90e13e5b494685bcf0824b52a62b09bf9af2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 08:20:36AM +0200, Greg Kroah-Hartman wrote:
> No, this is not correct, the indentation gives you context of what is
> happening.

Right, the indented defines are the values of the field define right
above them, and unindenting throws that context away. I'll drop this
patch.

A v2 of the series crossed with your review -- please disregard its
patch 2/2 as well. A v3 with only the conditional removal follows.

Sorry also for the subject-less 1/2 in this thread; that was a local
send-email mishap on my side.

Thanks for the review,

Nils

