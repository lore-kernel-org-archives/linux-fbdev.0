From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: radeonfb: DDC read wrong?
Date: Sat, 24 Jun 2006 20:11:46 +0800
Message-ID: <449D2C02.8010101@gmail.com>
References: <20060620140152.GB5414@polar.elf12.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fu6zS-0005PV-Gb for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 05:11:54 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fu6zP-00060U-V4
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 05:11:54 -0700
Received: by py-out-1112.google.com with SMTP id s49so1024315pyc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Jun 2006 05:11:51 -0700 (PDT)
In-Reply-To: <20060620140152.GB5414@polar.elf12.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, Robert.Siemer@backsla.sh

Robert Siemer wrote:
> Hello everybody!
> 
> problem: booting kernel overdrives monitor with 200Hz refresh
> 
> kernel: 2.6.16
> kernel which worked fine: 2.6.14
> 
> Monitor: EIZO FlexScan F563-T
> Graphic adapter: ATI Technologies Inc Radeon RV250 If [Radeon 9000]
>  (from Xorg.log)
> 
> I switched to 2.6.16 and booting the kernel overdrove my monitor with
> 200Hz refresh rate.
> 
> As I notice now I have a limit configured in X (I will try it without
> limitation to see what X is doing...).
> 
> The only interesting line so far from X-log:
> (II) RADEON(0): PLL parameters: rf=2700 rd=12 min=20000 max=40000;
> xclk=20000
> 
> 
> Any comments?

Can you change #undef DEBUG to #define DEBUG in drivers/video/fbmon.c
then post your dmesg?

If your monitor's EDID block is faulty, we can add it to our
monitor database for fixups.

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
