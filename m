From: Conor O <falling174fps@gmail.com>
Date: Sun, 16 Mar 2014 17:50:15 +0000
Subject: Re: Possible bug in deferred io with mmaped memory?
Message-Id: <CAAtz+1aPTuiV=CWFdTWtsj5AeaNKJEAK7F1va+t0wS-eOmashg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAAtz+1YfwnSQZMjpA3aKCKG7u1+kXLx+zbQAF6NV3oMsxVd6KQ@mail.gmail.com>
In-Reply-To: <CAAtz+1YfwnSQZMjpA3aKCKG7u1+kXLx+zbQAF6NV3oMsxVd6KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, Mar 16, 2014 at 4:25 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Sat, Mar 15, 2014 at 12:29 PM, Conor O <falling174fps@gmail.com> wrote:
>> Hello all, I hope this is a reasonable place to post a bug. If I fix
>> it I can post a fix too.
>>
>> I believe there might be a bug in deferred io. In my fb driver I have
>> a block of memory, allocated with kmalloc, that I can mmap, write to,
>> and munmap perfectly fine using my own mmap routine. As soon as I
>> switch to deferred io, there's a problem:
>>
>> From userspace, I can mmap the framebuffer memory fine and write to
>> it. The deferred io driver routine is called and updates the display
>> perfectly correctly. As soon as I call munmap() I get a repeated
>> kernel messages. This happens on ARM but not under an Ubuntu
>> Virtualbox VM (x86):
>
> You map kmalloc()ed memory to user-space? How do you guarantee that
> it's page-aligned? How do you protect kernel-internal state? This
> sounds really odd.
> Anyhow, you really need to post a link to the code in question if you
> want people to help you.

I was generalising a bit. I could have used __get_free_pages instead
and have the same issue going. In this case, I manually page aligned
the pointer. Yes, that might be considered a touch weird. I thought it
might use less memory than get_free_pages would. I mmap the pointer to
userspace in a similar way to
http://lxr.free-electrons.com/source/drivers/video/vfb.c. I get the
pfn for a particular position in the buffer and remap the range:

    bufpfn = virt_to_phys(vpos) >> PAGE_SHIFT;
    if (remap_pfn_range(vma, vma->vm_start, bufpfn, vsize, vma->vm_page_prot))
        return -EAGAIN;

However, that's really besides the point. Deferred io changes the
.fb_mmap function pointer in the fb_ops structure to point to its own
anyway. My framebuffer driver works fine with vmalloc as it stands so
I'm not in need of assistance. I'm just saying that it all collapses
if I use kmalloc on Arm. I haven't had time to trace the reason but
maybe its unmarking each page instead of a range. I don't know enough
about the virtual memory system to even guess.
