From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: Re: Re: [PATCH] sisfb accel capabilities
Date: Thu,  3 Jun 2004 08:26:49 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1086269209.40bf27191fe1c@mail.theboonies.us>
References: <20040603024412.GE20951@havoc.gtf.org>
	<40BEF4ED.7090909@winischhofer.net>
Reply-To: David Eger <eger-dated-1086874014.cda599@theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVsFG-0007a3-B6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 06:26:58 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BVsFF-0004yq-VO
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 06:26:58 -0700
In-Reply-To: <40BEF4ED.7090909@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: David Eger <eger@havoc.gtf.org>, linux-fbdev-devel@lists.sourceforge.net

Quoting Thomas Winischhofer <thomas@winischhofer.net>:

> David Eger wrote:
> > The following patch updates sisfb for the new fb accel capabilities
> > patch I'm sending upstream.  By default, this patch will rely on your
> > copyarea() and fillrect() accel functions instead of the panning.
>
> Could you give me any hint why this should be faster than panning?

The logic to prefer copyarea()/fillrect() to panning is in the main patch.  If
panning is faster than using these for most cards, then the default when both
are available should be panning as you say.  But I'll need numbers to determine
that ;-)  I think many drivers just map a chunk of video ram just big enough
for the requested resolution, so panning does zero for them :-/

> 1) fillrect and copyarea WERE (resp. ARE) being called here despite your
> previous statement that they were not. Fillrect is used to clear every
> line after pressing enter, and copyrect was used to copy the buffer to
> the start of the virtual screen when the end was reached.)

bizarre.  For radeonfb, fillrect() was called to clear the last line as you say,
but copyarea() never was.  I'll have to dig back through the old code to really
 grok your statement.

> 2) I still don't understand the meaning of FBINFO_HWACCEL_XPAN
> (especially as your sisfb patch sets it although sisfb did not support
> x-panning until yesterday evening...)

Good catch.  My patch should not set that flag, as it's inaccurate for your
driver.  My bad.  Good thing these are going through the individual driver
maintainers ;-)

> > Please test the core patch + this patch, and let me know your console
> > works.  I'm interested to hear what speeds you see :-)
>
> I will, but it will take some while. I need to merge your changes into
> my development version (which has been modified quite a bit).

Thanks.

-dte



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
