From: Blaine Booher <blaine@cliftonlabs.com>
Subject: SSP based framebuffer driver
Date: Mon, 21 Jul 2008 09:53:11 -0400
Message-ID: <200807210953.12214.blaine@cliftonlabs.com>
References: <1216534233-26674-1-git-send-email-jayakumar.lkml@gmail.com>
	<20080721111159.GA18909@flint.arm.linux.org.uk>
	<45a44e480807210532w20495622ub36bd8a9722c2023@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKvpH-0005lR-Ur for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 06:53:20 -0700
Received: from 106.135.68.216.ded-dsl.fuse.net ([216.68.135.106]
	helo=silverton.cliftonlabs.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KKvpF-0000kg-Gn
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 06:53:19 -0700
Received: from 107.135.68.216.ded-dsl.fuse.net ([216.68.135.107]
	helo=northbend.cliftonlabs.lan)
	by silverton.cliftonlabs.com with esmtps
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.63)
	(envelope-from <blaine@cliftonlabs.com>) id 1KKvpC-0006Vh-7M
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 09:53:16 -0400
In-Reply-To: <45a44e480807210532w20495622ub36bd8a9722c2023@mail.gmail.com>
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

Hey everyone,
  I am hoping that this list can provide some insight into an issue that I'm trying to figure out.  I am 
working with a Gumstix platform using an ssp driven LCD screen.  We can talk to the LCD screen 
over the ssp pins, and we even have a driver that maps it to a /dev/ file.

We would ultimately like to have this device working as a framebuffer driven device.  I don't know 
enough about framebuffers, yet, but am reading as much as possible.

So my questions are:
* Can anyone recommend any basic literature for diving into this?
* Has anyone seen or heard of this kind of functionality?
* Do any projects exist relating to this?
* From my understanding thus far, we would want to implement our own /dev/fb0 (or similar) that 
took X Server commands and throws them out to the ssp device.  Is this the right kind of thinking?

Thank you!
Blaine

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
