From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: atyfb and radeonfb
Date: 13 Nov 2002 00:09:44 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1037142584.2774.230.camel@zion>
References: <3DCBD804.8050109@ntlworld.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-2-234.abo.wanadoo.fr ([193.253.217.234] helo=zion.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Bk9x-0000bE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Nov 2002 15:09:29 -0800
In-Reply-To: <3DCBD804.8050109@ntlworld.com>
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
To: Steven Newbury <steven.newbury1@ntlworld.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 2002-11-08 at 16:28, Steven Newbury wrote:
> Is atyfb in 2.4 known to work with recent Mach64 chips like Rage XL? 
> When I install the driver it detects the chip but results in just a 
> black screen.  I also noticed that it detects WRAM, whereas I am certain 
> it should be SGRAM.  The XFree86 driver detects everything ok and just 
> works.

Well, I don't know if Geert still have much time to maintain
this driver, any help implementing the missing features would
be nice ;)

> I have also noticed that the radeonfb driver lacks support for 
> initialising the card if the BIOS hasn't already done it.  I have 
> recently changed from a matrox setup where the matroxfb driver would 
> initialise any matrox cards found irrespective of whether the BIOS 
> decided to do it unless it was told not to.  Is there any chance that 
> this functionality is going to be added to the radeonfb driver?  In 
> 2.5/6 perhaps?

If you can get ATI to provide POST code for every single ASIC
rev. out there, that may be a good start.

Ben.



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
