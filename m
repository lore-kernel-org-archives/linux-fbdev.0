From: Jordan Benjamin <jordanb@caltech.edu>
Subject: radeonfb & fbdev code status
Date: Sat, 15 Nov 2003 12:51:09 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <70AC3EE8-17AD-11D8-A894-0003931DDB42@caltech.edu>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AL7O2-0003zH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 12:51:18 -0800
Received: from steelemr-loadb-nat-49.caltech.edu ([131.215.49.69])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AL7O1-0002HF-Op
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Nov 2003 12:51:17 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net
Cc: Jordan Benjamin <jordanb@caltech.edu>

Hi, I'm very confused about the current status of these projects and I 
was hoping someone might be able to clarify. First, is Benjamin 
Herrenschmidt the author or maintainer of the radeonfb driver? What is 
the relationship between that code and the fbdev.diff files distributed 
by James Simmons? I've asked him about this already but he never 
responded.

What about the fbdev patches? Where do they come from? What are they? 
Should they apply to any kernel version, and if not, how do you tell 
which ones?

I'm asking because I have an IBM ThinkPad T40 with a Radeon Mobility 
9000 card on which I'm running linux. I have a dream of one day having 
accelerated 3d graphics, suspend/resume, refresh rate >50Hz, and 
console resolution greater than 640x480, perhaps even the native 
resolution of 1400x1050, all working at the same time. I can get the 
first two by using vesafb; I haven't had time to invest in the refresh 
rate yet, and so far it appears that vesafb won't support hi-res 
consoles. The radeonfb drivers I've tried don't allow the use of 
suspend/resume.

I apologize if I sound frustrated, but it almost seems like the 
framebuffer code development is occurring in secret. I've tried to find 
information on the web and the list archives, but I've not been 
successful. Messages from James Simmons on this and the kernel lists 
have made reference to, e.g, "Ben's new driver," which I guessed might 
be Benjamin Herrenschmidt, but his web page makes no reference to 
anything other than LinuxPPC.

Jordan




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
