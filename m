From: Robert Siemer <Robert.Siemer@backsla.sh>
Subject: radeonfb: DDC read wrong?
Date: Tue, 20 Jun 2006 16:01:52 +0200
Message-ID: <20060620140152.GB5414@polar.elf12.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fsgnv-0007Dl-8N for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 07:02:07 -0700
Received: from backsla.sh ([217.160.178.134])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fsgnt-0002RM-K2
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 07:02:07 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net

Hello everybody!

problem: booting kernel overdrives monitor with 200Hz refresh

kernel: 2.6.16
kernel which worked fine: 2.6.14

Monitor: EIZO FlexScan F563-T
Graphic adapter: ATI Technologies Inc Radeon RV250 If [Radeon 9000]
 (from Xorg.log)

I switched to 2.6.16 and booting the kernel overdrove my monitor with
200Hz refresh rate.

As I notice now I have a limit configured in X (I will try it without
limitation to see what X is doing...).

The only interesting line so far from X-log:
(II) RADEON(0): PLL parameters: rf=2700 rd=12 min=20000 max=40000;
xclk=20000


Any comments?

Robert
