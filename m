From: Meelis Roos <mroos@linux.ee>
Subject: S3Virge fb on PPC?
Date: Wed, 7 Aug 2002 20:14:18 +0300 (EEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.43.0208072005010.14939-100000@romulus.cs.ut.ee>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from romulus.cs.ut.ee ([193.40.5.125])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cUOB-0002kG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 Aug 2002 10:14:28 -0700
Received: from localhost (mroos@localhost)
	by romulus.cs.ut.ee (8.11.6+Sun/8.11.6/romulus-1.10) with ESMTP id g77HEJi24829
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 7 Aug 2002 20:14:19 +0300 (EEST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

I have a mac (powermac 7300/166 upgraded to G3/280) that has broken
onboard video (probaly a half-working address bit in its video RAM). The
computer also has a S3Virge PCI card with fcode so it can boot MacOS
with it and see the picture.

Now I want to have linux framebuffer & run accelerated X on this S3
Virge. There is some generic framebuffer (offb?) that somewhat works (no
acceleration and can't get X to work). XFree 4.1 with s3virge driver
also works somewhat but has strange bad effects: mouse cursor is bad in
HW mode, lower 1/3 of screen is full of gibberish, strange colors
sometimes, ... I have had similar problems on PC where matrox X driver
and matroxfb didn't play well, maybe something similar is happening
here.

Is there any hope that native s3virge framebuffer would work better
(besides being accelerated)?

Also, we seem to have a s3virge framebuffer for Amigas, how difficult
would it be to port it to PPC+x86 (I have a virge DX on a PC too where I
would like to see accelerated fb for faster scrolling). I would like to
do it if I can.

-- 
Meelis Roos (mroos@linux.ee)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
