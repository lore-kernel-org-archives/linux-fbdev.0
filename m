Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049B1F63CD;
	Tue, 27 Jan 2026 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501078; cv=none; b=tgUcCx0TfDNwbFI/hNGR2R2G9cHYlyj2+wC2YMd+cM+yPLSy+yasLewK0cRstEoWFNkdKccGh+WUPDw+/K09YovXXto5B5oBAIVh43boqMRGp6DmNNT2XmAqoiQuFf9M18N3z9KOkVm/rm5ddrQp+9yBlipzWWekVafslGsyA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501078; c=relaxed/simple;
	bh=qGKOSWJZDX7dixrIwqdmE3uOqHUhY2CdY8n2gD72vAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf1VP1AY6qiR7FkUyM6xuoXPDh6HZncb2WmbW62MVbzzhP9HVb/cXJuu5a41O9dXQF1PzMMEl5wlWBooQo+EzbqM7WYtQlEpxYIJvCvSkNCnfCa3+3n8/NQrQiXZlONgVa5xmCG9dkBwt+7nv+hGNoCHmHIAQkAww8ED04PmJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ca2d6fb8fb5611f0b0f03b4cfa9209d1-20260127
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f6d6b964-6b72-4e21-bbb6-91350823f3df,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:da141f988872f93dfd5565e7e8f36d3e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ca2d6fb8fb5611f0b0f03b4cfa9209d1-20260127
X-User: pengfuyuan@kylinos.cn
Received: from peng [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengfuyuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 348581575; Tue, 27 Jan 2026 16:04:22 +0800
Date: Tue, 27 Jan 2026 16:04:19 +0800
From: pengfuyuan <pengfuyuan@kylinos.cn>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>, Hans de Goede <hansg@kernel.org>,
	Lee Jones <lee@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
Message-ID: <20260127080419.GA965382@peng>
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
 <ed48e82a-cb94-477f-83c4-b2d87ae3cde6@suse.de>
 <DFYG7MT5JINY.1T8ZZ4ASIWXU@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DFYG7MT5JINY.1T8ZZ4ASIWXU@nvidia.com>

On Mon, Jan 26, 2026 at 07:28:21PM +0900, Alexandre Courbot wrote:
> On Mon Jan 26, 2026 at 7:01 PM JST, Thomas Zimmermann wrote:
> > Hi
> >
> > Am 26.01.26 um 09:17 schrieb pengfuyuan:
> >> This patch series adds Rust bindings and safe abstractions for the Linux
> >> framebuffer subsystem, enabling framebuffer drivers to be implemented in Rust.
> >
> > The framebuffer subsystem is obsolete and has been deprecated for a 
> > decade. No new drivers accepted. Anything that really wants fbdev 
> > already has a driver. Can we please let it die?
> 
> This, and the patchset is also obviously AI-generated.

Hi,
Thank you for the feedback.
I’d like to be clear about how I used AI in this work:

1.Cover letter – Yes, I used AI to help summarize and phrase the cover letter.
2.Comments in the code – Some comments were written or refined with AI assistance.
3.Learning the codebase – When reading and understanding existing Rust-for-Linux code (including DRM and other abstractions), I used AI as a helper to analyze and explain structure and patterns.
4.Writing the code – The implementation was not fully generated by AI.  I wrote the code myself and used AI mainly to look up existing abstractions, traits, and APIs (e.g. “how does X work? ”, “what’s the right trait for Y?”)  while I was coding.

So: AI was used for summaries, comments, learning, and looking things up;  the logic and structure of the code are mine, and I take responsibility for them.
If you have concerns about specific parts (e.g. wording, style, or design), I’m happy to rework those patches or to adjust how I describe tool use in future submissions.

Thanks,
pengfuyuan
