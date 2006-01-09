From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] nvidiafb: Fix 6xxx/7xxx cards
Date: Mon, 09 Jan 2006 13:32:13 +1100
Message-ID: <1136773933.30123.100.camel@localhost.localdomain>
References: <1133944427.7168.70.camel@gaston>  <43989DA3.8070602@gmail.com>
	 <1134080257.11760.19.camel@gaston>  <4398B995.6000903@gmail.com>
	 <1134287682.6989.49.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Evmqy-0007na-Fg
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 18:33:48 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Evmqx-0004US-6I
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 18:33:48 -0800
In-Reply-To: <1134287682.6989.49.camel@gaston>
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

On Sun, 2005-12-11 at 18:54 +1100, Benjamin Herrenschmidt wrote:
> > I already told akpm to drop mine and take yours instead as you already
> > verified that it works.  I'll send you the pci-e support patch, diffed
> > against your patch if you want.

It's not yet upstream and we are about to merge the new g5 support.
Andrew, will you send it to Linus or was there some issues with the
patch ?

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
