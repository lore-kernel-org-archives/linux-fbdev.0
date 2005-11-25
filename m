From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: RFC: bitmap line alignment
Date: Fri, 25 Nov 2005 15:10:50 +0100
Message-ID: <43871B6A.8090705@t-online.de>
References: <438700A3.3070503@t-online.de> <43870557.2090005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfeHw-0001L0-To
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Nov 2005 06:10:56 -0800
Received: from mailout07.sul.t-online.com ([194.25.134.83])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EfeHu-0001XH-Ei
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Nov 2005 06:10:56 -0800
In-Reply-To: <43870557.2090005@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Tony,

>If you create your own info->pixmap and an info->pixmap.scan_align = 4, the
>driver will be fed a bitmap that have a scanline that is 32-bit aligned.
>The default if you don't specify anything, of course, will be an 8-bit
>aligned bitmap which, for the sake of code efficiency, is the alignment
>assumed by the cfb_* drawing functions.
>
>(An example usage is in the patch I attached just a few days ago when
>I commented how the cyberblade should be intelligent enough to handle
>bitmaps with variable widths.)
>  
>
Well, here is what I did:  A quick look at the changes in 
cyblafb_imageblit made
it very clear to me that the code could not work as I assumed a totaly 
wrong format
for the image data. To me it was obvious from a look at skeletonfb that 
the data was
a continous bit field without anything like alignment gaps. Anyway, I 
was already
in the process of repeatedly locking up my PC with an accel function 
that was based
on that wrong assumption (I sent data until I reached the erroneously 
calculated end
of the data buffer, the accel engine waited for more data, got a new 
command in
between and locked everything). Yesterday I even attached an old VT 220 for
debugging, and that showed me that the data is byte aligned. Then it was 
easy to write
a much too complicated bitblit for that data with 8 bit pixelline alignment.

I assume by now you are ROTFL ;-)

I think a comment in skeletonfb would be a good idea.

cu,
 Knut




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
