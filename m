Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5D1B87F8;
	Wed, 19 Feb 2025 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947663; cv=none; b=sZmpBdkPl2meWOOpoXe365WRcvgcf1EAlpGcrHyauPN3cncb1W4745gDGpzh5UCWdF+QcoEsMQenYsDk7um0Aef2YBSDqvAU+LFugoK16wT9n8C33zYkbGPyE30ZhvRPVIX5aUGmYB98fznpBberI8EoLN1pBjAE5Nm6OauU0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947663; c=relaxed/simple;
	bh=lLC828cf4EMsaJ1JTfrov2AKE1L5G0zPb43ehUPW7Yc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QjhpJ4D98qNmxAlJMNF8Lk5I/r6flL5GOP+afd3pA55T8fxjyrXVZ6nyPWw7vZ1FJpCY6OPB+CEwTqssEnrF+ioSzHXjD87oFp6fQ+SuHQPhOWZXVPZxZ9koyAEo1TNzQKI2pf+sIESBMG4etEonKLR63cRJjiS8GPfWjzsI/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OFXPhAWh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S8cN9Grw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OFXPhAWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8cN9Grw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C4401380861;
	Wed, 19 Feb 2025 01:47:39 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Wed, 19 Feb 2025 01:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739947659;
	 x=1740034059; bh=J36qZr4XlQJHghLHCEZehAHjZbscRnNTmQ9ugnTYxVo=; b=
	OFXPhAWhRehitF6GSNzJuzWZoC9i+FkscVRs9xpeC0DjoI8ljDc2hB0HEdM+sfIh
	xjXTMyLSXAPttxAu/Rbg5OlNq8KVnSBtRGj34virrlToENk9Yt1AI03oSr17GP/p
	ItE6NA8QtriiHRFspzmdgWlOGL/BRcW6eNKuHkiJJW2W3E0NiyJ8AZQy5PT8VHlB
	Af4zuEKF3lKXgZZaN6m9nqivj5Xr4a1+vYIW0Recnh1I3/DOeRNO2lgxoWV9HhIk
	t1P3kyL3oDDjUtJ5nxIO8tsRHpeYkJoURtKdmsZEr0VOboByMV7L/p2WoQqnysDO
	Qj7WjF+3yA/plTuYqxfqcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739947659; x=
	1740034059; bh=J36qZr4XlQJHghLHCEZehAHjZbscRnNTmQ9ugnTYxVo=; b=S
	8cN9GrwjiCFlRI4BSr7oLDPMvEOAMFRL0/lhW26MFviJ9W0LX7rWlZ/MAVbrX7+o
	KXLCRFf4hnvRyU8JAj0OxmjeNzCBBXwxM03tCwNU+LKIbyDzWmVjxTBnvYC9Vyis
	E7SZdc8aRTWjzh04UvyxKf43YSMFB0vFzFx3GxLb++rgsj3aHfAAp69SizicXllz
	MC+Sj4xdIFf3DHnM3yUeLdR4Dna61+S13fjv9Gujzgbo9eqip08uBCbpDvXiAvj5
	PXZYLjB378W4dT5AbvEGsuZwIMLa6t/hr0IQ9fVY3NWrHP7WaESxoTg5t1MWxUdG
	d7yGQn9MDZkquAXmzpbzw==
X-ME-Sender: <xms:iX61ZyPZshRIVa-De3lhnUd8ev5oTNVqwRG8IBT7N6jjeIJ4Jab8Lg>
    <xme:iX61Zw8Cdk3v-pSafSh2TKhqROR0trG-RdXSjc_guD8jBzw_VnfLFoVmlypyK2JmP
    75ncgaeToNeM3E8LWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhushhhihigihhonhhguddtvd
    ehseduieefrdgtohhmpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighessggr
    hihlihgsrhgvrdgtohhmpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprhgtph
    htthhopehlrghurhgvnhhtrdhpihhntghhrghrthdorhgvnhgvshgrshesihguvggrshho
    nhgsohgrrhgurdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhushhhihigihhonhhgsehkhihlihhnohhsrdgtnhdprhgtphhtthhopegu
    rhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpth
    htohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehlihhnuhig
    qdhfsgguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iX61Z5SyTODmXICOp_WXU3NSDFy1s_FTtNbLc1gOCPdibSHLmS1lww>
    <xmx:iX61ZyttbKacXZ9qlo-Pw5b8KuvM-yTc0w3qHB8Pw_eSJaraQFybbw>
    <xmx:iX61Z6fhJnCSyXSQ6ZuOoUJdm596mkMwKo225NV-CHVuxl3TSNuOvw>
    <xmx:iX61Z226JAg3E-s_OB-Nr0DNGmrggT029C1mUx7bTU02ok-QVsAbhA>
    <xmx:i361Z64u886KwNja_d7rD4JlceV124kFry1zhn9OT4MmYloJ7kdd4R1O>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9AACC2220072; Wed, 19 Feb 2025 01:47:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Feb 2025 07:47:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: oushixiong <oushixiong1025@163.com>, "Helge Deller" <deller@gmx.de>
Cc: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>,
 "Lee Jones" <lee@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, oushixiong <oushixiong@kylinos.cn>
Message-Id: <4f2ae439-1bdc-4593-9151-e15981509344@app.fastmail.com>
In-Reply-To: <20250208092918.251733-1-oushixiong1025@163.com>
References: <20250208092918.251733-1-oushixiong1025@163.com>
Subject: Re: [PATCH v2] fbdev: lcdcfb: add missing device_remove_file()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Feb 8, 2025, at 10:29, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> 1. The device_remove_file() need to be called when driver is removing.
> 2. The device_remove_file() need to be called if the call to
>    device_create_file() fails.

This should probably use device_add_group() instead of
individual files to simplify both creation and removal.
It would also avoid the bug you introduced that gcc warns
about.

      Arnd
