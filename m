From: "Thomas S. Iversen" <zensonic@zensonic.dk>
Subject: Need advice on blitting to dword alignment
Date: Fri, 12 Sep 2003 15:52:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030912135229.GA12523@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xoMY-0002Rz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 06:53:26 -0700
Received: from 213.237.25.228.adsl.van.worldonline.dk ([213.237.25.228] helo=www.zensonic.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xoMX-0006Yf-AS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 06:53:25 -0700
Received: from www.zensonic.dk (localhost [127.0.0.1])
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.4) with ESMTP id h8CDqUkc012829
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 15:52:31 +0200
Received: (from zensonic@localhost)
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.4) id h8CDqUdx012827
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 15:52:30 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi There

I am in the final stages of developing a framebufferdriver for 
the Silicon Motion Lynx series chip, but ran into troubles
during development of accelerated host blits (mono font expansion to
arbitrary bpp depths)

The Lynx chip expects data in dwords no matter what. If
the image is a multiple of 32 bits wide this is just fine, 
but if it is not I have to pad in zeros in the last dword _for 
each line_

eg. an 24bit by 16 bit mono image would consist of 1 dword for each line
taking 16 dwords to transfer.

Is there _any_ way I can force the framebuffer console system to give
images aligned to dwords? It is ofcourse possible to transfer data
using a for loop taking the padding into account, but that seems
overly complex and in-efficient compared to a memcpy_toio(src,dst,size)

Any hints or suggestions?

Regards Thomas, Denmark


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
