From: Nikhil Jagtiani <a3158c@motorola.com>
Subject: framebuffer driver as a module
Date: Fri, 16 Aug 2002 15:40:31 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D5D7F5F.7E14609C@motorola.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from motgate.mot.com ([129.188.136.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17fph2-0001Hy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Aug 2002 15:35:44 -0700
Received: [from pobox3.mot.com (pobox3.mot.com [10.64.251.242]) by motgate.mot.com (motgate 2.1) with ESMTP id PAA15438 for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Aug 2002 15:35:43 -0700 (MST)]
Received: [from az33exm05.corp.mot.com (az33exm05.corp.mot.com [199.2.84.25]) by pobox3.mot.com (MOT-pobox3 2.0) with ESMTP id PAA20975 for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Aug 2002 15:33:46 -0700 (MST)]
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I am running linux on an ipaq with framebuffer support. I need to enable
support for an external graphics card  through a pcmcia slot - the
driver for which does not exist.

As this is my first in terms of device driver writing, I would be
grateful for some advice.

Is it possible to write this additional driver as a dynamic kernel
module (along the lines of fbmem.c which is static), which however
itself implements all device specific functions? Can this  make use of
the same ioctl functions that fbmem.c uses (defined in fb.h)? Would
there be a conflict considering that fbmem would remain in the system?

Alternately if i am to write this as a static module (which loads onto
fbmem.c) - is there any way i could test it out without having to
recompile the kernel repeatedly?

Any other suggestions on how to proceed would be very welcome.

Many Thanks,

Nikhil Jagtiani



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
