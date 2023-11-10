Return-Path: <linux-fbdev+bounces-3-linux-fbdev=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1091BC4167B
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:43 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AEE1C20A08
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B798838F9F;
	Fri, 10 Nov 2023 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nh4WX7/9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iNLZwafp"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8013A28B
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 17:46:38 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2F9A753A;
	Fri, 10 Nov 2023 05:49:36 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id BB71C3200A2B;
	Fri, 10 Nov 2023 08:49:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 08:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699624172; x=1699710572; bh=gr
	ojPZKgF7i4ycqWyl3K3qTSTs7COURoVDRKuNTUh/M=; b=nh4WX7/90u4Gme0x9f
	1uVVxdYgdkllPoE0w+fySPgMK1A/brPAhRGEvzdJOiAre58FQcJJVnwntB/kc05V
	eWs+EdPSM2+Lz/qojlylNUeTHuJEKb6T46VTozIyiN8tcTUSWSQEedKwKd0BzRVu
	qN5aQP2i1fnl3AXsYVqOQwRUMACE6F2vkqveUoE88YVXpUI0G6Rz0fvhEp+A4WhW
	EQiq7wQ7efxFk3caHmEb0/1usexPcla08oXwhJWnNezebKDTg85DiEFTQZsqi2G3
	NOem1u0/NEuC3W2uC170sYAuo5GGMfIFOqJqvij0zwjBbtVpH0kmHFHiEqfi0MIW
	11Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699624172; x=1699710572; bh=grojPZKgF7i4y
	cqWyl3K3qTSTs7COURoVDRKuNTUh/M=; b=iNLZwafpnPL0lFgVfmEOjglV4izfn
	7OjB/cdtwIolXThMkdjoQLesS7aYCyx9QBay/rlgZvC9rDql+8R8ur4x2YBRQizr
	+P8udFmmZfGrLb2qxKyjz7rGlrIaHHwD+Gt+2TS8CsOLJpuJhizRHjbtt6hk4805
	bzQmm6DCWJSmIEN4+vFIBoc68KrMKOLHVKT3EE2RRGlOfgLXhg3nlYaXu/Amk9q/
	TszC9qs4g4PSVXHr1aRHxG1J1leEmQX/va329eada/7QatpQ/lGcmD5PDgXl8qou
	9LfieCPTrNRoFNljgOj6+1DyCZyZTSu8SGSKgdSx7xspDu1eaAajnWrkA==
X-ME-Sender: <xms:7DROZZ0_hgUG9L4dTBBXenyfWx4sBzXAuBwmIUSK985PlcUXD-J_jg>
    <xme:7DROZQFAAgqfWQ7jUzmqywdH5YmZOdyAmPIHx2EzPCawsT0Ua-aPIGX2MCdHcvgKI
    q59hcQ9XW3pouqH_Do>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7DROZZ5-wh6otOKEuk4WIgfKBHPe2YcYLyyykC_5qqtB2AQj_SjXAA>
    <xmx:7DROZW1JHdnintBg4QsvWRFflXTgNHN_Z8s9hG4UjF4tayflPIHgjA>
    <xmx:7DROZcH1LzQgdRlgQoaRgJy-92gyXyBbdwU1VorEHz1ybICdzeiIMw>
    <xmx:7DROZYgLrQQPJDF_WrN2dHalA0rkpc-vr_CPcThEVWYSD2u8Fox7_Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0AEE1B60089; Fri, 10 Nov 2023 08:49:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <13bb798d-0631-4b89-ab28-2c3ef78847d8@app.fastmail.com>
In-Reply-To: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
References: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
Date: Fri, 10 Nov 2023 14:49:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Helge Deller" <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: drop IA64 reference in VGA_CONSOLE dependency list
Content-Type: text/plain

On Fri, Nov 10, 2023, at 12:44, Lukas Bulwahn wrote:
> Commit e9e3300b6e77 ("vgacon: rework Kconfig dependencies") turns the
> dependencies into a positive list of supported architectures, which
> includes the IA64 architecture, but in the meantime, this architecture is
> removed in commit cf8e8658100d ("arch: Remove Itanium (IA-64)
> architecture").
>
> Drop the reference to IA64 architecture in the dependency list of the
> VGA_CONSOLE config definition.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for the cleanup,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I was aware of this one, but decided to keep the vgacon cleanup
in a state that would independently work on ia64.

    Arnd

