From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: 27 Oct 2003 08:10:16 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <m1isma67jb.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>, Jeff Garzik <jgarzik@pobox.com>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 25 Oct 2003, Egbert Eich wrote:
> > 
> > Speaking of XFree86: when I developed the PCI resource stuff in 
> > XFree86 I was trying to get support from kernel folks to get the 
> > appropriate user space interfaces into the kernel. When I got 
> > nowhere I decided to do everything myself. 
> 
> There won't be any "user space interfaces". There are perfectly good 
> in-kernel interfaces, and anybody who needs them needs to be in kernel 
> space. Ie the kernel interfaces are for kernel modules, not for user space 
> accesses.

Well almost.    There is still one significant flaw in the kernel space stuff.

The BIOS can specify arbitrary regions as reserved in the E820 map and then
a kernel driver can't use that region itself.  This shows up in corner
cases where the resource on the PCI device is a boolean rather than
a general purpose thing.  Particularly for mtd map drivers to allow
flashing your ROM from linux this is a problem.

This is not required for 2.6.0 but it would be nice to actually be able
to reliably reserve resources in kernel drivers.

Eric


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
