From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Tue, 13 Jan 2004 17:02:21 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040113160221.GA12752@iliana>
References: <20040109163119.GA10151@scowler.net> <20040112121558.GA24511@iliana> <20040112215543.GB2150@scowler.net> <20040113074158.GF4863@iliana> <20040113154025.GA12817@scowler.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgQzt-0003o3-Tc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 08:02:29 -0800
Received: from smtp4.wanadoo.fr ([193.252.22.27] helo=mwinf0402.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AgQzt-0004uF-9R
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 08:02:29 -0800
Content-Disposition: inline
In-Reply-To: <20040113154025.GA12817@scowler.net>
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

On Tue, Jan 13, 2004 at 10:40:25AM -0500, Clint Adams wrote:
> > Ok, this may be the problem. The first one is initialized by the pm2fb,
> > while the second is not. This mean either some initialization problems,
> > or the fact that X doesn't initialize some values set by pm2fb.
> 
> Sound sreasonable.

Yep. It probably doesn't happen on x86, since the int10 stuff
initializes the card with the onboard bios. Using a x86 emulator in X to
run this bios might be a solution.

> > What kernel are you using, maybe it would be best to work on a 2.6
> > kernel and try to adapt the pm2fb to the new framework or something.
> 
> Currently using Herbert's 2.4.24-1.  I tried various 2.6 kernels prior
> to 2.6.1, but xdm couldn't seem to start the server and the USB HID
> drivers didn't seem to be functional.

Mmm.

> > Can you describe me the symptoms again ? what exactly did you see on the
> > second head ?
> 
> The second head is currently running WindowMaker with the default Debian
> background.  In the upper left corner, there is the 1/Main clip.
> Directly to the right of that (I assume by 64 pixels or so) is the exact
> same 1/Main clip.  In the border between the two are some flickering

Ho. definitively some registers who are bad. It has been a long time
since i have looked at the pm2 specs (kind of 98ish i think) though.
Maybe you could get hand of the free TI-pm2 specs and look for yourself ?

You would dump all the possible registers, and see which one is
different. Enabling debugging in the glint driver would also do. You can
safely run no-accel on these for the tests, as this is definitively not
an accel issue, but a video out/ramdac one.

> white lines.  The rest of the screen is filled with horizontal
> flickering black and whitish lines.  The left edge of the swirl is on
> the right hand side of the screen.  It appears 5 times.  The "debian"
> only appears as "de", though there are about 5 d's and 3 or 4 e's,
> overlapping.  The clips themselves look perfect, but nothing else does.

Any color problem ?

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
