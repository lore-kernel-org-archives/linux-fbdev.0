From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: Re: intelfb crashes during modprobe
Date: Mon, 18 Aug 2008 11:32:41 -0700
Message-ID: <376ea3380808181132v18ece4aby939e8feaf533e766@mail.gmail.com>
References: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
	<20080814161416.GG5916@omnius.localdomain>
	<376ea3380808180803r58c16e4dhbc29549cd79c6785@mail.gmail.com>
	<20080818154126.GA3281@omnius.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KV9X2-00056y-BN for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 11:32:44 -0700
Received: from ik-out-1112.google.com ([66.249.90.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KV9X0-0001Qw-VJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 11:32:44 -0700
Received: by ik-out-1112.google.com with SMTP id c21so2506915ika.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 18 Aug 2008 11:32:41 -0700 (PDT)
In-Reply-To: <20080818154126.GA3281@omnius.localdomain>
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
To: Scott Mcdermott <vaxerdec@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

I gave the kernel modesetting option a shot. It actually appears to
get me to a framebuffer much smoother than the previous method. I have
a good looking 720p framebuffer on the CRT port that I can play videos
with. I am quite happy about that thanks.

I have a HDMI port attached to the same chip, using DVO port C. Using
this port has much different results than the CRT port. I looked
through the DMESG and the kernel code and it appears that all non-crt
ports do not support mode switching.

Is there a hardware limitation reason for this?

I commented out the line in the kernel intelfb driver that disables
mode switching for the non-CRT ports, I had no luck (thought I'd give
it a shot just in case).

Anyone have an idea what it would take to fix this? I would be willing
to give it a shot as this box will ideally hook up to a tv using HDMI,
not a CRT monitor. I just need an idea where to start.

Thanks,
Jon

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
