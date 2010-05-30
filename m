From: Ben Dooks <ben@simtec.co.uk>
Date: Sun, 30 May 2010 06:01:32 +0000
Subject: Re: [PATCH 2/2] sm501fb.c: support mmap on PPC440SPe/PPC440EPx
Message-Id: <4C01FF3C.2020707@simtec.co.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274867863-4238-2-git-send-email-agust@denx.de>
In-Reply-To: <1274867863-4238-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 29/05/10 08:48, Andrew Morton wrote:
> On Wed, 26 May 2010 15:50:28 +0200
> Anatolij Gustschin <agust@denx.de> wrote:
> 
>> On Wed, 26 May 2010 20:13:16 +0900
>> Ben Dooks <ben@simtec.co.uk> wrote:
>>
>>> On 26/05/10 18:57, Anatolij Gustschin wrote:
>>>> Add driver specific mmap function to be able to mmap
>>>> frame buffer on PPC440SPe/PPC440EPx platforms. This
>>>> is needed because mmaping of the 36-bit physical
>>>> address of the frame buffer or MMIO is not supported
>>>> in generic fb_mmap().
>>>
>>> Surely this is something we should be fixing in the
>>> main fb layer?
>>
>> We need to store phys addresses > 32-bit somewhere. Changing
>> smem_start and mmio_start of the struct fb_fix_screeninfo to
>> unsigned long long would break user space compatibility.
> 
> gaaah, that was a big screwup.  What are we doing passing these
> addresses to and from userspace?
> 
>> How about adding smem_start_high and mmio_start_high to the
>> struct fb_fix_screeninfo for the purpose of storing upper
>> address bits?
> 
> Bit ugly.  fb_fix_screeninfo32 is presently treated as "thing for
> communicating with userspace" as well as "thing for kernel runtime
> use".  We could separate these functions, and treat fb_fix_screeninfo32
> as purely a userspace communication format.  Copy the fields in and out
> when we talk to userspace.  Obviously the simpler implementation would
> be to create a new fb_fix_screeninfo32_user.  And change the
> fb_fix_screeninfo32 fields to dma_addr_t or whatever.

Something like that, we could add a call to get an u64
smem_start if people really need that in userspace.

I'd rather see a solution that works for all drivers
than fixing up individual drivers.

If people don't want to spend too much time fixing
drivers, we could simply deprecate smem_start and
mmio_start from the in-kernel one and move it outside
to avoid a pile of selective copying of stuff across
ioctl() calls.

-- 
Ben
