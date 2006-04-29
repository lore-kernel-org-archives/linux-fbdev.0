From: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH 10/12] fbdev: Static pseudocolor with depth less than 4 does exist
Date: Sat, 29 Apr 2006 08:50:29 -0700
Message-ID: <20060429155029.GA23375@cynthia.pants.nu>
References: <4452B628.1020001@gmail.com> <Pine.LNX.4.62.0604290935310.4557@pademelon.sonytel.be> <44535D47.5060000@gmail.com> <Pine.LNX.4.62.0604292025410.4557@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZw6c-00049F-80
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 13:31:54 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZw6c-0006wX-8r
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 13:31:54 -0700
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net
	([216.102.214.42] helo=cynthia.pants.nu ident=Debian-exim)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FZw6X-0005zL-Mb
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Apr 2006 13:31:54 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0604292025410.4557@pademelon.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linux/m68k <linux-m68k@vger.kernel.org>

On Sat, Apr 29, 2006 at 08:28:37PM +0200, Geert Uytterhoeven wrote:
> On the other hand, at least on Mac/m68k the palette is inherited from MacOS.
> It would be possible for the Penguin booter to programs the standard console
> palette under MacOS, just before booting the kernel, but as I don't know much
> about Penguin, I have no idea whether that's currently done.

I'm not sure I have the latest version of Penguin, but the version I
have laying around has an option to set the current palette before
loading the kernel. I don't remember if it was on by default.

	Brad Boyer
	flar@allandria.com



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
