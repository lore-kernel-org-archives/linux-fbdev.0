From: Sven LUTHER <luther@lambda.u-strasbg.fr>
Subject: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 19:23:50 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020722172350.GA466@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25] helo=mel-rto6.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17WgqC-0001GX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 10:19:24 -0700
Received: from mel-rta10.wanadoo.fr (193.252.19.193) by mel-rto6.wanadoo.fr (6.5.007)
        id 3D18683700E6CEC1 for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Jul 2002 19:19:15 +0200
Received: from iliana (80.9.195.13) by mel-rta10.wanadoo.fr (6.5.007)
        id 3D2A7916006A07E9 for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Jul 2002 19:19:15 +0200
Received: from luther by iliana with local (Exim 3.35 #1 (Debian))
	id 17WguU-00007f-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 19:23:50 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Petr wrote :
> your drivers's init
>    --> look and init devices
>        --> call register_framebuffer
>            --> VGACON reads contents of VGA buffer
>            --> call to fbdev setvar
>            --> upper layer restores screen
> ...

Mmm, i did manage to override the vga save_screen function, and copy the
good values into vc_sceenbuf, but to no avail.

What frustrates me is that i cannot find any reference to some piece of
code using the data in vc_sceenbuf to write to the screen again.

How exactly does the upper layer restore the screen ?

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
