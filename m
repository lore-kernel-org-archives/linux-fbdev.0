From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Reading the EDID block for x86 machines
Date: Wed, 12 Mar 2003 10:16:58 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030312181658.96700.qmail@web14912.mail.yahoo.com>
References: <1047490650.1030.31.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14912.mail.yahoo.com ([216.136.225.248])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tAmh-00011m-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 10:16:59 -0800
In-Reply-To: <1047490650.1030.31.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--- Antonino Daplas <adaplas@pol.net> wrote:
> Unless I missed some imported BIOS calls or other
> methods to do this or
> something similar in real-mode...

You missed something. The address of the VBIOS ROM can
be controlled by writing to the PCI config space. You
can make the ROM appear anywhere you want it to.

This happens even for the boot video device. 
Somewhere very early in the boot the system BIOS
enabled the VBIOS ROM and copied it to C000. This is
the "shadow BIOS" option.



=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
