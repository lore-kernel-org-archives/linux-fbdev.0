From: "Peter Geoghegan" <peter.geoghegan86@gmail.com>
Subject: Re: Freeze when calling ioctl with VT_ACTIVATE
	request code number on intelfb
Date: Thu, 23 Oct 2008 09:50:57 +0100
Message-ID: <db471ace0810230150m710f2adfif38f16df584e858d@mail.gmail.com>
References: <db471ace0810221552k158829d0te481c8f4483754fa@mail.gmail.com>
	<Pine.LNX.4.64.0810230907560.7533@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <peter.geoghegan86@gmail.com>) id 1Ksvwo-0007yw-G5
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 08:53:38 +0000
Received: from yw-out-1718.google.com ([74.125.46.153])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KsvuE-0007YZ-DI for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 08:53:38 +0000
Received: by yw-out-1718.google.com with SMTP id 6so38089ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 23 Oct 2008 01:50:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0810230907560.7533@anakin>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Geert,

> I guess `consoledevice' contains `/dev/tty', not `/dev/fb'?

Yes. I just thought I'd put the really relevant line in context in
case someone wanted to refer to the Tslib source

> So far this looks virtual console specific, not frame buffer specific.
> Does switching virtual consoles manually work?

No, it does not. That is what led me to believe that it was frame
buffer specific,

Thanks,
Peter

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
