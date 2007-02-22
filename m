From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Thu, 22 Feb 2007 01:10:16 +0000
Message-ID: <1172106616.5790.90.camel@localhost.localdomain>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
	<877iub9mu2.fsf@sycorax.lbl.gov>
	<1172097718.5790.29.camel@localhost.localdomain>
	<20070221231706.GA3336@khazad-dum.debian.net>
	<1172103159.5790.45.camel@localhost.localdomain>
	<20070222005122.GA7928@khazad-dum.debian.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK2Th-000331-UE for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:10:34 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK2Th-00062A-61
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:10:33 -0800
In-Reply-To: <20070222005122.GA7928@khazad-dum.debian.net>
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
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: James Simmons <jsimmons@infradead.org>, Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Yaroslav Halchenko <kernel@onerussian.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 2007-02-21 at 22:51 -0200, Henrique de Moraes Holschuh wrote:
> On Thu, 22 Feb 2007, Richard Purdie wrote:
> > I have a thinkpad with Intel GM graphics ;-). I need it to work so I try
> > not to experiment too much on it. I've just tried the ibm-acpi driver
> > and it doesn't work well :-(.
> 
> 2.6.21-rc, or 2.6.20? 

2.6.21-rc1

> If it is in 2.6.21, could you give me a report of how
> it fares on 2.6.20?

Maybe next week. I'm away over the weekend and I need it working now ;-).

> > * 'echo 0 > brightness' lowered the intensity but by a level or two, not
> > set it to level 0. A couple of more attempts and it did jump from 7 -> 1
> > and so on, it seems erratic.
> 
> I know it used to work fine before 2.6.20.  Let me check...  works fine on a
> T43, 2.6.20 (Radeon X300).  I need more data to fix it :-)

The following sequence is reproducible:

echo 7 > brightness (repeat until actual_brightness reads 7)
echo 0 > brightness (brightness reads 0, actual_brightness reads 4)
echo 0 > brightness (brightness reads 0, actual_brightness reads 0)

I suspect this is interference from software on the machine as it does
show an onscreen display when I change the values in sysfs and the
values on the OSD don't match what's really going on.  The
actual_brightness does match the screen.

I guess this just means we need to get userspace to agree on one method
of access for this kind of thing. It makes me wondering where the
hardware brightness keys fit into things though...

> > actual_brightness always seems to be correct, as does brightness so it
> > looks like its not updating the hardware correctly.
> 
> Well, if you have the ACPI video module loaded, unload it.  Does it work
> now?

No change if unloaded.

Cheers,

Richard


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
