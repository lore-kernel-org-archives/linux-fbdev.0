From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: 2.6.11-rc5, rivafb i2c oops, bogus error handling
Date: Mon, 28 Feb 2005 22:41:54 +0800
Message-ID: <200502282241.55815.adaplas@hotpop.com>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050227203214.GA15572@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5m6F-0007MN-Ul
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 06:42:19 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D5m6E-0005P2-BJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 06:42:19 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B890714797FA
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 28 Feb 2005 14:42:07 +0000 (UTC)
In-Reply-To: <20050227203214.GA15572@suse.de>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Olaf Hering <olh@suse.de>, linux-nvidia@lists.surfsouth.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday 28 February 2005 04:32, Olaf Hering wrote:
>  On Wed, Feb 23, Linus Torvalds wrote:
> > This time it's really supposed to be a quickie, so people who can, please
> > check it out, and we'll make the real 2.6.11 asap.
>
> Here is another one, probably not new.
> Is riva_get_EDID_i2c a bit too optimistic by not having a $i2cadapter_ok
> member in riva_par->riva_i2c_chan? It calls riva_probe_i2c_connector
> even if riva_create_i2c_busses fails to register all 3 busses.
>

Thanks,

Can you try this?

Fixed error handling in rivafb-i2c.c if bus registration fails.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 rivafb-i2c.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
--- a/drivers/video/riva/rivafb-i2c.c	2005-01-13 03:57:12 +08:00
+++ b/drivers/video/riva/rivafb-i2c.c	2005-02-28 08:22:06 +08:00
@@ -120,8 +120,12 @@
 	rc = i2c_bit_add_bus(&chan->adapter);
 	if (rc == 0)
 		dev_dbg(&chan->par->pdev->dev, "I2C bus %s registered.\n", name);
-	else
-		dev_warn(&chan->par->pdev->dev, "Failed to register I2C bus %s.\n", name);
+	else {
+		dev_warn(&chan->par->pdev->dev,
+			 "Failed to register I2C bus %s.\n", name);
+		chan->par = NULL;
+	}
+
 	return rc;
 }
 
@@ -171,6 +175,9 @@
 		},
 	};
 	u8 *buf;
+
+	if (!chan->par)
+		return NULL;
 
 	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
 	if (!buf) {




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
