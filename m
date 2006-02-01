From: David Vrabel <dvrabel@arcom.com>
Subject: Re: [patch] Framebuffer driver for Geode GX
Date: Wed, 01 Feb 2006 10:07:08 +0000
Message-ID: <43E0884C.8050607@arcom.com>
References: <43DF9C09.30806@arcom.com> <8a0c36780601311341l83868bble5eafde500f513d7@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F4EtS-0007Nu-WC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Feb 2006 02:07:18 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F4EtQ-0001SX-DC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Feb 2006 02:07:18 -0800
In-Reply-To: <8a0c36780601311341l83868bble5eafde500f513d7@mail.gmail.com>
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
To: smithbone@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net

Richard Smith wrote:
> On 1/31/06, David Vrabel <dvrabel@arcom.com> wrote:
> 
>>A framebuffer driver for the display controller in AMD Geode GX
>>processors (Geode GX533, Geode GX500 etc.).  Tested at 640x480, 800x600,
>>1024x768 and 1280x1024 at 8, 16, and 24 bpp with both CRT and TFT.  No
>>accelerated features currently implemented and compression remains disabled.
>>
>>This driver requires that the BIOS (or the SoftVG/Firmbase code in the
>>BIOS) has created an appropriate virtual PCI header.
> 
> Aside from being more recient whats the difference between your driver
> and the 2.6.11 driver patch from AMD?

There's only a driver for the Geode LX (or more correctly, our AMD FAE
couldn't point me to a driver for the Geode GX).

AMD's drivers tend to use their OS independant HAL (c.f. cimarron for
the Geode LX driver and their use of the Durango API in their old 2.4
drivers for the Geode GX).  As such, they're not suitable for inclusion
into the kernel anyway.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
