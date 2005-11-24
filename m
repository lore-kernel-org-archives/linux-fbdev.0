From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Console rotation problems
Date: Thu, 24 Nov 2005 11:45:50 +1100
Message-ID: <1132793150.26560.357.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030547AbVKXAtj@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

Hi Antonio !

I decided to give a quick test to console rotation on my g5 (radeonfb)
and couldn't get it to work.

When I tried echo'ing something in con_rotate, something very strange
happened:

pogo:/sys/class/graphics/fb0# echo "1" >con_rotate
benh@pogo:~$

As you can see, it looks like I pressed ctrl-D (which I didn't do) and
thus exited my shell session. Thus my shell session got killed some way.
Verified it twice. Also the console stopped displaying anything (that
is,whatever was displayed was still there but the cursor didn't blink
anymore and no new stuff got displayed). 

When I then tried to echo "0" back there, it just hung in the kernel
(probably on a semaphore, I could still use the box for a little while
before it completely locked up).

Ben.
