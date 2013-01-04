From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 04 Jan 2013 10:49:06 +0000
Subject: Re: 3.8-rc2: EFI framebuffer lock inversion...
Message-Id: <CA+icZUXeNFfAwugKZMuy2Arnt0UU2stX5FbuOc=P_B+Rg5oQAw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUVEBEerN=YRSS8Rx-2Xvx4byFuBDbVcE45qq4QZ67+Q-A@mail.gmail.com>
	<CAMVG2svQkEZtz_kod-ifp1y=pwOPa4ZyRnsayf=oyzHzyRsotw@mail.gmail.com>
In-Reply-To: <CAMVG2svQkEZtz_kod-ifp1y=pwOPa4ZyRnsayf=oyzHzyRsotw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel J Blueman <daniel@quora.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>

On Thu, Jan 3, 2013 at 3:39 PM, Daniel J Blueman <daniel@quora.org> wrote:
> On 3 January 2013 22:11, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> Hi Daniel,
>>
>> just wanted to test the fb-fix [2] from Alan and followed the thread in [1].
>> Me is also working with i915 KMS.
>>
>> I looked at nouveau KMS driver and adapted the part for i915:
>>
>> drivers/gpu/drm/nouveau/nouveau_drm.c-200-      /* remove conflicting
>> drivers (vesafb, efifb etc) */
>> drivers/gpu/drm/nouveau/nouveau_drm.c:201:      aper = alloc_apertures(3);
>> drivers/gpu/drm/nouveau/nouveau_drm.c-202-      if (!aper)
>> drivers/gpu/drm/nouveau/nouveau_drm.c-203-              return -ENOMEM;
>>
>> Untested by me, feel free to test.
>>
>> Maybe some of the i915 and/or fb driver experts can comment on the problem.
>
> The structure array from alloc_apertures is just used for the PCI base
> address registers, so it's important here.
>
> I'll take a look at the efifb locking later.
>

You had a chance to look at this?

- Sedat -

> Thanks,
>   Daniel
> --
> Daniel J Blueman
