From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] radeonfb: mode switch work around
Date: Sat, 3 Jul 2004 19:59:23 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040704025923.39501.qmail@web14930.mail.yahoo.com>
References: <20040704021316.GA23914@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgxDv-0007ov-Nc
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 19:59:23 -0700
Received: from web14930.mail.yahoo.com ([216.136.225.159])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BgxDv-0007HU-BP
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 19:59:23 -0700
In-Reply-To: <20040704021316.GA23914@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>, adaplas@pol.net
Cc: Javier Marcet <javier-ml-gmane@marcet.info>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, xorg@freedesktop.org

I have noticed this too. I don't think it is specific to x.org. My best
guess is that the X server is mucking with the VGA registers on the
radeon card.

Try this experiment...
modprobe radeonfb from a VT, then switch to an xterm and rmmod it.
Try it the other way to, modprobe from xterm and rmmod from VT.
Both of those result in a reboot on my machine.

The problem seems to be with radeonfb snap shotting the register state
when it loads, and then restoring it when it unloads. But the VT/xterm
pair causes the retored registers to be set to the wrong values.

This saved register state is also used in other places. These other
uses may be the source of the problem you see. If I remember right, X
is also saving a snap shot of the initial register values.

--- David Eger <eger@havoc.gtf.org> wrote:
> On Sun, Jul 04, 2004 at 09:00:41AM +0800, Antonino A. Daplas wrote:
> > On Sunday 04 July 2004 08:46, David Eger wrote:
> > > 
> > > > Here's the fix for radeonfb for use with your patch.
> > >
> > > On second look, strike that.  I have general badness trying to
> > > switch out of X in recent kernels to radeonfb.  Grr..  I'm not
> > > having luck pinpointing what went wrong just yet.


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
