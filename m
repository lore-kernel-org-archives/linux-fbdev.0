From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 855resolution patch and linux framebuffer
Date: Sat, 07 Jan 2006 09:26:37 +0800
Message-ID: <43BF18CD.8060706@gmail.com>
References: <43BAC3ED.1090900@plek.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvOpv-0002f1-BH
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 07 Jan 2006 16:55:07 -0800
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EvOpu-0001x4-4h
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 07 Jan 2006 16:55:07 -0800
Received: by zproxy.gmail.com with SMTP id r28so3021184nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 07 Jan 2006 16:55:04 -0800 (PST)
In-Reply-To: <43BAC3ED.1090900@plek.net>
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
To: linux-fbdev-devel@lists.sourceforge.net

Eric Schoeller wrote:
> I have been working recently with the framebuffer driver vesafb and
> kernel 2.6.14. I am using the Intel 855GME chipset on a dell 700m
> laptop. The native resolution of the LCD on this device is 1280x800 -
> but can only be achieved after using Alain Porier's 855resolution patch
> to enter the correct mode into the chipset's BIOS. The sad thing is that
> I have to do this on every boot - and thus I have to run it before I
> load the vesafb driver. This procedure is undesirable.
> Is there a way similar functionality of this 855resolution patch could
> be integrated into the kernel in some way?
> I think it would be very useful for everyone who is using this chipset
> and is dealing with having to enter modes into the BIOS in similar
> fashions.
> 

It would require BIOS calls, and we don't have any facility yet to make
BIOS calls in the kernel.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
