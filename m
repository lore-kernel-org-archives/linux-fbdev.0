From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc6-mm2] fbdev: tag
 by	scantype in sysfs
Date: Fri, 23 Jun 2006 20:00:11 +0800
Message-ID: <449BD7CB.1050904@gmail.com>
References: <4497AA7A.5050507@st.com>
	<4497B4FA.2080602@pol.net>	<4497C289.5060007@st.com>
	<4497CE24.7050908@gmail.com>	<1151049881.12499.18.camel@butch.bri.st.com>	<Pine.LNX.4.62.0606231115180.31279@pademelon.sonytel.be>
	<449BB94A.6000003@st.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtkKm-0008V0-4R for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 05:00:24 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtkKk-0005ss-R6
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 05:00:24 -0700
Received: by py-out-1112.google.com with SMTP id c31so739702pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 23 Jun 2006 05:00:17 -0700 (PDT)
In-Reply-To: <449BB94A.6000003@st.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Daniel THOMPSON <daniel.thompson@st.com>, Geert Uytterhoeven <geert@linux-m68k.org>

Daniel THOMPSON wrote:
> Geert Uytterhoeven wrote:
>> On Fri, 23 Jun 2006, Daniel THOMPSON wrote:
>>> On Tue, 2006-06-20 at 18:29 +0800, Antonino A. Daplas wrote:
>>>>  /sys/class/graphics---fb0
>>>>                     :
>>>>                     --fb1
>>>>                     :
>>>>                     --fbn
>>>>                     :
>>>>                     --mode0---640x480@60
>>>>                     :       :
>>>>                     :       --1024x768@60
>>>>                     :  
>>>>                     --mode1
>>> So the directory mode0 contains all the modes that fb0 is capable of
>>> displaying? Can't that go inside fb0?
>> Let's hope not, as most machines/fb combos don't have enough RAM to store all
>> modes the fb is capable of.
> 
> Fair point.
> 
> By default the existing modes includes only the VESA standard modes,
> although I would expect drivers for TV-like hardware to override the
> mode list to get the supportable CEA-851 standards instead.
>

It only includes modes that are in the driver's private mode list. For
most drivers, that's one entry, for others with EDID, it can be as
much as 40 (near-maximum the EDID block is capable of), but typically
less than 10.
 
> I confess I'm having a great deal of difficulty trying to think of any
> way to update the mode list while sticking to one file, one value.

We can unbind fb[n] from display[n], echo the mode we want added to an 'x'
file one by one, and the modes we don't want into a 'y' file. Finally,
we can bind fb[n] back to display[n]. It's ugly, but can work.

After giving it some thought, sysfs is just not appropriate to serve the
needs of the framebuffer system. So I'll leave fbsysfs untouched for now and
just find/invent more appropriate interfaces.

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
