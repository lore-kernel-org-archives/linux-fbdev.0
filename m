From: Otto Solares <solca@guug.org>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 15:06:43 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031016210643.GD19795@guug.org>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAFMI-0003yE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 14:08:34 -0700
Received: from opensource-ca.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAFMG-0004UA-V3
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 14:08:33 -0700
Content-Disposition: inline
In-Reply-To: <1066298431.1407.119.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Carlo E. Prelz" <fluido@fluido.as>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Thu, Oct 16, 2003 at 12:00:32PM +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2003-10-16 at 11:19, Carlo E. Prelz wrote:
> > 	Subject: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
> > 	Date: gio, ott 16, 2003 at 12:27:44 +0100
> > 
> > Quoting James Simmons (jsimmons@infradead.org):
> > 
> > > I applied it. I also have Ben's new driver avaiable for testing. 
> > > The diff I released uses Ben's new driver but in BK I'm stilling using teh 
> > > old driver.
> > 
> > I am the happy owner of a "Club"-branded Radeon9200 video card. Here
> > are my experiences using your diff.
> > 
> > My card has a PCI id of 5964. Here you can read the output of 'lspci
> > -vvv' for it:
> 
> My new driver (bk://ppc.bkbits.net/linuxppc-2.5-benh) now uses a copy
> of XFree PCI IDs list, making it much easier to keep in sync. It should
> also support the 9200.

I think your driver is an improvement over the old one, but:

- Could I2C be ported to kernel I2C api and separated?, so it use would not
require the fbdev module loaded.

- PCI IDs list should be in pci_ids.h as every other drivers, reality is
that adding new IDs to pci_ids.h is not hard so your driver will not be the
exception to the rule.

-solca



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
