From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Help with Aki Laukkanen's vesafbd project?
Date: Thu, 20 Mar 2003 12:14:13 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E79B095.4261.E4B631B@localhost>
References: <3E78BC18.9671.A905E64@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18w6Qo-00063p-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Mar 2003 12:14:30 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h2KKEtPD016339
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Mar 2003 12:14:56 -0800
In-reply-to: <1048135312.1207.32.camel@localhost.localdomain>
Content-description: Mail message body
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas <adaplas@pol.net> wrote:

> > > I'm more inclined to generalize this as a vm86 daemon.  What I'm
> > > thinking is to create a character device /dev/vm86.  
> > 
> > Right, that is actually not a bad idea, especially as a way for making 
> > vm86 services available to Linux kernel modules. However one of the 
> > offshoots of the vesafbd daemon is also the ability to handle full mode 
> > setting and blitting from the userland daemon without needing the vm86() 
> > BIOS support (ie: using XFree86 modules or allowing other vendor supplied 
> > modules to support this).
> 
> I think that's not a problem, except perhaps for efficiency.  For
> instance, if the kernel module sent a request for int 0x10 with AX
> = 0x4f02 (Set VBE mode), the user daemon can choose to either: 
> 
> a. parse the request so it is compatible with XFree86 or some non-VBE
> modules for video mode changing

Yes, that is true, provided everything that can be done has an interface 
via the regular VBE standard.

> Similarly for blits, we can use the VBE/AF standard.

Actually no, because the VBE/AF standard is a loadable driver module 
interface, and the only ratified standard of VBE/AF 1.0 was only an 
assembler interface. VBE/AF 2.0 which had a C calling interface is dead 
and was never ratified by VESA. Instead we took what was good about 
VBE/AF 2.0, killed what was bad and created SciTech Nucleus which has now 
morphed into what is SciTech SNAP today.

So if you wanted an acceleration interface in this daemon, it could not 
be done via a BIOS style interface since there is no standard for this.

> This should make the kernel->user interface as simple and as
> generic as possible, and we just let the user daemon do whatever it
> wants perhaps with some suggestions from the kernel (such as "use
> the BIOS exclusively" or "use the BIOS only as a last resort"). 

Being a daemon IMHO the suggestions would be better coming from the user 
when the daemon starts up ;-)

> > > This way, the interface can be useful for other subsystems (APM, IDE,
> > > etc).  Plus, the interface will be very simple (the request structure
> > > will just contain x86's register set, the bus, device, function number,
> > > and perhaps a few flags) and it need not know if this is graphics,
> > > block, power, etc.  
> > 
> > I like the idea, but the downside is that some people on the Linux kernel 
> > list feel that the availability of a generic BIOS interface would allow 
> > hardware vendors to be 'lazy' and rely on these services, making their 
> > code less portable to non-x86 platforms. Hence the generic vm86d project 
> > might be a bit of a hard sell for those folks ;-)
> 
> Hmm, I hope not.  Using the BIOS is just too inefficient.

Inefficient, but it would work. Personally I don't see it as a big issue, 
but that is what some folks said on the kernel lists.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
