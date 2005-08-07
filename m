From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: CRTC scanout buffer types
Date: Mon, 08 Aug 2005 05:45:41 +0800
Message-ID: <42F68105.1080207@pol.net>
References: <9e47339105080513195dee0804@mail.gmail.com>	 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be> <9e47339105080706414faf1e40@mail.gmail.com> <42F67719.9050805@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1sxf-0001Y4-Ui
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 14:45:39 -0700
Received: from wproxy.gmail.com ([64.233.184.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1sxe-0006E3-Ob
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 14:45:40 -0700
Received: by wproxy.gmail.com with SMTP id i21so637591wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 14:45:32 -0700 (PDT)
In-Reply-To: <42F67719.9050805@us.ibm.com>
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
To: Ian Romanick <idr@us.ibm.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, DRI developer's list <dri-devel@lists.sourceforge.net>

Ian Romanick wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jon Smirl wrote:
>> I'm trying to work out a syntax for the sysfs attribute that will
>> control the config. My first idea is to use a alpha/red/blue/green
>> syntax. When red is set and blue/green are missing index mode is set.
>> When green is set and red/blue are missing gray scale is set.
>>
>> Are there chips that can scanout from buffers not packed at a power of two?
>> How should I work different color spaces (YCbCr) into this?
>>
>> 4bpp Index = /4
>> 4bpp greyscale = //4
>> 8bpp Index = /8
>> 8bpp RGB 332 = /3/3/2
>> 8bpp greyscale = //8
>> 16bpp aRGB 1555 = 1/5/5/5
>> 16bpp RGB 565 = /5/6/5
>> 16bpp aRGB 4444 = 4/4/4/4
>> 16bpp aIndex 88 = 8/8
>> 24bpp RGB 888 = /8/8/8
>> 24bpp aRGB 6666 = 6/6/6/6
>> 32bpp aRGB 8888 = 8/8/8/8
>> 32bpp aRGB 2:10:10:10 = 2/10/10/10
> 
> What would be wrong with using a letter, a colon, and a number to
> describe the field?  So, instead of 2/10/10/10 you'd have
> A:2/R:10/G:10/B:10.  Or A:8/I:8 for aIndex 88.  I'm not familiar with
> how sysfs attributes work, so this may be pure nonsense.

I agree that something like the above is acceptable, exept that we need
an extra field for offset and another if indexed color or not. So something like:

A:2/0/R:10/2/G:10/12/B:10/22//I

is ARGB2888. The I means it's indexed (directcolor), differentiating it from
truecolor.

A:8/0/R:8/0/G:8/0/B:8/0//I

is ARGB8 indexed, because offset's are all equal to 0 and len's are all
equal to 8.  The 'I' here is probably redundant, but it can be used to
differentiate it from static pseudocolor.

From here, you can get the color depth which usually translates to bpp:

if (offset's = 0 && red.len == green.len && green.len == blue.len)
	if (transp.offset == 0) //ARGB8 bpp8
		depth = green.len ; 
	else			//A8_RGB8 bpp16
		depth = green.len + transp.len
else
	depth = red.len + green.len + blue.len + transp.len

If depth returns 15 (RGB555), the driver can easily round that up to bpp16.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
