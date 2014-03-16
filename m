From: David Herrmann <dh.herrmann@gmail.com>
Date: Sun, 16 Mar 2014 16:25:11 +0000
Subject: Re: Possible bug in deferred io with mmaped memory?
Message-Id: <CANq1E4Q_0jMqhgGSUOSXZtN1p5sOv301Kh_40mRankNzdqVhRw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAAtz+1YfwnSQZMjpA3aKCKG7u1+kXLx+zbQAF6NV3oMsxVd6KQ@mail.gmail.com>
In-Reply-To: <CAAtz+1YfwnSQZMjpA3aKCKG7u1+kXLx+zbQAF6NV3oMsxVd6KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi

On Sat, Mar 15, 2014 at 12:29 PM, Conor O <falling174fps@gmail.com> wrote:
> Hello all, I hope this is a reasonable place to post a bug. If I fix
> it I can post a fix too.
>
> I believe there might be a bug in deferred io. In my fb driver I have
> a block of memory, allocated with kmalloc, that I can mmap, write to,
> and munmap perfectly fine using my own mmap routine. As soon as I
> switch to deferred io, there's a problem:
>
> From userspace, I can mmap the framebuffer memory fine and write to
> it. The deferred io driver routine is called and updates the display
> perfectly correctly. As soon as I call munmap() I get a repeated
> kernel messages. This happens on ARM but not under an Ubuntu
> Virtualbox VM (x86):

You map kmalloc()ed memory to user-space? How do you guarantee that
it's page-aligned? How do you protect kernel-internal state? This
sounds really odd.
Anyhow, you really need to post a link to the code in question if you
want people to help you.

Thanks
David
