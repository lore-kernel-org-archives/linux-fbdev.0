From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: lower level stuff
Date: Wed, 24 May 2006 07:02:52 +0800
Message-ID: <4473949C.7080003@gmail.com>
References: <bb9a78950605231441o297b3419rf4c6b64dde20a655@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FifuC-0005fr-Ku
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 16:03:12 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FifuC-0002dg-Oz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 16:03:12 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FifuA-0002Il-TX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 16:03:12 -0700
Received: by py-out-1112.google.com with SMTP id z59so2015312pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 May 2006 16:03:09 -0700 (PDT)
In-Reply-To: <bb9a78950605231441o297b3419rf4c6b64dde20a655@mail.gmail.com>
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
Cc: natetheking@gmail.com

Nathan King wrote:
> Hey folks,
> 
> Bit new to this. I want to monkey with the drivers that do the actual
> fillrect and bitblt business. Is ts vga16fb I want, or is there
> something else now. Using Fedora Core 5.
>

Several drivers do everything or in part in hardware.  That would be
rivafb, i810fb, nvidiafb, savagefb, atyfb, radeonfb, etc.

vga16fb still does it in software, but it has it's own functions because
of the planar nature of vga graphics.

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
