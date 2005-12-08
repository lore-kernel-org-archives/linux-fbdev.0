From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: PCI nvidiafb card init with a broken BIOS?
Date: Fri, 09 Dec 2005 05:39:42 +0800
Message-ID: <4398A81E.1040601@gmail.com>
References: <1133523556.7994.21.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkTUU-0002PS-3j
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 13:39:50 -0800
Received: from xproxy.gmail.com ([66.249.82.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkTUT-0007fj-VF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 13:39:50 -0800
Received: by xproxy.gmail.com with SMTP id h29so482489wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Dec 2005 13:39:47 -0800 (PST)
In-Reply-To: <1133523556.7994.21.camel@localhost.localdomain>
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
Cc: Richard Purdie <rpurdie@rpsys.net>

Richard Purdie wrote:
> Hi,
> 
> I have a Dell Poweredge 1600SC which is a Dual P4 Xeon system with an
> inbuilt ATI Rage XL. It has a variety of PCI slots and I tried inserting
> a PCI XFX Geforce FX 5200 256mb into it to upgrade its graphics
> capability as the inbuilt Rage XL can't cope with the resolutions I want
> to use.
> 
> Whilst the machine boots with the new card in, I see nothing on any of
> the video outputs from the BIOS or Linux. It looks like the BIOS can't
> cope with the card. (I've tried the card in each PCI slot).
> 
> I've included the Linux bootup below for 2.6.15-rc2. nvidiafb does load
> but the video memory size looks wrong and it pauses for a long time
> before printing "DMA Get lockup".  Reading Dell's forums, it looks like
> the inbuilt card is moved in memory rather than disabled and you can see
> this being detected as fb1 but again, no video output from it.
> 
> Its a long shot but it there any way I can get Linux to correctly init
> the PCI card and undo any damage done by the broken BIOS? Would
> disabling ACPI help or is there anything else I can try?

Does vesafb work for this card?

You can also try to compile nvidiafb as a module, then initialize the card
with a user land app (ie, lrmi or X), before a modprobe nvidiafb.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
