From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Frame swapping
Date: Fri, 09 Dec 2005 20:27:39 +0800
Message-ID: <4399783B.9020203@gmail.com>
References: <35786B99AB3FDC45A8215724617919736D9183@gbrwgceumf01.eu.xerox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkhLn-0006B8-OB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 04:27:47 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkhLm-0002ms-7V
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 04:27:47 -0800
Received: by zproxy.gmail.com with SMTP id r28so860792nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 04:27:44 -0800 (PST)
In-Reply-To: <35786B99AB3FDC45A8215724617919736D9183@gbrwgceumf01.eu.xerox.net>
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
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Jenkins, Clive wrote:
>> From: Antonino A. Daplas [mailto:adaplas@gmail.com] 
>> Sent: 08 December 2005 21:18
>> To: linux-fbdev-devel@lists.sourceforge.net
>> Cc: Jenkins, Clive
>> Subject: Re: [Linux-fbdev-devel] Frame swapping
>>
>> Jenkins, Clive wrote:
>>> How is frame swapping done, using the mechanisms provided
>>> by FB (in 2.4 and 2.6)?
>>> Can anyone point me to any good code examples in the
>>> existing FB device drivers?
>>>
>>> ["Frame swapping" or "video page flipping" is switching
>>> to an alternate framebuffer memory area during the
>>> vertical blank period. This is a common technique to
>>> achieve animation or a single clean change of picture.]
>> Use the pan display ioctl, FBIOPAN_DISPLAY.  Basically, set
>> var->yres_virtual to be at least 2x var->yres so you can have
>> 2 video buffers, one visible, one offscreen.  Then just do a
>> ypan ioctl to set which buffer becomes visible and which
>> becomes offscreen.
>>
>> Doing it during vblank is a little difficult.  You can poll
>> the VGA registers (which is slow), or set up an interrupt
>> handler for the driver you are using that waits for vblank.
>>
>> See www.directfb.org for code on how this can be done.  Also,
>> the directfb source have patches to some drivers that implements
>> the wating for vblank, such as in matroxfb.
>>
>> Tony
> 
> Thanks Tony. I was thinking I would have to implement my own
> ioctl to do this, but I agree it can be regarded as a special
> case of panning (even though my hardware doesn't fully support
> panning).
> 
> I would expect panning to be smooth and glitch-free whenever
> possible within the limitations of the hardware, so the
> switch-over should always occur during vblank. I have seen some
> drivers that definitely do this, by deferring all updates until
> the vb interrupt. But maybe many other drivers don't bother.

Yes, Because waiting for vblank will slow down console scrolling.

> 
> Another way might be to do a GETVAR ioctl, modify "yoffset",
> set the FB_ACTIVATE_VBL bit of "activate", and do a SETVAR
> ioctl. I am sure this is the intended usage of the ACTIVATE_VBL
> bit, even though it may not be well supported by existing drivers.
> 

No, this will be terribly slow.  And most drivers ignore 
ACTIVATE_VBL flag and also resets the yoffset to zero on a
SETVAR ioctl.

> I notice in fbmem.c (2.4.20 version), there is no fall-back
> code for the PAN_DISPLAY ioctl when the device method is absent.
> Perhaps the getvar/modify/setvar above should be coded here.

Possibly.  But don't do this for the reasons mentioned above.
It would be simpler to implement a pan_display hook.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
