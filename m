From: Simon Posnjak <simon.posnjak@cetrtapot.si>
Subject: Frame Buffer Driver for a Device on Parallel Port
Date: Fri, 5 Mar 2004 05:23:58 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403050523.58383.simon.posnjak@cetrtapot.si>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Az2ql-00022x-UK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Mar 2004 16:05:59 -0800
Received: from [194.165.122.143] (helo=klada.dyndns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Az2Iv-0007iJ-5e
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Mar 2004 15:31:01 -0800
Received: from localhost (localhost.dyndns.org [127.0.0.1])
	by klada.dyndns.org (Postfix) with ESMTP id 2BB006378
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  5 Mar 2004 00:58:17 +0100 (CET)
Received: from klada.dyndns.org ([127.0.0.1])
 by localhost (klada.dyndns.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 80848-10 for <linux-fbdev-devel@lists.sourceforge.net>;
 Fri,  5 Mar 2004 00:58:16 +0100 (CET)
Received: from AS-87-9.dial-up.siol.net (AS-87-9.dial-up.siol.net [213.250.7.9])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by klada.dyndns.org (Postfix) with ESMTP id 87BC460D7
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  5 Mar 2004 00:58:15 +0100 (CET)
Content-Disposition: inline
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

Hi,

I am working on an embedded system based on Axis Cris Development Board 
(running 2.4.22 kernel) to which we connected LCD with Epson's SED1335 LCD 
controller over the parallel port. I am currently investigating the posabilty 
of witting frame buffer driver for it. The problem i am having is that the 
memory of the LCD controller (very small: 32K - the area used is even smaller 
- about 10K) is not mapped to the address space of the processor and I have 
problems locating documentation that would tell me how to map it (all ways I 
looked at, require address of the device in processors name space - which I 
do not have).

The way I thought of doing the mapping was to say that some (unused) range in 
processor address space is the "mapping" and then if some body writes to the 
"mapping" I would translate the address (offset) in to the LCD's address 
space and sent the data over parallel port to the LCD, by issuing the right 
commands. Is this fisable? How could I do it (which kernel facility should I 
use)?

Any other ideas about how to write this driver would be deeply appreciated. 
Thank you.

		Regards Simon



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
