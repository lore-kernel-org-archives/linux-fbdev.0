From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: monitor detection through ddc/edid stuff.
Date: Sun, 12 Sep 2004 10:42:40 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040912084240.GA21563@pegasos>
References: <20040910111627.GA14811@pegasos> <20040911153625.GA3507@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6Pv3-0004sA-CL
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 01:41:09 -0700
Received: from smtp8.wanadoo.fr ([193.252.22.23] helo=mwinf0808.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6Pv2-0000W6-L3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 01:41:09 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0808.wanadoo.fr (SMTP Server) with SMTP id 57B5E180011E
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Sep 2004 10:41:01 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-31-86.w82-126.abo.wanadoo.fr [82.126.149.86])
	by mwinf0808.wanadoo.fr (SMTP Server) with ESMTP id 37E9518000F3
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Sep 2004 10:40:58 +0200 (CEST)
Received: from luther by pegasos with local (Exim 4.34)
	id 1C6PwY-0005cp-T6
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 10:42:42 +0200
Content-Disposition: inline
In-Reply-To: <20040911153625.GA3507@dreamland.darkstar.lan>
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

On Sat, Sep 11, 2004 at 05:36:25PM +0200, Kronos wrote:
> Il Fri, Sep 10, 2004 at 01:16:27PM +0200, Sven Luther ha scritto: 
> > I also have quickly overviewed the radeon driver, which has a function to read
> > the EDID either from the BIOS or the pmac OF. There seem to be no code
> > whatsoever that adds proper EDID reading through the graphic card directly,
> > like it is done in XFree86, where one can do in the individual drivers (using
> > i2c stuff also) :
> > 
> > 	...
> > 	pBus->BusName = "DDC";
> > 	pBus->I2CUDelay = WildcatVPI2CUDelay;
> > 	pBus->I2CPutBits = WildcatVPI2CPutBits;
> > 	pBus->I2CGetBits = WildcatVPI2CGetBits;
> >
> > These three being smallish functions to delay a bit, and to put/get bits in
> > the DCC Clock/Data Out/In registers.
> 
> Ok, you a have a bit-style adapter. i2c kernel core needs function to
> control SDA and SCL but they can be easily created from X functions.

Well, i have full specs of the board, so it will be enough to base the code
on.

> *GetBits must be splited in getscl (read clock) and getsda (get data),
> and *PutBits must be splited in setscl and setsda.

Yeah, i have seen that.

> I've done that with the radeon driver, look at drivers/video/aty/radeon_i2c.c.

Ah, i see, i had searched for it in the place with the rest of the i2c stuff,
where the prosavage and voodoo i2c code is. Why did you not add it there, but
in the radeon driver ? Should i do the same, or put it together with the other
code ? 

I had seen the voodoo i2c driver, and searched in vain for code using it in
the tdfx driver.

> > Would it make sense to implement such a feature in fbmon.c ? Is fbmon.c the
> > right place for this ? Is this already implemented somewhere else, or maybe in
> > some private tree somewhere ?
> 
> We already have a I2C subsystem, all you have to do is create a new
> adapter and read from it (ie. you put the starting address on bus and
> start reading).

Ok.

> > As i understand this, we would need some place to set the those three
> > function, and then a common function to actually do a real EDID reading
> > through the graphic card (get_EDID_from_harware ?).
> 
> Well, instead of PutBits/GetBits we have 4 functions, the algorithm is 
> provided by the i2c subsystem. Look at radeon_do_probe_i2c_edid in the
> radeon driver, it's not hard to do.

Ok, will look.

> Oh, radeon_probe_i2c_connector contains some "black magic" to wakeup
> some older boards/monitor. An ATI developer confirmed that it's needed
> to cover some corner case, probably you don't need that on your board.

No, i don't think so.

Now, another question which has me baffled. In set_par, i set the video mode
for the card, but i only seem to have access to the bpp, and not the actual
depth. Since i can distinguish between depth 15 (5551) and 16 (5650), as well
as between depth 24 (8888) and 30 (AAA2), where do i get the information
concerning the actual depth used from ? 

Friendly,

Sven Luther


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
