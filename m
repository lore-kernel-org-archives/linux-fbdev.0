From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1: 2.6.15-rc5-git3] Disable ywrap if not supported by
 fbcon scrolling code
Date: Tue, 13 Dec 2005 23:43:55 +0800
Message-ID: <439EEC3B.1050603@gmail.com>
References: <439ECBE8.5090002@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmCJz-0003PU-8g
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 07:44:07 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmCJx-0002pX-VV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 07:44:07 -0800
Received: by zproxy.gmail.com with SMTP id j2so1761054nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 Dec 2005 07:44:05 -0800 (PST)
In-Reply-To: <439ECBE8.5090002@t-online.de>
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
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> updatescrollmode() must not select ywrap scrolling if
> divides(vc->vc_font.height, yres) is not true as this is not
> supported by the actual ywrap scrolling code.
> 
> The bug is triggered with e.g. mode 800x600, vxres 1024,
> vyres 8192, bpp 8, font dimensions 8x16, 8Mb video ram
> and FBINFO_HWACCEL_YWRAP set. If those conditions
> are met, scrolling is broken and garbage is permanently
> displayed at the bottom of the screen.
> 
> No regression, no possible side effects.
> 
> Definitely needed by cyblafb and probably needed by amifb.
> 
> Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>
Acked-by: Antonino Daplas <adaplas@pol.net>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
