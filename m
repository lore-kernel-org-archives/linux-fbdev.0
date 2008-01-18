From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH] s3c2410_fb: Fix line length
	calculation
Date: 18 Jan 2008 13:46:43 +0100
Message-ID: <20080118124643.B8512118873@f31.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0801453362=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFqcT-0007ev-Ip for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 04:46:49 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JFqcS-0001cl-4n
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 04:46:49 -0800
Received: from f31.poczta.interia.pl (f31.poczta.interia.pl [10.217.2.31])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 13678663A42
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 18 Jan 2008 13:46:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by f31.poczta.interia.pl (Postfix) with ESMTP id B8512118873
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 18 Jan 2008 13:46:43 +0100 (CET)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

--===============0801453362==
Content-Type: TEXT/HTML; CHARSET=UTF-8

   > Fix line length calculation. var-&gt;width is the size of the display in mm.  > We  > like to use the pixel size.  >   > Without this fix, dynamic (fbset) based resolution changes with  > s3c2410_fb  > don\'t work at all.  >   > Spotted by john cass &lt;johnpcass@yahoo.com&gt;  >   > Signed-off-by: Stefan Schmidt &lt;stefan@openmoko.org&gt;  > Signed-off-by: Harald Welte &lt;laforge@openmoko.org&gt;  > Acked-by: Ben Dooks &lt;ben-linux@fluff.org&gt;  > Acked-by: Arnaud Patard &lt;arnaud.patard@rtp-net.org&gt;  >   > Index: linux-2.6/drivers/video/s3c2410fb.c  > ===================================================================  > --- linux-2.6.orig/drivers/video/s3c2410fb.c  > +++ linux-2.6/drivers/video/s3c2410fb.c  > @@ -488,7 +488,7 @@  >    break;  >   }  >    > - info-&gt;fix.li
 ne_length = (var-&gt;width * var-&gt;bits_per_pixel) / 8;  > + info-&gt;fix.line_length = (var-&gt;xres_virtual * var-&gt;bits_per_pixel) / 8;  >    >   /* activate this new configuration */
   >    >    Please send this patch to Andrew Morton.   Your patch also helps with depth switching.  Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>  Regards, Krzysztof

<TABLE cellPadding="3" bgColor="#ffffff"><TBODY><TR><TD style="font: 12px Courier New, Courier, monotype.com; padding: 3px; background: #ffffff; color: #000000">
<BR>
----------------------------------------------------------------------
<BR>
Nadchodzi galaktyczna wojna!
<BR>
Sprawdz &gt;&gt; <A href="http://link.interia.pl/f1ce0">http://link.interia.pl/f1ce0</a></TD></TR></TBODY></TABLE>



--===============0801453362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0801453362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0801453362==--
