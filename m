From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Re: [PATCH] sisfb accel capabilities
Date: Thu, 03 Jun 2004 18:40:34 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40BF5482.7080900@winischhofer.net>
References: <20040603024412.GE20951@havoc.gtf.org>	<40BEF4ED.7090909@winischhofer.net> <1086269209.40bf27191fe1c@mail.theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVvHt-0005IL-4A
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 09:41:53 -0700
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BVvHs-0004Pu-1I
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 09:41:52 -0700
In-Reply-To: <1086269209.40bf27191fe1c@mail.theboonies.us>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Eger <eger@theboonies.us>
Cc: David Eger <eger@havoc.gtf.org>, linux-fbdev-devel@lists.sourceforge.net


David,

while modifying sisfb for your new flags, I went through the base patch 
as posted to Andrew (and surprisingly fast merged into 2.6.7-rc2-mm2) 
but failed to find any possibility for userland to disable acceleration 
(considering that ACCELF_TEXT is now "stupid shit" aka deprecated).

You mention that this should be done through sysfs. Where is the 
corresponding code?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
