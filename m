From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Subject: [REGRESSION] i810fb: console switch causes
	pixel waste since 2.6.25-rc?
Date: Sun, 16 Mar 2008 01:33:19 +0100
Message-ID: <200803160133.19948.stefan.bauer@cs.tu-chemnitz.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jagol-0000ts-4S for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Mar 2008 17:33:39 -0700
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jagoh-000198-Um
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Mar 2008 17:33:37 -0700
Received: from v067e.v.pppool.de ([89.57.6.126] helo=noname)
	by john.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66) (envelope-from <stefan.bauer@informatik.tu-chemnitz.de>)
	id 1Jagoc-0002Gl-Um for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 01:33:31 +0100
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi there

in 2.6.25-rc4 and -rc5 every 5th to 10th console switching with Alt-Fn 
causes 'pixel waste' (see [1] for a picture - don't know how to describe 
better).
It doesn't happen with 2.6.24.3.

I tried a bisect on Linus' tree, but couldn't finish yet because I detected an 
intermediate state where no fb works at all. dmesg says
	agpgart: unable to get memory for graphics translation table
which causes i810fb to say
	i810fb_alloc_fbmem: cannot acquire agpgart
So all "bads" (except the first) in this git bisect log mean this broken 
agpgart.

git-bisect start
# bad: [29e8c3c304b62f31b799565c9ee85d42bd163f80] Linux 2.6.25-rc4
git-bisect bad 29e8c3c304b62f31b799565c9ee85d42bd163f80
# good: [49914084e797530d9baaf51df9eda77babc98fa8] Linux 2.6.24
git-bisect good 49914084e797530d9baaf51df9eda77babc98fa8
git-bisect bad bd45ac0c5daae35e7c71138172e63df5cf644cf6
git-bisect good 6bd48fcf73019219495f7599028296c65b749bb4
git-bisect good 746ef0cd0c7190d570c65b8e39a4ac67550ae43a
git-bisect bad 97896d04a14669b146c17d779b81ec7a339deeb3
git-bisect good 751752789162fde69474edfa15935d0a77c0bc17
git-bisect good 0a663088cd6ff9e89f285ae7689e6eee46cfb54c
git-bisect bad 51c6cf662b4b361a09fbd324f4c67875d9bcfbea

I will continue tomorrow figuring out since when agpgart is broken and since 
when it works again. Possibly that problem also causes this regression.

Distribution: Gentoo

System (Gigabyte GA-6OXM7):
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset 
Graphics Controller] (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801AA IDE Controller (rev 02)

Kernel config: See [2].

Boot options:
root=/dev/hda1 lapic 
video=i810fb:hsync1:30,hsync2:72,vsync1:50,vsync2:120,accel,mtrr,640x480-16@100


	Regards,
		Stefan

[1] 131 KB
<http://www-user.tu-chemnitz.de/~stefb/i810fb/pixel_waste.jpg>

[2] 32 KB
<http://www-user.tu-chemnitz.de/~stefb/i810fb/config>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
