From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] radeonfb ATI 9100IGP shared
	main memory / VRAM
Date: Fri, 23 Dec 2005 11:40:33 +1100
Message-ID: <1135298433.10035.221.camel@gaston>
References: <20051221203706.GR4495@sunbeam.de.gnumonks.org>
	 <20051221222639.GT4495@sunbeam.de.gnumonks.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Epb1C-0000bY-Cf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Dec 2005 16:42:46 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Epb1A-0001rx-TP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Dec 2005 16:42:46 -0800
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id jBN0bgWG016461
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Dec 2005 18:37:43 -0600
In-Reply-To: <20051221222639.GT4495@sunbeam.de.gnumonks.org>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2005-12-21 at 23:26 +0100, Harald Welte wrote:
> On Wed, Dec 21, 2005 at 09:37:06PM +0100, Harald Welte wrote:
> > I've altered radeon_base.c with a special exception for this chip, see
> > the patch below.  Now everything works like a charm.
> 
> unfortunately I now discovered that the PCI resource is always 64MB in
> size, even when the UMA BIOS setting is configured to smaller (e.g. 8MB)
> sizes.
> 
> I don't have a clue for a proper fix, but maybe you have ;)

You didn't get my mail about using RADEON_NB_TOM instead ?

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
