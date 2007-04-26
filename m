From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Console unregistration questions
Date: Thu, 26 Apr 2007 10:00:48 -0700
Message-ID: <200704261000.49088.jbarnes@virtuousgeek.org>
References: <200704241459.29297.jbarnes@virtuousgeek.org>
	<200704241646.34556.jbarnes@virtuousgeek.org>
	<1177463833.4829.20.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hh7Km-0001qL-8m for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 10:00:44 -0700
Received: from outbound-mail-09.bluehost.com ([69.89.17.209])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Hh7Kk-000612-Rh
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 10:00:44 -0700
In-Reply-To: <1177463833.4829.20.camel@daplas>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Jakob Bornecrantz <wallbraker@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On Tuesday, April 24, 2007 6:17 pm Antonino A. Daplas wrote:
> Here's a test patch.  Basically, it checks if the driver is still
> mapped to the console, and if it is, unregister_framebuffer() will
> exit immediately.  As mentioned, it's untested, so let me know if
> there are problems.
>
> Note, the driver must also do its part, by checking if the driver is
> opened by something in userspace.

Right.  Looks good to me.

Acked-by: Jesse Barnes <jesse.barnes@intel.com>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
