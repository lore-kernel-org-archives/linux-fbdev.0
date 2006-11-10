From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Sat, 11 Nov 2006 00:31:15 +0100
Message-ID: <200611110031.16173.rjw@sisk.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946221AbWKJXdq@vger.kernel.org>
content-class: urn:content-classes:message
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl, Hoffmann@albercik.sisk.pl, Christian.Hoffmann@wallstreetsystems.com

Hi,

We've just got the appended report.  Could you please have a look at this?

Greetings,
Rafael


----------  Forwarded Message  ----------

Subject: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Friday, 10 November 2006 20:44
From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
To: suspend-devel@lists.sourceforge.net

Hello,
 
when I have radeonfb enabled, my laptop (X700 ati mobility) doesnt resume
anymore. Screen stays black and nothing works anymore, no capslock light, no
ctrl alt sysreq b etc. I tried all kind of things vbetool, passing
acpi_sleep=s3_bios,s3_mode to the kernel. Nothing seems to work.
 
You can see dmesg output and lspci -vv output here 
 http://christianhoffmann.de/temp/radeon.log
 http://christianhoffmann.de/temp/lspci.log
 
Thanks a lot for any input.
 
Chris
 
PS: I use kernel 2.18.1 + patch for radeonfb from
http://bugzilla.kernel.org/attachment.cgi?id=9408&action=view
