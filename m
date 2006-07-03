From: "Dave Airlie" <airlied@gmail.com>
Subject: intelfb vsync and i2c support
Date: Mon, 3 Jul 2006 19:57:53 +1000
Message-ID: <21d7e9970607030257u7d73778cv8c6061a1cf59b756@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FxLBl-0003SW-AQ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Jul 2006 02:57:57 -0700
Received: from wx-out-0102.google.com ([66.249.82.201])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FxLBk-0001fu-2H
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Jul 2006 02:57:57 -0700
Received: by wx-out-0102.google.com with SMTP id t12so528273wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 03 Jul 2006 02:57:54 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>, Dennis Munsie <dmunsie@cecropia.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi Dennis,
 I finally got a chance to pull your patches into the intelfb tree,
the intelfb-mm branch
has them.

Andrew can you drop the i915fb branch (which I think you did already)
and add the intelfb-mm branch to -mm?

Thanks,
Dave.

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
