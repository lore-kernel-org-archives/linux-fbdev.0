From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Wed, 14 Jan 2004 22:12:13 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040114211213.GB6573@iliana>
References: <20040109163119.GA10151@scowler.net> <20040112121558.GA24511@iliana> <20040112215543.GB2150@scowler.net> <20040113074158.GF4863@iliana> <20040113154025.GA12817@scowler.net> <20040113160221.GA12752@iliana> <20040114210635.GA31286@scowler.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgsJk-0000VC-Ke
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 13:12:48 -0800
Received: from smtp1.wanadoo.fr ([193.252.22.30] helo=mwinf0104.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgsJk-0005Sg-59
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 13:12:48 -0800
Content-Disposition: inline
In-Reply-To: <20040114210635.GA31286@scowler.net>
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
To: Clint Adams <schizo@debian.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, 226973@bugs.debian.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, Jan 14, 2004 at 04:06:35PM -0500, Clint Adams wrote:
> > Yep. It probably doesn't happen on x86, since the int10 stuff
> > initializes the card with the onboard bios. Using a x86 emulator in X to
> > run this bios might be a solution.
> 
> According to Tech-Source, this card has no VGA bios..

Ok. An OF driver then ?

> > Ho. definitively some registers who are bad. It has been a long time
> > since i have looked at the pm2 specs (kind of 98ish i think) though.
> > Maybe you could get hand of the free TI-pm2 specs and look for yourself ?
> 
> I've been looking and not finding anything.

you did not find the specs, or you didn't find anything ? 

> > You would dump all the possible registers, and see which one is
> > different. Enabling debugging in the glint driver would also do. You can
> > safely run no-accel on these for the tests, as this is definitively not
> > an accel issue, but a video out/ramdac one.
> 
> Attached is the XFree86.0.log from xserver-xfree86-dbg.  I'll start it
> again with noaccel.  The only thing I notice is that it thinks the
> second card only has 4 megs of video ram.

Nope, this is not the right way, you have to rebuild the driver and add
some code to drop the content of the registers somewhere.

I don't have time right now, maybe later i will find time to send you a
register dropping patch or something.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
