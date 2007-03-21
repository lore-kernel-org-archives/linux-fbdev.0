From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] fbdev sysfs imrovements
Date: Tue, 20 Mar 2007 17:14:26 -0700
Message-ID: <20070321001426.GA29665@kroah.com>
References: <Pine.LNX.4.64.0703192055090.27580@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HToVP-0006X4-8U for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Mar 2007 17:16:43 -0700
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HToVN-0000Ri-R7
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Mar 2007 17:16:43 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703192055090.27580@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Dave Airlie <airlied@linux.ie>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@gmail.com>

On Tue, Mar 20, 2007 at 02:25:49PM +0000, James Simmons wrote:
> 
> This patch does several things to allow the underlying hardware to be 
> shared amount many devices. The most important thing is the use of
> the created device via device_create instead of the hardware device. No 
> longer should fbdev drivers use the xxx_set_drvdata with the parent
> bus device. The second change is having a bus independent power management
> for the framebuffer driver. The final change is using the release method 
> to cleanup the device. The reason again is to make the fbdev driver 
> independent of the bus parent device. Feedback is welcomed.

Looks good to me.

thanks,

greg k-h

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
