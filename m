From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Fri, 24 Oct 2003 13:06:36 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031024170636.GA28582@gtf.org>
References: <3F987E18.9080606@pobox.com> <Pine.LNX.4.44.0310240931090.6051-100000@home.osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310240931090.6051-100000@home.osdl.org>
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
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>

On Fri, Oct 24, 2003 at 09:44:38AM -0700, Linus Torvalds wrote:
> So wouldn't it be nice if we just had those ten lines as a generic
> function like
> 
> 	int pci_enable_rom(struct pci_device *dev)
> 	{
> 		...
> 
> 	int pci_disable_rom(..);

Yes.  Agreed,

	Jeff





-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
