From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Help with Aki Laukkanen's vesafbd project?
Date: Wed, 19 Mar 2003 18:51:04 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E78BC18.9671.A905E64@localhost>
References: <3E785539.23463.8FE8545@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vq9J-0003J3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 19 Mar 2003 18:51:21 -0800
Received: from KENDALLB (adsl-63-195-13-78.dsl.chic01.pacbell.net [63.195.13.78])
	by mail.scitechsoft.com (8.12.8/8.12.5) with ESMTP id h2K2pmPD007437
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 19 Mar 2003 18:51:48 -0800
In-reply-to: <1048116709.1187.42.camel@localhost.localdomain>
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

> I guess, 2.5.x.

Ok.

> > However since I am not that familiar with the patching mechanism for the 
> > Linux kernel, would someone more familiar with this be willing to help 
> > out? I would like to modify the vesafb module in the kernel to optionally 
> 
> Yes, I'll be interested and willing to help out.

Great!

> I'm more inclined to generalize this as a vm86 daemon.  What I'm
> thinking is to create a character device /dev/vm86.  

Right, that is actually not a bad idea, especially as a way for making 
vm86 services available to Linux kernel modules. However one of the 
offshoots of the vesafbd daemon is also the ability to handle full mode 
setting and blitting from the userland daemon without needing the vm86() 
BIOS support (ie: using XFree86 modules or allowing other vendor supplied 
modules to support this).

Hence although I like the idea of a vm86d deamon, I do think there is a 
place for a userland framebuffer console daemon as well.

> A daemon (perhaps named vm86d) will sleep waiting for a signal
> which when it arrives, does a file read.  

It can just do the read and it will block in the read until there is 
something to read. No need to wait on a signal ;-)

> Within the kernel side, an exportable function (perhaps named
> vm86_exec) will be available to anyone.  When this function is
> called, it will send a signal to the daemon (for select(), poll()
> or signal()), then optionally sleep. The read function will pass
> the generic request structure to the daemon.  The write function
> will get the result from the daemon and also wake up vm86_exec().  

An interesting side effect of this is that the vm86d daemon could be 
built using the x86emu BIOS emulator for support on non-x86 platforms 
such as Alpha and PowerPC.

> As a sidenote:  There are specific contexts in the kernel where
> the module cannot sleep (ie during vt switches).  In these cases,
> the module has to exit immediately without waiting for the daemon
> to write back the results, unless we find another method of waiting
> for the daemon to finish without the kernel module sleeping. 

Interesting, I had not thought of that.

> This way, the interface can be useful for other subsystems (APM, IDE,
> etc).  Plus, the interface will be very simple (the request structure
> will just contain x86's register set, the bus, device, function number,
> and perhaps a few flags) and it need not know if this is graphics,
> block, power, etc.  

I like the idea, but the downside is that some people on the Linux kernel 
list feel that the availability of a generic BIOS interface would allow 
hardware vendors to be 'lazy' and rely on these services, making their 
code less portable to non-x86 platforms. Hence the generic vm86d project 
might be a bit of a hard sell for those folks ;-)

> > Finally, before I embark on this project, will this patch will be 
> > accepted into the kernel source code tree? I would hate to spend my time 
> > on it only to find out that the kernel developers don't like it and won't 
> > accept it.  
> 
> Probably not.  However, if a lot of users find it useful, Linus
> tends to succumb to user demand (not vendor demand though), and
> might even accept patches which he personally thinks is ugly. 
> Also, if one of the main kernel hackers supports this, it might be
> easier for Linus to accept as he tends to listen to them. 

Right. So basically we should just go ahead and do it as a loadable 
module and then see how many people like it and start using it? Hopefully 
enough interest will get the patches into the kernel proper.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
