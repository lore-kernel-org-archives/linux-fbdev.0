From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Voyager GX color mapping
Date: Tue, 14 Dec 2004 18:14:52 +0100
Message-ID: <41BF1F8C.6030501@anagramm.de>
References: <41BF177E.7010205@anagramm.de> <Pine.GSO.4.61.0412141744200.10558@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeGEp-0004xS-W5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 09:13:27 -0800
Received: from moutng.kundenserver.de ([212.227.126.189])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CeGEl-00007e-LP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 09:13:27 -0800
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CeGEj-0005B3-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 18:13:21 +0100
Received: from [217.235.127.66] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CeGEj-0007tV-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 18:13:21 +0100
In-Reply-To: <Pine.GSO.4.61.0412141744200.10558@waterleaf.sonytel.be>
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

Hello, Geert!

>>well, my version of the Silicon Motion SM501 driver works now
>>quite well on the PowerMac (after some data integrity problems
>>with the card having in a dusty PCI slot. :-(( )
>>
>>Only one thing is missing: The color mapping in the
>>32bit mode doesn't fit with X. The fb memory map has a BGRA
>>color mapping but X11 writes it in RGBA.
>>
>>I have tried to change the fb_var_screeninfo.fb_bitfield
> 
> You should indeed make sure the fb_var_screeninfo.fb_bitfield values are
> correct.  BTW, have you tried fbtest to verify the correctness of your driver?
> You can check it out from CVS on SourceForge.

I got fbset already... thanks.

Well, whenever I change the (yet hardcoded) structs in the driver,
fbset -fb /dev/fb2 shows me the correct (changed) values.
But there is no change in X at all if I play around with the values.
Is it possible that X doesn't get my fb_var_screeninfo? Maybe I need
to check xorg.cfg again...
The same things happen in all 32bit (RGBA8888) as well as in
16bit (RGB565) modes (i haven't tried 8bit, as I don't need it).
Is this an PPC-endian related problem?
Is the SM501's BGRA mapping usual?
Hmm...

>>Where do I need to tweak to get it working?
> X should obey the fb_var_screeninfo.fb_bitfield values. If it doesn't, it's a
> bug in X.

Unlikely, I think?

I use a primary "ATI Radeon If" (fb0, fb1) on Depth 16 successfuly.
The SMI501 is the secondary graphics board (fb2) on Depth 16, 24, 32.
Does X listen only to the mapping of the primary card? I guess I will
get offtopic with the X questions.

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
