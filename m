From: James <james@onyx.nurealm.net>
Subject: tridentfb driver with Thinkpad 365XD
Date: Fri, 25 Feb 2005 01:46:34 -0700
Message-ID: <200502250846.j1P8kYt6005969@onyx.nurealm.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4b7d-0001ph-0F
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 00:46:53 -0800
Received: from onyx.nurealm.net ([199.45.155.18])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D4b7N-0002TX-CJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 00:46:52 -0800
Received: from onyx.nurealm.net (localhost.localdomain [127.0.0.1])
	by onyx.nurealm.net (8.13.1/8.13.0) with ESMTP id j1P8kYt6005969
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 25 Feb 2005 01:46:34 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi

Can anyone help with this?

The XFree86 trident driver has always had a problem with the Thinkpad 365XD
Trident TGUI 9320 "Cyber" chipset interacting with IBM's DSTN 800x600 LCD.
On startup, the screen would only display two horizontal orange lines and
"burn" the LCD, physically damaging the display - with some recovery over
time, as if each section of the dual scan display had lost the vertical scan
signal.

The traditional work-around has been to press Fn and F7, the
LCD/external-monitor switching function, after the X server is started.  The
result would be a normal display after a few second delay.  This was
possible with the XFree86 SVGA driver version 3.3.6 at least.

The new Xorg trident driver still shows the same problem with the burning
orange lines, but the "Fn and F7" hack has a problem - the system freezes /
crashes instantly.  The laptop must be powered down to recover.

Now, the reason I'm sending this to linux-fbdev-devel is that the kernel
trident framebuffer driver seems to have exactly the same problem.  The file
says "much inspired by the XFree86 4.x Trident driver sources by Alan
Hourihan".  The problem started with XFree86 4.0, with the change XFree86 3
to XFree86 4.  Xorg has inherited these driver problems, which have never
been fixed in XFree86.  The kernel trident framebuffer driver also seems to
have inherited whatever is causing this problem.

Anyone familiar with the XFree86 3 -> 4 changes?


Thanks

James



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
