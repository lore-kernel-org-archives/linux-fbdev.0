From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Help with Aki Laukkanen's vesafbd project?
Date: 20 Mar 2003 07:32:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048116709.1187.42.camel@localhost.localdomain>
References: <3E785539.23463.8FE8545@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vn6y-0004vn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 19 Mar 2003 15:36:44 -0800
In-Reply-To: <3E785539.23463.8FE8545@localhost>
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
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-20 at 03:32, Kendall Bennett wrote:
> I would like to revive this project, and the code I received from Matan 
> Ziv-Av still configures and compiles correctly on Red Hat 8.0. I need to 
> patch the latest kernel vesafb driver, but I think his patch is very old 
> (probably around 2.2.14 timeframe). I am grabbing the 2.2.14 code to see 
> if the patch will apply to that code, and then try to port the patch to 
> the latest kernel release. Which brings up the first question. What 
> kernel version should I patch against? 2.4.x or 2.5.x?  

I guess, 2.5.x.

> 
> However since I am not that familiar with the patching mechanism for the 
> Linux kernel, would someone more familiar with this be willing to help 
> out? I would like to modify the vesafb module in the kernel to optionally 

Yes, I'll be interested and willing to help out.

> support the vesafbd daemon if it is present on the system, if not it will 
> function as it does today. If vesafbd is present, it will be used to 
> provide extended features to the default VESA framebuffer console driver. 
>  I would also like to generalise the daemon module a bit such that it 
> does not need to be a VESA specific daemon, but could in fact contain 
> it's own hardware interfacing module. For instance the daemon could use 
> XFree86 loadable driver modules to implement the functions rather than 
> the VESA interface code, which would also open up the option of doing 
> accelerated screen blits using the existing XFree86 driver modules. Hence 
> I was thinking that the name 'vesafbd' for the daemon is a misnomer and 
> should probably be changed to something else like 'fbcond' or something. 
> Any suggestions? Or should we just leave it as 'vesafbd' even though it 
> could be updated to support more than just the VESA BIOS interface?  

I'm more inclined to generalize this as a vm86 daemon.  What I'm
thinking is to create a character device /dev/vm86.  A daemon (perhaps
named vm86d) will sleep waiting for a signal which when it arrives, does
a file read.  It should get a generic structure containing all the
registers and the type of request (initialization, interrupt service or
general x86-specific code).  After executing the request, it will do a
file write returning the results of the request.

Within the kernel side, an exportable function (perhaps named vm86_exec)
will be available to anyone.  When this function is called, it will send
a signal to the daemon (for select(), poll() or signal()), then
optionally sleep. The read function will pass the generic request
structure to the daemon.  The write function will get the result from
the daemon and also wake up vm86_exec().  

As a sidenote:  There are specific contexts in the kernel where the
module cannot sleep (ie during vt switches).  In these cases, the module
has to exit immediately without waiting for the daemon to write back the
results, unless we find another method of waiting for the daemon to
finish without the kernel module sleeping.

Optionally, we need to make sure that the correct process opened
/dev/vm86 perhaps by letting the daemon do a specific ioctl which
basically says "I'm here, ignore everyone else".  We would then prevent
kernel confusion when a user does a cat /dev/vm86.

This way, the interface can be useful for other subsystems (APM, IDE,
etc).  Plus, the interface will be very simple (the request structure
will just contain x86's register set, the bus, device, function number,
and perhaps a few flags) and it need not know if this is graphics,
block, power, etc.  The daemon will have the option, perhaps with
suggestions from the kernel, on what to use (vm86, vm86emu, or perhaps
even parse VBE/AF requests into specific XFree86 instructions).
     
> 
> Finally, before I embark on this project, will this patch will be 
> accepted into the kernel source code tree? I would hate to spend my time 
> on it only to find out that the kernel developers don't like it and won't 
> accept it.  

Probably not.  However, if a lot of users find it useful, Linus tends to
succumb to user demand (not vendor demand though), and might even accept
patches which he personally thinks is ugly.  Also, if one of the main
kernel hackers supports this, it might be easier for Linus to accept as
he tends to listen to them.

Tony





-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
