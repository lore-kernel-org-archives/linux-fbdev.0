Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A5202C37
	for <linux-fbdev@vger.kernel.org>; Mon, 16 Dec 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344002; cv=none; b=gSxqd+Fkk9aVboPfzRVukdYhj6zEeQa6iBQPX1Pk4krmzN35pjQ9wXnQL9tFoXDjwsrBMKmkEpvgiq5KJzgFqewB/TcbLIEcDr0Rw7Jj4Fdgi0muqNhc+IjWV4Mn5if7XkcwjprONgNo4INNAhBOuXZdlRwakHcRed/McY1/NNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344002; c=relaxed/simple;
	bh=wivUGdcXYn6VwelfaLekmpNak5Bcy3xhV06KWiQzClA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E2S25k3QzkO8v6dNTlfbIClE06jvJTn1vzlvUKLBKg0fSaSofhqhhfNzT6pYv5vT2p9cA4YcYWdTMfgiHdnA/DhrefMmn65HIFd6FXXoOVbtmMi9pTIaOZ6zHisnSePvXDFTWncyJqa4wwWeypr+vrR7JiK2Noq0WO7ZK2NvqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=E4Wy5Iut; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qDCud6QC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="E4Wy5Iut";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDCud6QC"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 26BA91383AB0;
	Mon, 16 Dec 2024 05:13:18 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 16 Dec 2024 05:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734343998;
	 x=1734430398; bh=wivUGdcXYn6VwelfaLekmpNak5Bcy3xhV06KWiQzClA=; b=
	E4Wy5IutbDxBHk8+mFIuN+1AMbV4u7yWjqcjs/ohVZLVVAHXszEUEfWI3EsvKgD4
	uGHO1ky7A2JnKY2b5V/o9gedVq3mfvmB0O8n/hZ9Zdp6sjQsjJ0Ss/M3xVECN9Y2
	285OVJ2qtUIguSLeU1h+ZUU/0jzDa2LhbSBGEWhfrYt//H/yqE4YoxhEepgVE6Te
	gNB7/czcXQQcRG1Vxod/itgte84EX/Q50lRxM6pbOhkBoOGrrtMn61f5hcZb2CT/
	pxYTDGtgm6ItwrkMC6ymMSxThAJ8e9LXE6jI2YFP6qlw9dU2yn4dzM10/fS9bSAM
	kdE7SyinUJAW3+lsJ47EdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734343998; x=
	1734430398; bh=wivUGdcXYn6VwelfaLekmpNak5Bcy3xhV06KWiQzClA=; b=q
	DCud6QCp0V1iCaJmCs2gPw/rtFX7/5LQjHdNzXb950CIQJV2tBHWlSTERH+wu5mU
	OcvaV78TQd0hdsZM555o6WkvKoVqP/ThqsQ5QxDAJmiS0GiDXkPrQmva0u9BYBWJ
	hOP9ulZksMG4v43kVrklzDxoEllOTLJFKOdL3SFyLL0UqZBJ4WK/qYX+i9w0oZRf
	Q+cO07omolM2Kd2chyN+Seph2Kh1dWLA1dU+ybfR9BhQjBUEF2I4IQk8ysq+CHQP
	KXMuytkmU+Fs8vuZprFplJNUjlBIZLud0IFNOTjYeMd58fGjiSlvdG3w25P2Wih6
	Ak7fL31c0qlMcGiu8+1LA==
X-ME-Sender: <xms:Pf1fZwQL3IFh4yAdP0IZXTOYWupixVQKRIR2VXACtF0FIwMKs2bbnw>
    <xme:Pf1fZ9xkPOTDIun49Y_r06EpTBwZraZgBdfcPadFOjHKiCOZrw5Mvrr9hLtoeI0-O
    qduH0dY9WYQkb8KUtk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduuddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghroh
    ihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghh
    pdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopeguvg
    hllhgvrhesghhmgidruggvpdhrtghpthhtohepjhgrnhhirdhnihhkuhhlrgeslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrd
    hfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqshhtrghgihhn
    gheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigphhptgdqug
    gvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtohepjhgrvhhivghrmhes
    rhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:Pf1fZ93xhCqySX7gHNrptVHxhMGCe3rk4EOLDa7frWmCUGYK_WrnNQ>
    <xmx:Pf1fZ0D1hm5-bVL5XAY4NjKbP6tXldx00oItEU-lMwIamAYLcIOwQw>
    <xmx:Pf1fZ5iwESOtKK7P3N9JqntnJqIadOwfNE_dBBE1NGPtU5ub9ty3eA>
    <xmx:Pf1fZwpdN_CUM20AQx7drnZuBhUmFQoV_uy_M_QXfCL0YxMag_ob-g>
    <xmx:Pv1fZ-aYJaDSAZC-h4tgh1CAopr3btq1o-_2Lt81K2X-t6HIex-fugaU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 52B3A2220072; Mon, 16 Dec 2024 05:13:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Dec 2024 11:12:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Javier Martinez Canillas" <javierm@redhat.com>,
 "Helge Deller" <deller@gmx.de>, "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Simona Vetter" <simona@ffwll.ch>, "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Message-Id: <1dcda6ee-dc0f-4d2e-b234-6f03b5637d01@app.fastmail.com>
In-Reply-To: <20241216074450.8590-1-tzimmermann@suse.de>
References: <20241216074450.8590-1-tzimmermann@suse.de>
Subject: Re: [PATCH v3 0/3] drm,fbdev: Fix module dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 16, 2024, at 08:42, Thomas Zimmermann wrote:
> Fix the dependencies among the various graphics modules.
>
> Before addressing the FB_CORE issue, patch 1 first resolves a problem
> with BACKLIGHT_CLASS_DEVICE. A number of fbdev drivers select it, which
> results in a recursive-dependency error after patch has been applied.
> Making these drivers (or parts of them) depend on BACKLIGHT_CLASS_DEVICE
> fixes this.
>
> Patch 2 selects FB_CORE for DRM_GEM_DMA_HELPER and DRM_TTM_HELPER.
> This is necessary with the recently added DRM client library.
>
> Patch 3 is the second half of the patch provided by Arnd at [1]. It
> could not yet be merged because of the issues fixed by patch 1.
>
> Side note: For the majority of graphics drivers, backlight functionality
> depends on BACKLIGHT_CLASS_DEVICE. In a few cases drivers select the
> Kconfig token automatically. These drivers should be updated to depend
> on the token as well, such that backlight functionality is fully user-
> controlled.
>
> v3:
> - Fix PMAC_BACKLIGHT case (Christophe)
> v2:

The patches look good to me. I've had a slightly different version
in my randconfig test tree and have replaced it with yours now
to do some more regression testing, but I expect this to be fine.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
