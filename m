From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Fri, 24 Oct 2003 23:08:30 +0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031024230830.A2362@jurassic.park.msu.ru>
References: <3F987E18.9080606@pobox.com> <Pine.LNX.4.44.0310240931090.6051-100000@home.osdl.org> <20031024165718.GA4972@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20031024165718.GA4972@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Fri, Oct 24, 2003 at 06:57:18PM +0200
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>

On Fri, Oct 24, 2003 at 06:57:18PM +0200, Petr Vandrovec wrote:
> We need something more sophisticated. Matrox's hardware has bits
> 31-16 readable/writable only if bit 0 is set to 1 (ROM enabled; you can
> (obviously) set bits 31-16 & 0 in one write). When ROM is disabled, 
> bits 31-1 are always read as 0.

Hmm, I believe it's not true at least for Mystique, Millennium II
and G400. Otherwise we wouldn't be able to determine ROM size/alignment
as we do probe with ROM disabled (probe.c, line 125):

		pci_write_config_dword(dev, rom, ~PCI_ROM_ADDRESS_ENABLE);
		pci_read_config_dword(dev, rom, &sz);


Ivan.


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
