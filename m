From: Edgar Hucek <hostmaster@ed-soft.at>
Subject: Re: [PATCH] imacfb: Add Intel-based Macintosh
	Framebuffer Support
Date: Sun, 25 Jun 2006 13:28:07 +0200
Message-ID: <449E7347.7080303@ed-soft.at>
References: <449E603B.5030809@gmail.com>
	<20060625033751.45081f05.akpm@osdl.org>
	<449E69A0.9010309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuSmh-000729-Te for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 04:28:11 -0700
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]
	helo=mognix.dark-green.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FuSmg-0004CP-G2
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 04:28:11 -0700
In-Reply-To: <449E69A0.9010309@gmail.com>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas schrieb:
> Andrew Morton wrote:
>> On Sun, 25 Jun 2006 18:06:51 +0800
>> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>>
>>> This patch adds a new framebuffer driver for the Intel Based macs.
>>> This framebuffer is needed when booting from EFI to get something
>>> out the box.
>> A few fixlets below.
>>
>> This driver looks like it'll leak lots of things when the module is unloaded.
> 
> It can't and shouldn't be compiled as a module.
> 
> Tony
> 

It was never supposed to build the driver as module.

cu

Edgar (gimli) Hucek

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
