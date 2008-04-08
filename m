From: Bhaskar <abc.bhaskar@gmail.com>
Subject: FramBuffer for ep9310 ARM Board
Date: Tue, 8 Apr 2008 11:46:19 +0530
Message-ID: <f63322490804072316g447cf528m5bd402f1b8f77645@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj781-0000Fd-U2 for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 23:16:21 -0700
Received: from ti-out-0910.google.com ([209.85.142.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jj780-0004gY-Hv
	for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 23:16:21 -0700
Received: by ti-out-0910.google.com with SMTP id d10so760020tib.18
	for <Linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 07 Apr 2008 23:16:19 -0700 (PDT)
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
To: Linux-fbdev-devel@lists.sourceforge.net

Dear Team,

I need to modify modify Frame Buffer for ep9310 ARM board.  The
original frame buffer was provided by Cirrus Logic.  For the debugging
purpose, I introduced trace messages in frame buffer operation
functions like imageblit, fillrect, etc.

These messages appear only during Linux boot up and shutdown.  When I
move the window, none of the trace messages from the frame buffer
appears.  The Xserver used is XOrg-6.9

Somebody kindly provide a pointer from where to start inorder to
understand the flow functionlity of the existing framebuffer.

Regards.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
