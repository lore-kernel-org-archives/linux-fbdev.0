From: Michal Januszewski <spock@gentoo.org>
Subject: Re: [PATCH 0/4] fbdev: uvesafb
Date: Sat, 30 Jun 2007 18:39:18 +0200
Message-ID: <20070630163918.GG3838@spock.one.pl>
References: <20070623104920.GA12623@spock.one.pl>
	<20070626104241.GR8547@earth.li>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I4fyj-0004yb-4F for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Jun 2007 09:39:21 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I4fyh-0003M1-OA
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Jun 2007 09:39:21 -0700
Content-Disposition: inline
In-Reply-To: <20070626104241.GR8547@earth.li>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Jun 26, 2007 at 11:42:41AM +0100, Jonathan McDowell wrote:

> Have you considered using libx86[1] in v86d? It looks very similar to
> what you have at present and there are plans to extend it to non
> x86(_64) archs.

It looks like an interesting solution and it is indeed similar to what
I'm currently using.  I'll consider switching to it in the next version
of v86d.

Thanks,
Michal


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
