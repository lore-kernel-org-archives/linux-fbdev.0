From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Sat, 16 Oct 2004 13:44:23 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e47339104101610447a393abc@mail.gmail.com>
References: <416E6ADC.3007.294DF20D@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIsbS-0005Ju-6Z
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 10:44:26 -0700
Received: from rproxy.gmail.com ([64.233.170.194] helo=mproxy.gmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CIsbR-0000tS-KK
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 10:44:26 -0700
Received: by mproxy.gmail.com with SMTP id 79so64273rnk
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Oct 2004 10:44:24 -0700 (PDT)
In-Reply-To: <416E6ADC.3007.294DF20D@localhost>
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
To: Kendall Bennett <kendallb@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org

> What this means is that it should be possible to build a new version of
> the VESA framebuffer console driver for the Linux kernel that will have
> these important features:
> 
> 1. Be able to switch display modes on the fly, supporting all modes
> enumerated by the Video BIOS.
> 
> 2. Be able to support refresh rate control on graphics cards that support
> the VBE 3.0 services.

How is this going to work if there are multiple graphics cards
installed? Each card will want to install it's own VBE extension
interrupt.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
