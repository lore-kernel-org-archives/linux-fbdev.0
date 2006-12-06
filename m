From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Display class
Date: Wed, 6 Dec 2006 10:57:24 -0800
Message-ID: <20061206105724.cf7b39bc.randy.dunlap@oracle.com>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	<653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	<Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
	<Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
	<20061205171401.fd11160d.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
	<20061206101434.8acb229a.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612061818540.28745@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gs1x0-0001ov-Gd for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Dec 2006 10:57:02 -0800
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gs1wy-00054B-SS
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Dec 2006 10:57:02 -0800
In-Reply-To: <Pine.LNX.4.64.0612061818540.28745@pentafluge.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Miguel Ojeda <maxextreme@gmail.com>, kernel-discuss@handhelds.org, Luming Yu <Luming.yu@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Zabolotny <zap@homelink.ru>

On Wed, 6 Dec 2006 18:24:08 +0000 (GMT) James Simmons wrote:

> 
> > > That patch was rought draft for feedback. I applied your comments. This 
> > > patch actually works. It includes my backlight fix as well.
> > 
> > Glad to hear it.  I had to make the following changes
> > in order for it to build.
> > However, I still have build errors for aty.
> 
> Ug. I see another problem. I had backlight completly compiled as a 
> module! Thus it hid these compile errors. So we need also a 
> CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE check as well. Can sysfs handle this 
> well or would it be better the the backlight class be a boolean instead?

SCSI works as a module and it uses sysfs.
See drivers/scsi/scsi_sysfs.c.
Does that answer your question?  I wasn't quite sure what
the question was.

Next question, based on:
drivers/built-in.o: In function `probe_edid':
(.text.probe_edid+0x42): undefined reference to `fb_edid_to_monspecs'

Should backlight and/or display support depend on
CONFIG_FB?  Right now they don't, so the above can happen...

---
~Randy

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
