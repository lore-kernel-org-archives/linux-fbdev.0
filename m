Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D415574F;
	Mon,  6 May 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008487; cv=none; b=FpHQr1YdGI/4KEqQq2SyTRWtVC4IhgQqGXtAWP+9BAMjT1pBzgYTNktPO98ql3yTNB89llVTLC9bG+c5mS7Pz6mdFdohk5dURZxhOubWNKVkiVAeWXg/zuoKPCBiGxHRD9pitwS3vjFf+KGotkOOVZf3aHmEP03QZNRnqwg/Igw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008487; c=relaxed/simple;
	bh=WdGRLnn/VtmML/RSa8wpE+KLf07KYVpqQJXIs+Yp1cM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Uc7h6XRXLSbWsPOx6NsYwaUnEYOCNp+k2U5tTTyuSLS5kBv84a8MxC4oAfjSHg4dthwmASBg9rQpK9b6rfnU/70FDCR661yGbxf52P87gfxhgmx65V/B4aTzAtRlaC/7GLysgrBTCFwpzOvrzxn+AVU8o4ww8VUpJZfhC2XSnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NaO+Rt7M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoT89lpb; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NaO+Rt7M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoT89lpb"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 130DF180013F;
	Mon,  6 May 2024 11:14:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 06 May 2024 11:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715008483; x=1715094883; bh=gLUe+zUDiv
	mPqZGQxuXZTT6/Fx3FkhmBqOIVx66+4hI=; b=NaO+Rt7MUy2AcPaVgx6tw4zrh+
	5uh5nZtN/+pUlpiYtwu+qSOS0US5En0DRd771nYvorFs6X3fW2lGBISgZh7EgqsS
	bZi1BNhN6ByaLF35nzNd0aHdtEY2um8iXWmqQyV+zOvWuA9DBAlvzukWEBnODSeA
	Y8R8B7flhy60PRMKqP5oSCjDuVH6Cl4sWRNLhBHcVDuIMhz40rcIeo+80uOFQxTZ
	LkeCrTzFKpHGtSZqA3P2MPuzu0a17PyVeSMm5TtW+3rEbQOZ3RlcLXJqEyA54Hg2
	nZu06fxFF1T+Jqt2wDdkWscpKUCclEFCBS04f1vbZR2116dqgT8ra8JHBt8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715008483; x=1715094883; bh=gLUe+zUDivmPqZGQxuXZTT6/Fx3F
	khmBqOIVx66+4hI=; b=HoT89lpbziT5N8m/FfuyhrDzwBIAlnTOD3Up2g++v+RE
	dx+GzBd2JYL6IB9yu16NmoOOgUHF7vD1Sd3h3zTyLefSwQ0fL4u1GyqwRQm0hq25
	pHXBq/d1V4Nl76wfmIUlfegY6hnhz/QBvs5tdT0c4143nZBRCcL3UusIcjAgWrzu
	OqRmNLiPqNM/nsQ2Ce+M3Lgdn1bo/WrQ7YLSKek4EGknbkCyW+AiLZ8zIx4aHzo4
	FY5AcciH5gFKDeBj3XxeXjOYHZULhkr6WsnN7wgc3O5D3JiROB32J4EILjWa3dMj
	ZkgjKnLXmpKPzDaI8+WdRBPYVnj1ycI7Ya9yKiW6ig==
X-ME-Sender: <xms:4_M4Znp2edXWlzkjdACp3Wb04ntw0OzFBo1AtkuaRnPR2ft3V1xGhA>
    <xme:4_M4Zhoql1FCSA6qHZvZDZlt_395T-deA4EZqJhp8vtnnussyELDhBFAj8XQj3I4U
    hosBLQnKSle6i_fxGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepleehueefffevveejgfelveeiuedutdevtdfhtdevveelgfevuedtkeeiffei
    geffnecuffhomhgrihhnpehgohhoghhlvghsohhurhgtvgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdr
    uggv
X-ME-Proxy: <xmx:4_M4ZkOhiOBgBmQ6oV7yRpr7xUjO0bDTMYtJL1f1w39FOOozxMg55Q>
    <xmx:4_M4Zq5HtmMpcgmwilY196HYutrAWb7aEOvM7Hdmy3V08V-lEVAqrw>
    <xmx:4_M4Zm6drm2XFnwr3Quuv0kwajqIcwrtiDc-SxbtFYGoFafWGF6_Fw>
    <xmx:4_M4Zih4GJtHow5_R9qGkcefOkb1gIDcPtgtAwQ60Ozc-R8HRGLUtQ>
    <xmx:4_M4Zotg_n3dJBwLWJ-vpX_vIVVJ0v46krWJAiI7uYb5nmwiy_fMwdZ8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 65593B6008F; Mon,  6 May 2024 11:14:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-437-gcad818a2a-fm-20240502.001-gcad818a2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <618ea004-6fd9-4f1c-836a-fbf66089a03b@app.fastmail.com>
In-Reply-To: <47c63c4c-c657-4210-b476-c91c4f192483@app.fastmail.com>
References: <20240503192858.103640-1-florian.fainelli@broadcom.com>
 <8e1867fc-34da-457c-b95a-2d51ea97336a@app.fastmail.com>
 <05a5e893-12f7-49fd-9a9a-abd387571f9b@broadcom.com>
 <ZjjXtEwWWZX43c6l@phenom.ffwll.local>
 <47c63c4c-c657-4210-b476-c91c4f192483@app.fastmail.com>
Date: Mon, 06 May 2024 17:14:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Daniel Vetter" <daniel@ffwll.ch>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, "Helge Deller" <deller@gmx.de>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Javier Martinez Canillas" <javierm@redhat.com>,
 "Sam Ravnborg" <sam@ravnborg.org>,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] fbdev: Have CONFIG_FB_NOTIFY be tristate
Content-Type: text/plain

On Mon, May 6, 2024, at 16:53, Arnd Bergmann wrote:
> On Mon, May 6, 2024, at 15:14, Daniel Vetter wrote:
>>
>> This one is. And it doesn't need to be simpledrm, just a drm kms driver
>> with fbdev emulation. Heck even if you have an fbdev driver you should
>> control the corresponding backlight explicitly, and not rely on the fb
>> notifier to magical enable/disable some random backlights somewhere.
>>
>> So please do not encourage using this in any modern code.
...
> Alternatively, I wonder if that recovery image could be changed
> to access the screen through the /dev/dri/ interfaces? I have
> no experience in using those without Xorg or Wayland, is that
> a sensible thing to do?

Replying to myself here, I think I found the answer in
https://android.googlesource.com/platform/bootable/recovery/+/refs/heads/main/minui/

which has separate backends for fbdev and drm, and should
just work as long as the drm driver is loaded in the
recovery image.

Florian, do you know why this is not being used on the
machines you are looking at?

      Arnd
