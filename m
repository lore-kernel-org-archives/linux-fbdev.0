From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Fri, 24 Oct 2003 23:45:05 +0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031024234505.B2362@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0310241051450.8177-100000@home.osdl.org> <20031024183405.36600.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20031024183405.36600.qmail@web14915.mail.yahoo.com>; from jonsmirl@yahoo.com on Fri, Oct 24, 2003 at 11:34:04AM -0700
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>, Jeff Garzik <jgarzik@pobox.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>

On Fri, Oct 24, 2003 at 11:34:04AM -0700, Jon Smirl wrote:
> PCI ROM enabale/disable has come up before on LKML. Russell made this comment
> about making the code more portable.
> 
> --- Russell King <rmk@arm.linux.org.uk> wrote:
> > You should use pcibios_resource_to_bus() to convert a resource to a
> > representation suitable for a BAR.

pci_assign_resource() does call pcibios_resource_to_bus(),
so Linus' proposal will work correctly as it is.

Ivan.


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
