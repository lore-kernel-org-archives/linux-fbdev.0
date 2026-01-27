Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DF2571C7;
	Tue, 27 Jan 2026 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502627; cv=none; b=QRyVKZ8TMJ3ZUFHGJL17WryChpDR5D3hofpPsap4RdGr+SxIT5MRDppL2Lq2fxWKbznFR+j7E4Vh5e+HVR44ZSg7FXidd712UzlDLa6W5LPk6xsDFeXwiST/JgRpGNb3oXTb+RIyoK+1AsNkADaavALHzBkIWx6TO4wM4kh/ci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502627; c=relaxed/simple;
	bh=Qd9o0dhwwbCdLcEjAR+CNYNTHgGjnJKzdZKupLKpFFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSo9LxB/yQLYhH8PVQ9/wBb3/kctVuhPOjbmoQoEKmiHgQLQYgXLv3EUG0uUdAEkdh6TUnCMh+fznf0QhMOzobavki/H/A5VlioLD7hL4gUS4axV1tml05dOTbnLXpF3yYkwQKniy4/2DjDExez4SxPHkJ/3YIX6QJO2Yjj9A04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 69791998fb5a11f0b0f03b4cfa9209d1-20260127
X-CID-CACHE: Type:Local,Time:202601271604+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:35cfd77d-35cf-4da1-a4a8-7c1512706972,IP:0,UR
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
X-UUID: 69791998fb5a11f0b0f03b4cfa9209d1-20260127
X-User: pengfuyuan@kylinos.cn
Received: from peng [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengfuyuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1400207429; Tue, 27 Jan 2026 16:30:18 +0800
Date: Tue, 27 Jan 2026 16:30:15 +0800
From: pengfuyuan <pengfuyuan@kylinos.cn>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
	Helge Deller <deller@gmx.de>, Hans de Goede <hansg@kernel.org>,
	Lee Jones <lee@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
Message-ID: <20260127083015.GB965382@peng>
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
 <ed48e82a-cb94-477f-83c4-b2d87ae3cde6@suse.de>
 <DFYG7MT5JINY.1T8ZZ4ASIWXU@nvidia.com>
 <CANiq72kRhkLKcc279CacJ8CnQ18JEZ4A9-vkcg_k4Jw88O4EDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kRhkLKcc279CacJ8CnQ18JEZ4A9-vkcg_k4Jw88O4EDw@mail.gmail.com>

On Mon, Jan 26, 2026 at 12:46:41PM +0100, Miguel Ojeda wrote:
> On Mon, Jan 26, 2026 at 11:28 AM Alexandre Courbot <acourbot@nvidia.com> wrote:
> >
> > This, and the patchset is also obviously AI-generated.
> 
> pengfuyuan: the generated content guidelines I mentioned earlier this
> month in another of your patches have been merged now, please read:
> 
>     https://docs.kernel.org/next/process/generated-content.html
> 
> Thanks!
> 
> Cheers,
> Miguel

Hi Miguel,

Thank you for the pointer. I've read the generated content guidelines at
https://docs.kernel.org/next/process/generated-content.html and will follow
them.

For transparency, here is the disclosure for my contribution:

Tools used:
- Cursor (IDE) with Claude Sonnet 4.5

Parts affected by tool use:
- Cover letter: The cover letter text was summarized/written with AI assistance.
- Code comments: Comments in the code were written with AI assistance.
- Learning and development: I used AI to help analyze existing Rust for Linux
  framework code (e.g. rust/kernel/drm and similar abstractions) and to look
  up existing traits/abstractions while writing the code. The code itself was
  not fully AI-generated; I wrote it with AI used as an aid for querying
  existing abstractions and patterns.

Testing:
- I tested on a real ARM64 machine, manually swapping six different
  graphics cards to verify the changes.

I understand and can explain the code I submit, and I'm prepared to respond
to review comments.

Thanks,
pengfuyuan
