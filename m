From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: vga16fb doesn't build on powerpc
	(vgacon_remap_base)
Date: Wed, 17 Oct 2007 19:01:19 +1000
Message-ID: <1192611679.11899.160.camel@pasglop>
References: <20071016191403.GA5962@nineveh.local>
	<Pine.LNX.4.62.0710171047430.29856@pademelon.sonytel.be>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ii4mN-0000dw-Ll for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 02:01:28 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19TE3l9u8XQIyZ1H3YFMYOQLMLIJgIYh58=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ii4mL-0005Ip-4n
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 02:01:27 -0700
In-Reply-To: <Pine.LNX.4.62.0710171047430.29856@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net


On Wed, 2007-10-17 at 10:49 +0200, Geert Uytterhoeven wrote:
> > 
> > So VGACON probably doesn't work either on 32bit.  I'm guessing
> arch/powerpc
> > doesn't support PREP.
> 
> It's not only useful for PREP, but also for CHRP.
> 
> > How best could this be fixed up? Or should I just let the thing
> > be?  This is obviously not a new thing, and I don't have any
> hardware
> > that supports this stuff either.
> 
> I remember this problem was present when I still had a working
> LongTrail (which
> is CHRP), long before arch/powerpc/ was created.

It's all very old stuff that needs to be dusted. If you have a setup
where legacy VGA is useable, feel free to do a bit of work on that :-)

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
