From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH resend] vt: fix potential race in
	VT_WAITACTIVE handler
Date: Mon, 02 Apr 2007 07:39:07 +0800
Message-ID: <1175470747.7772.14.camel@daplas>
References: <20070401124323.GA4040@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HY9ds-0000pY-74 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 16:39:24 -0700
Received: from nz-out-0506.google.com ([64.233.162.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HY9dq-0006dc-Rx
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 16:39:24 -0700
Received: by nz-out-0506.google.com with SMTP id i11so1636394nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 01 Apr 2007 16:39:22 -0700 (PDT)
In-Reply-To: <20070401124323.GA4040@spock.one.pl>
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
To: spock@gentoo.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, 2007-04-01 at 14:43 +0200, Michal Januszewski wrote:
> From: Michal Januszewski <spock@gentoo.org>
> 
> On a multiprocessor machine the VT_WAITACTIVE ioctl call may return 0
> if fg_console has already been updated in redraw_screen() but the
> console switch itself hasn't been completed. Fix this by checking
> fg_console in vt_waitactive() with the console sem held.
> 
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
Acked-by: Antonino Daplas <adaplas@pol.net>

Andrew,

Drop the old version I sent to you.

Tony



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
