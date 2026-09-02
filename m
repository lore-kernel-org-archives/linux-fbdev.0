Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD6480952
	for <linux-fbdev@vger.kernel.org>; Wed,  2 Sep 2026 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351950; cv=none; b=cQyiMuIMNN0Nbg8DR+Na7H16KdwGrln/5VYmPvwUabktsMKwskOIgi0nJQEL8jYN4AuAPdE/JS/leP3eLanHO/7runq/0LH9/U2myEg600TfjucF8WSqV1qDrsFbwhjaTRPtowtDYBaPJbIIj71xOq8pmymOr6OEJ9u7PUhwQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351950; c=relaxed/simple;
	bh=/C5jHO5KGjc1uyhBAXwASd+Pv7sP5Fby0HfqQuui0CE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=teBBON3K7rCYISbjRwUdVc7kocRggfN1Nr3U04rwGLQk91Jc57KfKtlhed+MZ5edpHxzIXYxIXXXSLOdm9vZdRoYp4IC1Dv3dx0yW2qXhGCRvC2MVSLH9CBml1WWd7YuW72qfx0+Eg2Pj2xc0g/S7MFOa/vFuzjD3Qrhdp0/4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jd4MAbsr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fCjSrcyN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jd4MAbsr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fCjSrcyN"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788351947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/C5jHO5KGjc1uyhBAXwASd+Pv7sP5Fby0HfqQuui0CE=;
	b=Jd4MAbsrMX51++xbiIcBBT3jkVzbG7sssQ8C39uuRgS1rrFyQpwkuMyfLr5NuXRo66t9CZ
	NZVIs/H4S4AKfsPybOTBOXepvvLVnDwLfKiBKS+bIdTEMxl2WfqO9vopG9fIjTazdnIB8D
	fMlF0tfqyKEDq4JNuSbh1poBNyd7f8JMA0rrO6pUJ6E/s7dc99bbKCS7ZjMxA6rjrFTemw
	lPDYKSMoY03Y2uCIpdtaB8feXnoJw0H0MN8MJtTNO8LJtTqzAzWsDWInehkC5I0Wu1IVIv
	gIAAgM6WC+Ox4gUggzyoDDvt+JMgCm3uF3TQaJa7KjWMR/3WyJqJRqXQE8vSlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788351947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/C5jHO5KGjc1uyhBAXwASd+Pv7sP5Fby0HfqQuui0CE=;
	b=fCjSrcyNnRY78KBlVexoMvhb9JK3qVVVKxn8N5W9rvlfnm4A/CM7mM70PfenD8qStnQ3Gy
	Xt/jps03OVFHcTBA==
To: Anshika Jain <anshikajain196872@gmail.com>, Andy Shevchenko
 <andy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Anshika Jain <anshikajain196872@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
In-Reply-To: <20260902045026.7442-1-anshikajain196872@gmail.com>
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
Date: Wed, 02 Sep 2026 14:25:46 +0200
Message-ID: <87wlt3vnzp.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anshika Jain <anshikajain196872@gmail.com> writes:
> This is a latent bug: nothing in the current code prevents
> two adjacent negative values in an init_sequence from producing len=0,

Can you elaborate what you mean by "two adjacent negative values in an
init_sequence from producing len=0"? How is it possible that negative
values in the init sequence causing len to be zero?

> and there is no guarantee future or out-of-tree panel definitions
> won't do so.

Basic testing of future drivers would prevent such bug. It is not on any
rarely-executed code path.

Nam
