From: Ian Romanick <idr@us.ibm.com>
Subject: Re: [Fwd: [PATCH] Read MGA PInS data on PowerPC]
Date: Thu, 25 Aug 2005 10:44:56 -0700
Message-ID: <430E0398.1010504@us.ibm.com>
References: <430D0567.1010305@gmail.com> <430D2579.7080104@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8LnC-0005eC-Mq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 10:45:34 -0700
Received: from e33.co.us.ibm.com ([32.97.110.131])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1E8Ln6-0005TW-4s
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 10:45:34 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7PHj2NN108666
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Aug 2005 13:45:10 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7PHjBct268658
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Aug 2005 11:45:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7PHj1NC005401
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Aug 2005 11:45:01 -0600
In-Reply-To: <430D2579.7080104@vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Vandrovec wrote:
>> This updates the matroxfb code so that it can find the PInS data
>> embedded in the BIOS on PowerPC cards.  The process for finding the data
>> is different on OpenFirmware cards than on x86 cards, and the code for
>> doing so was missing.
> 
> Can you resend patch with 'Signed-off-by: Ian Romanick <idr@us.ibm.com>'
> included?

Yes.  Sorry.

>> After patching, building, installing, and booting a kernel, you should
>> grep for "PInS" in /var/log/messages.  You should see two messages in
>> the log:
>>
>> PInS data found at offset XXXXX
>> PInS memtype = X
> 
> Is not it possible to find PINS some other way, or just look at every
> 16th byte for signature, or something like that?  Unless your image has
> signature at the beginning, it should take years to read EEPROM this
> way, with byte-after-byte reads.  At least it is reason why I used this
> undocumented feature that PINS pointer is stored at the end of image.
> Scanning just every 16th byte in EEPROM took about 5 seconds before it
> found PINS at 0x6XXX address...

I've looked through all the documentation that I have, and I haven't
been able to find another way to do it.  For x86, the PInS offset *is*
documented to be stored at offset 0x7FFC.

> As for your question about sparc in the code - what about modifying
> get_pins() to return success/failure, and then try current i386 code
> first, and if this fails to find PINS then scan whole BIOS image ?  This
> way it will work even if you'll plug OpenFirmware card into i386 box.

The docs that I have indicate that offset 0x7FFC is past the end of the
end of the BIOS image on PowerPC versions of the card.  I don't think
trying to access it on those cards is a good idea.

>> On the GXT135p card I get "31168" and "5".  The first value is
>> irrelevant, but it's presence lets me know that the PInS data was
>> actually found.  On a GXT130p, the second value should be 3.  Since I
>> don't have access to that hardware, if someone can verify that, I will
>> submit a follow-on patch that rips out all the memtype parameter stuff.
> 
> I would leave memtype untouched...

AFAIK, the only reason that parameter is needed is to support PowerPC
cards where the memtype couldn't be read from the PInS.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDDgOYX1gOwKyEAw8RAqXrAJ4mFRR8SaohEEZdTuRR55sRJRs1vgCfWiH2
5GmhGrUfFDlkIENEiS4bxIo=
=v5+D
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
