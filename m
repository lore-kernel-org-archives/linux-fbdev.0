From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Finding Aki M Laukkanen's VESAFBD project?
Date: 18 Mar 2003 05:39:04 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047936527.3668.26.camel@localhost.localdomain>
References: <3E71B0FE.1534.4BFD86E@localhost> 
	<3E75A1EB.8118.1424F41D@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18v2NH-0007AO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 13:42:27 -0800
In-Reply-To: <3E75A1EB.8118.1424F41D@localhost>
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
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-03-18 at 02:22, Kendall Bennett wrote:

> The other option is to use the x86emu BIOS emulator project. Then you 
> don't need to do any of this stuff and instead can warm boot all the 
> graphics controllers using the BIOS from the card (see the sample 
> 'warmboot' program included in the source code archives). The code is 
> presently 32-bit specific I believe, so you would have two choices for 
> running this from real mode - port the code to a 16-bit C compiler or 
> port it to run in 32-bit real mode. I assume you are probably thinking of 
> during the boot phase of GRUB or LILO, so at that point you will have 
> full control and should be able to execute 32-bit real mode code. You may 

Interesting, an x86 emulator while in real mode...  This is probably
worth a try.  Thanks.

Tony 




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
