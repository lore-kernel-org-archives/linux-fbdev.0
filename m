From: Andrew Clunis <orospakr@orospakr.is-a-geek.org>
Subject: Virtual Framebuffer on UM
Date: Sat, 10 Jul 2004 01:45:22 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1089438322.3195.126.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BjAg5-0001VO-Gf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jul 2004 22:45:37 -0700
Received: from nasc-out-2.nasc.inter.net ([203.176.60.254] helo=app5.nasc.inter.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BjAg5-0007EV-5j
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jul 2004 22:45:37 -0700
Received: from cpe00a00cc1c1a6-cm00407b87b341.cpe.net.cable.rogers.com ([69.196.229.246] helo=[192.168.0.147])
	by app5.nasc.inter.net with asmtp (Exim 3.36 #2)
	id 1BjAfw-0002cu-00
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jul 2004 01:45:28 -0400
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
To: linux-fbdev-devel@lists.sourceforge.net

Hey, all!

I've been hacking on the UM kernel to reenable framebuffer support, in
preparation for writing a driver using SDL (http://libsdl.org).  The
only things I have modified (at least with this tree, heh heh) so far
were to add 'source drivers/video/Kconfig' to arch/um's Kconfig, and
patch fbmem.c to disable caching on the UM arch.  This is in the fb_mmap
function, in all those messy #ifdefs around the arch specific calls to
disable caching on the video memory.

I have a 2.6.6 UM kernel with the aforementioned patches that has been
booted with video=vfb:, and displays:
  fb0: Virtual frame buffer device, using 1024K of video memory
in the kernel messages.

I've ensured /dev/fb0 device node has major 29 and minor 0.

However, when I do 'cp /dev/fb0 /root/blob', I get a file of size 0.  I
was expecting a 1 meg file.

Is this normal behavior?  

p.s. Geert, where can the source for your old GDK UM driver be found,
the one that had the -lpthread trouble?  I have a design that will
(hopefully) not have those issues, but I'm curious as to how you tackled
the rest of it.  (SDL itself has a -lpthread dependency, but I can get
around this. The graphical component of SDL does not require pthreads,
so as long as I don't init the audio or threading components, I should
be OK)

-- 
Regards,
Andrew Clunis

http://orospakr.is-a-geek.org/



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
