From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Voyager GX color mapping
Date: Tue, 14 Dec 2004 17:40:30 +0100
Message-ID: <41BF177E.7010205@anagramm.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeFha-0002ex-SQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 08:39:06 -0800
Received: from moutng.kundenserver.de ([212.227.126.176])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CeFhZ-0001eA-1j
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 08:39:05 -0800
Received: from [212.227.126.161] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CeFhW-0007Bb-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 17:39:02 +0100
Received: from [217.235.127.66] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CeFhW-0000rg-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 17:39:02 +0100
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hello, again,

well, my version of the Silicon Motion SM501 driver works now
quite well on the PowerMac (after some data integrity problems
with the card having in a dusty PCI slot. :-(( )

Only one thing is missing: The color mapping in the
32bit mode doesn't fit with X. The fb memory map has a BGRA
color mapping but X11 writes it in RGBA.

I have tried to change the fb_var_screeninfo.fb_bitfield
values in the driver and via fbset -rgba ... but it seems as
X doesn't care at all.

Where do I need to tweak to get it working?
Is there a performance penalty to remap the pixels in software?
Which is the optimum way to get correct color mapping?

Thank you in advance,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
