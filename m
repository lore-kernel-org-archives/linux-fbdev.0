From: Miernik <miernik@ctnet.pl>
Subject: Re: long time of switch console->X (fast opposite way)
Date: Sun, 18 Jul 2004 03:33:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040718013310.5E70.0.NOFFLE%miernik@ctnet.pl.local>
References: <40F9C8D9.9010605@winischhofer.net>
Reply-To: Miernik <miernik@ctnet.pl>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bm0ee-0000n3-L7
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jul 2004 18:39:52 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bm0ee-0003Bd-0s
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jul 2004 18:39:52 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1Bm0eM-0000EZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 18 Jul 2004 03:39:49 +0200
Received: from 82.160.30.99 ([82.160.30.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 18 Jul 2004 03:39:34 +0200
Received: from miernik by 82.160.30.99 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 18 Jul 2004 03:39:34 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Thomas Winischhofer <thomas@winischhofer.net> wrote:
> 
> > The problem I have it takes 6.7 seconds to switch from console to X
> > with <Alt><F7>. The 6.7 s time is very consistent, every time I
> > measure it. It's very long and annoying.
> 
> This is very probably related to a problem with your mouse (which some 

I do not have a mouse. Can that be a problem? If so, what can I do to 
make X don't even think about a mouse?

> versions of X reset during startup). Check your XF86Config and the X log 
> for related messages. 

I have put these config and log files here:
http://www.miernik.ctnet.pl/problems/slow-fb/
Can you have a look if there is any clue in there?

> Besides, sisfb does not support 1152x864 at 60Hz. This mode is (yet) 
> only supported at 75 and 85Hz, both of which exceed the HSync range of 
> your monitor. Hence the log entries (which BTW only appear when the 
> display mode is switched and not "every several minutes").

In fact my monitor supports way more than that. In the mode I use all 
the time, and which is used in the logs in the previous message too, I 
use: 68.0 kHz / 75 Hz which is displayed in the OSD of my monitor,
and it is perfectly OK with that. 

I have no idea where does sisfb take that from:

Jul 13 12:31:29 jaworz kernel: sisfb: Monitor range H 31-61KHz, V 60-75Hz, Max. dotclock 78MHz
Jul 13 12:31:29 jaworz kernel: sisfb: WARNING: Refresh rate exceeds monitor specs!
Jul 13 12:31:29 jaworz kernel: sisfb: Mode is 1152x864x16 (60Hz)

My monitor is Hyundai DeluxScan 5870
and it can do (data from the manual):

H: 30-70 kHz
V: 50-160 Hz

-- 
    Miernik         _________________________  xmpp:miernik@amessage.info
___________________/__ tel: +48888299997 __/      mailto:miernik@ctnet.pl
http://www.miernik.ctnet.pl/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
