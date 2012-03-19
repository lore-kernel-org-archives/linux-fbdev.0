From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Mon, 19 Mar 2012 14:42:29 +0000
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
Message-Id: <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
 <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
 <1332103797.3105.202.camel@pasglop>
In-Reply-To: <1332103797.3105.202.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tony Breeds <tbreeds@au1.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Mon, Mar 19, 2012 at 12:49 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2012-03-18 at 18:04 +0400, Dmitry Eremin-Solenikov wrote:
>> On Sun, Mar 18, 2012 at 4:46 AM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Sat, 2012-03-17 at 20:04 +0400, Dmitry Eremin-Solenikov wrote:
>> >> Hello,
>> >>
>> >> I'm trying to make framebuffer to work on PPC460EX board (canyonlands).
>> >>
>> >> The peculiarity of this platform is the fact that it has
>> >> sizeof(unsigned long) = 4,
>> >> but physical address on it is 36 bits width. It is a common to various pieces
>> >> of the code to expect that unsigned long variable is able to contain physical
>> >> address. Most of those places are easy to fix.
>> >
>> > Yes. In fact, Tony (CC) has some patches to fix a lot of the DRM
>> > infrastructure (we have radeon KMS working on a similar platform).
>>
>> That is interesting! Are those patches published or otherwise available
>> somewhere? We are also very interested in enabling Canyonlands
>> with Radeon KMS!
>
> You will run into additional problems with 460 due to the fact that it's
> not cache coherent for DMA. Tony patches don't address that part of the
> problem (they were used on a 476 based platform).

Hmm. Could you please spill a little bit more of details? Also are those patches
for 476 merged or present somewhere?

>
>> > In fact, we could make the new structure such that it doesn't break
>> > userspace compatibility with 64-bit architectures at all, ie, the "new"
>> > and "compat" ioctl could remain entirely equivalent on 64-bit.
>>
>> I remember stuff about compat_ioctl, but I have never used/implemented
>> that. Are there any details of requirements for the structures being passed?
>
> In that specific case, I meant something else. IE. The old ioctl could
> remain unchanged, and the new ioctl make the same as the old one on
> 64-bit platforms.

I don't think this kind of magic would be good. I'd just stick to the new
ioctl.

>
> Cheers,
> Ben.
>
>
>



-- 
With best wishes
Dmitry
