From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/5] VT binding: Update fbcon to
	support binding
Date: Sat, 10 Jun 2006 21:28:05 +0800
Message-ID: <448AC8E5.6040106@gmail.com>
References: <448933EB.3070003@gmail.com>
	<200606101310.04174.ioe-lkml@rameria.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fp3Vg-0005j3-1k for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 06:28:16 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fp3Vf-0003D0-Qs for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 06:28:15 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fp3Vf-0003bM-KN
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 06:28:15 -0700
Received: by py-out-1112.google.com with SMTP id x31so1230119pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2006 06:28:15 -0700 (PDT)
In-Reply-To: <200606101310.04174.ioe-lkml@rameria.de>
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
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Ingo Oeser wrote:
> Hi Antonio,
> 
> On Friday, 9. June 2006 10:40, Antonino A. Daplas wrote:
>>     5. When fbcon is completely unbound from the console layer, fbcon will
>>        also release (iow, decrement module reference counts to zero) all fbdev
>>        drivers. In other words, a bind or unbind request from the console layer
>>        will propagate down to the framebuffer drivers.
>>
>>     6. If fbcon is not bound to the console, it will ignore all notifier
>>        events (except driver registration and unregistration) and all sysfs
>>        requests.
> 
> Wow! 
> 
> Now one can:
> 
> 	- implement different framebuffer drivers for a chip. 
> 	- try a stable and development version without rebooting,
> 	- have probing with user interaction ("if you see me please 
> 	  press enter else I will try the previous driver in 15 seconds.") 
> 	  instead of deciding on "failsafe" (vga/vesa) and "fast" 
> 	  (special driver) at boot.

Yes, all of the above are possible :-), and with our present user tools,
are currently very, very doable (at least in x86).

> 
> I love it!
> 
> Just the take_over_console() as alternative API looks strange.

It's not an alternative API, it's the default API and behavior. So, I
just can't remove it without breaking all console drivers.

Tony
