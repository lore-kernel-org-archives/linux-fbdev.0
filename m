From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Voyager GX color mapping
Date: Tue, 14 Dec 2004 18:23:58 +0100
Message-ID: <41BF21AE.4000605@anagramm.de>
References: <41BF177E.7010205@anagramm.de> <20041214165732.GA10585@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeGNa-0005ZP-1t
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 09:22:30 -0800
Received: from moutng.kundenserver.de ([212.227.126.189])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CeGNX-0000hV-TR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 09:22:29 -0800
Received: from [212.227.126.209] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CeGNX-00084u-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 18:22:27 +0100
Received: from [217.235.127.66] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CeGNW-0003YB-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 18:22:26 +0100
In-Reply-To: <20041214165732.GA10585@linux-sh.org>
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

Hello, Paul,

>>well, my version of the Silicon Motion SM501 driver works now
>>quite well on the PowerMac (after some data integrity problems
>>with the card having in a dusty PCI slot. :-(( )
 >
> Do you have this driver in a tree somewhere? We have a version now in
> the sh tree that needs to be tossed out and rewritten, and it would be
> good not to duplicate effort..

Currently, it's only local, it's work in progress... PPC tested only.
I did quite some code cleanup and removed some redundant/unused code.
I added some (my first time) module load/unload capability and lots
of test/debug things for HW testing also.

I don't maintain a local CVS tree here yet...
Tell me if I can put it somewhere to the public.

Best greets,

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
