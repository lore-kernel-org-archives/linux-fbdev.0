From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Thu, 22 Feb 2007 10:00:50 +0000
Message-ID: <1172138450.5837.34.camel@localhost.localdomain>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
	<877iub9mu2.fsf@sycorax.lbl.gov>
	<1172097718.5790.29.camel@localhost.localdomain>
	<20070221231706.GA3336@khazad-dum.debian.net>
	<1172103159.5790.45.camel@localhost.localdomain>
	<20070222005122.GA7928@khazad-dum.debian.net>
	<20070222011017.GA8845@khazad-dum.debian.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKAl9-0002fA-1i for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 02:01:09 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HKAl8-00080q-C6
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 02:01:07 -0800
In-Reply-To: <20070222011017.GA8845@khazad-dum.debian.net>
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

On Wed, 2007-02-21 at 23:10 -0200, Henrique de Moraes Holschuh wrote:
> On Wed, 21 Feb 2007, Henrique de Moraes Holschuh wrote:
> > > * 'cat brightness' != 'cat actual_brightness' upon bootup (doesn't have
> > 
> > Hmm, I see this in 2.6.20 too.  And brightness is the one that is buggy.  I
> > will look into it.
> 
> Now, that was trivial to fix, and I will reply with a patch (which will have
> Cc's trimmed to just the MLs and Richard).
> 
> But really, should not the backlight *class* be doing the initial update of
> the brightness?  Looks like something that every device would need to do if
> the class doesn't do it, and unlike the "power it off on unregister" thing,
> I can't think of a reason not to do it for every backlight class device.
> 
> Please ACK the ibm-acpi patch in my next message if you'd like me to submit
> it to Len Brown for merging into 2.6.21, or NACK it if you'd rather do it in
> the backlight class core.

We can't change the backlight class code since some hardware can't read
from the device, only write to it. Initialisation in that case is a bit
different.

Richard




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
