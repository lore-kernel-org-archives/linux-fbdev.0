From: Ian Romanick <idr@us.ibm.com>
Subject: Re: [Dri-devel] Two Linux framebuffer patches, Radeon and Rage128
Date: Sun, 10 Aug 2003 15:44:21 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F36CAC5.7060504@us.ibm.com>
References: <20030810213238.95434.qmail@web14905.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030810213238.95434.qmail@web14905.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, dri-devel <dri-devel@lists.sourceforge.net>

Jon Smirl wrote:

> These add all known Radeon and Rage128 PCI IDs to
> their respective framebuffer drivers. It also updates
> linux/pci_ids.h with these IDs.
> 
> Both drivers will display pretty_name if
> CONFIG_PCI_NAMES is enabled, otherwise a name is
> generated.
> 
> Please check over the chip family definitions in the
> framebuffer files. The Radeon ones are more likely to
> be wrong. I also made the Radeon FB claim secondary
> adapters but not do anything with them. This will make
> them display in /proc as being owned by the driver.
> For this to work right the devices ID have to be in
> the correct secondary family. I may not have these all
> right since I don't have the doc.
> 
> I removed about 15 definitions from pci_ids.h that
> were wrong.
> 
> The rage128 patch is newer than the last one. I had a
> typo in an IFDEF. Rage128 add PCI IDs and fixes bug
> when modprobe didn't work.

Did you see a very similar patch that I sent to dri-devel a week or two 
ago?  Isn't pci_ids.h generated automatically from drivers/pci/pci.ids? 
  The patch that I sent to dri-devel updates / cleans-up 
drivers/pci/pci.ids and had a Python script to generate a table that 
looks very similar to the radeonfb_pci_table.  It seems that 
automatically generating that data from pci.ids is a better solution 
that doing it by hand.

I think using something more like my PCI ID structure would help cut out 
some code in the Radeon FB driver because instead of just having an enum 
in the table, you could have a pointer to a structure (such as the 
correct entry in the radeon_chip_info table) that would eliminate some 
of those extra switch-statements.

My changes only cover the Radeon family.  Once that much got into DRI I 
had plans to make similar changes for the Rage128 and MGA families of chips.

Check:

http://marc.theaimsgroup.com/?l=dri-devel&m=105979521324026&w=2




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
