From: "Fido, Martin" <Martin.Fido@eu.sony.com>
Subject: Implementing an fb driver on a MIPS32 4Kc processor
Date: Tue, 18 Nov 2003 11:54:36 -0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <01738C0043536A4DA982AA8B13A0DDFDAF23D7@ukbpebasmsx06>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AM4SZ-0007Ve-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 03:55:55 -0800
Received: from smtp1.eu.sony.com ([195.212.15.51] helo=relay1.eu.sony.co.jp)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AM4SY-0007hm-Bg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Nov 2003 03:55:54 -0800
Received: from eugw.eu.sony.co.jp (eugw.eu.sony.co.jp [43.194.155.188])
	by relay1.eu.sony.co.jp (8.11.3/8.11.3) with ESMTP id hAIBsUO245720
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 11:54:31 GMT
Received: from gbisseweymss04.eu.sony.com ([43.194.30.210])
	by eugw.eu.sony.co.jp (AIX4.3/8.9.3/8.9.3) with ESMTP id LAA274584
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 11:55:50 GMT
Received: from gbisseweymsx07.eu.sony.com (unverified) by 
    gbisseweymss04.eu.sony.com (Content Technologies SMTPRS 4.3.10) with 
    ESMTP id <T65fb1b0b492bc21ed2820@gbisseweymss04.eu.sony.com> for 
    <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 11:55:50 
    +0000
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
To: "'linux-fbdev-devel@lists.sourceforge.net'" <linux-fbdev-devel@lists.sourceforge.net>

Hi guys & gals,


I'm trying to implement a frame buffer driver on a MIPS32 4Kc processor,
using the MontaVista toolkit (2.4.17 kernel). The product is a set top box,
so the console is on a serial port and the framebuffer is visible on a TV.

The processor has no video memory, so the driver has to allocate memory for
the frame buffer in RAM, and one of the CPUs registers is given the
allocated address.
I'm currently trying to simply insmod my driver and then open /dev/fb/0 and
read some bytes from the file handle. When the drivers init function is
called I fill the framebuffer with a colour for debugging.

I can't allocate the buffer with kmalloc as it's too big. If I declare it
statically or use vmalloc then the CPU doesn't seem to be able to see the
buffer (I see garbage on the screen). I've tried using virt_to_phys etc but
this doesn't help (the CPU register doesn't read the top 6 bits of the
address anyway).
If I pass the "mem" option to the kernel at boot to reserve some memory and
then allocate the buffer with ioremap then the CPU can see the buffer.
This isn't the best solution, since a static buffer has to be big enough to
hold the max resolution in 32 bit colour mode, which is quite large. It
would be much better if I could dynamically create the buffer according to
the res & colour mode requested, but I'm not sure this is possible (I
believe the memory must be contiguous in physical address space).

The real problem however is that regardless of how I allocate the buffer,
when reading from the file handle all I see is zeros. I've filled in
fix.smem_start & fix.smem_len with the address & size of the buffer. Do I
need to do any more than this? I've filled in info.screen_base in my init
function as well (possibly incorrectly - what's the best way to determine
the virtual address?).

I've also tried implementing my own mmap function and calling it from an
application, but with no success - I figure I need to sort out basic read &
write from the filehandle first anyway.

Ok, I think my problems are more to do with memory management (or my lack of
understanding of mm at least) than framebuffers, so please let me know if
there's a more suitable list I can post my questions too.


Many thanks for any advice,


Martin.



***********************************************************************************************
The information contained in this message or any of its attachments may be confidential and is intended for the exclusive use of the addressee(s). Any disclosure, reproduction, distribution or other dissemination or use of this communication is strictly prohibited without the express permission of the sender. The views expressed in this email are those of the individual and not necessarily those of Sony or Sony affiliated companies. Sony email is for business use only. 

This email and any response may be monitored by Sony United Kingdom Limited.
(04)
***********************************************************************************************



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
