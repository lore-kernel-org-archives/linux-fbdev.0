From: Kronos <kronos@people.it>
Subject: Re: OLS and console rearchitecture
Date: Wed, 28 Jul 2004 23:31:02 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040728213102.GB26087@dreamland.darkstar.lan>
References: <20040728185346.36263.qmail@web14921.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040728185346.36263.qmail@web14921.mail.yahoo.com>
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
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, dri-devel <dri-devel@lists.sourceforge.net>

Hi Jon

Il Wed, Jul 28, 2004 at 11:53:46AM -0700, Jon Smirl ha scritto: 
> 3) Secondary card reset - Handled by an initial hotplug event. We need
> a volunteer to write clean vm86 and emu86 apps for running the ROM
> initialization.

There was a thread on acpi-devel about POSTing VGA ROM after resume:

http://marc.theaimsgroup.com/?l=acpi4linux&m=109023076427394&w=2

The code does a real mode switch in kernel and execute the ROM. Ok, doing
that in userspace is more elegant, but that code is not a mess (though
it's arch dependant).
 
Btw, how do we POST non-x86 (eg. ppc) video boards? I don't think that
there's x86 code in their ROM...

> 7) Mode setting from normal user space - devices will have a standard
> IOCTL accepting a mode string like fbdev currently uses.

sysfs? I sent a patch a while ago but didn't get much feedback.

> 14) A new framebuffer memory manager is needed for mesa GL support. Ian
> is working on it. The memory manager will be part of the support
> library driver code.

sisfb has a memory manager for fb/drm, it may be worth a closer look.

Luca
-- 
Home: http://kronoz.cjb.net
La differenza fra l'intelligenza e la stupidita`?
All'intelligenza c'e` un limite.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
