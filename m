From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 21/41] fbdev: Pass struct fb_info to
	fb_read and fb_write
Date: Thu, 26 Apr 2007 09:01:10 +0900
Message-ID: <20070426000110.GA12889@linux-sh.org>
References: <462EF97C.2050209@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgrQN-000786-Gg for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 17:01:28 -0700
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgrQM-0006DF-72
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 17:01:27 -0700
Content-Disposition: inline
In-Reply-To: <462EF97C.2050209@gmail.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Christopher Hoover <ch@hpl.hp.com>

On Wed, Apr 25, 2007 at 02:47:24PM +0800, Antonino A. Daplas wrote:
> It is unnecessary to pass struct file to fb_read() and fb_write() in struct
> fb_ops. For consistency with the other methods, pass struct fb_info instead.
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

pvr2fb bits look fine.

Acked-by: Paul Mundt <lethal@linux-sh.org>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
