From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Dri-devel] rage/radeon fb driver patch again!
Date: 17 Aug 2003 10:07:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061107655.602.17.camel@gaston>
References: <20030817034344.12442.qmail@web14901.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030817034344.12442.qmail@web14901.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-08-17 at 05:43, Jon Smirl wrote:
> linux/pci_ids.h changed which stomped my patch again.
> I am really getting tired of editing patches consiting
> of hundreds of hex numbers. I spent a full day
> collecting this set of Rage and Radeon PCI IDs and it
> is a real pain that it is being added to pci_ids.h
> piecemeal. This patch sorts the list, adds more
> missing entries, removes some known wrong ones, and
> fixes some spelling. 

Oops, my fault, I sent a patch fixing some incorrect IDs in
James latest one, that was breaking some M9 based PowerMacs.

Maybe you could submit the pci_ids.h patch to Linus right now,
separate from the actual radeon/r128 driver patches ?

> The IGP PCIs should be added in the X0/X1/X2 form, not
> as RS300_speed. If we are going to switch to chip
> family/speed for the name then do it to all of the IDs
> not just a couple.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
