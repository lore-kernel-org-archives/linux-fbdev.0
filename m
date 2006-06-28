From: Michael Buesch <mb@bu3sch.de>
Subject: radeonfb: corrupted screen on bootup
Date: Wed, 28 Jun 2006 21:18:27 +0200
Message-ID: <200606282118.27750.mb@bu3sch.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751027AbWF1TS5@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi,

I have a weird error with my PowerBook G4, which
has a radeon card. I am using radeonfb.
After bootup, the screen sometimes looks like it is melting.
I made a video to show you what is going on:
http://bu3sch.de/misc/after_boot.avi  (6.1 MB)

It does only happen sometimes. I could not find
a way to reproduce it.
If I start X after boot with a melting screen, X is also
melting:
http://bu3sch.de/misc/after_x_switch.avi  (6.6 MB)

But here comes the interresting part:
If I switch back into the console, the screen becomes
normal again and I can continue to work as usual.

I am suspecting some initialization routine bug.
It never happened when booting into OSX.

In X I use the "radeon" driver.

Please give some suggestions on how to track down the problem.

PS: I am very sorry for the big video files.
    I tried to install some video coding software to
    reduce the size, but it appears that installing
    video software on linux is a nontrivial task.
    I stopped after resolving the millionth
    dependency manually. :)

-- 
Greetings Michael.
