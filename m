From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: Re: intelfb crashes during modprobe
Date: Mon, 18 Aug 2008 08:00:42 -0700
Message-ID: <376ea3380808180800h308a5d89v5cd213acfa6b2c0c@mail.gmail.com>
References: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
	<20080817200928.15da18c6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KV6Dt-0004Av-60 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:00:45 -0700
Received: from nf-out-0910.google.com ([64.233.182.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KV6Dr-0000Rs-QT
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:00:45 -0700
Received: by nf-out-0910.google.com with SMTP id g16so1091147nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 18 Aug 2008 08:00:42 -0700 (PDT)
In-Reply-To: <20080817200928.15da18c6.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net

> Could you provide more details? Especially, if you have connected a CRT
> (either real CRT or external LCD panel) or the LVDS (LCD directly to
> the chip - like in laptops).

I have the graphics chip connected to an external LCD using the vga port.

Btw, I made a mistake in my first post. The chip is an intel 945GM, not 965G.

I've done a bit of experimenting and this crash only occurs when the
"accel" option is turned on. If accel is turned on (the default), then
when I modprobe the driver the system restarts. Otherwise the system
comes on.

Is accel something crucial that I should be concerned about?

Thanks,
Jon

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
