From: Miles Lane <miles.lane@gmail.com>
Subject: The nvidiafb driver is requiring too much vmalloc space and other problems.
Date: Wed, 30 Mar 2005 14:59:09 -0800
Message-ID: <a44ae5cd05033014597bb3a2e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGm9r-0005Nj-NX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Mar 2005 14:59:31 -0800
Received: from wproxy.gmail.com ([64.233.184.195])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DGm9b-0005BA-6p
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Mar 2005 14:59:31 -0800
Received: by wproxy.gmail.com with SMTP id 69so353698wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Mar 2005 14:59:09 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@pol.net>

Hello,

With guidance from Randy Dunlap, it has been determined that
the nvidiafb driver will fail to operate correctly unless more than
128M of memory is provided by using "vmalloc=".  The default 
kernel configuration provides for 128M, but Randy found that:

>I started looking at vmalloc() and what it calls (which is
> __get_vm_area).  _get_vm_area() always allocates one extra
> page (called a "guard page") between all vmalloc allocations,
> so even though 128 MB is the default amount and the amount
> that nvidiafb wants to use, the kernel wants to allocate
> 128 MB + PAGE_SIZE (4 KB on x86; are you on x86?), so even
> if nvidiafb is the only caller, the vmalloc() call will fail.

Booting with vmalloc=256M works, but Andrew thinks that 
nvidiafb should not be requiring 128M in the first place.

Regarding the problems with i2c bit-banging drivers, I don't
know if the Oops I have been getting is related to the vmalloc
issue somehow.  Comments?  I'll try to repro the crash with
vmalloc=256M set.

Lastly, with vmalloc=256M, my machine crashes whenever 
I try to switch from XFree86 to a framebuffer console.  I cannot
see the oops.  Unfortunately, the only machine I could use for
debugging using a serial connection is a Powerbook, which has
no serial port.

I could try setting up dumping the stack over the network,
but I have never tried to do this before and do not know
whether I can do the dump to a Powerbook running OS/X.
Any suggestions?

Thanks,
        Miles


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
