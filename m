From: Vassilis Virvilis <vasvir@iit.demokritos.gr>
Subject: Twister savagefb doesn't sync
Date: Tue, 16 May 2006 10:46:30 +0300
Message-ID: <44698356.80806@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FfuC2-0007Jf-Vq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 00:42:10 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FfuC3-0006eH-2n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 00:42:11 -0700
Received: from zeus.iit.demokritos.gr ([143.233.226.2])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FfuC1-00073A-Cc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 00:42:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by zeus.iit.demokritos.gr (Postfix) with ESMTP id D57D48D69F
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 May 2006 10:42:02 +0300 (EEST)
Received: from zeus.iit.demokritos.gr ([127.0.0.1])
 by localhost (zeus [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18045-04 for <linux-fbdev-devel@lists.sourceforge.net>;
 Tue, 16 May 2006 10:42:01 +0300 (EEST)
Received: from [62.74.2.63] (dyn63.kif3.nas.panafonet.gr [62.74.2.63])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by zeus.iit.demokritos.gr (Postfix) with ESMTP id 586A88D4D3
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 May 2006 10:41:59 +0300 (EEST)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I am a newcomer to the list so please forgive any unforgivable mistake I may do.

The problem at hand is savagefb. The specific model is 0x5333:0x8d01 (twisterP).
I am using a recent enough kernel and I am trying to use fb through SDL.

I believe SDL is not the problem because one of the monitors I tried it is
an EIZO FlexScan 520 that has the extremely nice feature to report the freequency
of the signals the graphics adaptor emits.

See the table:
         640x480       800x600        1024x768
bpp 8   23.1/28.7     26.8/33.2       48.3/59.9 (works)
bpp 16  18.6/23.1     26.8/33.2       33.2/41.2
bpp 32  18.6/23.1     29.7/36.8       33.2/41.2

That means that 640x480x8 emits Horizontal sync at 23.1KHz / VF 28.Hz
which is out of the sync range of any monitor. So the savage clocks are
not programmed correctly (sorry for awkard use of terminology but I am
hardly a graphics expert).

As a workaround for my EIZO I tried (succesfully)

#This syncronize at 100Hz vertical refresh rate
#fbset -xres 640 -yres 480 -depth 16 -t 9260 48 16 33 10 96 2
#This syncronize at 60Hz vertical refresh rate (fbset -i repors 160Hz)
fbset -xres 640 -yres 480 -depth 16 -t 15385 48 16 33 10 96 2

This is not working for my other monitor a TFT Medion (1280x1024). So
I guess that makes it an EDID dependent bug.

So I tried to look the X source code. Looks like it is from the same
codebase more or less with the in kernel savage driver. However the
X driver supports the Option UseBios for mode switching. The default
setting is yes. I tried to disable it and bingo. X exhibits similar
behaviour to the FB driver. It programs the clocks like above. (more or less
I didn't try all the combinations).

So AFAIU neither kernel nor X knows how to program the specific savage card.
I would like it to debug it further but I don't know from where to start.
The code is nicely written but incomprehensible if you don't have the
manual in order to see what all these registers do.

I know howto patch/compile/test and I am willing to help with this if
there is somebody which can guide me a little bit.

          .bill


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
