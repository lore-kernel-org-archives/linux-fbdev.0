From: Matthew Hodgson <matthew@arasphere.net>
Subject: vfb performance problems.
Date: Fri, 11 Apr 2003 17:28:47 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53L0.0304111723510.21591@phoenix.siarch.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pc1-oxfd1-3-cust164.oxfd.cable.ntl.com ([62.254.132.164] helo=mail.arasphere.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1941HZ-0000E6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Apr 2003 09:21:41 -0700
Received: from localhost ([127.0.0.1] ident=matthew)
	by mail.arasphere.net with esmtp (Exim 4.12)
	id 1941OR-00072T-00
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Apr 2003 17:28:47 +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

On compiling the vfb module, and writing a very simple user-mode program
to mmap the vfb and then repeatedly memcpy to the framebuffer, I am
getting spectacularly slow write performance.  To be precise, under 2.4.20
and 2.4.21-pre7 the figures are:

architecture        | memcpy to mmaped vfb | fastmemcpy to malloced
--------------------|----------------------|-----------------------
Athlon 1800+XP      | 12.25MB/s            | 400MB/s
Dual Athlon 2400+MP |  1.07MB/s            | 690MB/s
Pentium 4 2.4GHz    | 15.81MB/s            | 640MB/s

Where the second column is the same program, but memcpying (using a
fastmemcpy pinched from the MPlayer source) straight to a user-mode
malloc()ed 'framebuffer'.  The MPlayer code results in double the
performance on Athlons beyond the normal libc memcpy.

The skeletal form of the program (with error checking, timing code etc.
removed) is:

  fd = open("/dev/fb0", O_RDWR);
  src1 = (unsigned char *) malloc(width * height * bytesperpixel);
  src2 = (unsigned char *) malloc(width * height * bytesperpixel);
  memset(src1, 0, width*height*bytesperpixel);
  memset(src2, ~0, width*height*bytesperpixel);
  data = (unsigned char*) mmap(0, width * height * bytesperpixel,
                               PROT_WRITE, MAP_SHARED, fd, 0);
//data = (unsigned char *) malloc(width * height * bytesperpixel);
  while(1) {
      memcpy(data, src1, width*height*bytesperpixel);
      memcpy(data, src2, width*height*bytesperpixel);
  }

A readily compilable version of this can be found at
http://www.arasphere.net/code/vfb_perftest.c

I cannot understand why copying memory from user-space to kernel-space
would be so much slower than from plain user-space to user-space.  I've
tried a very stripped down version of the core vfb idea:

static int mjhtest_init(void)
{
    ...
    if (!(videomemory = (u_long)vmalloc(videomemorysize)))
        return -ENOMEM;
    ...
}

int mjhtest_remap_mmap(struct file *filp, struct vm_area_struct *vma) {
    unsigned long offset = VMA_OFFSET(vma);

    if (offset >= __pa(high_memory) || (filp->f_flags & O_SYNC))
        vma->vm_flags |= VM_IO;
    vma->vm_flags |= VM_RESERVED;

    if (remap_page_range(vma->vm_start, offset, vma->vm_end-vma->vm_start,
                         vma->vm_page_prot))
        return -EAGAIN;

    vma->vm_ops = &simple_remap_vm_ops;
    simple_vma_open(vma);
    return 0;
}

But this performs identically when writing to the offset in the total
memory space exported where the vmalloc() has allocated.  Moreover, a
nopage based implementation behaves identically too.

any help would be hugely appreciated;

thanks

Matthew.

_______________________________________
Matthew Hodgson   matthew@arasphere.net


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
