From: Jim Hague <jim.hague@acm.org>
Subject: Re: New API and X option UseFBDev
Date: Tue, 09 Sep 2003 23:59:53 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030909235953.jim.hague@acm.org>
References: <20030909164026.GC4428@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wrSn-0006GS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 15:59:57 -0700
Received: from mta05-svc.ntlworld.com ([62.253.162.45])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wrSm-0000Fm-Uh
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 15:59:57 -0700
In-Reply-To: <20030909164026.GC4428@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 09-Sep-2003 Sven Luther wrote:
> Mmm, notice that the :
> 
> (--) GLINT(0): Linear framebuffer at 0xCE800000
> (--) GLINT(0): MMIO registers at 0xCFFE0000
> (EE) GLINT(0): mmap mmio: Invalid argument
> (EE) GLINT(0): mmap mmio: Invalid argument
> 
> means that the linear framebuffer and mmio registers, values given to
> you by pm2fb, are correct (but check this fact with lspci). GLINTMapMem
> should call fbdevHWMapVidmem, so i suppose the message you see are from
> fbdevhw. Try enabling the DEBUG #define in glint_driver.c to get a bit
> more context. 

I'd notice that. The code in question is in fbdevhw.c.

I've abstracted the problem out into the test program below. It mimics what
fbdehhw.c does, namely open the frame buffer device, get the fix screen info
and (I'm assuming) mmap() the io (I haven't delved through the detail
of /dev/fb0).

I've run this on 2.4.22-pre6-ac1 and it works fine, and by implication, since
X via UseFBDev has worked since then, since early 2.4. Here's the output:

PAGE_MASK 0xfffff000, ~PAGE_MASK 0xfff
smem_start 0xcf000000 smem_len 0x400000, mmio_start 0xcffe0000, mmio_len 0x10000
fb_off 0x0 fb_len 0x400000, mmio_off 0x0, mmio_len 0x10000
mmap(NULL, 0x10000, PROT_READ | PROT_WRITE, MAP_SHARED, 3, 0x400000)
Worked - map 0x40016000

On 2.6.0-test3 and 2.6.0-test5 the mmap() fails with EINVAL. Again, the output:

PAGE_MASK 0xfffff000, ~PAGE_MASK 0xfff
smem_start 0xcf000000 smem_len 0x400000, mmio_start 0xcffe0000, mmio_len 0x10000
fb_off 0x0 fb_len 0x400000, mmio_off 0x0, mmio_len 0x10000
mmap(NULL, 0x10000, PROT_READ | PROT_WRITE, MAP_SHARED, 3, 0x400000)
mmap mmio: Invalid argument (22)

As you see, the parameters to mmap() are identical. The problem is fb_len -
reduce this to, say, 0x3f0000 and mmap() works.

Any suggestions as to where to look next?

Jim

Test prog:

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <linux/fb.h>
#include <asm/page.h>

#define FRAMEBUFFER     "/dev/fb0"

int main(int ac, char *av[])
{
    struct fb_fix_screeninfo fix;
    int fd = open(FRAMEBUFFER, O_RDWR, 0);
    size_t mmio_len, fb_len;
    unsigned long mmio_off, fb_off;
    off_t offset;
    int prot, flags;
    void* map;

    if ( fd < 0  )
    {
        printf("Can't open " FRAMEBUFFER "\n");
        exit(1);
    }

    if ( ioctl(fd, FBIOGET_FSCREENINFO, &fix) < 0 )
        printf("IOCTL failed\n");
    else
    {
        printf("PAGE_MASK 0x%x, ~PAGE_MASK 0x%x\n", PAGE_MASK, ~PAGE_MASK);
        
        printf("smem_start 0x%x smem_len 0x%x, "
               "mmio_start 0x%x, mmio_len 0x%x\n",
               fix.smem_start, fix.smem_len, fix.mmio_start, fix.mmio_len);

        mmio_off = (unsigned long) fix.mmio_start & ~PAGE_MASK;
        mmio_len = (mmio_off + fix.mmio_len + ~PAGE_MASK) & PAGE_MASK;
        fb_off = (unsigned long) fix.smem_start & ~PAGE_MASK;
        fb_len = (fb_off + fix.smem_len + ~PAGE_MASK) & PAGE_MASK;
        
        printf("fb_off 0x%x fb_len 0x%x, "
               "mmio_off 0x%x, mmio_len 0x%x\n",
               fb_off, fb_len, mmio_off, mmio_len);

        printf("mmap(NULL, 0x%x, PROT_READ | PROT_WRITE, "
                        "MAP_SHARED, %d, 0x%x)\n",
                        mmio_len, fd, fb_len);
        map = mmap(NULL, mmio_len, PROT_READ | PROT_WRITE, MAP_SHARED,
                   fd, fb_len);
        if ( -1 == (long) map )
            printf("mmap mmio: %s (%d)\n", strerror(errno), errno);
        else
        {
            printf("Worked - map 0x%x\n", map);
            munmap(map, mmio_len);
        }
    }

    close(fd);
    exit(0);
}


-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
