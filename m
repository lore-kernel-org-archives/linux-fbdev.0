Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617EA32BF52;
	Tue, 27 Jan 2026 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504321; cv=none; b=c+g7fPPr9VVxdIAjpLZsrNtdGSV7vfLMP1z7bRSv02nJN/sQl3mgPrKZw/j5n+g4jDP+z6DRMfzWnOqOkzP8Q4BbUmfg0UNy/5l2UDldRD1xIsQJpcHjKwHJefPueC2L0hBLMiPbuFc9bvIgt479CvPTww+DDBj4sC/oLtI2oXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504321; c=relaxed/simple;
	bh=upyv7IwdIeGyogoOnKef2nVc10ymlNOHVf8nDAj6nw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsVeF/zuw969yn4898m/rJ3RI6GLAK2vVFNWgNMrlt+kGUA+nAWP5uQMz5byUA8n7Fi8gJ+RsEoFcoGgVY03BNX9bSOpZZOpopnduo21sKYj65Vg0NqhFdNZg1kFZo26ujoVCxZWKh8hiIFFniIF/RJjWC59jR3HDMGSKLYwjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 59da2636fb5e11f0b0f03b4cfa9209d1-20260127
X-CID-CACHE: Type:Local,Time:202601271604+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3c3462cc-1a5a-46f3-9b98-f1e81a037db3,IP:0,UR
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
X-UUID: 59da2636fb5e11f0b0f03b4cfa9209d1-20260127
X-User: pengfuyuan@kylinos.cn
Received: from peng [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengfuyuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1688504528; Tue, 27 Jan 2026 16:58:30 +0800
Date: Tue, 27 Jan 2026 16:58:26 +0800
From: pengfuyuan <pengfuyuan@kylinos.cn>
To: Helge Deller <deller@gmx.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
	Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Zsolt Kajtar <soci@c64.rulez.org>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
Message-ID: <20260127085826.GA970322@peng>
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
 <ed48e82a-cb94-477f-83c4-b2d87ae3cde6@suse.de>
 <DFYG7MT5JINY.1T8ZZ4ASIWXU@nvidia.com>
 <20260127080419.GA965382@peng>
 <578209b5-6d22-4255-a2e6-256d3f5afa72@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578209b5-6d22-4255-a2e6-256d3f5afa72@gmx.de>

On Tue, Jan 27, 2026 at 09:16:35AM +0100, Helge Deller wrote:
> On 1/27/26 09:04, pengfuyuan wrote:
> > On Mon, Jan 26, 2026 at 07:28:21PM +0900, Alexandre Courbot wrote:
> > > On Mon Jan 26, 2026 at 7:01 PM JST, Thomas Zimmermann wrote:
> > > > Hi
> > > > 
> > > > Am 26.01.26 um 09:17 schrieb pengfuyuan:
> > > > > This patch series adds Rust bindings and safe abstractions for the Linux
> > > > > framebuffer subsystem, enabling framebuffer drivers to be implemented in Rust.
> > > > 
> > > > The framebuffer subsystem is obsolete and has been deprecated for a
> > > > decade. No new drivers accepted. Anything that really wants fbdev
> > > > already has a driver. Can we please let it die?
> > > 
> > > This, and the patchset is also obviously AI-generated.
> > 
> > Hi,
> > Thank you for the feedback.
> > I’d like to be clear about how I used AI in this work:
> > 
> > 1.Cover letter – Yes, I used AI to help summarize and phrase the cover letter.
> > 2.Comments in the code – Some comments were written or refined with AI assistance.
> > 3.Learning the codebase – When reading and understanding existing Rust-for-Linux code (including DRM and other abstractions), I used AI as a helper to analyze and explain structure and patterns.
> > 4.Writing the code – The implementation was not fully generated by AI.  I wrote the code myself and used AI mainly to look up existing abstractions, traits, and APIs (e.g. “how does X work? ”, “what’s the right trait for Y?”)  while I was coding.
> > 
> > So: AI was used for summaries, comments, learning, and looking
> > things up;  the logic and structure of the code are mine, and I take
> > responsibility for them.
> > If you have concerns about specific parts (e.g. wording, style, or
> > design), I’m happy to rework those patches or to adjust how I
> > describe tool use in future submissions.
> 
> No.
> Please don't resend any patches for the fbdev layer.
> There is no need to provide rust bindings for fbdev, as new
> graphics drivers should use DRM.
> 
> Helge

Hi Helge,

Thank you for the clarification, I understand. I will not resend any fbdev
patches.

Just to give some background on why I started with Rust framebuffer bindings:
our company has a new graphics card, and the plan is to gradually implement
the display controller (DC) driver using the Rust-for-Linux DRM framework.
My goal is to bring up the display step by step on an ARM64 system with this
new GPU.

Since it looks like the current Rust DRM support does not yet include KMS
abstractions (CRTC/plane/connector etc.), my initial idea was to first use a
simple framebuffer-based approach to light up the display, and then later
migrate the DC driver to DRM and eventually to KMS abstractions in Rust.

Given your feedback, I will drop the fbdev approach and focus on DRM instead.

I would like to ask about the current status and plans for Rust DRM KMS
support:

- Is there any active work or a design for KMS abstractions in Rust?
- Is there a WIP tree or an RFC that I could look at?
- Are there specific areas where I could help (e.g. prototyping KMS bindings,
  writing tests, or working on smaller pieces under guidance)?

My goal is to eventually run the DC driver for this new GPU using the Rust
DRM stack on that ARM64 system, so I would be happy to help where it is most
useful for the project.

Thank you again for your time and guidance.

Best regards,
pengfuyuan
