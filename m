From: Raphael Assenat <raph@8d.com>
Subject: Re: ohci: USB devices only detected at boot time
Date: Tue, 13 Feb 2007 08:35:50 -0500
Message-ID: <45D1BEB6.60107@8d.com>
References: <45D1BE46.80100@8d.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HGxpC-0002cM-I9 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Feb 2007 05:36:02 -0800
Received: from roc.holo.8d.com ([64.254.227.115])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HGxp8-0000Q8-TX
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Feb 2007 05:35:59 -0800
Received: from darkstar.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtp (Exim 4.50) id 1HGxp3-0006XG-Ff
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Feb 2007 08:35:55 -0500
In-Reply-To: <45D1BE46.80100@8d.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Oops, wrong mailing list.

Sorry about that.

Raphael Assenat wrote:
> Hello,
> I have some pxa270 based single board computers which have an 
> IT8152G companion chip. This chip has a built-in USB Host controller 
> which is (according to the datasheet) register compatible with OHCI 
> specification version 1.0.
> 
> During boot, I see that the OHCI controller is detected properly. 
> Devices that were already connected to the USB ports handled by this 
> chip are also detected at boot time. And they work correcly.
> 
> But when I connect a new device to a free port, nothing happens. No 
> messages in dmesg, and the device does not seem to initialize. (eg: 
> Led under optical mouse does not turn on). I have verified, and 
> there is power on the USB power pins. If I disconnect a device that 
> was present at boot time and reconnect it, it is not re-detected.
> 
> Here is a list of kernel version I was able to test with, and the 
> results:
> 2.6.20 -> Same problems as described above.
> 2.6.18 -> Same problems as described above.
> 2.6.17.5 -> Same problems as described above.
> 2.6.16.12 -> Everything works fine.
> 
> Suspecting that this could be a bug in the chip's implementation 
> exposed by some new features, I started looking at the code in the 
> hope to find stuff like controller specific work arounds, quirks, 
> etc to try. but I found nothing that was applicable to my problem...
> 
> I eventually decided to try the modification below, and now it works 
> correctly! But I dont understand why as I have very little knowledge 
> on the subject.
> 
> Any ideas?
> 
> --- linux-2.6.20/drivers/usb/host/ohci-hub.c
> +++ linux-2.6.20-8d/drivers/usb/host/ohci-hub.c
> @@ -413,7 +413,7 @@
>   {
>      struct ohci_hcd *ohci = hcd_to_ohci (hcd);
>      int     i, changed = 0, length = 1;
> -   int     any_connected = 0;
> +   int     any_connected = RH_PS_CCS;
>      unsigned long   flags;
> 
>      spin_lock_irqsave (&ohci->lock, flags);
> 
> 
> Detection messages:
> ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) 
> Driver (PCI)
> ohci_hcd 0000:00:01.4: OHCI Host Controller
> ohci_hcd 0000:00:01.4: new USB bus registered, assigned bus number 2
> ohci_hcd 0000:00:01.4: irq 167, io mem 0x10000000
> 
> 
> Best regards,


-- 
Raphael Assenat
8D Technologies Inc.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
