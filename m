From: Kronos <kronos@people.it>
Subject: Re: monitor detection through ddc/edid stuff.
Date: Sat, 11 Sep 2004 17:36:25 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040911153625.GA3507@dreamland.darkstar.lan>
References: <20040910111627.GA14811@pegasos>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C69vV-0001FS-8C
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 08:36:33 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C69vS-0007tr-7o
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 08:36:33 -0700
Received: from dreamland.darkstar.lan (82.84.183.146) by mail-relay-2.tiscali.it (7.1.021.3)
        id 40F419A700E0A533 for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 17:36:11 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Il Fri, Sep 10, 2004 at 01:16:27PM +0200, Sven Luther ha scritto: 
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

Ok, you a have a bit-style adapter. i2c kernel core needs function to
control SDA and SCL but they can be easily created from X functions.

*GetBits must be splited in getscl (read clock) and getsda (get data),
and *PutBits must be splited in setscl and setsda.

I've done that with the radeon driver, look at drivers/video/aty/radeon_i2c.c.

> Would it make sense to implement such a feature in fbmon.c ? Is fbmon.c the
> right place for this ? Is this already implemented somewhere else, or maybe in
> some private tree somewhere ?

We already have a I2C subsystem, all you have to do is create a new
adapter and read from it (ie. you put the starting address on bus and
start reading).

> As i understand this, we would need some place to set the those three
> function, and then a common function to actually do a real EDID reading
> through the graphic card (get_EDID_from_harware ?).

Well, instead of PutBits/GetBits we have 4 functions, the algorithm is 
provided by the i2c subsystem. Look at radeon_do_probe_i2c_edid in the
radeon driver, it's not hard to do.

Oh, radeon_probe_i2c_connector contains some "black magic" to wakeup
some older boards/monitor. An ATI developer confirmed that it's needed
to cover some corner case, probably you don't need that on your board.

Luca
-- 
Home: http://kronoz.cjb.net
"L'abilita` politica e` l'abilita` di prevedere quello che
 accadra` domani, la prossima settimana, il prossimo mese e
 l'anno prossimo. E di essere cosi` abili, piu` tardi,
 da spiegare  perche' non e` accaduto."


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
