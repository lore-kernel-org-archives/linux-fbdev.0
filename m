From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Fw: oops in aty128_bl_set_power
	in	2.6.18-rc5
Date: Wed, 30 Aug 2006 22:59:50 +0800
Message-ID: <1156949990.13504.10.camel@daplas.org>
References: <20060829205111.19809528.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GIRXv-0004wA-EW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Aug 2006 08:00:03 -0700
Received: from nz-out-0102.google.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GIRXs-0005hk-MJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Aug 2006 08:00:03 -0700
Received: by nz-out-0102.google.com with SMTP id m22so118008nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 30 Aug 2006 07:59:58 -0700 (PDT)
In-Reply-To: <20060829205111.19809528.akpm@osdl.org>
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
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>, Michael Hanselmann <linux-kernel@hansmi.ch>

On Tue, 2006-08-29 at 20:51 -0700, Andrew Morton wrote:

> NIP [C01A62E8] aty128_bl_set_power+0x28/0x9c
> LR [C01A62E4] aty128_bl_set_power+0x24/0x9c
> Call Trace:
> [CDF95D70] [C01A62E4] aty128_bl_set_power+0x24/0x9c (unreliable)
> [CDF95D90] [C01A65A8] aty128fb_blank+0x64/0x120
> [CDF95DB0] [C01706DC] fb_blank+0x4c/0x84
> [CDF95DE0] [C01716C0] fb_ioctl+0x4e4/0x5c4
> [CDF95ED0] [C00977A0] do_ioctl+0x6c/0x84
> [CDF95EE0] [C0097B38] vfs_ioctl+0x380/0x3b4
> [CDF95F10] [C0097BD4] sys_ioctl+0x68/0x98
> [CDF95F40] [C0012480] ret_from_syscall+0x0/0x40
> --- Exception: c01 at 0xfd75f48
>     LR = 0xfd75ee0

Backlight registration can fail resulting in info->bl_dev = NULL.  This
may be the cause of the oops.  An additional 'if (info->bl_dev)' check
in aty128_bl_set_power() may be necessary.

On another note, is the call to aty128_bl_set_power() from
aty128fb_blank() necessary? aty128_bl_set_power() will be called twice
per call to aty128fb_blank().

Tony



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
