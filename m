From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control
	with ATI Radeon display support on HP nx6125.
Date: Sun, 14 Oct 2007 16:02:47 +0200
Message-ID: <200710141602.48206.rjw@sisk.pl>
References: <bug-9155-10286@http.bugzilla.kernel.org/>
	<200710132030.20826.rjw@sisk.pl>
	<1192346817.6265.22.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ih3oF-0000oY-Lc for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 14 Oct 2007 06:47:13 -0700
Received: from ogre.sisk.pl ([217.79.144.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ih3oD-0006j9-7I
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 14 Oct 2007 06:47:11 -0700
In-Reply-To: <1192346817.6265.22.camel@localhost>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Daniel =?iso-8859-15?q?W=FCrfel?= <daniel.wuerfel@gmx.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>

On Sunday, 14 October 2007 09:26, Daniel W=FCrfel wrote:
> Hi there,
> =

> at first great respect for your fast answers. =

> I don't think, that the binary ati driver is the problem, because:
> 1. with switched of "ati radeon display support" in the kernel, the fan
> control works correctly (and i still using the ati-driver)

How do you know, however, that the "ati radeon display support" in the kern=
el
does not interfere with the ATI driver in a destructive way?

> 2. the fan starts spinning at the boot screen even if the radeon display
> driver was loaded (and the ati driver is not just loaded yet).

I'm not sure what you mean exactly.  Can you clarify, please?

> Here you see the difference between 2.6.21, when it all works correctly, =
and
> 2.6.22 and 2.6.23: the screen resolution of the boot screen changed to
> the native resolution 1024x768 (in 2.6.21 it still the default terminal
> resolution) =


This only means that the kernel's radeon driver has changed.

It's difficult to say what's going wrong.

What's the CPU load when the fan is spinning?

Greetings,
Rafael

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
