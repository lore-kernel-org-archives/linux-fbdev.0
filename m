From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Subject: VESA VGA Graphic console has error to use emacs
Date: Tue, 13 Aug 2002 07:57:32 +0900
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200208122257.AA00113@prism.kumin.ne.jp>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from heavymos.kumin.ne.jp ([61.114.158.133] helo=emerald.kumin.ne.jp)
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17eO8i-0002qP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 Aug 2002 15:58:21 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net.

Hi.

I found VESA VGA Graphic console at linux-2.5.31 again.
and I was adviced by Petr Vandrovec that forward to linux-fbdev-devel@lists.sourceforge.net

=====

>I use linux-2.5.30 with VESA VGA Graphic console at slackware-8.1 based environment.
>when I use emacs( 21.2 ), these situation occured. (I used to boot up with vga=771)
>
>(1) # emacs /tmp/test
>    I type a line ( /sbin/ifconfig lo 127.0.0.1 ), and save file.
>
>(2) # emacs /tmp/test
>    a line ( /sbin/ifconfig lo 127.0.0.1 ) displayed in emacs frame.
>
>(3) I wand to insert few spaces between /sbin/ifconfig and lo.
>    when I type a space, then a line change to a line ( /sbin/ifconfig  oo 127.0.0.1 ).
>    I could not edit a line as I want to edit.
>    this situation display only. when I save file and re-read file, results were fine.
>
>(4) I boot up PC ( erase VGA option ), I checked this test, everything OK.
>
>I checked a same test at linux-2.5.26,28,30 and got a same result.
>I checked at linux-2.4.19, it is OK( everything work fine with vga=771 ).
>I thinked VESA VGA Graphic console has bug to display in emacs frame.
>
>Before VESA VGA Graphic console occured kernel panic at linux-2.5.14,15.
>from linux-2.5.16 VESA VGA Graphic console compile and work fine,
>but Pengin Image did not display at boot up time. is it OK?

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
