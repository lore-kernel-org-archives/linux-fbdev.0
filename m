From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Reading the EDID block for x86 machines
Date: Wed, 12 Mar 2003 15:36:31 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030312233631.38505.qmail@web14909.mail.yahoo.com>
References: <1047508652.1005.6.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14909.mail.yahoo.com ([216.136.225.61])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tFly-0006uJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 15:36:34 -0800
In-Reply-To: <1047508652.1005.6.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Antonino Daplas <adaplas@pol.net> wrote:
> 1.  scan for pci devices looking for the vga
> controller type

BIOS provide this via INT for find-pci-device-by-class
= 3

> 2.  if 1 is found other than the primary, disable
> the current controller

Must disable VGA ports. ROM should already be
disabled. The reset program I sent you had the code
for doing the disable properly. You need to poke some
output ports.

No need to diable primary ROM it is not enabled. C000
is a copy of it.

> 3.  write to PCI config space of secondary
> controller the address you
> want it to appear (ie C000:0000).  Can I use other
> addresses?

The ROM will need to appear in an address space hole.
Look in your BIOS for where it is leaving a hole in
the 1MB. Map the VBIOS into the hole and then copy it
to C000. The PC has RAM mapped to C000 so you can't
map the ROM there. 

I believe there is a standard place for this hole
probably E000 or A000 but I would need to reboot to
look.

> 4. enable the controller
> 
> 5. far call c000:0003

This will set up INTs to work on secondary controller.

Now call INT to get EDID data and stick it somewhere
FB can find it.

> 6. disable the controller
> 
> 7. repeat

8) Move the default one back and copy it's ROM back.

You will also need to fix up the INT 10 vectors to
point to the correct entry points for the primary ROM.
The reset code did this too.

> 
> Besides the finer points, did I miss anything
> obvious?
> 
> Tony 
> 


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
