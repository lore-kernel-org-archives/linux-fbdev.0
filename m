From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Re: Current discussion about the future of
 free software graphics
Date: Wed, 12 May 2004 14:23:11 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40A2799F.7070201@bitworks.com>
References: <Pine.LNX.4.44.0405121854590.30585-100000@phoenix.infradead.org>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO1UG-0001Ar-F7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 14:42:00 -0700
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BO1UF-0004tI-Tt
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 14:42:00 -0700
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 May 2004 14:22:33 -0500
In-Reply-To: <Pine.LNX.4.44.0405121854590.30585-100000@phoenix.infradead.org>
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
To: jsimmons@infradead.org
Cc: jonsmirl@yahoo.com, Ian Romanick <idr@us.ibm.com>, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net

James Simmons wrote:

> That app must be pretty big if it runs on non intel platforms. You nedd to 
> translate the x86 BIOS code to native assembly before you run it.

Or you emulate thier functionality.. but perhaps thats what you are 
saying.  Thats what X does.  LinuxBIOS has pulled the x86emu out into a 
standalone userspace app that we use to try and get video cards up 
across a serial console.  Currently that app is 400k (dynamic linked)

The plan though is to include that emulation ability into LinuxBIOS and 
400k is way to large.  The authors feel though that it can be done.  I 
think the core pieces aren't really that big.

It dosen't seem to work with my ATI bios though which is why I was 
interested in another implementation.  Word is that the current 
LinuxBIOS implementation has issues with int10 replacement and then 
calling back into itself.

>>Jon Smirl wrote:
>>
>>
>>>licenses). I've already built a very messy prototype by moving the existing
>>>fbdev code to user space and it works just fine. I also called another little
>>>app which executed the VBIOS and reset secondary cards at boot via hotplug.
>>
>>Is that app available somewhere?  I'm trying to get an ATI Rage Mobility 
>>  M1 chip up under LinuxBIOS and such and app would be useful for me.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
