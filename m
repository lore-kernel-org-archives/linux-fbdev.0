From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: New API and X option UseFBDev
Date: Wed, 10 Sep 2003 06:52:20 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030910045220.GB1560@iliana>
References: <20030909164026.GC4428@iliana> <XFMail.20030909235953.jim.hague@acm.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wwyS-0007o7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 21:53:00 -0700
Received: from smtp8.wanadoo.fr ([193.252.22.30] helo=mwinf0101.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wwyR-00018U-HW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 21:52:59 -0700
Content-Disposition: inline
In-Reply-To: <XFMail.20030909235953.jim.hague@acm.org>
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
Content-Transfer-Encoding: 7bit
To: Jim Hague <jim.hague@acm.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, linux-fbdev-devel@lists.sourceforge.net

On Tue, Sep 09, 2003 at 11:59:53PM +0100, Jim Hague wrote:
> On 09-Sep-2003 Sven Luther wrote:
> > Mmm, notice that the :
> > 
> > (--) GLINT(0): Linear framebuffer at 0xCE800000
> > (--) GLINT(0): MMIO registers at 0xCFFE0000
> > (EE) GLINT(0): mmap mmio: Invalid argument
> > (EE) GLINT(0): mmap mmio: Invalid argument
> > 
> > means that the linear framebuffer and mmio registers, values given to
> > you by pm2fb, are correct (but check this fact with lspci). GLINTMapMem
> > should call fbdevHWMapVidmem, so i suppose the message you see are from
> > fbdevhw. Try enabling the DEBUG #define in glint_driver.c to get a bit
> > more context. 
> 
> I'd notice that. The code in question is in fbdevhw.c.

Ok.

> I've abstracted the problem out into the test program below. It mimics what
> fbdehhw.c does, namely open the frame buffer device, get the fix screen info
> and (I'm assuming) mmap() the io (I haven't delved through the detail
> of /dev/fb0).
> 
> I've run this on 2.4.22-pre6-ac1 and it works fine, and by implication, since
> X via UseFBDev has worked since then, since early 2.4. Here's the output:
> 
> PAGE_MASK 0xfffff000, ~PAGE_MASK 0xfff
> smem_start 0xcf000000 smem_len 0x400000, mmio_start 0xcffe0000, mmio_len 0x10000
> fb_off 0x0 fb_len 0x400000, mmio_off 0x0, mmio_len 0x10000
> mmap(NULL, 0x10000, PROT_READ | PROT_WRITE, MAP_SHARED, 3, 0x400000)
> Worked - map 0x40016000
> 
> On 2.6.0-test3 and 2.6.0-test5 the mmap() fails with EINVAL. Again, the output:
> 
> PAGE_MASK 0xfffff000, ~PAGE_MASK 0xfff
> smem_start 0xcf000000 smem_len 0x400000, mmio_start 0xcffe0000, mmio_len 0x10000
> fb_off 0x0 fb_len 0x400000, mmio_off 0x0, mmio_len 0x10000
> mmap(NULL, 0x10000, PROT_READ | PROT_WRITE, MAP_SHARED, 3, 0x400000)
> mmap mmio: Invalid argument (22)
> 
> As you see, the parameters to mmap() are identical. The problem is fb_len -
> reduce this to, say, 0x3f0000 and mmap() works.
> 
> Any suggestions as to where to look next?

It sounds like a kernel problem, and i can't help you more about this.
Still, and sorry if i am speaking non-sense, but it is early morning,
but in the :

>         map = mmap(NULL, mmio_len, PROT_READ | PROT_WRITE, MAP_SHARED,
>                    fd, fb_len);

Code, i see nowhere that you make mention of the corresponding offsets.
In a small program i did myself for accessing my graphic card by hand, i
did :

      base = mmap((caddr_t)0, Size, PROT_READ|PROT_WRITE,
	          MAP_SHARED|MAP_LOCKED, fd, (off_t)Base);

so your fb_len should maybe have been mmio_start, i think.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
