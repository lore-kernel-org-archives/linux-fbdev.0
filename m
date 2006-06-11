From: Vassilis Virvilis <vasvir@iit.demokritos.gr>
Subject: Re: Twister savagefb doesn't sync (resolved for
 640x480@64K)
Date: Sun, 11 Jun 2006 15:03:07 +0300
Message-ID: <448C067B.3040404@iit.demokritos.gr>
References: <44698356.80806@iit.demokritos.gr> <44781B3A.5030406@gmail.com>	
	<44781BFB.5020708@gmail.com> <447994A8.30600@iit.demokritos.gr>	
	<447A3CC0.9060403@gmail.com> <447AF58E.3050803@iit.demokritos.gr>	
	<447B60D7.8020204@gmail.com> <44845DEC.1000608@iit.demokritos.gr>	
	<a728f9f90606052211v43de97c7l91a22a9faa93f76c@mail.gmail.com>	
	<44855197.7040801@iit.demokritos.gr>
	<a728f9f90606060743t7fd6dfdfia3e2a050ff954e06@mail.gmail.com>
Reply-To: vasvir@iit.demokritos.gr,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010506020104030403030809"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpOaC-0004w2-0z for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Jun 2006 04:58:20 -0700
Received: from zeus.iit.demokritos.gr ([143.233.226.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpOaA-0007Of-DV
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Jun 2006 04:58:20 -0700
In-Reply-To: <a728f9f90606060743t7fd6dfdfia3e2a050ff954e06@mail.gmail.com>
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

This is a multi-part message in MIME format.
--------------010506020104030403030809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

I would like to thank you and Antonino for all the help so far. I have finally
manage to make my twister to sync with both of my screens (one TFT, one CRT).

I am attaching the patch. The patch itself disables all modes other than
640x480@64K-60Hz. Note that the patch is clearly inapropriate but it
may sparkle some discussion about how this thing works.

One more question:

Alex Deucher wrote:
>> > The reason the savage xorg drver uses the bios is because almost every
>> > panel they connect to the chip seems to require fairly custom timings.
>> > the twisters and prosavages are even worse than the discrete chips.
>> > Also, only the bios seems to know the magic incantation necessary for
>> > dualhead.  I tried for a while to add non-bios mode setting to crtc2
>> > without much luck.
>>

When you say panel what do you mean?
a) The rest of the framebuffer and scan logic resided in CRTC?
b) The screen attached to CRTC?

I believe a) but I would like to know for sure.

Thanks again...

    .bill

--------------010506020104030403030809
Content-Type: text/x-patch;
 name="savage-640x48064K.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="savage-640x48064K.patch"

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 10e6b3a..117205e 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -901,6 +901,7 @@ static int savagefb_decode_var (struct f
 
 	SavageCalcClock (dclk, 1, 1, 127, 0, 4, 180000, 360000, &m, &n, &r);
 	/* m = 107; n = 4; r = 2; */
+	m = 0xfc; n = 0x5; r = 0x3; /* TwisterP */
 
 	if (par->MCLK <= 0) {
 		par->SR10 = 255;
@@ -908,6 +909,7 @@ static int savagefb_decode_var (struct f
 	} else {
 		common_calc_clock (par->MCLK, 1, 1, 31, 0, 3, 135000, 270000,
 				   &par->SR11, &par->SR10);
+		par->SR10 = 0x0; par->SR11 = 0x0; /* TwisterP */
 		/*      par->SR10 = 80; // MCLK == 286000 */
 		/*      par->SR11 = 125; */
 	}

--------------010506020104030403030809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010506020104030403030809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------010506020104030403030809--
