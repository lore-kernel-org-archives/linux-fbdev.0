From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Radeon 9000 on a linux 2.4.18 kernel.
Date: Fri, 24 Jan 2003 10:04:23 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030124090423.GA1690@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18bzlH-0003BU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 01:04:32 -0800
Received: from mel-rta7.wanadoo.fr (193.252.19.61) by mel-rto3.wanadoo.fr (6.7.015)
        id 3E0C33B501121B39 for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jan 2003 10:04:24 +0100
Received: from iliana (81.48.237.20) by mel-rta7.wanadoo.fr (6.7.015)
        id 3E26CE54004F1F42 for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jan 2003 10:04:24 +0100
Received: from luther by iliana with local (Exim 3.36 #1 (Debian))
	id 18bzl9-0000Rd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 10:04:23 +0100
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

Hello, ...

I am trying to use a Radeon 9000 on my pegasos board, and had the same
success with it as with the matrox millenium II i used previously. Well,
it is even worse, since radeonfb doesn't even output a bit in the boot
log.

After a bit of thinking, i realize that this is quite normal, sine i
have to use a 2.4.18 kernel, which knows nothing of the Radeon 9000,
since it did not exist at that time.

So, my questions are :

  1) is it ok to just add the Radeon 9000 pci ids and whatever to the
  2.4.28 kernel and hope it works. (Maybe not, but then the Radeon 9000
  and the Radeon 8500 are supposed to be really similar).

  2) Does anyone know how to check the pci ids of such a card from OF ?

  3) Are the 2.5.x kernel working on powerpc, and if yes, is the
  radeonfb driver ported ?

Friendly,

Sven Luther




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
