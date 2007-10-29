From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Silence radeon_pm warning
Date: Mon, 29 Oct 2007 00:02:02 -0500
Message-ID: <20071029050202.GA16159@lixom.net>
References: <20071029135911.ba1bfee2.sfr@canb.auug.org.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ImMdc-00012u-46 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Oct 2007 21:54:08 -0700
Received: from lixom.net ([66.141.50.11] helo=mail.lixom.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ImMdY-0008Li-Po
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Oct 2007 21:54:08 -0700
Content-Disposition: inline
In-Reply-To: <20071029135911.ba1bfee2.sfr@canb.auug.org.au>
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
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Mon, Oct 29, 2007 at 01:59:11PM +1100, Stephen Rothwell wrote:
> drivers/video/aty/radeon_pm.c:30: warning: 'radeon_reinitialize_M10' declared 'static' but never defined
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I posted this one a few days ago, without adding a new ifdef (just moving the
declaration down into the already existing ifdef below it):

http://marc.info/?l=linux-kernel&m=119311699109698&w=2


-Olof


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
