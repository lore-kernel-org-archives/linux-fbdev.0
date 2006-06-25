From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] imacfb: Add Intel-based Macintosh
	Framebuffer Support
Date: Sun, 25 Jun 2006 18:46:56 +0800
Message-ID: <449E69A0.9010309@gmail.com>
References: <449E603B.5030809@gmail.com>
	<20060625033751.45081f05.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuS8u-0003Se-R4 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:47:04 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FuS8t-0001so-Hy
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:47:04 -0700
Received: by py-out-1112.google.com with SMTP id z74so309583pyg
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Jun 2006 03:47:02 -0700 (PDT)
In-Reply-To: <20060625033751.45081f05.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> On Sun, 25 Jun 2006 18:06:51 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> This patch adds a new framebuffer driver for the Intel Based macs.
>> This framebuffer is needed when booting from EFI to get something
>> out the box.
> 
> A few fixlets below.
> 
> This driver looks like it'll leak lots of things when the module is unloaded.

It can't and shouldn't be compiled as a module.

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
