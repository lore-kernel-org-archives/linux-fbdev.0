From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 12:19:05 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031016101905.GA7454@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AA5EP-0002PQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 03:19:45 -0700
Received: from a205017.upc-a.chello.nl
	([62.163.205.17] helo=mail.fluido.as ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AA5E3-0006Rw-3L
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 03:19:23 -0700
Content-Disposition: inline
In-Reply-To: <1066298431.1407.119.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

	Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
	Date: gio, ott 16, 2003 at 12:00:32 +0200

Quoting Benjamin Herrenschmidt (benh@kernel.crashing.org):

> My new driver (bk://ppc.bkbits.net/linuxppc-2.5-benh) now uses a copy
> of XFree PCI IDs list, making it much easier to keep in sync. It should
> also support the 9200.

The latest (*NON*bk) patch distributed by James appears to include your
new driver. The header from radeon_base.c  reads:

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

/*
 *      drivers/video/radeonfb.c
 *      framebuffer driver for ATI Radeon chipset video boards
 *
 *      Copyright 2003  Ben. Herrenschmidt <benh@kernel.crashing.org>
 *      Copyright 2000  Ani Joshi <ajoshi@kernel.crashing.org>
 *
 *      i2c bits from Luca Tettamanti <kronos@kronoz.cjb.net>
 *
 *      Special thanks to ATI DevRel team for their hardware donations.
 *
 *      ...Insert GPL boilerplate here...
 *
 *      TODO: - Bring a couple of cleanups from 2.4 to the mode setting code,
 *            - Split CRT vs. FP register calc/setting
 *            - Add CRTC2 support for mirror at least, dual head then
 *            - Add back some accel
 *
 */


#define RADEON_VERSION  "0.2.0"

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--


Thus the rest of my previous message should be referred to
your new driver.

Carlo

PS I am BK-handicapped. I had downloaded the program, and tried your
instruction as per an old message of yours, and no download would take
place. Since, if I recall correctly, bk cannot be used for free on
closed-source projects, I cannot switch to it (nor lose too much time
on it): I work on projects of both types, and changing every time
between RCS/CVS and bk would be very umcomfortable.

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
