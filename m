From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Sun, 18 Mar 2012 14:04:04 +0000
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
Message-Id: <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
In-Reply-To: <1332031585.3105.197.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tony Breeds <tbreeds@au1.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Sun, Mar 18, 2012 at 4:46 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2012-03-17 at 20:04 +0400, Dmitry Eremin-Solenikov wrote:
>> Hello,
>>
>> I'm trying to make framebuffer to work on PPC460EX board (canyonlands).
>>
>> The peculiarity of this platform is the fact that it has
>> sizeof(unsigned long) = 4,
>> but physical address on it is 36 bits width. It is a common to various pieces
>> of the code to expect that unsigned long variable is able to contain physical
>> address. Most of those places are easy to fix.
>
> Yes. In fact, Tony (CC) has some patches to fix a lot of the DRM
> infrastructure (we have radeon KMS working on a similar platform).

That is interesting! Are those patches published or otherwise available
somewhere? We are also very interested in enabling Canyonlands
with Radeon KMS!

>
>> The problem I'm stuck with is a fb_mmap() code. To find a right memory to map
>> it uses information from struct fb_fix_screeninfo provided by the driver.
>> This structure uses two unsigned long fields to hold physical addresses
>> (smem_start and mmio_start). It would be easy to change that structure
>> to use phys_addr_t instead of unsigned long, but this structure is a part
>> of userspace ABI. It is returned to userspace on FBIOGET_FSCREENINFO ioctl.
>> And now I'm stuck with it.
>
> It's an old problem, which I think we described a while back on the
> list. Back then the conclusion was to make a new version with a proper
> __u64, a new ioctl to access is, and a "compatible" ioctl that blanks
> the address fields (or fails) if they contain a value >32-bit.
>
> We just never got to actually implement it.

I see. I will try to prepare patches.

>
> In fact, we could make the new structure such that it doesn't break
> userspace compatibility with 64-bit architectures at all, ie, the "new"
> and "compat" ioctl could remain entirely equivalent on 64-bit.

I remember stuff about compat_ioctl, but I have never used/implemented
that. Are there any details of requirements for the structures being passed?

-- 
With best wishes
Dmitry
