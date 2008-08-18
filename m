From: Scott Mcdermott <vaxerdec@gmail.com>
Subject: Re: intelfb crashes during modprobe
Date: Mon, 18 Aug 2008 08:41:26 -0700
Message-ID: <20080818154126.GA3281@omnius.localdomain>
References: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
	<20080814161416.GG5916@omnius.localdomain>
	<376ea3380808180803r58c16e4dhbc29549cd79c6785@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KV6sS-0003PZ-7x for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:42:40 -0700
Received: from wf-out-1314.google.com ([209.85.200.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KV6rJ-0005zG-0E
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:41:30 -0700
Received: by wf-out-1314.google.com with SMTP id 27so3180019wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 18 Aug 2008 08:41:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <376ea3380808180803r58c16e4dhbc29549cd79c6785@mail.gmail.com>
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
To: Jon Dufresne <jon.dufresne@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Jon Dufresne on Mon 18/08 08:03 -0700:
> > I believe intelfb dev for later chipsets has gone
> > here:
> >
> > http://www.google.com/search?q=%22kernel%20modesetting%22
> >
> > supposedly 965G works in that tree, and is enableable
> > with FC9 shipped kernel given the command line args
> > mentioned
> 
> I took a look at that site. Does this modeset command
> line option affect the framebuffer, or X?

It moves all graphics modesetting code into the kernel.
I believe X no longer does the modesetting and has been
built to support the kernel changes.  Fbcon is just
always running.  Haven't tried it yet myself yet
though...

I believe the goal is to move the DRM portion that sets
modes and such into the kernel for all drivers and X
will no longer do low level mode switching.  No more
several second pauses to switch console-X-console
and/or start X.

This thread explains origins but it's a little old:

http://kerneltrap.org/node/8242

I can't find a home site for this project.  But since
RH is pushing it I'll bet money it will get into the
standard kernel before long if it's not already.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
