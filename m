From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Strange iotcl operation
Date: Thu, 22 Jun 2006 20:00:21 +0800
Message-ID: <449A8655.8080101@gmail.com>
References: <4499F432.00003A.03013@m61.126.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1718536109=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtNrL-00005s-Ld for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 05:00:31 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtNrK-00025I-Cn
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 05:00:31 -0700
Received: by py-out-1112.google.com with SMTP id i75so307488pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Jun 2006 05:00:29 -0700 (PDT)
In-Reply-To: <4499F432.00003A.03013@m61.126.com>
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
Cc: twomol@126.com

--===============1718536109==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

twomol wrote:
> Hi,all
> I'm using FC5, our graphic card's framebuffer driver's ioctl function
> work abnormally.I mean
> our framebuffer driver provide extending ioctl command. But the ioctl
> cmd can't be transport correctly from user space to kernel space, ie,if
> I ioctl(fd,0x123456,&arg) in user space, the kernel space can not get
> the cmd 0x12345, but a totally different number.

You can't just use any number, be sure to use the 'F'  (0x46) identifier for
framebuffer devices.  See also Documentation/ioctl-number.txt.

Also, look at drivers that has their own ioctl's for help, such as matroxfb
(drivers/video/matrox/matroxfb_base.c).

Tony


--===============1718536109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
--===============1718536109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1718536109==--
