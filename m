From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [Dri-devel] Rage128 and Radeon patches
Date: 15 Aug 2003 10:18:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1060935516.13317.9.camel@gaston>
References: <20030814224729.32404.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030814224729.32404.qmail@web14911.mail.yahoo.com>
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


> Putting the EDID data into the RAM copy will never
> work the case where there are multiple cards since
> there is only one copy of the ROM in low RAM.

Yup, but at least it works for single cards, and that
helps a lot of users until radeonfb can do better

> Personally I'd just like to ignore the boot VROM and
> do everything in the Radeon driver code. But ATI won't
> give out detailed info on how to read EDID or reset
> the card with C code from the driver. So instead we
> end up with the idiotic x86 emulator and doing INT10's
> in simulated real mode.
> 
> Maybe someone with more leverage can coax this info
> out of them.....

Getting the full POST code is probably a lost cause. However,
if you look at the current XFree CVS driver, you'll see rather
complete code to get the EDID via DDC/i2c on all connectors.

Ben.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
