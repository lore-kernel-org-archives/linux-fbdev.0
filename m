From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Re: aty128fb problems on iMac, kernel 2.8.1 (fwd)
Date: Thu, 23 Sep 2004 13:31:48 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040923113148.GA8333@uvt316-2.ruk.cuni.cz>
References: <Pine.GSO.4.61.0409231022110.7127@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.11] (helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CARrh-0004oY-1D
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 04:34:21 -0700
Received: from dec59.ruk.cuni.cz ([195.113.2.17])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CARrf-0003Fw-S3
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 04:34:21 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0409231022110.7127@waterleaf.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Theodore Kilgore <kilgota@banach.math.auburn.edu>

On Thu, Sep 23, 2004 at 10:27:34AM +0200, Geert Uytterhoeven wrote:
> 
> 
> ---------- Forwarded message ----------
> Date: Mon, 20 Sep 2004 22:13:36 -0500 (CDT)
> From: Theodore Kilgore <kilgota@banach.math.auburn.edu>
> To: Brad Douglas <brad@neruo.com>
> Subject: aty128fb problems on iMac, kernel 2.8.1
> 
> Brad,
> 
> Sorry to disturb you, but I cannot seem to find any "live" leads to this
> problem on Google -- all searches seem to lead to old, dead links.
> 
> I have recently decided to learn something about PowerPC architecture, so
> I managed to obtain an old iMac, which has in it the model 750 CPU,
> running at 350mhz.
> 
> I wanted to put both OS-X and Linux on it, with the idea of doing some
> software development on both systems (I do some device support for
> libgphoto2 and also some other USB stuff, in addition to my "day" job as a
> math professor). I am not in a big hurry and being a Slackware lover, I
> decided to try to install Slackintosh.
> 
> Well, after overcoming many obstacles I have been successful in much of
> what I wanted to do, but now it comes to supporting X. Which was compiled
> from source on the machine. But it seems that X needs more than what it
> sees in order to run properly. I can only get 8-bit color, with a few
> problems about artifacts (incidentally, these problems disappear if one
> switches the VT back and forth).
> 
> I gather that the problem is, I do not have any proper kernel module to
> support the framebuffer features of the video chip. So here now is
> the problem I had with this.
> 
> Doing the kernel config, I enable framebuffer support, and I choose the
Also enable console on framebuffer support
> support for the ATI Rage 128, which is the chip in the iMac. It also says
> in lspci that the ATI Rage 128 is an AGP 4x setup, running off the
> uni-north bridge (I wonder if this has anything to do with a framebuffer
> setup? I don't know but I enabled it anyway, as a character device module,
> and also enabled the agp support module).
> 
> So, when I do make modules it says that it compiled the aty128fb module,
> but it gives two error messages:
> 
> mac_find_mode  undefined
> 
> and
> 
> mac_vmode_to_var  undefined.
Does it give the error messages during compilation or during module
loading?
If during module loading, you are probably missing some additional
module.
I had no problem with 2.6.7 kernel but I compiled the ati framebuffer
directly into kernel to get some usable console from the start.
I cannot curruntly say what exact ati chip the iMac has or what was my
kernel config because it is running OS X right now and I am not
physically at the machine.
You should definitely try to compile the aty128fb into kernel to avoid
problems with current fbcons.

If you cannot solve the problem I can look at my config later. It would
run X fine.

Hope this helps

Michal Suchanek


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
