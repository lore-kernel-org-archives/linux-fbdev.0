From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fb: fsync() method for deferred	I/O
	flush.
Date: Mon, 05 Mar 2007 19:11:48 +0800
Message-ID: <1173093108.6782.15.camel@daplas>
References: <20070305103905.GA12601@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOB4o-0000KE-MQ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 03:09:58 -0800
Received: from nz-out-0506.google.com ([64.233.162.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOB4n-0005qr-9X
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 03:09:58 -0800
Received: by nz-out-0506.google.com with SMTP id i11so2511370nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 05 Mar 2007 03:09:53 -0800 (PST)
In-Reply-To: <20070305103905.GA12601@linux-sh.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, jayakumar.lkml@gmail.com, linux-kernel@vger.kernel.org

On Mon, 2007-03-05 at 19:39 +0900, Paul Mundt wrote:
> There are cases when we do not want to wait on the delay for
> automatically updating the "real" framebuffer, this implements a
> simple ->fsync() hook for explicitly flushing the deferred I/O
> work. The ->page_mkwrite() handler will rearm the work queue
> normally.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Antonino Daplas <adaplas@gmail.com>

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
