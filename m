From: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [Bugme-new] [Bug 4347] New: savavgfb ddc eeprom oops when "sensors" used as non-root
Date: Thu, 17 Mar 2005 20:22:17 +0100 (CET)
Message-ID: <m5m8epI4.1111087337.7808120.khali@localhost>
References: <20050317110941.4e5801fa.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC0cf-0006ZW-Rf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 11:25:33 -0800
Received: from zone4.gcu-squad.org ([213.91.10.50])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DC0ca-0000Z6-Lr
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 11:25:33 -0800
In-Reply-To: <20050317110941.4e5801fa.akpm@osdl.org>
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
To: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net
Cc: Salah Coronya <salahx@yahoo.com>


Hi Andrew, all,

> This might be a savagefb bug?

I don't think so. We could reproduce the oops on different systems with
different framebuffer drivers (nvidia, radeon) [1]. I'm almost certain
the problem is in my eeprom driver, and I just proposed a patch:
http://bugzilla.kernel.org/attachment.cgi?id=3D4744&action=3Dview
Testers welcome.

[1] http://archives.andrew.net.au/lm-sensors/msg29950.html

Thanks,
--
Jean Delvare


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
