From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: intelfb crashes during modprobe
Date: Thu, 14 Aug 2008 08:21:01 -0700
Message-ID: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KTedM-0005oG-Ii for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Aug 2008 08:21:04 -0700
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KTedK-0001BM-T9
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Aug 2008 08:21:04 -0700
Received: by nf-out-0910.google.com with SMTP id g16so313615nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 14 Aug 2008 08:21:01 -0700 (PDT)
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I am experimenting with using a framebuffer for video playback with
DirectFB. The first goal of mine is to get a stable fb driver working
that DirectFB can talk to.

My target platform is an x86 with an intel 965G chipset running
fedora. I am attempting to use the intelfb driver to successfully
complete this project.

I let my system boot, and then modprobe intelfb with no parameters.
Every time the system always either reboots, or hangs with no response
to input. Has anyone experienced this before? I can successfully do
low resolution video playback using the vesa driver.

I've developed Linux drivers in the past and am going to dive into the
code to see if I can solve this, and other problems. Should I be in
direct contact with the current maintainer of this module to possibly
point me in the right direction?

Thanks,
Jon

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
