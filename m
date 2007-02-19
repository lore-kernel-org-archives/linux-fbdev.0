From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Mon, 19 Feb 2007 09:19:48 +0000
Message-ID: <1171876788.6046.3.camel@localhost.localdomain>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJ4gr-00038j-3F for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 01:20:09 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJ4gl-0000kk-Aq
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 01:20:06 -0800
In-Reply-To: <20070219000412.acad13de.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Yaroslav Halchenko <kernel@onerussian.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 2007-02-19 at 00:04 -0800, Andrew Morton wrote:
> On Sun, 18 Feb 2007 23:46:16 -0500 Yaroslav Halchenko <kernel@onerussian.com> wrote:
> > Since the most recent successful for me kernel 2.6.19-rc6-mm1, I've
> > tried few times to build more recent snapshots and now finally
> > 2.6.20-mm2. In all those cases I have a sad outcome -- kernel boots but
> > at some point during boot (few moments after Penguin icon in the top left
> > corner appears), light turns off... I still can see something, especially
> > if I light a strong flashlight at a sharp angle.
> > 
> > I've enabled back-light support and lcd support for those unsuccessful
> > kernels (with all backlight support features disabled kernel boots
> > ok and backlight shines as bright as always)
> > 
> > All my changes of values for files under
> > /sys/class/backlight/radeonbl0
> > had no impact on the screen. Also I had no files under /sys/class/lcd.
> > 
> > Running 
> > radeontool light off
> > caused complete turning off of LCD - I could not see
> > anything anymore.
> > 
> > sony's spictl -b had no effect as well.
> > 
> > Config can be found at
> > http://www.onerussian.com/Linux/bugs/nobacklight.1/config-2.6.20-mm2
> > lshw
> > http://www.onerussian.com/Linux/bugs/nobacklight.1/lshw
> > other details are available from
> > http://www.onerussian.com/Linux/bugs/nobacklight.1/
> > 
> > Could you please advise?
> 
> (cc's added)
> 
> Is 2.6.20 broken?  I assume the latest 2.6.20-gitN snapshot are failing..

It would be extremely useful to know which kernel versions you tested
and which ones failed. There are a number of backlight changes which are
just in 2.6.20-mm1 and -mm2 which it would be useful to rule out or
identify as the cause.

Also, do you normally see files under /sys/class/lcd?

Regards,

Richard



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
