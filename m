From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] savagefb: vsync for twisterP
Date: Wed, 20 Dec 2006 08:37:35 -0800
Message-ID: <20061220083735.84ea3c5f.randy.dunlap@oracle.com>
References: <Pine.LNX.4.64.0612201036130.2728@localhost.localdomain>
	<Pine.LNX.4.64.0612201059100.2728@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gx4Qp-0008MU-8P for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 08:36:40 -0800
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gx4Qo-0000Ol-MC
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 08:36:39 -0800
In-Reply-To: <Pine.LNX.4.64.0612201059100.2728@localhost.localdomain>
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

On Wed, 20 Dec 2006 10:59:32 +0100 (CET) Mark Pustjens wrote:

> Ofcourse, I have to actually *add* the patch :)

Preferably not as an attachment, but as inline text.
Pine can usually do that without problems.


> On Wed, 20 Dec 2006, Mark Pustjens wrote:
> 
> > Hi,
> >
> > This patch add support to the savagefb driver for
> > waiting for vsync for the TwisterP chipset.
> >
> > The patch adds an ioctl FBIO_WAITFORVSYNC just like the
> > matroxfb driver.
> >
> > It probably needs some work.

Here are some comments.

1.  Use tabs consistently for indentation.  The patch has lots
of mixed spaces/tabs, e.g.:

+	struct savagefb_par *par = dev_id;
+        u_int32_t status;
+        int handled = 0;
+	unsigned char b;

2.  Function opening brace goes on a line by itself, not like this
(and other places):

+int savagefb_enable_irq(struct fb_info *info, int reenable) {

3.  Use new irq request names.  This:

+                if (request_irq(par->pcidev->irq, savagefb_irq,
+                                SA_SHIRQ, "savagefb", par)) {

should use IRQF_SHARED instead of SA_SHIRQ.
See comment in linux/interrupt.h:

/*
 * Migration helpers. Scheduled for removal in 1/2007
 * Do not use for new code !
 */

4.  Try to keep source lines < 80 columns so that they are
easily readable in a term window.

5.  Linux switch/case style puts 'case' at the same indent
level as 'switch' to save on indentation.

6.  Don't wrap one-line if-s in braces.  I.e., drop these and
similar braces (and use tabs to indent):

+        if (ret) {
+                return ret;
+        }

7.  Use /* ... */ comment style, not // style.

8.  s/treshold/threshold/ (typo/spello)

---
~Randy

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
