From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix switch from XFree
Date: Tue, 10 Feb 2004 22:17:21 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076411840.874.18.camel@gaston>
References: <1076409397.873.6.camel@gaston>  <20040210110622.GA1913@lambda>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqVtZ-0004Jz-5U
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 03:17:37 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AqVte-0005V4-IQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 03:17:42 -0800
In-Reply-To: <20040210110622.GA1913@lambda>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Mmm, i wonder about this. The X driver is supposed to be responsible for
> saving and reseting the engine when leaving/entering. This is usually
> done in a separate way when using or not using fbdev.

This is a nice dream. It's both _very_ impractical (you can't always
_read_ the engine state) and usually buggy as hell (and go fix XFree :)

On the other hand, it's very simple for the driver to just reset &
restore the engine state it expects.

> Now, if we are going to save/restore the contect too, then this would
> mean a risk of dual saving the engine state. Or maybe the X server
> doesn't really save the context, but just reinitialize it when entering.

It tries too for the mode... but fails. It doesn't try for the engine

> I have the feeling that more working together would be helpfull, or
> maybe setup a proper policy for X/fbdev to handle this properly.

I don't think it's reasonable to expect the XFree driver to save/restore
the accel engine state. It's already quite broken with the mode on
radeonfb (the VGA stuff seem to do bad things on PPC at least).

> Maybe the fbdev driver could set a flag or something, which would tell
> the X server that it is taking charge of saving/restoring the accel
> engine, so the X driver would not try doing this too, at least in the
> UseFBDev case (but do we care about the other case ?).

No. Trying to save/restore the engine state would mean trying to
save/restore dozens (or hundreds maybe ? depends if you count the 3D
engine too :), it makes little sense, it's much simpler for fbdev
to just reset the state it expects.

Ben.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
