From: Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH: fixup EDID for slightly broken monitors
Date: Mon, 26 Jul 2004 15:25:55 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040726152555.30271a6b.akpm@osdl.org>
References: <Pine.LNX.4.21.0407151711290.1024-100000@tull.umassp.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BpDwO-0007pk-5w
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Jul 2004 15:27:28 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BpDwN-0002uX-Ly
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Jul 2004 15:27:28 -0700
In-Reply-To: <Pine.LNX.4.21.0407151711290.1024-100000@tull.umassp.edu>
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
To: "Brian S. Julin" <bri@tull.umassp.edu>
Cc: linux-fbdev-devel@lists.sourceforge.net


Could the fbdev people please review this?

Brian, in future, kernel patches should be in `patch -p1' form.  And your
mailer replaces tabs with spaces.  And your signature gives `patch' a heart
attack.  And we always place the body of a `for' loop on a separate line.

Thanks.



From: "Brian S. Julin" <bri@tull.umassp.edu>

The following patch will allow monitor EDID blocks some leeway in
conformance to the DDC specifications.

My monitor (DEC PCXAV-YZ) seems to not emit a legal EDID header block, as
the first two bytes are consistantly 0x23, 0x81 instead of the expected
0x00, 0xff.  I have logged the raw i2c bit transfers and found that, at
least as far as my limited knowlege of DDC goes, there seems to be no error
in the use of the protocol, and these values are in fact what is being
returned by the monitor.  Plus there haven't been large scale complaints
that DDC fails so I assume it is working for most other users.

The EDID checksum fails when these values are left as is (and the header
verification would also fail even were this not the case) but the EDID data
seems to be valid otherwise, and the checksum succeeds if a normal header
is reconstructed.  Doing so only slightly increases the probability of a
false-ok on the checksum/verification, so I figured perhaps this was the
best workaround.

The given method may seem quirky but it should also work for the
alternative EDID header I saw mention of (sorry I lost the URL to that
reference) if that ever needs to be supported.

My work was done with RadeonFB on a Radeon QD.  X also has trouble with DDC
on this monitor.

I'd be interested to know if anyone else has noticed problems with these
monitors.  

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/video/fbmon.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff -puN drivers/video/fbmon.c~fixup-edid-for-slightly-broken-monitors drivers/video/fbmon.c
--- 25/drivers/video/fbmon.c~fixup-edid-for-slightly-broken-monitors	2004-07-26 15:23:39.890721168 -0700
+++ 25-akpm/drivers/video/fbmon.c	2004-07-26 15:23:54.888441168 -0700
@@ -72,13 +72,18 @@ static int edid_checksum(unsigned char *
 	for (i = 0; i < EDID_LENGTH; i++)
 		csum += edid[i];
 
-	if (csum == 0x00) {
-		/* checksum passed, everything's good */
+	if (csum == 0x00) /* checksum passed, everything's good */
 		return 1;
-	} else {
-		printk("EDID checksum failed, aborting\n");
-		return 0;
-	}
+	printk("EDID checksum failed, trying a header reconstruct\n");
+	for (i = 0; i < 4; i++)
+		edid[i] = edid[7-i];
+	csum = 0;
+	for (i = 0; i < EDID_LENGTH; i++)
+		csum += edid[i];
+	if (csum == 0x00) /* checksum passed, everything's good */
+		return 1;
+	printk("Reconstructed EDID checksum failed\n");
+	return 0;
 }
 
 static int edid_check_header(unsigned char *edid)
_



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
