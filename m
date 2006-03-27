From: "Jorge Luis Zapata Muga" <jorgeluis.zapata@gmail.com>
Subject: new driver sis6326, i know, its very old =)
Date: Mon, 27 Mar 2006 15:33:27 +0200
Message-ID: <eb77d7060603270533y58fb9eeetb797fad6cdf22b81@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNrwk-0005wN-FC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:39:50 -0800
Received: from wproxy.gmail.com ([64.233.184.235])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FNrwj-0005F4-Bc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:39:50 -0800
Received: by wproxy.gmail.com with SMTP id i30so1650061wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Mar 2006 05:39:45 -0800 (PST)
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi all,
im coding a fb driver for the old sis6326, (dont ask me why :) i know
its really old, im just coding it for fun)
its based on the sis driver from X and some vga based fb's
(cirrus,neo,cyber). its currently working, not quite well, but it
works. im having one problem setting the crt register 13h (the offset
screen), its only written once at module load, when i change the depth
it is written but then it is set to the previous value it had, and
dont know why. maybe someone can give a little info about it, changing
it on the command line is possible (ive made a small c app to write
registers) and it works.
also does anyone on the list has this card so it can be tested?
thanks in advance


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
