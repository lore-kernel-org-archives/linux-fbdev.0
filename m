From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] nvidiafb: Fix 6xxx/7xxx cards
Date: Sun, 8 Jan 2006 19:13:11 -0800
Message-ID: <20060108191311.00ab5dba.akpm@osdl.org>
References: <1133944427.7168.70.camel@gaston>
	<43989DA3.8070602@gmail.com>
	<1134080257.11760.19.camel@gaston>
	<4398B995.6000903@gmail.com>
	<1134287682.6989.49.camel@gaston>
	<1136773933.30123.100.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvnXI-0000lA-Ep
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 19:17:32 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EvnXH-00043a-4l
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 19:17:32 -0800
In-Reply-To: <1136773933.30123.100.camel@localhost.localdomain>
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
Cc: benh@kernel.crashing.org, adaplas@hotpop.com

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Sun, 2005-12-11 at 18:54 +1100, Benjamin Herrenschmidt wrote:
> > > I already told akpm to drop mine and take yours instead as you already
> > > verified that it works.

I didn't get that message..

>  I'll send you the pci-e support patch, diffed
> > > against your patch if you want.
> 
> It's not yet upstream and we are about to merge the new g5 support.
> Andrew, will you send it to Linus or was there some issues with the
> patch ?
> 

Current nvidia patches which I have are:

nvidiafb-i2c-bus-name-beautification.patch
fbdev-nvidiafb-driver-cleanup.patch
nvidiafb-add-support-for-some-pci-e-chipsets.patch
nvidiafb-add-support-for-some-pci-e-chipsets-fix.patch
nvidiafb-add-boot-option-bpp.patch
nvidiafb-reduce-stack-usage.patch
nvidia-agp-use-time_before_eq.patch

None of those appear to do the same thing as Ben's patch, so I don't know
what's going on here.


Gad.  It looks like a variant of Ben's patch is in the powerpc tree.  wtf
is it doing there?


Anyway, all of the above patches apply OK to whatever is in git-powerpc so
I spose we can just merge git-powerpc and be happy.  Soon, I hope - I have
a few things held up by that tree.

Tell Paul to grovel appropriately to Linus when he sends it though -
putting non-arch stuff into an arch tree tends to upset him.  


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
