From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 18 Mar 2003 05:38:59 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047933906.3668.18.camel@localhost.localdomain>
References: <20030317193338.94491.qmail@web14908.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18v2NG-00078a-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 13:42:26 -0800
In-Reply-To: <20030317193338.94491.qmail@web14908.mail.yahoo.com>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-03-18 at 03:33, Jon Smirl wrote:
> --- Antonino Daplas <adaplas@pol.net> wrote:
> > You're talking about other device's expansion ROM's.
> >  VGA ROM's,
> > especially for the x86, are an exception and has to
> > be always mapped at
> > c000:0000.
> 
> Reboot and add pci=rom (case sensitive) to your kernel
> parameters. That will show you where the video ROMs
> are really located.
> 
> My x86 PC's boot video ROM is located at dd000000 not
> C00000. C00000 is only a copy of the ROM in RAM.

That's not the problem.  I can easily grab a copy of the ROM through
extended memory copy, but it cannot just run anywhere.  The VBIOS code
(as with other BIOS code) must run in real mode (address below 1MB) and
VBIOS can only run when at C000:0000 (C000:0000 is in real-mode
segmented addressing, it is C0000 when translated to a linear address). 
Check the definition of DEFAULT_V_BIOS in the code you sent me.

> How is this write protection being achieved? Is it
> done via manipulation of the processor descriptor
> tables; if so just undo it.

Possibly through some BIOS specific thing.  Usually the BIOS places it
somewhere where it cannot be reached, even by the OS.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
