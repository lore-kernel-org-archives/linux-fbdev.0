From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Fri, 24 Oct 2003 09:44:38 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310240931090.6051-100000@home.osdl.org>
References: <3F987E18.9080606@pobox.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F987E18.9080606@pobox.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>


On Thu, 23 Oct 2003, Jeff Garzik wrote:
> 
> The mechanics aren't complicated, but I seem to recall there being a 
> Real Good Reason why you want to leave it disabled 99% of the time.  No, 
> I don't recall that reason :(  But my fuzzy memory seems to think that 
> "enable, grab a slice o 'rom, disable" was viable.

That's not what I'm worried about: yes, it's doable, and it's only ten
lines of code, but my point is that having drivers do something like this:

>       /* Assign space for ROM resource if not already assigned. Ugly. */
>       if (!pci_resource_start(dev, PCI_ROM_RESOURCE))
>               if (pci_assign_resource(dev, PCI_ROM_RESOURCE) < 0)
>                       return -ENOMEM;
> 
>       /* Enable it. This is too ugly */
>       if (!(pci_resource_flags(dev, PCI_ROM_RESOURCE) & PCI_ROM_ADDRESS_ENABLE)) {
>               u32 val;
>               pci_read_config_dword(dev, PCI_ROM_ADDRESS, &val);
>               val |= PCI_ROM_ADDRESS_ENABLE;
>               pci_write_config_dword(dev, PCI_ROM_ADDRESS, val);
>               pci_resource_flags(dev, PCI_ROM_RESOURCE) |= PCI_ROM_ADDRESS_ENABLE;
>       }

over and over again _is_ going to cause us problems later. Either we'll
change some interface slightly (and have to fix up the drivers), or a
couple of the drivers are going to do things _slightly_ wrong (forget to
assign the resource, or forget to mark it enabled, or whatever), and then
we'll have a subtle bug that only shows up on certain hardware and
firmware combinations, depending on how the BIOS sets up regions etc.


So wouldn't it be nice if we just had those ten lines as a generic
function like

	int pci_enable_rom(struct pci_device *dev)
	{
		...

	int pci_disable_rom(..);

that does all of this properly for the (few) drivers that need this in 
order to fetch resource information from the ROM's?

That way people could just do

	if (pci_enable_device(dev))
		return -ENODEV;

	if (pci_enable_rom(dev))
		return -Exxx;

and we wouldn't have to have drivers that have _waay_ too much knowledge
about things like assigning bus resources and the PCI_ROM_ADDRESS_ENABLE 
bit.

Drivers really shouldn't need to know or care. A driver writer should just 
know that his card has a ROM attached to it, and that he will need to 
enable it explicitly because for most chips we just don't want to waste IO 
mapping space by enabling it by default.

(Yeah, the driver still needs to know about doing the ioremap() etc and
only accessing it with read/write[bwl(), but those are common to any
memory-mapped thing, so that's not "new" knowledge per se).

Case in point: I had to dig around a bit to write those ten lines of code. 
And I consider myself above-average-knowledgeable about PCI device issues. 

So I don't think driver writers should have to write those ten lines, the
same way I think they should just do "pci_enable_device()" to get the
interrupt line and regular BAR things up, and the chip powered on..

And no, most drivers really don't care about their roms. Most devices
don't even have any roms. But grepping for "PCI_ROM_" shows that there
clearly are more than one or two that do (and I'm afraid to think about
the ones that use hardcoded values rather than the symbolic ones, just
because the driver writer didn't find a helper function and just did it by
hand by reading the PCI spec).

		Linus



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
