From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 17 Sep 2010 18:11:00 +0000
Subject: Re: fb_write unaligned writes
Message-Id: <4C93AF34.4030308@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201009092338.59880.james@albanarts.com>
In-Reply-To: <201009092338.59880.james@albanarts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

James Hogan schrieb:
> Hi,
> 
> I came across a problem in fb_write (drivers/video/fbmem.c) which doesn't make 
> any effort to avoid unaligned writes. It copies up to a page at a time from 
> userspace into a buffer, then fb_writel's as much as possible from the buffer 
> into the framebuffer, then fb_writeb's any remaining bytes. However on 
> architectures which don't perform unaligned writes this can cause a bus error 
> or silently fail when it tries to fb_writel to an unaligned framebuffer 
> position.
> 
> My question is how best should this be fixed? I know I could avoid writing 
> more than 3 bytes to an unaligned framebuffer offset, but the standard write 
> syscall should be able to handle this, and Documentation/unaligned-memory-
> access.txt makes it clear that unaligned accesses are to be avoided and with 
> good reason.
> 
> Is it possible to just copy_from_user straight into the framebuffer, or should 
> I define an fb_memcpy to go with the other definitions around line 925 of 
> include/linux/fb.h, or something else?

Just doing copy_from_user straight into the framebuffer sounds like the right 
thing to me but my knowledge is limited to x86. As far as I can see this would 
make the functions (doing the same for fb_read can't hurt, can it?) in fbmem.c 
very similar to those in fb_sys_fops.c. Most users of the later functions can be 
easily eliminated as simply removing ".fb_{read,write} = fb_sys_{read,write}" is 
sufficient, only xen-fbfront.c looks more difficult as it also refreshes the 
screen so I'd suggest the following:
Merging fb_sys_fops.c in fbmem.c, adjusting the fb_{read,write} functions to use 
the the fb_sys_{read,write} copying and removing all trivial uses of 
fb_sys_{read,write}. As far as I can see this should solve your problem and 
would be a cleanup at the same time.
But it would be good if someone who knows other archs (especially sparc as they 
currently seem to perform some assembler that I can't decipher) could comment on 
this topic.


Thanks,

Florian Tobias Schandinat
