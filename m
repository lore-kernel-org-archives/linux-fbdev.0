From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: framebuffer driver as a module
Date: Sat, 17 Aug 2002 01:04:05 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020816230405.GF13358@ppc.vc.cvut.cz>
References: <3D5D7F5F.7E14609C@motorola.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from panoramix.vasoftware.com ([198.186.202.147])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17fqBn-0000ed-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Aug 2002 16:07:31 -0700
Received: from p024.as-l031.contactel.cz ([212.65.234.216]:32844 helo=ppc.vc.cvut.cz)
	by panoramix.vasoftware.com with esmtp (Exim 4.05-VA-mm1 #1 (Debian))
	id 17fqBY-0004QG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Aug 2002 16:07:20 -0700
Content-Disposition: inline
In-Reply-To: <3D5D7F5F.7E14609C@motorola.com>
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
Content-Transfer-Encoding: 7bit
To: Nikhil Jagtiani <a3158c@motorola.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Aug 16, 2002 at 03:40:31PM -0700, Nikhil Jagtiani wrote:
> Hi,
> 
> I am running linux on an ipaq with framebuffer support. I need to enable
> support for an external graphics card  through a pcmcia slot - the
> driver for which does not exist.
> 
> As this is my first in terms of device driver writing, I would be
> grateful for some advice.
> 
> Is it possible to write this additional driver as a dynamic kernel
> module (along the lines of fbmem.c which is static), which however
> itself implements all device specific functions? Can this  make use of
> the same ioctl functions that fbmem.c uses (defined in fb.h)? Would
> there be a conflict considering that fbmem would remain in the system?

Couple of fbdevs can be compiled as a module, just look for tristate in
drivers/video/Config.in... You can insmod/rmmod such driver as you
want, only thing you must ensure is that there are no users of your
fbdev when you do rmmod. If you have two fbdevs, just move VTs from
"main" to "testing" and back by using con2fb/con2fbmap. If you'll have
only "testing" fbdev in your ipaq, and you have kernel with support
for virtual terminals, it is very tricky, usually impossible to unload
such module - it will have usecount 64 or 128 or another multiple of 64
as soon as you'll see 'Console: switching to ...' on your screen.
						Petr Vandrovec
						vandrove@vc.cvut.cz



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
