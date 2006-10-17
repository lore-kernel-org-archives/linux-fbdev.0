From: Olaf Hering <olaf@aepfle.de>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v2)
Date: Tue, 17 Oct 2006 18:23:23 +0200
Message-ID: <20061017162323.GA6467@aepfle.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	<20061017155934.GC3502@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZrj8-0005QX-4t for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 09:23:38 -0700
Received: from natklopstock.rzone.de ([81.169.145.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GZrj3-0007ym-Fp
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 09:23:38 -0700
Content-Disposition: inline
In-Reply-To: <20061017155934.GC3502@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Oct 17, Adrian Bunk wrote:

> Subject    : monitor not active after boot
> References : http://lkml.org/lkml/2006/10/5/338
> Submitter  : Olaf Hering <olaf@aepfle.de>
> Caused-By  : Antonino Daplas <adaplas@pol.net>
>              commit 346bc21026e7a92e1d7a4a1b3792c5e8b686133d
> Status     : unknown

The nvidiafb change was removed again. I will see if I can figure out
why the EDID is lost.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
