From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005	with radeonfb enabled
Date: Sat, 11 Nov 2006 15:27:50 +0100
Message-ID: <D0233BCDB5857443B48E64A79E24B8CE043CB4@labex2.corp.trema.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Giu57-0003ux-Ql for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Nov 2006 06:43:42 -0800
Received: from wshld2.trema.com ([194.103.215.196]
	helo=webshieldout.corp.trema.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Giu55-00088U-RU
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Nov 2006 06:43:41 -0800
content-class: urn:content-classes:message
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
To: Stuffed Crust <pizza@shaftnet.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl, Hoffmann@albercik.sisk.pl

Hello,
yes, it resumes OK, when I don't have radeonfb and pass kernel options: irqpoll acpi_irq_balance noapic (found that on the gentoo acer ferrari wiki here: http://gentoo-wiki.com/HARDWARE_Gentoo_Acer_Ferrari_4005WLMi_Manual
(maybe these issues should be reported to some kernel developers as well)

I use a patched dsdt but I cant remember where I got it from. I uploaded it to: http://christianhoffmann.de/temp/dsdt2.dsl

Yes, I use the free radeon xorg driver at the same time and X is running when suspending. Ill try without.

I dont know how to get more traces than from dmesg and /var/log/messages. Seems that the kernel params are not shown.
 

kernel /boot/kernel-genkernel-x86_64-2.6.18-gentoo-r1 root=/dev/ram0 init=/linuxrc ramdisk=8192 real_root=/dev/hda
3 udev video=radeonfb splash=silent,theme:livecd-2006.1 CONSOLE=/dev/tty1 quiet irqpoll acpi_irq_balance noapic pc
i=assign-busses

initrd /boot/initramfs-genkernel-x86_64-2.6.18-gentoo-r1


Chris

-----Original Message-----
From:	Stuffed Crust [mailto:pizza@shaftnet.org]
Sent:	Sat 11/11/2006 2:45 PM
To:	linux-fbdev-devel@lists.sourceforge.net
Cc:	Rafael J. Wysocki; Christian Hoffmann; LKML; Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl
Subject:	Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005	with radeonfb enabled

On Sat, Nov 11, 2006 at 12:49:06PM +1100, Benjamin Herrenschmidt wrote:
> There are many possible reasons for that. The most likely is that the
> BIOS isn't bringing the chip back on resume, causing radeonfb to
> crash when trying to access it.

I have the same laptop, and it also crashes for me on resume when 
radeonfb is loaded.  However, it also crashes on a resume when radeonfb 
*isn't* loaded, so I hardly considered that a regression.  :)

> On Thu, Nov 09, 2006 at 07:50:17PM +0100, Christian Hoffmann wrote:
> > when I have radeonfb enabled, my laptop (X700 ati mobility) doesnt resume
> > anymore. Screen stays black and nothing works anymore, no capslock light, no
> > ctrl alt sysreq b etc. I tried all kind of things vbetool, passing
> > acpi_sleep=s3_bios,s3_mode to the kernel. Nothing seems to work.

...but it used to work?  Now that's interesting; this is the first 
report I've heard of a suspend-to-RAM (and subsequent resumes) working 
on that machine.

> > You can see dmesg output and lspci -vv output here 
> >  http://christianhoffmann.de/temp/radeon.log
> >  http://christianhoffmann.de/temp/lspci.log

Can you send the *full* bootup log, including the command lines you 
used?

I noticed that you have the 'radeon' drm module loading too; that may be 
causing problems.  Are you running X when you try to suspend/resume?

Also, since you're using a Ferarri 4000, are you using the stock 3A23 
BIOS/DSDT, or are you using the patched DSDT from http://acpi.sf.net?

 - Solomon
-- 
Solomon Peachy        		       pizza at shaftnet dot org	 
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344





Privileged or confidential information may be contained in this message.  If you are not the addressee of this message please notify the sender by return and thereafter delete the message, and you may not use, copy, disclose or rely on the information contained in it. Internet e-mail may be susceptible to data corruption, interception and unauthorised amendment for which Wall Street Systems does not accept liability. Whilst we have taken reasonable precautions to ensure that this e-mail and any attachments have been swept for viruses, Wall Street Systems does not accept liability for any damage sustained as a result of viruses.  Statements in this message or attachments that do not relate to the business of  Wall Street Systems are neither given nor endorsed by the company or its Directors.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
