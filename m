From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb & fbdev code status
Date: Sun, 16 Nov 2003 16:05:53 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1068959152.5157.50.camel@gaston>
References: <70AC3EE8-17AD-11D8-A894-0003931DDB42@caltech.edu>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALF7h-000334-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 21:06:57 -0800
Received: from griffin-can-au.getin2net.com ([203.43.225.34])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ALF77-0007Lx-So
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Nov 2003 21:06:22 -0800
Received: from gaston ([10.100.1.33])
	by griffin-can-au.getin2net.com (8.11.6/8.11.6) with ESMTP id hAG56DU32244
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 16:06:13 +1100
In-Reply-To: <70AC3EE8-17AD-11D8-A894-0003931DDB42@caltech.edu>
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
To: Jordan Benjamin <jordanb@caltech.edu>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-11-16 at 07:51, Jordan Benjamin wrote:
> Hi, I'm very confused about the current status of these projects and I 
> was hoping someone might be able to clarify. First, is Benjamin 
> Herrenschmidt the author or maintainer of the radeonfb driver? What is 
> the relationship between that code and the fbdev.diff files distributed 
> by James Simmons? I've asked him about this already but he never 
> responded.

The author of radeonfb is Ani Joshi.

I took over maintainership of the 2.4 version a while ago and did
the initial port to 2.6. Lately, I've been working on a new version
significantly improved, though not completely ready to replace the
old one yet.

> What about the fbdev patches? Where do they come from? What are they? 
> Should they apply to any kernel version, and if not, how do you tell 
> which ones?

James Simmons maintains the core fbdev & fbcon, those patches are
the updates from his devel. tree, including some of the driver updates
sent to him by the various drivers maintainers, or things he did
himself. I beleive his latest patches contain a recent version of
my new radeonfb as well.

> I'm asking because I have an IBM ThinkPad T40 with a Radeon Mobility 
> 9000 card on which I'm running linux. I have a dream of one day having 
> accelerated 3d graphics, suspend/resume, refresh rate >50Hz, and 
> console resolution greater than 640x480, perhaps even the native 
> resolution of 1400x1050, all working at the same time. I can get the 
> first two by using vesafb; I haven't had time to invest in the refresh 
> rate yet, and so far it appears that vesafb won't support hi-res 
> consoles. The radeonfb drivers I've tried don't allow the use of 
> suspend/resume.

You should be able to get most of this with the new radeonfb (let me
know if that doesn't work), _except_ maybe the suspend/resume. What
happens on x86 laptops regarding suspend/resume is not very clear,
depending on if you are doing ACPI or APM suspend for example, and
in some case, the only solution is to actually reboot the chip from
scratch, which we cannot do, at least not with the current scheme.

Since it works with vesafb, I suppose your BIOS is taking care of
restoring the chip, so the problem may either be the radeonfb resume
code not properly restoring its own graphic setup, or the BIOS beeing
shoked by some of the settings changes done by radeonfb. It may be
worth trying to restore the initial state of the chip when suspending,
I'll investigate that.

First, try to get the new driver working and let me know of any
problem beside suspend/resume. Then, we'll see if we can get something
working for suspend/resume as well.

> I apologize if I sound frustrated, but it almost seems like the 
> framebuffer code development is occurring in secret. I've tried to find 
> information on the web and the list archives, but I've not been 
> successful. Messages from James Simmons on this and the kernel lists 
> have made reference to, e.g, "Ben's new driver," which I guessed might 
> be Benjamin Herrenschmidt, but his web page makes no reference to 
> anything other than LinuxPPC.

Well, radeonfb has been a fairly critical piece for the PowerMacs for
quite a while now, I only recently started caring myself about non
PPC machines when I took over the maintainership of the driver, I'm
not always fully aware of all the issues that plague the x86
platform unfortunately...

Ben.



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
