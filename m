From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Wed, 28 Feb 2007 07:09:15 +0800
Message-ID: <1172617755.13422.0.camel@daplas>
References: <20070226144744.GA3615@DervishD>
	<1172503471.20842.14.camel@daplas> <20070226171334.GB13496@DervishD>
	<1172510654.7101.11.camel@daplas>  <20070226203223.GA161@DervishD>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7bvyZxsUGVkF1nVmq7lq"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMBPW-00041Z-0Y for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Feb 2007 15:07:06 -0800
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMBPU-0004dX-D4
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Feb 2007 15:07:05 -0800
Received: by py-out-1112.google.com with SMTP id a29so976469pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 27 Feb 2007 15:07:01 -0800 (PST)
In-Reply-To: <20070226203223.GA161@DervishD>
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
To: DervishD <lkml@dervishd.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux-kernel <linux-kernel@vger.kernel.org>


--=-7bvyZxsUGVkF1nVmq7lq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2007-02-26 at 21:32 +0100, DervishD wrote:
>     Hi Antonino :)
> 
>  * Antonino A. Daplas <adaplas@gmail.com> dixit:
> > On Mon, 2007-02-26 at 18:13 +0100, DervishD wrote:
> > That's why tdfxb limits the vyres to a maximum of 4096. As to why the
> > problem disappeared just by changing this parameter, that I too don't
> > know.
> 
>     Probably setting it back to 4096 will make the problem reappear.
> Right now I cannot test, but I'll make some experiments.
> 

Can you try this patch?  It might help with the screen corruption.

Tony


--=-7bvyZxsUGVkF1nVmq7lq
Content-Disposition: attachment; filename=tdfxfb_delay.diff
Content-Type: text/x-patch; name=tdfxfb_delay.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 689ce02..bb3ca71 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -284,7 +284,8 @@ static inline void banshee_make_room(str
 {
 	/* Note: The Voodoo3's onboard FIFO has 32 slots. This loop
 	 * won't quit if you ask for more. */
-	while((tdfx_inl(par, STATUS) & 0x1f) < size-1);
+	while((tdfx_inl(par, STATUS) & 0x1f) < size-1)
+		mdelay(5);
 }
  
 static int banshee_wait_idle(struct fb_info *info)
@@ -297,7 +298,9 @@ static int banshee_wait_idle(struct fb_i
 
 	while(1) {
 		i = (tdfx_inl(par, STATUS) & STATUS_BUSY) ? 0 : i + 1;
-		if(i == 3) break;
+		if(i == 3)
+			break;
+		mdelay(5);
 	}
 	return 0;
 }

--=-7bvyZxsUGVkF1nVmq7lq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-7bvyZxsUGVkF1nVmq7lq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--=-7bvyZxsUGVkF1nVmq7lq--
