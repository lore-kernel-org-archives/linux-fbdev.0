From: Matthias Badaire <mbadaire20@yahoo.fr>
Subject: FB through DMA
Date: Mon, 09 Feb 2004 23:01:59 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <868yjb29pk.fsf@debian.baz.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqLBm-0001CT-JS
	for Linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 15:51:42 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AqL09-0004Bk-DE
	for Linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 15:39:41 -0800
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
Content-Transfer-Encoding: 7bit
To: Linux-fbdev-devel@lists.sourceforge.net

Hi,

I am sorry if it is not the right place to ask this question.

I am currently using an hauppauge PVR-350 with tv-out.
The driver for this card (http://ivtv.sourceforge.net/) expose a framebuffer driver.
We have a direct access to the mem of this card and therefore the fb kernel driver was easy.

Now my problem comes from the fact that I want to avoid to write directly to the 
RAM of the card but I want to send the frame via DMA(via an ioctl).

I suceed to make some ugly modif to fbdev.c by
- define my new ioctl in fbdevhw.c
- using the shadow options
- define my own buffer through a malloc (call it memBuf) 
- change FBDevWindowLinear to give memBuf back (for shadowUpdatePacked to write in it)
- define my own FBshadowUpdatePacked (and pass it for shadowAdd())
- FBshadowUpdatePacked calls shadowUpdatePacked and then calls 
the ioctl with memBuf as a parameter for the card to dma the memBuf.

Now I am quite sure it is not the right way to do it (I hear some laughing already).
Could somebody tell me in a nutshell how I should have implemented this.

I know the way I did this, it is now irrelevant to FrameBuffer, as I am not using 
the mmap of the kernel fb driver, but maybe some people could help me here?

Thx

M


 


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
