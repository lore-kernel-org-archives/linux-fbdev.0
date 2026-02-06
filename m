Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F43612FE;
	Fri,  6 Feb 2026 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375160; cv=none; b=WA+1UDQM9/CaFh68FkYwpliss3Oas/B7P4n0IfpP/9ceBpJq9Iz1/VZ91Obv7ncSB7sA9CPQS1P4+XdfB+a7Z/Um9IaFblZsfdGqHoER2vzpHPAI4rhAjwmpRp0n4KVKS3ogzQSGqrCtBZ1kQaOkc6oz3tn1KFT7E0Gdkrc8Reo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375160; c=relaxed/simple;
	bh=UgxfQXUKOatBOVleoePxmxeSAoJtHGvRagjbWMbfPj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+FiHnZhKjZO1krGNljaKRidDPTXJk5QygtHSYKhjYugAYVmVH2P1TExajMHUPfuplgZv78zAUHMVI6qpDIdK9Ppj09JLU6KPNaI/2id1nVb3oLKSdZUXbFVwzWj9juSiwYrQ9zz6SlsWyLAvx53DiL+mo/2PHO9wyXKZd9RF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=lhZOmRjf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="lhZOmRjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770375157; x=1770979957; i=deller@gmx.de;
	bh=D2/89PNhXZQiNoqohv+99rAcUceHCZUAFM03iY26VQA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lhZOmRjfXkMglAa0mJ5P5Ta/pOIf2R+xaqe6dFfejSe4KXEilxZm+CoGlPjBowr+
	 1NFURE10yc9SmKYX0jxuAUioDzBDMGPRdwb1V5o3st2m6aSfesf49HSrHUa/LyWzt
	 /s2MmtksPvQ6tHVHR2WM3Ak42G3m19J36fw60YeQcAfyXhnj8cleAeRVQ+jtiRBk/
	 8O64UQniIMtr8LJ9MU+55ejtNmPXq/k5S4mgybm/Id70w0iSOnw1fPCxr+BNs7KnG
	 96SAysOe7OBPl2imvInEN1CFLgKyEDWI6OqxuxPw0O4Xw3lec8e7HAmkbjo5pghd+
	 yVufR1bYR30uOeJuKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.105]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1vIpyl0tRm-00pAdG; Fri, 06
 Feb 2026 11:52:37 +0100
Message-ID: <827d7def-6db2-4ea6-a185-22535b8af504@gmx.de>
Date: Fri, 6 Feb 2026 11:52:32 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: of_display_timing: Fix device node reference leak
 in of_get_display_timings()
To: Felix Gu <ustc.gu@gmail.com>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@nvidia.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260131-of_display_timging-v1-1-f4f8d9f87c3c@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260131-of_display_timging-v1-1-f4f8d9f87c3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LVwQXYK2nPDkdjbd/w9isvT7saSIF0BU+E3pGhugmux8s4aTLjS
 02tnsxG4frhix1nRPfSUs7T2JEJ9ArAIuWWIZceDvYRK7CyBsjSMtn5ufKmN8lbtnK6dQzC
 C5slrHNh2TaAWDhddAS6PfvxW/Hbx1OJRlDKuBdnPI8hQr9msSRyUWUVSmgEZubhTSIbjcQ
 hnBuMIXA1a8Ctg9mhgQwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:89L39131+G0=;CwMX7q1XftqzIZBTul5Gh1zkMan
 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
 p/It2ddmd5Z2omp0iKF6mxhMKqfd6

On 1/31/26 13:48, Felix Gu wrote:
> Use for_each_child_of_node_scoped instead of for_each_child_of_node
> to ensure automatic of_node_put on early exit paths, preventing
> device node reference leak.
>=20
> Fixes: cc3f414cf2e4 ("video: add of helper for display timings/videomode=
")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>   drivers/video/of_display_timing.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

applied.
Thanks!
Helge
