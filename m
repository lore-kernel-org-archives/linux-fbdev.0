From: "Ben Gardner" <gardner.ben@gmail.com>
Subject: 2.6.19-rc5: Geode GX frame buffer takes 13
	seconds to initialize
Date: Thu, 16 Nov 2006 10:29:53 -0600
Message-ID: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gkk7m-0005of-Lc for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Nov 2006 08:30:02 -0800
Received: from wx-out-0506.google.com ([66.249.82.227])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gkk7i-0007ye-OZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Nov 2006 08:30:02 -0800
Received: by wx-out-0506.google.com with SMTP id i30so952006wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 16 Nov 2006 08:29:54 -0800 (PST)
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
To: linux-fbdev-devel@lists.sourceforge.net, Jordan Crouse <jordan.crouse@amd.com>

Hi all,

I'm using the Geode GX processor and the associated frame buffer
driver in 2.6.19-rc5.
I have a 640x480 LCD attached, without DDC support (not sure if that matters).

The frame buffer driver takes 12.5 seconds to initialize.

Is this normal?

Relevant kernel log:
[   18.516093] io scheduler deadline registered (default)
[   18.539818] gxfb 0000:00:01.1: 16384 Kibyte of video memory at 0x41000000
[   31.052135] Console: switching to colour frame buffer device 80x30
[   31.070906] fb0: Geode GX frame buffer device
[   31.094200] Real Time Clock Driver v1.12ac

I tried building the driver as a module, but that makes no difference
-- modprobe 'hangs' for 13 seconds.

I looked through the Geode driver code and didn't see anything obvious
that would eat up 13 seconds.

Any idea as to what is going on?

Thanks,
Ben

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
