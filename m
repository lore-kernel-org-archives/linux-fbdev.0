From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OLS and console rearchitecture
Date: Wed, 28 Jul 2004 21:10:18 +0100
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <1091045416.31698.13.camel@localhost.localdomain>
References: <20040728185346.36263.qmail@web14921.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040728185346.36263.qmail@web14921.mail.yahoo.com>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, DRI Devel <dri-devel@lists.sourceforge.net>

On Mer, 2004-07-28 at 19:53, Jon Smirl wrote:
> First a basic definition. There are two consoles, the kernel one
> (printk, kdbg, OOPs, etc) and user one (normal console logins). There
> is no requirement that these consoles be handled with the same code
> even though they are today.

Not sure that was consensus 8)

> 2) VGA control - there needs to be a device for coordinating this. It
> would ensure that only a single VGA device gets enabled at a time. It
> would also adjust PCI bus routing as needed. It needs commands for
> disabling all VGA devices and then enabling a selected one. This device
> may need to coordinate with VGA console. You have to use this device
> even if you aren't using VGA console since it ensures that only a
> single VGA device gets enabled.

Some vendors have multiple vga routers according to bus, unclear how
much we care however.

> the mode registers. Early boot and normal user space will use the same
> hotplug apps so they need to be as small as possible (good luck IA64
> and emu86).

IA64 has EFI to get it up initially.

> 11) OOPs will cause an immediate screen clear and painting of the
> system console including the OOPs data. It is not needed to change the
> video mode. Further drawing to the screen will be blocked until SysReq
> returns to normal operation if possible.

No consensus on the screen clear bit - there are actually reasons to
argue against it.

> 16) accelerated, kernel based console drivers are not supported in this
> model. The only in kernel operations are simple ones like CR/scroll,
> clear, print text. It is possible to call existing DRM entry points
> from a kernel thread, but the code needed is complex.

Its not "unsupported" its merely potentially hard because an accelerated
driver may well have to be a DRI client.

> 18) A coordinated system for grouping console devices needs to be
> designed. This will be bad if each distro does it differently. One
> proposal is to use udev to create: /console/1/mouse,
> /console/1/keyboard, /console/1/usb_hub, /console/2/mouse,
> /console/3/keyboard, /console/4/usb_hub, etc.

Another is to use namespace mounts

> 19) SAK - secure attention key. We forgot to talk about this so we need
> a design.

Falls straight out of having the kernel + helper mode setting



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
--
