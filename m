From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Mar 2014 16:05:15 +0000
Subject: Fwd: Addition to https://www.kernel.org/doc/Documentation/fb/deferred_io.txt
Message-Id: <CAMuHMdU6-pCU9ENsVG2u9imYfdpXO8Y1heJo1+i8BT3SXA=VsQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

--------- Forwarded message ----------
From: Conor O <falling174fps@gmail.com>
Date: Tue, Mar 11, 2014 at 4:36 PM
Subject: Addition to https://www.kernel.org/doc/Documentation/fb/deferred_io.txt
To: Geert Uytterhoeven <geert@linux-m68k.org>


Dear Geert,

Having run into this problem myself
(http://stackoverflow.com/questions/22285151/kernel-panic-using-deferred-io-on-kmalloced-buffer)
I'd like to suggest an addendum to the deferred_io.txt document to
note the difference in treatment between a framebuffer allocated with
vmalloc and one allocated with, say, kmalloc. I've pasted in the diff
below.

Thanks,

Conor O'Rourke.

$ diff deferred_io.txt deferred_io_changes.txt
75a76,89
>
> 5. Bear in mind the following:
>
>   - deferred_io changes info->fp_ops->fb_mmap to its own function that
>     sets up fault handlers etc. In the fault handler it checks bounds
>     against info->fix.smem_len
>
>   - when it gets the page written, it checks the address in info->screen_base
>     to see if that address is one from vmalloc. If so it uses that address
>     as the one to get the page number. If not, the assumption is that the
>     address of interest is the physical framebuffer address stored in
>     info->fix.smem_start. You can get an physical address from, say, a
>     kmalloced pointer by using virt_to_phys().
>
