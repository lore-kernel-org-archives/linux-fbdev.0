From: Daniel THOMPSON <daniel.thompson@st.com>
Subject: Re: [PATCH 2.6.17-rc6-mm2] fbdev: tag by
	scantype in sysfs
Date: Fri, 23 Jun 2006 10:50:02 +0100
Message-ID: <449BB94A.6000003@st.com>
References: <4497AA7A.5050507@st.com> <4497B4FA.2080602@pol.net>
	<4497C289.5060007@st.com> <4497CE24.7050908@gmail.com>
	<1151049881.12499.18.camel@butch.bri.st.com>
	<Pine.LNX.4.62.0606231115180.31279@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtiN9-0005y7-0M for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 02:54:43 -0700
Received: from lon-del-03.spheriq.net ([195.46.50.99])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FtiN7-0005SW-7t
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 02:54:43 -0700
Received: from lon-out-01.spheriq.net ([195.46.50.129])
	by lon-del-03.spheriq.net with ESMTP id k5N9sbvX008437
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 23 Jun 2006 09:54:37 GMT
Received: from lon-cus-01.spheriq.net (lon-cus-01.spheriq.net [195.46.50.37])
	by lon-out-01.spheriq.net with ESMTP id k5N9teRk021222
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 23 Jun 2006 09:55:44 GMT
In-Reply-To: <Pine.LNX.4.62.0606231115180.31279@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@gmail.com>

Geert Uytterhoeven wrote:
> On Fri, 23 Jun 2006, Daniel THOMPSON wrote:
>> On Tue, 2006-06-20 at 18:29 +0800, Antonino A. Daplas wrote:
>>>  /sys/class/graphics---fb0
>>>                     :
>>>                     --fb1
>>>                     :
>>>                     --fbn
>>>                     :
>>>                     --mode0---640x480@60
>>>                     :       :
>>>                     :       --1024x768@60
>>>                     :  
>>>                     --mode1
>> So the directory mode0 contains all the modes that fb0 is capable of
>> displaying? Can't that go inside fb0?
> 
> Let's hope not, as most machines/fb combos don't have enough RAM to store all
> modes the fb is capable of.

Fair point.

By default the existing modes includes only the VESA standard modes,
although I would expect drivers for TV-like hardware to override the
mode list to get the supportable CEA-851 standards instead.

I confess I'm having a great deal of difficulty trying to think of any
way to update the mode list while sticking to one file, one value.

-- 
Daniel Thompson (STMicroelectronics) <daniel.thompson@st.com>
1000 Aztec West, Almondsbury, Bristol, BS32 4SQ. 01454 462659

If a car is a horseless carriage then is a motorcycle a horseless horse?

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
