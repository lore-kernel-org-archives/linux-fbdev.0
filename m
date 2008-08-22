From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: multiple outputs
Date: Thu, 21 Aug 2008 21:42:05 -0700
Message-ID: <376ea3380808212142x390fd4f8we9d6fac6439fe94b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KWOTQ-0001Px-Gg for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 21:42:08 -0700
Received: from ik-out-1112.google.com ([66.249.90.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KWOTP-0005MY-4S
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 21:42:08 -0700
Received: by ik-out-1112.google.com with SMTP id c21so208712ika.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 21 Aug 2008 21:42:05 -0700 (PDT)
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

I have a graphics device (intel 945GM) that has multiple outputs (4 in
this case, although not all can be on at the same time). I want to use
the graphics device directly through the fb, and not through some
other layer such as X. When using the fb is it possible to tell the
graphics device to change outputs through ioctls, or ideally through
fbset?

For example I know with v4l you can enumerate ports, and then by using
an index switch through them. Does fb have an ioctl similar to this? I
couldn't find anything in the source. I'm envisioning something like

# fbset --enumerate-outputs
output 1: ANALOG
output 2: DVI
output 3: HDMI
output 4: LVDS

# fbset --get-output
output is "ANALOG"

# fbset --set-output 2
switching to "DVI" output

# fbset --get-output
output is "DVI"

# fbset --set-output 1
switching to "ANALOG" output

And then fbset could use the fb ioctls to tell the fb to switch ports,
which would tell my fb driver the same. Does this functionality exist,
in either the ioctls, or fbset?

Thanks,
Jon

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
