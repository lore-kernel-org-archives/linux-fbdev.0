From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: Re: Re: [PATCH] sisfb accel capabilities
Date: Thu,  3 Jun 2004 12:08:46 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1086282526.40bf5b1e52eca@mail.theboonies.us>
References: <20040603024412.GE20951@havoc.gtf.org>
	<40BEF4ED.7090909@winischhofer.net>
	<1086269209.40bf27191fe1c@mail.theboonies.us>
	<40BF5482.7080900@winischhofer.net>
Reply-To: David Eger <eger-dated-1086887330.ffe1f7@theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVvhz-0003iJ-OQ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 10:08:51 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BVvhz-0002P4-Cq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 10:08:51 -0700
In-Reply-To: <40BF5482.7080900@winischhofer.net>
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


I guess I shouldn't mark it "stupid shit" until I actually have the replacement
code ready ;-)  You want me to revise the name of the #define?

Basically, I think the name FB_ACCELF_TEXT is silly and misleading:
+ it means the kernel is enabling the acceleration engine; not really to do with
_TEXT
+ it's not really a flag, since it and zero are the only valid settings
+ it doesn't really belong with the mode settings (i.e. 1024x768, 60 Hz 32bpp) 
which is what var is, mainly

But it is how things are done now.  So yes, fbset -accel 0 => var.accel_flags =
FB_ACCELF_TEXT => set_par() is still the only path that the drivers have to
enable/disable acceleration.  You'll note that the main patch does #define this
to be true for now.

I'm generating an alternate kernel at the moment with Antonino's logic to see
how panning and accel compares on my chip.  If it's faster, I should have a
patch with revised logic (favoring panning if there's sufficient yres_virtual)
by tomorrow..

-David


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
