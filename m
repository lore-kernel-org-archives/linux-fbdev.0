From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Mon, 09 Apr 2012 16:18:26 +0000
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
Message-Id: <CALT56yOU2FDTNRnr=aLVFTGHiVsGNKVoqLqAWQ7Q+Xzg6_B8qQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
 <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
 <1332103797.3105.202.camel@pasglop>
 <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
 <1332222008.2982.13.camel@pasglop>
In-Reply-To: <1332222008.2982.13.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tony Breeds <tbreeds@au1.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Tue, Mar 20, 2012 at 9:40 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>> >> That is interesting! Are those patches published or otherwise available
>> >> somewhere? We are also very interested in enabling Canyonlands
>> >> with Radeon KMS!
>> >
>> > You will run into additional problems with 460 due to the fact that it's
>> > not cache coherent for DMA. Tony patches don't address that part of the
>> > problem (they were used on a 476 based platform).
>>
>> Hmm. Could you please spill a little bit more of details? Also are those patches
>> for 476 merged or present somewhere?
>
> Well, DMA on 46x isn't cache coherent. The DRM plays interesting games
> with mapping/unmapping pages for DMA by the chip and I don't think we
> have the right hooks to do the appropriate cache flushing on these guys,
> but Tony might be able to comment, I don't know whether he tried or not.
>
> On the other hand 476 has fully cache coherent DMA so the only problem
> there is the >32-bit physical address space.
>
> As for the patches, you'll have to wait for Tony to respond (I'll poke
> him locally).

Any news on these patches? A dirty and "not for the upstream yet" version
would be sufficient for me for now.

>
> Cheers,
> Ben.
>

-- 
With best wishes
Dmitry
