From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: monitor detection through ddc/edid stuff.
Date: Fri, 10 Sep 2004 13:44:20 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040910114420.GA15743@pegasos>
References: <20040910111627.GA14811@pegasos>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5wD8-0005xB-46
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 17:57:50 -0700
Received: from smtp4.wanadoo.fr ([193.252.22.27] helo=mwinf0409.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5lgH-0000Wd-Tv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 06:43:17 -0700
Content-Disposition: inline
In-Reply-To: <20040910111627.GA14811@pegasos>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Sep 10, 2004 at 01:16:27PM +0200, Sven Luther wrote:
> Hello,
> 
> I am currently working on a 3dlabs wildcat vp fbdev driver (my 560 died, but i
> got a 880 Pro :). And i have some questions with the monitor detection and
> ddc/edid stuff.
> 
> I have looked over fbmon.c, and foung that it contains code for parsing the
> EDID data, but not for actually reading it, apart the get_EDID_from_firmware
> which is rather primitive, and doesn't actually do anything (i suppose that
> the edid_info.dummy is read from the x86 bios in some other function).
> 
> I also have quickly overviewed the radeon driver, which has a function to read
> the EDID either from the BIOS or the pmac OF. There seem to be no code
> whatsoever that adds proper EDID reading through the graphic card directly,
> like it is done in XFree86, where one can do in the individual drivers (using
> i2c stuff also) :
> 
> 	...
> 	pBus->BusName = "DDC";
> 	pBus->I2CUDelay = WildcatVPI2CUDelay;
> 	pBus->I2CPutBits = WildcatVPI2CPutBits;
> 	pBus->I2CGetBits = WildcatVPI2CGetBits;
> 
> These three being smallish functions to delay a bit, and to put/get bits in
> the DCC Clock/Data Out/In registers.
> 
> And then :
> 
> 	pMon = xf86DoEDID_DDC2(pScrn->scrnIndex, pBus);
> 
> There is also a DCC1 function i think, or something such.
> 
> Would it make sense to implement such a feature in fbmon.c ? Is fbmon.c the
> right place for this ? Is this already implemented somewhere else, or maybe in
> some private tree somewhere ? 
> 
> As i understand this, we would need some place to set the those three
> function, and then a common function to actually do a real EDID reading
> through the graphic card (get_EDID_from_harware ?).
> 
> Does this make sense ? Any hint on how to best implement this ? 

Ah, i suppose i need to setup a i2c bus like the voodoo3 does, right ? but i
don't see that the voodoo3 tdfx driver uses this bus to probe for monitor
stuff, but maybe i missed it.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
