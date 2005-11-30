From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: scroll modes
Date: Thu, 01 Dec 2005 04:40:03 +0800
Message-ID: <438E0E23.2000203@gmail.com>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhYlD-0003SR-Sc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 12:41:03 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhYl9-0002ua-9l
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 12:41:04 -0800
Received: by zproxy.gmail.com with SMTP id z3so96656nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Nov 2005 12:40:58 -0800 (PST)
In-Reply-To: <438DE211.2060900@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Knut Petersen wrote:
> Geert Uytterhoeven wrote:
> 
>> Ywrap has been working fine with amifb since ages (unless someone
>> broke it very
>> recently).
>>
>>  
>>
> We are talking about scrollmode = SCROLL_WRAP_MOVE ?

Try this patch.

Tony

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 1a8f0ea..5ebe68f 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1972,12 +1972,6 @@ static __inline__ void updatescrollmode(
 	int fast_imageblit = (cap & FBINFO_HWACCEL_IMAGEBLIT) &&
 		!(cap & FBINFO_HWACCEL_DISABLED);
 
-	p->vrows = vyres/fh;
-	if (yres > (fh * (vc->vc_rows + 1)))
-		p->vrows -= (yres - (fh * vc->vc_rows)) / fh;
-	if ((yres % fh) && (vyres % fh < yres % fh))
-		p->vrows--;
-
 	if (good_wrap || good_pan) {
 		if (reading_fast || fast_copyarea)
 			p->scrollmode = good_wrap ?
@@ -1991,6 +1985,16 @@ static __inline__ void updatescrollmode(
 		else
 			p->scrollmode = SCROLL_REDRAW;
 	}
+
+	p->vrows = vyres/fh;
+
+	if (p->scrollmode != SCROLL_WRAP_MOVE &&
+	    (yres > (fh * (vc->vc_rows + 1))))
+		    p->vrows -= (yres - (fh * vc->vc_rows)) / fh;
+
+	if ((yres % fh) && (vyres % fh < yres % fh))
+		p->vrows--;
+
 }
 
 static int fbcon_resize(struct vc_data *vc, unsigned int width, 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
