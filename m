From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Tue, 23 Dec 2003 18:16:51 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE8CCE3.4010709@undead.cc>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>	 <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc> <1070410792.21174.83.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040805050303000603020103"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYvm4-0006zp-3H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 15:17:12 -0800
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AYvm3-0000sU-Kr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 15:17:11 -0800
In-Reply-To: <1070410792.21174.83.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040805050303000603020103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>>Little.  It's an single processor Athalon box.  I'll do the test later 
>>tonight as I don't want to reboot the other machine at the moment.
>>    
>>
>
>Ok, so this isn't an endian problem in the cfb_ routines. Thanks.
>I'll try to figure out what's up here as well later this week, I'm
>a bit too busy with other things at the moment.
>
>Ben.
>  
>

Here's a patch that fixed things on my machine.  I found it by trial and 
error since I don't have a hardware reference document and the code is a 
little confusing to me.  I don't know if this is the root cause or just 
a fix for the symptoms.  Changing the u16's to u32's fixed the verticle 
grille appearance and most of the color corruption.  Commenting out that 
small block of code fixed the rest of the color problems.

I have a few questions.  Why are we going through the palette instead of 
just writing the proper directcolor/truecolor bitvalues for that color?  
Does that have to do with the disabled HW acceleration code?   Or is it 
because the hw palette color components are 8 bits wide so the displayed 
colors are more accurate?

And the code that I commented out, why is it accesing palette array 
elements that have been set on a previous call or haven't been set yet?  
Why is it trying to compensate for the wider green field when we're 
programming 8 bit values to the hw palette?

My understanding of the low level video hardware control is very limited 
beyond standard VGA register programming so I'm hoping to learn 
something with all my questions.  :)

John


--------------040805050303000603020103
Content-Type: text/plain;
 name="patch.16bppfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.16bppfix"

diff -urNX dontdiff linux.old/drivers/video/aty/radeon_base.c linux/drivers/video/aty/radeon_base.c
--- linux.old/drivers/video/aty/radeon_base.c	2003-12-21 17:54:33.000000000 -0500
+++ linux/drivers/video/aty/radeon_base.c	2003-12-23 17:41:07.000000000 -0500
@@ -1179,12 +1179,12 @@
 				return 1;
 
 			/* For 565, the green component is mixed one order below */
-			if (rinfo->depth == 16) {
-		                OUTREG(PALETTE_INDEX, pindex>>1);
-	       	         	OUTREG(PALETTE_DATA, (rinfo->palette[regno>>1].red << 16) |
-	                        	(green << 8) | (rinfo->palette[regno>>1].blue));
-	                	green = rinfo->palette[regno<<1].green;
-	        	}
+//			if (rinfo->depth == 16) {
+//		                OUTREG(PALETTE_INDEX, pindex>>1);
+//	       	         	OUTREG(PALETTE_DATA, (rinfo->palette[regno>>1].red << 16) |
+//	                        	(green << 8) | (rinfo->palette[regno>>1].blue));
+//	                	green = rinfo->palette[regno<<1].green;
+//	        	}
 		}
 
 		if (rinfo->depth != 16 || regno < 32) {
@@ -1197,11 +1197,11 @@
  	if (regno < 16) {
         	switch (rinfo->depth) {
 		case 15:
-			((u16 *) (info->pseudo_palette))[regno] =
+			((u32 *) (info->pseudo_palette))[regno] =
 			    (regno << 10) | (regno << 5) | regno;
 			break;
 		case 16:
-			((u16 *) (info->pseudo_palette))[regno] =
+			((u32 *) (info->pseudo_palette))[regno] =
 			    (regno << 11) | (regno << 6) | regno;
 			break;
 		case 24:

--------------040805050303000603020103--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
