From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 8/9] fbdev: Detect primary display
	device
Date: Sun, 27 May 2007 15:45:31 -0700 (PDT)
Message-ID: <20070527.154531.39158567.davem@davemloft.net>
References: <465952CD.2040409@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsRUK-00041S-Ou for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 15:45:27 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsRUK-0006y5-LE
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 15:45:24 -0700
In-Reply-To: <465952CD.2040409@gmail.com>
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
To: adaplas@gmail.com
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: "Antonino A. Daplas" <adaplas@gmail.com>
Date: Sun, 27 May 2007 17:43:41 +0800

> Add function helper, fb_is_display_device().  Given struct fb_info, it will
> return a nonzero value if the device is the primary display.
> 
> Currently, only the i386 is supported, other platforms only have stubs. For 
> the i386, the function checks for the IORESOURCE_ROM_SHADOW flag.
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

Thank you so much for following up on this work.

I'll try to get the sparc side implemented some time this
coming week.

Thanks again.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
