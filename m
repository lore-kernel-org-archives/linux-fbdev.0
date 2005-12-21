From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb ATI 9100IGP shared main memory / VRAM
Date: Thu, 22 Dec 2005 09:56:50 +1100
Message-ID: <1135205811.10035.138.camel@gaston>
References: <20051221203706.GR4495@sunbeam.de.gnumonks.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EpCuy-00082u-PR
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 14:58:44 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EpCux-0000xJ-LY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 14:58:45 -0800
In-Reply-To: <20051221203706.GR4495@sunbeam.de.gnumonks.org>
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
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2005-12-21 at 21:37 +0100, Harald Welte wrote:

> I've altered radeon_base.c with a special exception for this chip, see
> the patch below.  Now everything works like a charm.

Hi !

Actually, this isn't the right way, the PCI resource might be bigger
than the RAM assigned to the IGP chip. I'll try to get something better
for you. The thing to do looks like that in X:

    else if ((info->ChipFamily == CHIP_FAMILY_RS100) ||
	     (info->ChipFamily == CHIP_FAMILY_RS200) ||
	     (info->ChipFamily == CHIP_FAMILY_RS300)) {
        CARD32 tom = INREG(RADEON_NB_TOM);

	pScrn->videoRam = (((tom >> 16) -
			    (tom & 0xffff) + 1) << 6);

	OUTREG(RADEON_CONFIG_MEMSIZE, pScrn->videoRam * 1024);

With
	#define RADEON_NB_TOM                       0x15c

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
