From: Andrew Morton <akpm@osdl.org>
Subject: Re: Hang when using a Matrox G550 with DVI
Date: Wed, 25 May 2005 23:39:58 -0700
Message-ID: <20050525233958.05ceaa58.akpm@osdl.org>
References: <7f45d93905042111313ae10b39@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbC32-0000ck-JI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 23:40:52 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DbC30-0006rY-N4
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 23:40:52 -0700
In-Reply-To: <7f45d93905042111313ae10b39@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Shaun Jackman <sjackman@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Shaun Jackman <sjackman@gmail.com> wrote:
>
> When I have a DVI display plugged into my Matrox G550 video card the
> Linux kernel 2.6.11 hangs while booting. This can be worked around by
> "disabling CONFIG_VIDEO_SELECT and/or comment out call to store_edid
> in arch/i386/boot/video.S" [1], or by unplugging the DVI display
> before the kernel boots and plugging it back in before X starts. This
> is the same bug listed here [2], and it has been around since the
> 2.5.67-bk6 days.
> 
> Please cc me in your reply. Cheers,
> Shaun
> 
> [1] http://www.ussg.iu.edu/hypermail/linux/kernel/0408.2/0434.html
> [2] http://bugme.osdl.org/show_bug.cgi?id=1458

Do the fbdev guys know about this?

Does 2.6.12-rc5 still have the bug?


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
