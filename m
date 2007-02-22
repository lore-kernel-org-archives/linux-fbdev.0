From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Thu, 22 Feb 2007 00:12:39 +0000
Message-ID: <1172103159.5790.45.camel@localhost.localdomain>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
	<877iub9mu2.fsf@sycorax.lbl.gov>
	<1172097718.5790.29.camel@localhost.localdomain>
	<20070221231706.GA3336@khazad-dum.debian.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK1Zy-0005qn-FV for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:13:01 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HK1Zw-0006Fs-KY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:12:58 -0800
In-Reply-To: <20070221231706.GA3336@khazad-dum.debian.net>
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

On Wed, 2007-02-21 at 21:17 -0200, Henrique de Moraes Holschuh wrote:
> On Wed, 21 Feb 2007, Richard Purdie wrote:
> > enabled. On a thinkpad, the backlight is probably under ACPI control.
> 
> BIOS+ACPI, actually.  Without ACPI video loaded, the firmware does
> everything correctly.  With ACPI video, the firmware does it, then its
> changes are clobbered over by ACPI video's.
> 
> If ibm-acpi is loaded, a backlight device "ibm" is added.  ibm-acpi's ibm
> backlight device can change the display brightness.  It is *not* capable of
> turning the backlight on or off, AFAIK.
> 
> BTW, some ThinkPads don't have a Radeon, but rather an Intel GM/GMX device.

I have a thinkpad with Intel GM graphics ;-). I need it to work so I try
not to experiment too much on it. I've just tried the ibm-acpi driver
and it doesn't work well :-(.

So far I've noticed:

* 'cat brightness' != 'cat actual_brightness' upon bootup (doesn't have
to be true if there is hardware brightness limiting or level changing in
action but that wouldn't be the case here and this could be fixed
easily).
* 'echo 0 > brightness' lowered the intensity but by a level or two, not
set it to level 0. A couple of more attempts and it did jump from 7 -> 1
and so on, it seems erratic.

actual_brightness always seems to be correct, as does brightness so it
looks like its not updating the hardware correctly.

Regards,

Richard








-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
