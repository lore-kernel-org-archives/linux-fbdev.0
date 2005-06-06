From: Jon Smirl <jonsmirl@gmail.com>
Subject: Three new features for fbdev
Date: Mon, 6 Jun 2005 15:35:15 -0400
Message-ID: <9e47339105060612352d15c20b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfNOD-0004WH-1m
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:36:01 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DfNOC-00027Y-4z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:36:00 -0700
Received: by wproxy.gmail.com with SMTP id 69so1991620wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 Jun 2005 12:35:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@www.infradead.org>

If anyone is interested in working on these topics I can use some help.
Three main features I still need from fbdev:

1) Trigger a user space app to reset a secondary card on boot. I have
this working but not in a shippable state. It needs kernel fixes in
hotplug to trigger the app properly. The app needs debugging to work
right with emu86.

2) User space mode list generation. I have code for this too. It needs
fixes in hotplug to allow subdir creation in /sys/class/xxx. The user
space mode app can read files from /etc to name the modes, adjust for
broken EDID, supply mode list for non-EDID monitor, etc.

3) Hardware cursor support.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
