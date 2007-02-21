From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Wed, 21 Feb 2007 22:41:57 +0000
Message-ID: <1172097718.5790.29.camel@localhost.localdomain>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
	<877iub9mu2.fsf@sycorax.lbl.gov>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK0AJ-0005KH-Fp for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 14:42:23 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HK0AG-0000M4-KI
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 14:42:22 -0800
In-Reply-To: <877iub9mu2.fsf@sycorax.lbl.gov>
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
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: James Simmons <jsimmons@infradead.org>, Yaroslav Halchenko <kernel@onerussian.com>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

On Wed, 2007-02-21 at 14:18 -0800, Alex Romosan wrote:
> Richard Purdie <rpurdie@rpsys.net> writes:
> i have exactly the same problem with 2.6.21-rc1 on a thinkpad t40
> with an ati radeon card. the machine boots up but the backlight never
> comes on. 2.6.20 worked okay.

Can you have a look at the differences between the defconfigs for 2.6.20
and 2.6.21-rc1?

If the backlight changes are at fault, I'm guessing James' Kconfig
changes to the video Kconfig would be the culprit since
FB_RADEON_BACKLIGHT only used to be selectable if PMAC_BACKLIGHT was
enabled. On a thinkpad, the backlight is probably under ACPI control.

If FB_RADEON_BACKLIGHT wasn't set for 2.6.20, can you try 2.6.21-rc1
with that option disabled?

An ls /sys/class/backlight under 2.6.20 will tell us which driver it was
using...

Thanks,

Richard



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
