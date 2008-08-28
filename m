From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: hdmi mode in intelfb
Date: Thu, 28 Aug 2008 09:39:27 -0700
Message-ID: <376ea3380808280939o7a1205edx2ee248111d0becfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYkWw-000211-OR for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 09:39:30 -0700
Received: from fk-out-0910.google.com ([209.85.128.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYkWv-0006Um-Cu
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 09:39:30 -0700
Received: by fk-out-0910.google.com with SMTP id 18so314249fkq.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 28 Aug 2008 09:39:27 -0700 (PDT)
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

I have a intel 945GM. This particular board has port sdvoc connected
to an hdmi port.

I need to use the frame buffer connected to this port so I've been
trying to hack the intelfb driver to support hdmi mode switching in
the intelfb driver. I noticed it currently only supports the adpa port
(analog crt).

I can successfully get mode switching working on the adpa port and the
sdvob port (connected to a dvi port on my board). I have read the
documentation extensively as well as looked at the X driver, the drm
driver and whatever else google turns up. But when I use the same
procedure to do mode switching on the hdmi port the monitor goes blank
every time and will not be able to lock onto the signal.

I'm wondering if anyone has tried to get hdmi out working with a an
intel card and had success, I just can't seem to get it to work. Would
anyone be willing to give me a hand?

Thanks,
Jon

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
