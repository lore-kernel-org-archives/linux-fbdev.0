From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 1/1] PXAFB: Support for backlight
	control
Date: Thu, 22 Feb 2007 17:11:56 +0000
Message-ID: <1172164316.5837.102.camel@localhost.localdomain>
References: <20070221145353.GA23916@enneenne.com>
	<1056908425.20070221180037@gmail.com>
	<20070221161210.GL4641@enneenne.com>
	<1741775233.20070221182608@gmail.com>
	<20070222083204.GN4641@enneenne.com>
	<1868738509.20070222123335@gmail.com>
	<20070222163727.GV13924@enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKHUa-0006J1-2m for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:12:28 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HKHUX-00044B-8L
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:12:27 -0800
In-Reply-To: <20070222163727.GV13924@enneenne.com>
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
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Paul Sokolovsky <pmiscml@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, 2007-02-22 at 17:37 +0100, Rodolfo Giometti wrote:
> On Thu, Feb 22, 2007 at 12:33:35PM +0200, Paul Sokolovsky wrote:
> > 
> >   We in handhelds.org codebase have attached patch* to make corgi_bl
> > more suitable for general use. This patch was submitted to Richard
> > (so, more votes needed ;-) ). Otherwise, snippet I pasted is from real
> > machine implementation, HP iPaq h4000.
> 
> You have my vote! :)
> 
> So let me suggest this patch who allows multiple driver instances (I
> use it for both LCD and keypad backlighti devices).
> 
> Hope it could be merged into main line (maybe without the "corgi"
> prefix ;-).

Doing something along these lines is on my todo list but not at the top
since its 2.6.22 material now. Something should appear in -mm within a
few weeks but I don't have the time just at the moment.

Richard



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
